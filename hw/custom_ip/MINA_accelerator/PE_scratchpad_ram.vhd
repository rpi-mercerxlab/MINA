library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

-- Requires the parameterized pe_pkg from the array-sizing changes.
-- Port A addresses 32-bit host words; port B addresses complete vectors.
entity PE_scratchpad_ram is
    port (
        clk    : in std_logic;
        addr_a : in std_logic_vector(HOST_ADDR_WIDTH-1 downto 0);
        we_a   : in std_logic;
        din_a  : in std_logic_vector(HOST_DATA_WIDTH-1 downto 0);
        dout_a : out std_logic_vector(HOST_DATA_WIDTH-1 downto 0);

        addr_b : in std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
        we_b   : in std_logic;
        din_b  : in std_logic_vector(VECTOR_WIDTH-1 downto 0);
        dout_b : out std_logic_vector(VECTOR_WIDTH-1 downto 0)
    );
end entity PE_scratchpad_ram;

architecture rtl of PE_scratchpad_ram is
    type data_array_t is array (0 to NUM_BANKS-1)
        of std_logic_vector(HOST_DATA_WIDTH-1 downto 0);

    signal dout_a_arr : data_array_t;
    signal dout_b_arr : data_array_t;
    signal we_a_arr : std_logic_vector(NUM_BANKS-1 downto 0);
    signal bank_sel : natural range 0 to NUM_BANKS-1;
    signal bank_sel_reg : natural range 0 to NUM_BANKS-1 := 0;
    signal bank_addr_a : std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
begin
    assert VECTOR_WIDTH mod HOST_DATA_WIDTH = 0
        report "Vector width must be a multiple of host data width"
        severity failure;

    assert NUM_BANKS = 2**BANK_SEL_WIDTH
        report "RAM bank count must be a power of two"
        severity failure;

    assert HOST_ADDR_WIDTH = RAM_ADDR_WIDTH + BANK_SEL_WIDTH
        report "Host address width does not match RAM banking"
        severity failure;

    -- Low address bits select the bank. This also supports NUM_BANKS = 1.
    bank_sel <= to_integer(unsigned(addr_a)) mod NUM_BANKS;
    bank_addr_a <= std_logic_vector(
        resize(shift_right(unsigned(addr_a), BANK_SEL_WIDTH), RAM_ADDR_WIDTH)
    );

    process(all)
    begin
        we_a_arr <= (others => '0');
        if we_a = '1' then
            we_a_arr(bank_sel) <= '1';
        end if;
    end process;

    -- Match the one-clock synchronous read latency of basic_dual_port.
    process(clk)
    begin
        if rising_edge(clk) then
            bank_sel_reg <= bank_sel;
        end if;
    end process;

    dout_a <= dout_a_arr(bank_sel_reg);

    GEN_BRAM: for i in 0 to NUM_BANKS-1 generate
        -- Bank zero occupies the least-significant host word.
        dout_b((i+1)*HOST_DATA_WIDTH-1 downto i*HOST_DATA_WIDTH)
            <= dout_b_arr(i);

        BRAM_INST: entity work.basic_dual_port
            generic map (
                DATA_WIDTH => HOST_DATA_WIDTH,
                ADDR_WIDTH => RAM_ADDR_WIDTH
            )
            port map (
                clk_a  => clk,
                we_a   => we_a_arr(i),
                addr_a => bank_addr_a,
                din_a  => din_a,
                dout_a => dout_a_arr(i),

                clk_b  => clk,
                we_b   => we_b,
                addr_b => addr_b,
                din_b  => din_b((i+1)*HOST_DATA_WIDTH-1 downto i*HOST_DATA_WIDTH),
                dout_b => dout_b_arr(i)
            );
    end generate GEN_BRAM;
end architecture rtl;
