library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_pe is
    generic (
        INPUT_WIDTH : integer := 32;
        OUTPUT_WIDTH : integer := 8
    );
    port (
        clk   : in std_logic;
        rst_n : in std_logic;

        -- 00: pass-through, 01: ReLU, 11: Sigmoid
        activation_function : in std_logic_vector(1 downto 0);
        input  : in std_logic_vector(INPUT_WIDTH - 1 downto 0);
        output : out std_logic_vector(OUTPUT_WIDTH - 1 downto 0);

        quant_mult : in std_logic_vector(9 downto 0);
        shift_amt  : in std_logic_vector(3 downto 0)
    );
end entity output_pe;

architecture Behavioral of output_pe is
    -- Stage 1: Capture the input and its quantization settings together.
    signal input_buffer   : signed(INPUT_WIDTH - 1 downto 0) := (others => '0');
    signal shift_buf      : std_logic_vector(3 downto 0);
    signal quant_mult_sig : signed(9 downto 0);

    -- Stage 2: Product, shift count, and rounding offset for the same input.
    signal scaled     : signed(41 downto 0);
    signal real_shift : integer range 12 to 27;
    signal offset_buf : std_logic_vector(41 downto 0);

    -- Stage 3: Registered rounded product, with its matching shift count.
    signal rounded_reg   : signed(41 downto 0);
    signal real_shift_d1 : integer range 12 to 27;

    -- Stage 4: Arithmetic shift and saturation to signed int8.
    signal shifted  : signed(41 downto 0);
    signal quant_8b : signed(7 downto 0);

    -- Stages 5 and 6: Match the two-cycle sigmoid LUT latency.
    signal no_actv_d1, no_actv_d2 : signed(7 downto 0);
    signal relu_d1, relu_d2       : signed(7 downto 0);
    signal sigmoid_out          : std_logic_vector(7 downto 0);
begin
    -- Addition ends at rounded_reg. Shifting and clipping occur after it.
    shifted <= shift_right(rounded_reg, real_shift_d1);

    SIGMOID_LUT: entity work.sigmoidLUT
        port map (
            clk    => clk,
            input  => std_logic_vector(quant_8b),
            output => sigmoid_out
        );

    process(clk)
        variable stage2_shift : integer range 12 to 27;
    begin
        if rising_edge(clk) then
            -- Stage 1
            input_buffer   <= signed(input);
            quant_mult_sig <= signed(quant_mult);
            shift_buf      <= shift_amt;

            -- Stage 2
            scaled <= input_buffer * quant_mult_sig;

            -- Both settings use shift_buf; using the old real_shift for
            -- offset_buf would misalign the offset by one input sample.
            stage2_shift := to_integer(unsigned(shift_buf)) + 12;
            real_shift <= stage2_shift;
            offset_buf <= std_logic_vector(
                shift_left(to_signed(1, 42), stage2_shift - 1)
            );

            -- Stage 3: Only the rounding addition is before this register.
            rounded_reg   <= scaled + signed(offset_buf);
            real_shift_d1 <= real_shift;

            -- Stage 4: Shift and clip the registered rounded value.
            if shifted > 127 then
                quant_8b <= to_signed(127, 8);
            elsif shifted < -128 then
                quant_8b <= to_signed(-128, 8);
            else
                quant_8b <= resize(shifted, 8);
            end if;

            -- Stages 5 and 6: Pass-through and ReLU alignment.
            no_actv_d1 <= quant_8b;
            no_actv_d2 <= no_actv_d1;

            if quant_8b > 0 then
                relu_d1 <= quant_8b;
            else
                relu_d1 <= (others => '0');
            end if;
            relu_d2 <= relu_d1;
        end if;
    end process;

    -- Final combinational activation selection.
    -- Keep activation_function stable for the complete drain/writeback.
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
                output <= (others => '0');
        end case;
    end process;
end architecture Behavioral;
