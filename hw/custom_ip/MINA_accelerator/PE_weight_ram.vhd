library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PE_weight_ram is
    port (
        clk : in std_logic;
        
        addr_a : in std_logic_vector(12 downto 0);
        we_a   : in std_logic;
        din_a  : in std_logic_vector(31 downto 0);
        dout_a : out std_logic_vector(31 downto 0);

        addr_b : in std_logic_vector(11 downto 0);
        dout_b : out std_logic_vector(63 downto 0)
    );
end PE_weight_ram;

architecture rtl of PE_weight_ram is
    -- Custom array type for organizing the data lines
    type data_array_t is array (0 to 1) of std_logic_vector(31 downto 0);
    signal dout_a_arr : data_array_t;
    signal dout_b_arr : data_array_t;
    
    signal we_a_arr  : std_logic_vector(1 downto 0);
    signal sel_a_reg : std_logic_vector(0 downto 0);
begin
    -- 1. Address Decoding for Port A Write Enable
    -- Only one BRAM is written to at a time based on addr_a(0)
    process(addr_a, we_a)
    begin
        we_a_arr <= "00";
        if we_a = '1' then
            if addr_a(0) = '0' then
                we_a_arr(0) <= '1'; -- BRAM A
            else
                we_a_arr(1) <= '1'; -- BRAM B
            end if;
        end if;
    end process;

    -- 2. Register Port A Select Bits
    -- BRAM read data arrives 1 clock cycle after address is presented.
    -- We must delay the select signal by 1 clock to mux the correct output.
    process(clk)
    begin
        if rising_edge(clk) then
            sel_a_reg(0) <= addr_a(0);
        end if;
    end process;

    -- 3. Multiplex Port A Output
    dout_a <= dout_a_arr(to_integer(unsigned(sel_a_reg)));

    -- 4. Concatenate Port B Output (64 bits parallel)
    -- dout_b_arr(1) is MSB (bits 63:32), dout_b_arr(0) is LSB (bits 31:0)
    dout_b <= dout_b_arr(1) & dout_b_arr(0);

    -- 5. Generate 2 BRAM instances
    GEN_BRAM: for i in 0 to 1 generate
        BRAM_INST: entity work.basic_dual_port
            generic map (
                DATA_WIDTH => 32,
                ADDR_WIDTH => 12
            )
            port map (
                -- Port A (32-bit interleaved access)
                clk_a  => clk,
                we_a   => we_a_arr(i),
                addr_a => addr_a(12 downto 1), -- Drop lowest 1 bit (select bit)
                din_a  => din_a,
                dout_a => dout_a_arr(i),
                
                -- Port B (64-bit parallel access)
                clk_b  => clk,
                we_b   => '0',
                -- Port B is Read-Only, padded to 13 bits to match ADDR_WIDTH
                addr_b => addr_b,  
                din_b  => (others => '0'),
                dout_b => dout_b_arr(i)
            );
    end generate GEN_BRAM;
end rtl;
