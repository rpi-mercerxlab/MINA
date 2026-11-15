#!/usr/bin/env python3
"""Flash MINA CPU or NPU memories using the UART hardware bootloader."""

import argparse
from pathlib import Path
import sys

SYNC_BYTE = 0x55
CMD_WRITE = 0x01
CMD_NPU_INSTR = 0x02
CMD_NPU_WEIGHT = 0x03
CMD_NPU_SCRATCHPAD = 0x04
UART_ACK = 0x06
UART_NACK = 0x15


def calculate_checksum(cmd, addr_bytes, data_bytes):
    checksum = cmd
    for byte in addr_bytes + data_bytes:
        checksum ^= byte
    return checksum


def send_write_packet(ser, address, data_word, command=CMD_WRITE):
    """data_word is wire-order (big-endian); retain the old three-argument API."""
    expected = 5 if command == CMD_NPU_INSTR else 4
    if command not in (1, 2, 3, 4) or len(data_word) != expected:
        raise ValueError("Invalid command or data length")
    addr_bytes = address.to_bytes(4, "big")
    packet = bytes([SYNC_BYTE, command]) + addr_bytes + data_word
    packet += bytes([calculate_checksum(command, addr_bytes, data_word)])
    if ser.write(packet) != len(packet):
        raise IOError("Incomplete UART packet write; toggle boot mode before retrying")
    response = ser.read(1)
    where = f"command 0x{command:02X}, address 0x{address:08X}"
    if not response:
        raise TimeoutError(f"UART timeout ({where}); toggle boot mode before retrying")
    if response[0] == UART_NACK:
        raise RuntimeError(
            f"NACK (0x15) ({where}); check boot mode, NPU readiness, and memory configuration"
        )
    if response[0] != UART_ACK:
        raise RuntimeError(f"Unexpected response 0x{response[0]:02X} ({where})")
    return True


def integer(value):
    return int(value, 0)


def parser_for_cli():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("port", help="Serial port, e.g. /dev/ttyUSB0 or COM3")
    parser.add_argument("file", nargs="?", help="CPU binary (normal mode only)")
    parser.add_argument(
        "-npu", "--npu", action="store_true", help="Upload separate NPU memories"
    )
    parser.add_argument("--instructions", type=Path, help="NPU instruction binary")
    parser.add_argument("--weights", type=Path, help="NPU weight binary")
    parser.add_argument("--scratchpad", type=Path, help="NPU scratchpad binary")
    parser.add_argument("--baud", type=int, default=115200)
    parser.add_argument(
        "--timeout",
        type=float,
        default=1.0,
        help="Serial read/write timeout in seconds",
    )
    parser.add_argument(
        "--address",
        type=integer,
        default=None,
        help="CPU base byte address (default: 0)",
    )
    parser.add_argument(
        "--instruction-index",
        type=integer,
        default=None,
        help="First NPU instruction index (default: 0)",
    )
    parser.add_argument(
        "--weight-address",
        type=integer,
        default=None,
        help="Local weight byte offset (default: 0)",
    )
    parser.add_argument(
        "--scratchpad-address",
        type=integer,
        default=None,
        help="Local scratchpad byte offset (default: 0)",
    )
    parser.add_argument(
        "--instruction-bytes",
        type=int,
        choices=(5, 8),
        default=None,
        help="Bytes per instruction in the input file (default: 8); little-endian, 36 valid bits",
    )
    parser.add_argument(
        "--host-addr-width",
        type=int,
        default=None,
        help="NPU HOST_ADDR_WIDTH, must match hardware (default: 16)",
    )
    return parser


def load_image(name, path, command, base, entry_bytes, stride, limit=None):
    if base < 0 or base >= 2**32 or base % stride:
        raise ValueError(f"{name}: invalid or unaligned starting address")
    data = Path(path).read_bytes()
    if not data:
        raise ValueError(f"{name}: file is empty: {path}")
    if len(data) % entry_bytes:
        if command != CMD_WRITE:
            raise ValueError(
                f"{name}: file size must be a multiple of {entry_bytes} bytes; NPU files are not padded"
            )
        padding = (-len(data)) % entry_bytes
        print(f"Padding CPU binary with {padding} bytes of 0xFF.")
        data += b"\xff" * padding
    count = len(data) // entry_bytes
    if base + count * stride > (limit if limit is not None else 2**32):
        raise ValueError(f"{name}: image exceeds memory address range")
    words = []
    for i in range(count):
        value = int.from_bytes(data[i * entry_bytes : (i + 1) * entry_bytes], "little")
        if command == CMD_NPU_INSTR and value >= 2**36:
            raise ValueError(f"{name}: entry {i} has nonzero bits above bit 35")
        words.append(value.to_bytes(5 if command == CMD_NPU_INSTR else 4, "big"))
    return name, command, base, stride, words


def prepare_images(args):
    """Read and validate every file before opening the serial port."""
    if args.baud <= 0 or not 0 < args.timeout < float("inf"):
        raise ValueError("Baud and timeout must be positive and finite")
    if not args.npu:
        npu_values = (
            args.instructions,
            args.weights,
            args.scratchpad,
            args.instruction_index,
            args.weight_address,
            args.scratchpad_address,
            args.instruction_bytes,
            args.host_addr_width,
        )
        if any(v is not None for v in npu_values):
            raise ValueError("NPU options require -npu")
        if not args.file:
            raise ValueError("CPU mode requires a binary file")
        return [load_image("CPU", args.file, CMD_WRITE, args.address or 0, 4, 4)]
    if args.file or args.address is not None:
        raise ValueError(
            "Use --instructions/--weights/--scratchpad and their offsets in NPU mode, not a CPU file or --address"
        )
    if not any((args.instructions, args.weights, args.scratchpad)):
        raise ValueError(
            "-npu requires at least one of --instructions, --weights, --scratchpad"
        )
    for option, path, value in (
        ("--instruction-index", args.instructions, args.instruction_index),
        ("--weight-address", args.weights, args.weight_address),
        ("--scratchpad-address", args.scratchpad, args.scratchpad_address),
        ("--instruction-bytes", args.instructions, args.instruction_bytes),
    ):
        if value is not None and path is None:
            raise ValueError(f"{option} requires its corresponding binary file")
    width = args.host_addr_width if args.host_addr_width is not None else 16
    if not 1 <= width <= 18:
        raise ValueError("--host-addr-width must be between 1 and 18")
    images = []
    # Data first, program last. The hardware keeps execution stopped throughout.
    if args.weights:
        images.append(
            load_image(
                "Weights",
                args.weights,
                CMD_NPU_WEIGHT,
                args.weight_address or 0,
                4,
                4,
                4 * 2**width,
            )
        )
    if args.scratchpad:
        images.append(
            load_image(
                "Scratchpad",
                args.scratchpad,
                CMD_NPU_SCRATCHPAD,
                args.scratchpad_address or 0,
                4,
                4,
                4 * 2**width,
            )
        )
    if args.instructions:
        images.append(
            load_image(
                "Instructions",
                args.instructions,
                CMD_NPU_INSTR,
                (args.instruction_index or 0) * 8,
                args.instruction_bytes or 8,
                8,
                8192,
            )
        )
    return images


def main(argv=None):
    parser = parser_for_cli()
    args = parser.parse_args(argv)
    try:
        images = prepare_images(args)
    except (OSError, ValueError) as exc:
        parser.error(str(exc))
    try:
        import serial
    except ImportError:
        print(
            "Error: PySerial is missing. Re-run install-sdk, or install pyserial in your Python environment.",
            file=sys.stderr,
        )
        return 1
    print(
        "Hardware boot mode must be active; the flasher does not toggle it or start execution."
    )
    try:
        with serial.Serial(
            args.port, args.baud, timeout=args.timeout, write_timeout=args.timeout
        ) as ser:
            ser.reset_input_buffer()
            for name, command, base, stride, words in images:
                print(f"Uploading {name}: {len(words)} entries at 0x{base:08X}")
                for i, word in enumerate(words):
                    address = base + i * stride
                    send_write_packet(ser, address, word, command)
                    if (i + 1) % 128 == 0 or i + 1 == len(words):
                        print(
                            f"\r{name}: {(i + 1) * 100 // len(words)}% ({i + 1}/{len(words)})",
                            end="",
                            flush=True,
                        )
                print()
    except KeyboardInterrupt:
        print(
            "\nUpload interrupted; memory may be partially programmed. Toggle boot mode before retrying.",
            file=sys.stderr,
        )
        return 130
    except (OSError, RuntimeError, serial.SerialException) as exc:
        print(
            f"\nUpload failed: {exc}. Memory may be partially programmed.",
            file=sys.stderr,
        )
        return 1
    print(
        "Upload complete successfully! Execution remains stopped until started externally."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
