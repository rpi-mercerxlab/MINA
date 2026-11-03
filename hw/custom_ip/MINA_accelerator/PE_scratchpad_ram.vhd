library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PE_scratchpad_ram is
    port (
        clk : in std_logic;
        
        -- Port A (Exposed to Top Level - RISC-V/DMA)
        addr_a : in std_logic_vector(12 downto 0);
        we_a   : in std_logic;
        din_a  : in std_logic_vector(31 downto 0);
        dout_a : out std_logic_vector(31 downto 0);

        -- Port B (Internal to NPU - Driver & Post-Processing)
        addr_b : in std_logic_vector(11 downto 0);
        we_b   : in std_logic;
        din_b  : in std_logic_vector(63 downto 0);
        dout_b : out std_logic_vector(63 downto 0)
    );
end PE_scratchpad_ram;

architecture rtl of PE_scratchpad_ram is
    type data_array_t is array (0 to 1) of std_logic_vector(31 downto 0);
    signal dout_a_arr : data_array_t;
    signal dout_b_arr : data_array_t;
    signal din_b_arr  : data_array_t;
    
    signal we_a_arr  : std_logic_vector(1 downto 0);
    signal sel_a_reg : std_logic_vector(0 downto 0);
begin
    -- Address Decoding for Port A (32-bit interleaved access)
    process(addr_a, we_a)
    begin
        we_a_arr <= "00";
        if we_a = '1' then
            if addr_a(0) = '0' then
                we_a_arr(0) <= '1';
            else
                we_a_arr(1) <= '1';
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            sel_a_reg(0) <= addr_a(0);
        end if;
    end process;

    dout_a <= dout_a_arr(to_integer(unsigned(sel_a_reg)));

    -- Split 64-bit input and concatenate 64-bit output for Port B
    din_b_arr(1) <= din_b(63 downto 32);
    din_b_arr(0) <= din_b(31 downto 0);
    dout_b <= dout_b_arr(1) & dout_b_arr(0);

    GEN_BRAM: for i in 0 to 1 generate
        BRAM_INST: entity work.basic_dual_port
            generic map (
                DATA_WIDTH => 32,
                ADDR_WIDTH => 12
            )
            port map (
                -- Port A 
                clk_a  => clk,
                we_a   => we_a_arr(i),
                addr_a => addr_a(12 downto 1),
                din_a  => din_a,
                dout_a => dout_a_arr(i),
                
                -- Port B (64-bit parallel write/read)
                clk_b  => clk,
                we_b   => we_b,
                addr_b => addr_b,  
                din_b  => din_b_arr(i),
                dout_b => dout_b_arr(i)
            );
    end generate GEN_BRAM;
end rtl;
