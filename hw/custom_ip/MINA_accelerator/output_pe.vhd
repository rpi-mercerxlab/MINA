library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_pe is
    generic (
        INPUT_WIDTH : integer := 32;
        OUTPUT_WIDTH : integer := 8
    );
    port (
        -- Basics
        clk    : in  std_logic;
        rst_n    : in  std_logic;

        -- 00, nothing, 01, RELu, 02, Sigmoid
        activation_function : in std_logic_vector(1 downto 0);
        input : in std_logic_vector(INPUT_WIDTH - 1 downto 0);
        output : out std_logic_vector(OUTPUT_WIDTH - 1 downto 0)

    );
end entity output_pe;

architecture Behavioral of output_pe is

begin

process (clk)
begin
    if (rising_edge(clk)) then

    end if;
end process;

end architecture Behavioral;
