import math

input_ints = list(range(-128, 128))  # 2's comp 8 bit range

INPUT_SCALE = 0.046875


def sigmoid(x):
    # Added parentheses to properly calculate the denominator
    return 1 / (1 + math.exp(-x))


sigmoid_ints = [int(sigmoid(x * INPUT_SCALE) * 127) for x in input_ints]

sigmoid_bin = [f"{x:08b}" for x in sigmoid_ints]

vhdl = ""

vhdl += """library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sigmoidLUT is
    port (
        clk : in std_logic;
        input : in std_logic_vector(7 downto 0);
        output : out std_logic_vector(7 downto 0)
    );
end entity sigmoidLUT;

architecture Behavioral of sigmoidLUT is

signal input_buffer : std_logic_vector(7 downto 0) := (others => '0');
signal output_buffer : std_logic_vector(7 downto 0) := (others => '0');

begin

process (clk)
begin
    if (rising_edge(clk)) then
        input_buffer <= input;
        case input_buffer is
"""

# Generate the switch cases mapping 2's comp input directly to unsigned output
for x, out_val in zip(input_ints, sigmoid_ints):
    # (x & 0xFF) cleanly converts negative Python integers to 8-bit 2's complement binary strings
    in_bin = f"{(x & 0xFF):08b}"
    out_bin = f"{out_val:08b}"

    vhdl += f'            when "{in_bin}" => output_buffer <= "{out_bin}";\n'

vhdl += """            when others => output_buffer <= (others => '0');
        end case;
    end if;
end process;

output <= output_buffer;

end architecture Behavioral;
"""

with open("sigmoidLUT.vhd", "w") as f:
    f.write(vhdl)
