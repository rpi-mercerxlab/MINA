import argparse
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Union

import yaml


@dataclass
class FieldSpec:
    name: str
    high: int
    low: int

    @property
    def width(self) -> int:
        return self.high - self.low + 1

    @property
    def mask(self) -> int:
        return (1 << self.width) - 1


@dataclass
class InstructionSpec:
    mnemonic: str
    fixed_fields: Dict[str, int] = field(default_factory=dict)
    operand_fields: List[str] = field(default_factory=list)


class AssemblerError(ValueError):
    pass


class Assembler:
    """Generic YAML-driven assembly-to-binary generator."""

    def __init__(self, spec: dict):
        self.width: int = int(spec.get("instruction_width", 32))
        self.fields: Dict[str, FieldSpec] = self._parse_fields(spec.get("fields", {}))
        self.instructions: Dict[str, InstructionSpec] = {}

        if "decode_tree" in spec:
            self._walk_tree(spec["decode_tree"], fixed_fields={})

    @classmethod
    def from_yaml(cls, yaml_path: Union[str, Path]) -> "Assembler":
        path = Path(yaml_path)
        if not path.is_file():
            raise FileNotFoundError(f"YAML spec not found: {path}")
        with open(path, "r", encoding="utf-8") as f:
            return cls(yaml.safe_load(f))

    # ------------------------------------------------------------------
    # Spec parsing
    # ------------------------------------------------------------------

    @staticmethod
    def _parse_fields(raw_fields: Dict[str, str]) -> Dict[str, FieldSpec]:
        parsed: Dict[str, FieldSpec] = {}
        for name, rng in raw_fields.items():
            s = str(rng).strip()
            m = re.fullmatch(r"(\d+)\s+downto\s+(\d+)", s, re.IGNORECASE)
            if m:
                high, low = int(m.group(1)), int(m.group(2))
            elif re.fullmatch(r"\d+", s):
                high = low = int(s)
            else:
                raise AssemblerError(f"Unsupported field range '{rng}' for '{name}'")
            if high < low:
                raise AssemblerError(f"Invalid range '{rng}' for '{name}' (high < low)")
            parsed[name] = FieldSpec(name=name, high=high, low=low)
        return parsed

    @staticmethod
    def _parse_pattern(pattern: Union[str, int]) -> int:
        if isinstance(pattern, int):
            return pattern
        return int(str(pattern).strip(), 0)

    def _walk_tree(self, node: Optional[dict], fixed_fields: Dict[str, int]) -> None:
        if not node:
            return

        # Register instruction if an 'asm' keyword is present
        if "asm" in node and node["asm"]:
            mnemonic = str(node["asm"]).strip().upper()
            if mnemonic in self.instructions:
                raise AssemblerError(f"Duplicate asm mnemonic '{mnemonic}'")

            if "asm_args" in node and node["asm_args"] is not None:
                operand_fields = list(node["asm_args"])
            else:
                # Infer operand order from @FIELD references in 'set'
                operand_fields = []
                for val in (node.get("set") or {}).values():
                    if isinstance(val, str) and val.startswith("@"):
                        fname = val[1:]
                        if fname not in operand_fields:
                            operand_fields.append(fname)

            for fname in operand_fields:
                if fname not in self.fields:
                    raise AssemblerError(
                        f"Instruction '{mnemonic}' references unknown field '{fname}'"
                    )

            self.instructions[mnemonic] = InstructionSpec(
                mnemonic=mnemonic,
                fixed_fields=dict(fixed_fields),
                operand_fields=operand_fields,
            )

        # Recurse into nested switch ('match' or direct 'field')
        match_node = node.get("match", node if "field" in node else None)
        if match_node and "field" in match_node:
            switch_field = match_node["field"]
            if switch_field not in self.fields:
                raise AssemblerError(f"Unknown switch field '{switch_field}'")

            for pattern, branch in (match_node.get("cases") or {}).items():
                next_fixed = dict(fixed_fields)
                next_fixed[switch_field] = self._parse_pattern(pattern)
                self._walk_tree(branch, next_fixed)

    # ------------------------------------------------------------------
    # Assembly & encoding
    # ------------------------------------------------------------------

    @staticmethod
    def _strip_comment(line: str) -> str:
        return re.split(r"#|;|//", line, maxsplit=1)[0].strip()

    @staticmethod
    def _parse_operand(token: str, labels: Dict[str, int]) -> int:
        t = token.strip()
        if t in labels:
            return labels[t]
        # Allow register syntax like r0, R12, $4
        reg_match = re.fullmatch(r"[rR\$](\d+)", t)
        if reg_match:
            return int(reg_match.group(1))
        try:
            return int(t, 0)
        except ValueError as exc:
            raise AssemblerError(
                f"Invalid operand or undefined label: '{token}'"
            ) from exc

    def _pack_field(
        self,
        word: int,
        used_mask: int,
        field_name: str,
        value: int,
        allow_signed: bool = True,
    ) -> Tuple[int, int]:
        f = self.fields[field_name]
        min_val = -(1 << (f.width - 1)) if allow_signed else 0
        max_val = (1 << f.width) - 1

        if not (min_val <= value <= max_val):
            raise AssemblerError(
                f"Value {value} out of range for field '{field_name}' "
                f"(width {f.width}, allowed [{min_val}, {max_val}])"
            )

        field_bits = (value & f.mask) << f.low
        field_mask = f.mask << f.low

        if used_mask & field_mask:
            raise AssemblerError(
                f"Bit overlap detected while packing field '{field_name}' "
                f"({f.high} downto {f.low})"
            )

        return word | field_bits, used_mask | field_mask

    def encode_instruction(
        self, mnemonic: str, operands: List[int], line_no: Optional[int] = None
    ) -> int:
        key = mnemonic.strip().upper()
        if key not in self.instructions:
            loc = f"Line {line_no}: " if line_no is not None else ""
            raise AssemblerError(f"{loc}Unknown instruction '{mnemonic}'")

        spec = self.instructions[key]
        if len(operands) != len(spec.operand_fields):
            loc = f"Line {line_no}: " if line_no is not None else ""
            raise AssemblerError(
                f"{loc}'{key}' expects {len(spec.operand_fields)} operand(s) "
                f"({', '.join(spec.operand_fields)}), got {len(operands)}"
            )

        word = 0
        used_mask = 0
        for fname, fval in spec.fixed_fields.items():
            word, used_mask = self._pack_field(
                word, used_mask, fname, fval, allow_signed=False
            )

        for fname, fval in zip(spec.operand_fields, operands):
            word, used_mask = self._pack_field(
                word, used_mask, fname, fval, allow_signed=True
            )

        return word

    def assemble(self, source: str) -> List[int]:
        """Two-pass assembly supporting labels (e.g. 'loop:'). Returns list of integer words."""
        labels: Dict[str, int] = {}
        parsed_lines: List[Tuple[int, str, List[str]]] = []

        # Pass 1: collect labels and tokenize instructions
        pc = 0
        for line_no, raw_line in enumerate(source.splitlines(), start=1):
            line = self._strip_comment(raw_line)
            if not line:
                continue

            # Handle one or more labels on a line (e.g. "loop: ADDI r1, r0, 5")
            while ":" in line:
                label_part, rest = line.split(":", 1)
                label = label_part.strip()
                if not re.fullmatch(r"[A-Za-z_]\w*", label):
                    raise AssemblerError(f"Line {line_no}: Invalid label '{label}'")
                if label in labels:
                    raise AssemblerError(f"Line {line_no}: Duplicate label '{label}'")
                labels[label] = pc
                line = rest.strip()

            if not line:
                continue

            parts = line.split(None, 1)
            mnemonic = parts[0]
            arg_str = parts[1] if len(parts) > 1 else ""
            tokens = [t.strip() for t in re.split(r"[,\s]+", arg_str) if t.strip()]
            parsed_lines.append((line_no, mnemonic, tokens))
            pc += 1

        # Pass 2: resolve operands and encode
        words: List[int] = []
        for line_no, mnemonic, tokens in parsed_lines:
            try:
                operands = [self._parse_operand(tok, labels) for tok in tokens]
                words.append(
                    self.encode_instruction(mnemonic, operands, line_no=line_no)
                )
            except AssemblerError as exc:
                if not str(exc).startswith("Line "):
                    raise AssemblerError(f"Line {line_no}: {exc}") from exc
                raise

        return words

    def assemble_file(self, asm_path: Union[str, Path]) -> List[int]:
        """Reads and assembles a .asm_mina (or any text) file."""
        path = Path(asm_path)
        if not path.is_file():
            raise FileNotFoundError(f"Assembly file not found: {path}")
        return self.assemble(path.read_text(encoding="utf-8"))

    # ------------------------------------------------------------------
    # Output formatters & writers
    # ------------------------------------------------------------------

    def to_binary_strings(self, words: List[int]) -> List[str]:
        return [f"{w:0{self.width}b}" for w in words]

    def to_hex_strings(self, words: List[int]) -> List[str]:
        hex_digits = (self.width + 3) // 4
        return [f"{w:0{hex_digits}X}" for w in words]

    def to_bytes(
        self,
        words: List[int],
        entry_bytes: int = 8,
        byteorder: str = "little",
    ) -> bytes:
        min_bytes = (self.width + 7) // 8
        if entry_bytes < min_bytes:
            raise ValueError(
                f"entry_bytes ({entry_bytes}) is smaller than required ({min_bytes}) "
                f"for {self.width}-bit instructions."
            )
        return b"".join(w.to_bytes(entry_bytes, byteorder=byteorder) for w in words)

    def write_output(
        self,
        words: List[int],
        out_path: Union[str, Path],
        fmt: str = "raw",
        entry_bytes: int = 8,
        byteorder: str = "little",
    ) -> None:
        """Writes assembled words as 'raw' (binary), 'bin' (text), or 'hex' (text)."""
        path = Path(out_path)
        if fmt == "bin":
            content = "\n".join(self.to_binary_strings(words))
            path.write_text((content + "\n") if content else "", encoding="utf-8")
        elif fmt == "hex":
            content = "\n".join(self.to_hex_strings(words))
            path.write_text((content + "\n") if content else "", encoding="utf-8")
        elif fmt == "raw":
            path.write_bytes(
                self.to_bytes(words, entry_bytes=entry_bytes, byteorder=byteorder)
            )
        else:
            raise ValueError(
                f"Unsupported output format '{fmt}'. Use 'bin', 'hex', or 'raw'."
            )


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Assemble a .asm_mina file using a YAML decoder spec."
    )
    parser.add_argument("input", help="Path to the .asm_mina file")
    parser.add_argument(
        "-s", "--spec", default="npu_decoder.yaml", help="Path to YAML decoder spec"
    )
    parser.add_argument(
        "-o", "--output", help="Output file path (prints to stdout if omitted)"
    )
    parser.add_argument(
        "-f",
        "--format",
        choices=["bin", "hex", "raw"],
        default="raw",
        help="Output format (default: raw)",
    )
    parser.add_argument(
        "--instruction-bytes",
        type=int,
        choices=[5, 8],
        default=8,
        help="Bytes per instruction for raw output (default: 8, matches py-flasher.py)",
    )
    parser.add_argument(
        "--byteorder",
        choices=["little", "big"],
        default="little",
        help="Byte order for raw output (default: little, matches py-flasher.py)",
    )
    args = parser.parse_args()

    try:
        asm = Assembler.from_yaml(args.spec)
        words = asm.assemble_file(args.input)

        if args.output:
            asm.write_output(
                words,
                args.output,
                fmt=args.format,
                entry_bytes=args.instruction_bytes,
                byteorder=args.byteorder,
            )
            print(f"Assembled {len(words)} instructions -> {args.output}")
        elif args.format == "raw":
            sys.stdout.buffer.write(
                asm.to_bytes(
                    words,
                    entry_bytes=args.instruction_bytes,
                    byteorder=args.byteorder,
                )
            )
        elif args.format == "hex":
            print("\n".join(asm.to_hex_strings(words)))
        else:
            print("\n".join(asm.to_binary_strings(words)))
    except (AssemblerError, FileNotFoundError, ValueError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
