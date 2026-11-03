library ieee;
use ieee.std_logic_1164.all;
use work.pe_pkg.all; 

entity processing_row is
    port (
        clk                 : in  std_logic;
        rst_n               : in  std_logic;
        
        -- Control signals packed from the Decoder's drain instruction
        activation_function : in  std_logic_vector(1 downto 0);
        quant_mult          : in  std_logic_vector(9 downto 0);
        shift_amt           : in  std_logic_vector(3 downto 0);
        
        -- 8x32-bit parallel row from PE_arr bottom_out
        row_in              : in  accum_row_t;
        
        -- Packed 64-bit output to PE_arr_driver scratchpad_in
        row_out             : out std_logic_vector(63 downto 0)
    );
end entity processing_row;

architecture rtl of processing_row is
    -- Intermediate array to catch the 8-bit outputs before concatenation
    type quant_out_array_t is array (0 to NUM_COLS-1) of std_logic_vector(7 downto 0);
    signal quant_out_arr : quant_out_array_t;
begin

    GEN_POST_PROC: for i in 0 to NUM_COLS-1 generate
        PE_OUT_INST: entity work.output_pe
            generic map (
                INPUT_WIDTH  => ACC_WIDTH, -- 32
                OUTPUT_WIDTH => 8
            )
            port map (
                clk                 => clk,
                rst_n               => rst_n,
                activation_function => activation_function,
                quant_mult          => quant_mult,
                shift_amt           => shift_amt,
                input               => row_in(i),
                output              => quant_out_arr(i)
            );
            
        -- Map the 8-bit output directly to the correct slice of the 64-bit vector.
        -- Column 0 goes to bits 7:0, Column 1 to 15:8, up to Column 7 (bits 63:56)
        row_out((i*8) + 7 downto i*8) <= quant_out_arr(i);
    end generate GEN_POST_PROC;

end architecture rtl;
