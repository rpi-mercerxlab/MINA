library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pe_pkg.all;

entity NPU is
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        -- connections to port B of instruction RAM
        instr_we : in std_logic;
        instr_addr : in std_logic_vector(9 downto 0);
        instr_din : in std_logic_vector(35 downto 0);
        instr_dout : out std_logic_vector(35 downto 0);

        -- connections to port A of weight RAM
        weight_we : in std_logic;
        weight_din : in std_logic_vector(31 downto 0);
        weight_dout : out std_logic_vector(31 downto 0);
        weight_addr_a : in std_logic_vector(13 downto 0)
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

    -- BUFFERS FOR PE_ARR
    signal pe_clear_acc_buf : std_logic;
    signal pe_valid_in : std_logic;
    signal pe_drain : std_logic;

    signal pe_top_weights_buf : weight_row_t;
    signal pe_left_data_buf : data_col_t;
    signal pe_bottom_out_buf : accum_row_t; 
    -- BUFFERS FOR PE_arr

    -- BUFFERS FOR WEIGHT RAM
    signal weight_addr : std_logic_vector(11 downto 0);
    signal weight_ram_din : std_logic_vector(127 downto 0);
    signal weight_arr_din : weight_row_t;
    -- BUFFERS FOR WEIGHT RAM
begin

    UNPACK_WEIGHTS: for i in 0 to NUM_COLS-1 generate
        weight_arr_din(i) <= weight_ram_din(((i+1)*WEIGHT_WIDTH) - 1 downto i*WEIGHT_WIDTH);
    end generate;

    PE_WEIGHT_RAM: entity work.PE_weight_ram
        port map (
            clk => clk,

            addr_a => weight_addr_a,
            we_a => weight_we,
            din_a => weight_din,
            dout_a => weight_dout,

            addr_b => weight_addr,
            dout_b => weight_arr_din
                 );

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

    INSTR_bram: entity work.instr_bram
        port map (
            clk_a => clk,
            we_a => open,
            addr_a => instr_addr_o_buf,
            din_a => open,
            dout_a => instr_d_in_buf,

            clk_b => clk,
            we_b => instr_we,
            addr_b => instr_addr,
            din_b => instr_din,
            dout_b => instr_dout
                 );
    
    PE_SKEW_BUFFER: entity work.SkewBuffer
        port map (
            clk => clk,
            rst_n => rst_n,
            enable => open,

            raw_weights => open,
            raw_data => open,

            skewed_weights => pe_top_weights_buf,
            skewed_data => pe_left_data_buf
                 );

    PE_arr: entity work.PE_arr
        port map (
            clk => clk,
            rst_n => rst_n,

            clear_acc => pe_clear_acc_buf,
            valid_in => pe_valid_in,
            drain => pe_drain,
            top_weights => pe_top_weights_buf,
            left_data => pe_left_data_buf,
            bottom_out => pe_bottom_out_buf
        );

end architecture Structural;
