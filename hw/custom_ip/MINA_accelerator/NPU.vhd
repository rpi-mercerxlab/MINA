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

    -- BUFFERS FOR INSTR FETCHER
    signal instr_done_buf : std_logic;
    signal jump_addr_vo_buf : std_logic;
    signal jump_addr_buf : std_logic_vector(9 downto 0);
    signal instr_o_buf : std_logic_vector(35 downto 0);
    signal instr_valid_o_buf : std_logic;

    signal instr_bram_en_buf : std_logic;
    signal instr_d_in_buf : std_logic_vector(35 downto 0);
    signal instr_addr_o_buf : std_logic_vector(9 downto 0);
    -- BUFFERS FOR INSTR FETCHER
begin

    INSTR_fetch: entity work.instr_fetcher
        port map (
            clk => clk,
            rst_n => rst_n,

            instr_done => instr_done_buf,
            jump_addr_vo => jump_addr_vo_buf,
            jump_addr => jump_addr_buf,
            instr_o => instr_o_buf,
            instr_valid_o => instr_valid_o_buf,

            bram_en => instr_bram_en_buf,
            d_in => instr_d_in_buf,
            addr_o => instr_addr_o_buf
                 );

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
