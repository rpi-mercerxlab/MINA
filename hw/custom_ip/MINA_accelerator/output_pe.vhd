library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_pe is
    generic (
        INPUT_WIDTH : integer := 32;
        OUTPUT_WIDTH : integer := 8
    );
    port (
        clk    : in  std_logic;
        rst_n  : in  std_logic;

        -- 00: pass-through, 01: ReLU, 11: Sigmoid
        activation_function : in std_logic_vector(1 downto 0);
        input : in std_logic_vector(INPUT_WIDTH - 1 downto 0);
        output : out std_logic_vector(OUTPUT_WIDTH - 1 downto 0);

        quant_mult : in std_logic_vector(9 downto 0);
        shift_amt : in std_logic_vector(3 downto 0)
    );
end entity output_pe;

architecture Behavioral of output_pe is

    -- Input & Quantization Registers
    signal input_buffer   : signed(INPUT_WIDTH - 1 downto 0) := (others => '0');
    signal real_shift     : integer range 12 to 27;
    signal quant_mult_sig : signed(9 downto 0);
    signal scaled         : signed(41 downto 0);
    
    -- Combinational math signals
    signal rounded        : signed(41 downto 0);
    signal shifted        : signed(41 downto 0);
    
    -- The clipped 8-bit output (feeds all activation paths)
    signal quant_8b       : signed(7 downto 0);

    -- Alignment Delay Registers (2 cycles to match LUT)
    signal no_actv_d1, no_actv_d2 : signed(7 downto 0);
    signal relu_d1, relu_d2       : signed(7 downto 0);
    
    -- LUT Output
    signal sigmoid_out : std_logic_vector(7 downto 0);

begin


    -- Stage 3: Round, Shift, and Saturate (Combinational logic into a register)
    rounded <= scaled + shift_left(to_signed(1, 42), real_shift - 1);
    shifted <= shift_right(rounded, real_shift);

    SIGMOID_LUT: entity work.sigmoidLUT
        port map (
            clk => clk,
            input => std_logic_vector(quant_8b),
            output => sigmoid_out
        );

    process (clk)
    begin
        if rising_edge(clk) then
            -- Stage 1: Buffer inputs
            real_shift <= to_integer(unsigned(shift_amt)) + 12;
            quant_mult_sig <= signed(quant_mult);
            input_buffer <= signed(input);

            -- Stage 2: DSP Multiplication
            scaled <= input_buffer * quant_mult_sig;
            
            
            if shifted > 127 then
                quant_8b <= to_signed(127, 8);
            elsif shifted < -128 then
                quant_8b <= to_signed(-128, 8);
            else
                quant_8b <= resize(shifted, 8); 
            end if;

            -- Stage 4 & 5: Delay pipelines for non-LUT activations
            -- Path 1: Pure pass-through (Delayed 2 cycles)
            no_actv_d1 <= quant_8b;
            no_actv_d2 <= no_actv_d1;

            -- Path 2: ReLU (Calculate combinational, then delay 2 cycles)
            if quant_8b > 0 then
                relu_d1 <= quant_8b;
            else 
                relu_d1 <= (others => '0'); 
            end if;
            relu_d2 <= relu_d1;

        end if;
    end process;

    -- Stage 6: Final Output Multiplexer (Combinational)
    -- All data arriving here has exactly the same pipeline latency
    process(activation_function, no_actv_d2, relu_d2, sigmoid_out)
    begin
        case activation_function is 
            when "00" =>
                output <= std_logic_vector(no_actv_d2);
            when "01" =>
                output <= std_logic_vector(relu_d2);
            when "11" =>
                output <= sigmoid_out;
            when others =>
                output <= (others => '0'); -- Prevent latches
        end case;
    end process;

end architecture Behavioral;
