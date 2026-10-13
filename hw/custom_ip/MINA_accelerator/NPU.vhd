library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;
use work.pe_pkg.all;

entity NPU is
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;


    );
end entity NPU;

architecture Structural of NPU is

begin

    PE_arr: entity work.PE_arr
        port map (
            clk => clk,
            rst_n => rst_n,

            clear_acc => ,
            valid_in => ,
            drain => ,
            top_weights => ,
            left_data => ,
            bottom_out
        );

end architecture Structural;
