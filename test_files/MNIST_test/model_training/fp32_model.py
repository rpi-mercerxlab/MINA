import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms
from torch.utils.data import DataLoader


# 1. Model Definition (no BatchNorm, pure Linear + ReLU)
class MNIST_MLP(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 32, bias=False)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(32, 10, bias=False)

    def forward(self, x):
        x = x.view(x.size(0), -1)  # Flatten [B, 1, 28, 28] -> [B, 784]
        x = self.relu(self.fc1(x))
        x = self.fc2(x)
        return x


def main():
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    # 2. Data: Keep pixels in [0, 1] for clean symmetric int8 input quantization
    transform = transforms.ToTensor()
    train_ds = datasets.MNIST(
        root="./data", train=True, download=True, transform=transform
    )
    test_ds = datasets.MNIST(
        root="./data", train=False, download=True, transform=transform
    )

    train_loader = DataLoader(train_ds, batch_size=128, shuffle=True)
    test_loader = DataLoader(test_ds, batch_size=512, shuffle=False)

    # 3. Setup
    model = MNIST_MLP().to(device)
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.AdamW(model.parameters(), lr=1e-3, weight_decay=1e-4)

    # 4. Training Loop
    epochs = 10
    for epoch in range(1, epochs + 1):
        model.train()
        for images, labels in train_loader:
            images, labels = images.to(device), labels.to(device)
            optimizer.zero_grad()
            loss = criterion(model(images), labels)
            loss.backward()
            optimizer.step()

        # Evaluate
        model.eval()
        correct = 0
        with torch.no_grad():
            for images, labels in test_loader:
                images, labels = images.to(device), labels.to(device)
                preds = model(images).argmax(dim=1)
                correct += (preds == labels).sum().item()

        acc = 100.0 * correct / len(test_ds)
        print(f"Epoch {epoch:2d}/{epochs} | Test Accuracy: {acc:.2f}%")

    # 5. Save FP32 checkpoint for PTQ
    torch.save(model.state_dict(), "mnist_784_32_10_fp32.pt")
    print("Saved model to mnist_784_32_10_fp32.pt")


if __name__ == "__main__":
    main()
