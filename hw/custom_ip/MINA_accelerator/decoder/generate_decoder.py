import sys
import yaml


def format_vhdl_pattern(pattern):
    """Converts YAML keys like '0x05' or '0b010' into VHDL literals x"05" or "010"."""
    p = str(pattern).strip()
    if p.startswith("0x") or p.startswith("0X"):
        return f'x"{p[2:]}"'
    if p.startswith("0b") or p.startswith("0B"):
        return f'"{p[2:]}"'
    return p


def resolve_value(val, fields):
    """Replaces @FIELD_NAME with instr(high downto low)."""
    if isinstance(val, str) and val.startswith("@"):
        field_name = val[1:]
        if field_name not in fields:
            raise KeyError(
                f"Field '{field_name}' referenced with '@' is not defined in 'fields'."
            )
        return f"instr({fields[field_name]})"
    return val


def generate_case_tree(node, fields, status_inputs, indent_level=3):
    """Recursively walks the YAML decode_tree and builds VHDL case statements."""
    indent = "    " * indent_level
    lines = []

    if not node:
        lines.append(f"{indent}null;")
        return lines

    has_assignments = False

    # 1. Handle 'wait_for' -> routes a hardware status input to instr_done
    if "wait_for" in node and node["wait_for"]:
        wait_sig = node["wait_for"]
        if wait_sig not in status_inputs and wait_sig not in ("'0'", "'1'"):
            raise KeyError(
                f"wait_for signal '{wait_sig}' is not defined in 'status_inputs'."
            )
        lines.append(f"{indent}instr_done <= {wait_sig};")
        has_assignments = True

    # 2. Emit control signal assignments at this level
    if "set" in node and node["set"]:
        for sig, val in node["set"].items():
            vhdl_val = resolve_value(val, fields)
            lines.append(f"{indent}{sig} <= {vhdl_val};")
            has_assignments = True

    # 3. Check if this node is a switch ('field') or contains a nested switch ('match')
    match_node = node.get("match", node if "field" in node else None)

    if match_node:
        field_name = match_node["field"]
        if field_name not in fields:
            raise KeyError(f"Switch field '{field_name}' is not defined in 'fields'.")

        slice_range = fields[field_name]
        lines.append(f"{indent}case instr({slice_range}) is")

        for pattern, branch in match_node.get("cases", {}).items():
            vhdl_pattern = format_vhdl_pattern(pattern)
            lines.append(f"{indent}    when {vhdl_pattern} =>")
            lines.extend(
                generate_case_tree(branch, fields, status_inputs, indent_level + 2)
            )

        # Always generate a 'when others' branch to prevent latches
        lines.append(f"{indent}    when others =>")
        if "default" in match_node and match_node["default"]:
            lines.extend(
                generate_case_tree(
                    match_node["default"], fields, status_inputs, indent_level + 2
                )
            )
        else:
            lines.append(f"{indent}        null;")

        lines.append(f"{indent}end case;")
    elif not has_assignments:
        lines.append(f"{indent}null;")

    return lines


def build_vhdl(yaml_path):
    with open(yaml_path, "r") as f:
        spec = yaml.safe_load(f)

    entity = spec.get("entity_name", "instr_decoder")
    width = spec.get("instruction_width", 32)
    fields = spec.get("fields", {})
    signals = spec.get("control_signals", {})
    status_inputs = spec.get("status_inputs", {})

    # Remove instr_done from user dict if present so we can manage its safe/active defaults cleanly
    signals.pop("instr_done", None)

    # 1. Build Port List
    ports = [
        f"        instr       : in  std_logic_vector({width - 1} downto 0)",
        f"        instr_valid : in  std_logic",
    ]

    for name, w in status_inputs.items():
        if w == 1:
            ports.append(f"        {name} : in  std_logic")
        else:
            ports.append(f"        {name} : in  std_logic_vector({w - 1} downto 0)")

    ports.append(f"        instr_done  : out std_logic")
    for name, props in signals.items():
        w = props["width"]
        if w == 1:
            ports.append(f"        {name} : out std_logic")
        else:
            ports.append(f"        {name} : out std_logic_vector({w - 1} downto 0)")
    port_str = ";\n".join(ports)

    # 2. Build Safe Inactive Defaults (when instr_valid = '0')
    defaults = ["        instr_done <= '0';"]
    defaults.extend(
        [f"        {name} <= {props['default']};" for name, props in signals.items()]
    )
    default_str = "\n".join(defaults)

    # 3. Build Recursive Switch Tree (indented inside 'if instr_valid = '1' then')
    tree_lines = generate_case_tree(
        spec["decode_tree"], fields, status_inputs, indent_level=3
    )
    tree_str = "\n".join(tree_lines)

    return f"""library ieee;
use ieee.std_logic_1164.all;

entity {entity} is
    port (
{port_str}
    );
end entity {entity};

architecture rtl of {entity} is
begin
    process(all)
    begin
        -- Safe Inactive Defaults (when instr_valid = '0', nothing triggers and PC waits)
{default_str}

        if instr_valid = '1' then
            -- Active Default: Single-cycle instructions complete immediately unless overridden
            instr_done <= '1';

            -- Instruction Decode Switch Tree
{tree_str}
        end if;
    end process;
end architecture rtl;
"""


if __name__ == "__main__":
    input_yaml = sys.argv[1] if len(sys.argv) > 1 else "decoder_spec.yaml"
    output_vhdl = sys.argv[2] if len(sys.argv) > 2 else "decoder.vhd"

    vhdl_code = build_vhdl(input_yaml)
    with open(output_vhdl, "w") as f:
        f.write(vhdl_code)
    print(f"Generated {output_vhdl} from {input_yaml}")
