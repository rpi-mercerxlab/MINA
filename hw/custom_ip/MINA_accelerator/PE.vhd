library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pengine is
    generic (
        DATA_WIDTH : integer := 8;
        WEIGHT_WIDTH : integer := 8;
        ACC_WIDTH : integer := 32
    );
    port (
        -- Basics
        clk    : in  std_logic;
        rst_n    : in  std_logic;

        -- Control Signals
        clear_acc : in std_logic;
        valid_in : in std_logic;
        drain : in std_logic;

        -- Data in
        weight_in : in std_logic_vector(WEIGHT_WIDTH-1 downto 0);
        value_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
        drain_in : in std_logic_vector(ACC_WIDTH-1 downto 0);
        
        -- Outputs
        weight_passthrough : out std_logic_vector(WEIGHT_WIDTH-1 downto 0);
        value_passthrough : out std_logic_vector(DATA_WIDTH-1 downto 0);
        output_shift : out std_logic_vector(ACC_WIDTH-1 downto 0)
        
    );
end entity Pengine;

architecture Behavioral of Pengine is

    -- Stage 1: Input Buffers
    signal weight_buf : std_logic_vector(WEIGHT_WIDTH-1 downto 0) := (others => '0');
    signal value_buf : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    
    -- Stage 2: Delay Buffers (matches multiplier latency)
    signal weight_delay : std_logic_vector(WEIGHT_WIDTH-1 downto 0) := (others => '0');
    signal value_delay : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

    -- Math Signals
    -- Note: 8-bit * 8-bit = 16-bit. We hold the exact width here for the DSP, 
    -- then sign-extend when adding to the 32-bit accumulator.
    signal mult_output : signed(DATA_WIDTH+WEIGHT_WIDTH-1 downto 0) := (others => '0');
    signal accum : signed(ACC_WIDTH-1 downto 0) := (others => '0');

    attribute use_dsp : string;
    attribute use_dsp of mult_output : signal is "yes";

begin

process (clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            accum <= (others => '0'); 
            weight_buf <= (others => '0'); 
            value_buf <= (others => '0'); 
            weight_delay <= (others => '0');
            value_delay <= (others => '0');
            mult_output <= (others => '0');
            output_shift <= (others => '0');
        else
            if valid_in = '1' then
                --if valid input, take in data
                weight_buf <= weight_in;
                value_buf <= value_in;
            else
                --otherwise, set to zero
                weight_buf <= (others => '0');
                value_buf <= (others => '0');
            end if;
            
            --go to mult buffer
            mult_output <= signed(weight_buf) * signed(value_buf);

            --delay buffers to create latency equal to that of multiplcation for passthrough
            weight_delay <= weight_buf;
            value_delay <= value_buf;

            -- accumulator and drain logic
            if drain = '1' then
                -- Shift mode: pass the accumulator from the PE above us down the chain
                accum <= signed(drain_in);
            elsif clear_acc = '1' then
                accum <= resize(mult_output, ACC_WIDTH);
            else
                accum <= accum + resize(mult_output, ACC_WIDTH);
            end if;

            -- Always output the current accumulator value to the PE below us
            output_shift <= std_logic_vector(accum);

        end if;
    end if;
end process;

weight_passthrough <= weight_delay;
value_passthrough <= value_delay;

end architecture Behavioral;
