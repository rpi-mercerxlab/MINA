import numpy as np
import torch
import torch.nn as nn
from torchvision import datasets, transforms
from torch.utils.data import DataLoader

# ==========================================
# 1. Hardware Configuration Knobs
# ==========================================
MULT_BITS = 10  # Bit-width of your unsigned hardware multiplier (e.g., 8 or 16)
SHIFT_MIN = 12  # Minimum right-shift your hardware supports
SHIFT_MAX = 27  # Maximum right-shift your hardware supports
ROUND_SHIFT = True  # True = add 2^(n-1) before shift; False = plain truncation


# ==========================================
# 2. Model Definition (must match training)
# ==========================================
class MNIST_MLP(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 32, bias=False)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(32, 10, bias=False)

    def forward(self, x):
        x = x.view(x.size(0), -1)
        x = self.relu(self.fc1(x))
        return self.fc2(x)


# ==========================================
# 3. Quantization Helper Functions
# ==========================================
def quantize_weights_sym(W_fp32):
    """Symmetric per-tensor int8 weight quantization."""
    s_w = float(np.max(np.abs(W_fp32))) / 127.0
    W_q = np.clip(np.round(W_fp32 / s_w), -127, 127).astype(np.int8)
    return W_q, s_w


def solve_mult_shift(M, mult_bits=MULT_BITS, shift_min=SHIFT_MIN, shift_max=SHIFT_MAX):
    """Find largest shift n in [shift_min, shift_max] where m fits in mult_bits."""
    max_m = (1 << (mult_bits - 1)) - 1
    best_m, best_n, best_err = 1, shift_min, float("inf")

    for n in range(shift_max, shift_min - 1, -1):
        m = int(round(M * (1 << n)))
        if 1 <= m <= max_m:
            err = abs(M - (m / (1 << n)))
            if err < best_err:
                best_m, best_n, best_err = m, n, err
    return best_m, best_n


def hw_requantize(acc32, m, n, relu=False):
    """Bit-exact hardware multiply-and-shift + clip."""
    # Use int64 in Python to prevent intermediate overflow during (acc32 * m)
    prod = acc32.astype(np.int64) * np.int64(m)
    if ROUND_SHIFT and n > 0:
        prod += 1 << (n - 1)
    shifted = prod >> n
    low = 0 if relu else -128
    return np.clip(shifted, low, 127).astype(np.int8)


# ==========================================
# 4. Main PTQ & Golden Model Verification
# ==========================================
def main():
    # Load FP32 model
    model = MNIST_MLP()
    model.load_state_dict(torch.load("mnist_784_32_10_fp32.pt", map_location="cpu"))
    model.eval()

    # Load calibration set (500 train images) and full test set (10,000 images)
    transform = transforms.ToTensor()
    train_ds = datasets.MNIST(
        root="./data", train=True, download=True, transform=transform
    )
    test_ds = datasets.MNIST(
        root="./data", train=False, download=True, transform=transform
    )

    calib_loader = DataLoader(train_ds, batch_size=500, shuffle=True)
    test_loader = DataLoader(test_ds, batch_size=10000, shuffle=False)

    X_calib_fp, _ = next(iter(calib_loader))
    X_calib_fp = X_calib_fp.view(-1, 784).numpy()

    X_test_fp, y_test = next(iter(test_loader))
    X_test_fp = X_test_fp.view(-1, 784).numpy()
    y_test = y_test.numpy()

    # Input quantization: pixels in [0, 1] -> int8 in [0, 127]
    S_in = 1.0 / 127.0
    X_calib_q = np.clip(np.round(X_calib_fp / S_in), 0, 127).astype(np.int8)
    X_test_q = np.clip(np.round(X_test_fp / S_in), 0, 127).astype(np.int8)

    # Extract FP32 weights and biases
    W1_fp = model.fc1.weight.detach().numpy()  # [64, 784]
    W2_fp = model.fc2.weight.detach().numpy()  # [10, 64]

    # --- LAYER 1 QUANTIZATION & CALIBRATION ---
    W1_q, S_W1 = quantize_weights_sym(W1_fp)

    # Run Layer 1 MACs on calibration set to measure true post-ReLU dynamic range
    acc1_calib = X_calib_q.astype(np.int32) @ W1_q.astype(np.int32).T
    h1_fp_approx = np.maximum(0, acc1_calib) * (S_W1 * S_in)

    # Use 99.9th percentile to avoid a single outlier crushing dynamic range
    S_h1 = float(np.percentile(h1_fp_approx, 99.9)) / 127.0
    M1 = (S_W1 * S_in) / S_h1
    m1, n1 = solve_mult_shift(M1)

    # Generate actual quantized Layer 1 outputs for sequential calibration of Layer 2
    H1_calib_q = hw_requantize(acc1_calib, m1, n1, relu=True)

    # --- LAYER 2 QUANTIZATION & CALIBRATION ---
    W2_q, S_W2 = quantize_weights_sym(W2_fp)

    acc2_calib = H1_calib_q.astype(np.int32) @ W2_q.astype(np.int32).T
    out_fp_approx = acc2_calib * (S_W2 * S_h1)
    S_out = float(np.percentile(np.abs(out_fp_approx), 99.9)) / 127.0
    M2 = (S_W2 * S_h1) / S_out
    m2, n2 = solve_mult_shift(M2)

    # --- BIT-EXACT INTEGER GOLDEN MODEL EVALUATION ---
    # Layer 1
    acc1_test = X_test_q.astype(np.int32) @ W1_q.astype(np.int32).T
    H1_test_q = hw_requantize(acc1_test, m1, n1, relu=True)

    # Layer 2
    acc2_test = H1_test_q.astype(np.int32) @ W2_q.astype(np.int32).T
    Y_test_q = hw_requantize(acc2_test, m2, n2, relu=False)

    # Compare FP32 vs. Integer-Only Accuracy
    with torch.no_grad():
        fp32_preds = model(torch.from_numpy(X_test_fp)).argmax(dim=1).numpy()
    fp32_acc = 100.0 * np.mean(fp32_preds == y_test)
    int8_acc = 100.0 * np.mean(Y_test_q.argmax(axis=1) == y_test)

    print(
        f"Layer 1: m1 = {m1}, n1 = {n1} (target M1 = {M1:.6f}, hw = {m1 / (1 << n1):.6f})"
    )
    print(
        f"Layer 2: m2 = {m2}, n2 = {n2} (target M2 = {M2:.6f}, hw = {m2 / (1 << n2):.6f})"
    )
    print(f"FP32 Test Accuracy:     {fp32_acc:.2f}%")
    print(f"Int8 HW Test Accuracy:  {int8_acc:.2f}%")
    print(f"Accuracy Drop:          {fp32_acc - int8_acc:.2f}%")

    # Save quantized artifacts for C header / binary export
    np.savez(
        "mnist_784_32_10_int8.npz",
        W1_q=W1_q,
        m1=m1,
        n1=n1,
        W2_q=W2_q,
        m2=m2,
        n2=n2,
    )
    print("Saved quantized parameters to mnist_784_32_10_int8.npz")


if __name__ == "__main__":
    main()
