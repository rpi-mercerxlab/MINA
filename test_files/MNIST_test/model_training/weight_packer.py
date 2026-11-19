import numpy as np

TILE = 8


def pack_weights_col_tile_major(W_out_in):
    """
    Input:  W_out_in of shape (N, K), int8 (PyTorch Linear weight format)
    Output: Contiguous int8 array of shape (N_tiles, K_tiles, 8, 8)
            Each 8-byte row is one 64-bit vector for weight_ram (lane 0 = byte 0 / LSB).
    """
    # Transpose to (K, N) so rows = K (time steps) and cols = N (PE columns)
    B = W_out_in.T  # shape: (K, N)
    K, N = B.shape

    # Zero-pad N (columns) to a multiple of 8 (e.g., 10 -> 16)
    rem_n = N % TILE
    if rem_n != 0:
        B = np.pad(B, ((0, 0), (0, TILE - rem_n)), mode="constant", constant_values=0)
        N = B.shape[1]

    K_tiles = K // TILE
    N_tiles = N // TILE

    # Reshape into (K_tiles, 8_k, N_tiles, 8_n) -> transpose to (N_tiles, K_tiles, 8_k, 8_n)
    # Within each tile, axis 2 is the 8 cycles (vector_index 0..7) and axis 3 is the 8 PE columns
    packed = B.reshape(K_tiles, TILE, N_tiles, TILE).transpose(2, 0, 1, 3)
    return np.ascontiguousarray(packed, dtype=np.int8)


def main():
    data = np.load("mnist_784_32_10_int8.npz")
    W1 = data["W1_q"]  # (32, 784)
    W2 = data["W2_q"]  # (10, 32)

    W1_packed = pack_weights_col_tile_major(
        W1
    )  # (4, 98, 8, 8) -> 3,136 vectors (25,088 bytes)
    W2_packed = pack_weights_col_tile_major(
        W2
    )  # (2,  4, 8, 8) ->    64 vectors (   512 bytes)

    # Concatenate into one contiguous binary image for weight_ram
    all_weights = np.concatenate([W1_packed.ravel(), W2_packed.ravel()])
    all_weights.tofile("weights.bin")

    w1_vecs = W1_packed.size // TILE
    w2_vecs = W2_packed.size // TILE
    print(f"W1: {w1_vecs} vectors ({W1_packed.nbytes} bytes) | W1_BASE = 0")
    print(f"W2: {w2_vecs} vectors ({W2_packed.nbytes} bytes) | W2_BASE = {w1_vecs}")
    print(
        f"Total: {w1_vecs + w2_vecs} vectors ({all_weights.nbytes} bytes) -> weights.bin"
    )


if __name__ == "__main__":
    main()
