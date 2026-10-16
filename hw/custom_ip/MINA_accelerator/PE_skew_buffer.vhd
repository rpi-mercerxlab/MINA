library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity SkewBuffer is
    port (
        clk            : in  std_logic;
        rst_n          : in  std_logic;
        -- Keep enabled while feeding and flushing; the PE pipeline does not stall.
        enable         : in  std_logic;

        raw_weights    : in  weight_row_t;
        raw_data       : in  data_col_t;

        skewed_weights : out weight_row_t;
        skewed_data    : out data_col_t
    );
end entity SkewBuffer;

architecture RTL of SkewBuffer is

    -- 2D array for Weight delay lines: (column_index, delay_stage)
    -- Each column j uses 2*j stages to match the two-register PE forwarding path.
    type weight_delay_grid_t is array (0 to NUM_COLS-1, 0 to 2*(NUM_COLS-1)-1) 
        of std_logic_vector(WEIGHT_WIDTH-1 downto 0);
        
    -- 2D array for Data delay lines: (row_index, delay_stage)
    type data_delay_grid_t is array (0 to NUM_ROWS-1, 0 to 2*(NUM_ROWS-1)-1) 
        of std_logic_vector(DATA_WIDTH-1 downto 0);

    signal weight_sr : weight_delay_grid_t := (others => (others => (others => '0')));
    signal data_sr   : data_delay_grid_t   := (others => (others => (others => '0')));

begin

    ----------------------------------------------------------------------------
    -- 1. Weight Skew Generation (Top Edge)
    -- Column j receives 2*j clock cycles of delay
    ----------------------------------------------------------------------------
    gen_weight_skew: for j in 0 to NUM_COLS - 1 generate
        
        -- Column 0: 0 cycles delay (direct pass-through)
        gen_w_col0: if j = 0 generate
            skewed_weights(0) <= raw_weights(0);
        end generate gen_w_col0;

        -- Columns 1 to NUM_COLS-1: j cycles of shift register delay
        gen_w_col_n: if j > 0 generate
            process(clk, rst_n)
            begin
                if rst_n = '0' then
                    for d in 0 to 2*j - 1 loop
                        weight_sr(j, d) <= (others => '0');
                    end loop;
                elsif rising_edge(clk) then
                    if enable = '1' then
                        -- Stage 0 takes the fresh input
                        weight_sr(j, 0) <= raw_weights(j);
                        -- Subsequent stages shift down the line
                        for d in 1 to 2*j - 1 loop
                            weight_sr(j, d) <= weight_sr(j, d - 1);
                        end loop;
                    end if;
                end if;
            end process;

            -- Tap the last of the 2*j delay stages.
            skewed_weights(j) <= weight_sr(j, 2*j - 1);
        end generate gen_w_col_n;

    end generate gen_weight_skew;

    ----------------------------------------------------------------------------
    -- 2. Data Skew Generation (Left Edge)
    -- Row i receives 2*i clock cycles of delay
    ----------------------------------------------------------------------------
    gen_data_skew: for i in 0 to NUM_ROWS - 1 generate

        -- Row 0: 0 cycles delay (direct pass-through)
        gen_d_row0: if i = 0 generate
            skewed_data(0) <= raw_data(0);
        end generate gen_d_row0;

        -- Rows 1 to NUM_ROWS-1: i cycles of shift register delay
        gen_d_row_n: if i > 0 generate
            process(clk, rst_n)
            begin
                if rst_n = '0' then
                    for d in 0 to 2*i - 1 loop
                        data_sr(i, d) <= (others => '0');
                    end loop;
                elsif rising_edge(clk) then
                    if enable = '1' then
                        -- Stage 0 takes the fresh input
                        data_sr(i, 0) <= raw_data(i);
                        -- Subsequent stages shift down the line
                        for d in 1 to 2*i - 1 loop
                            data_sr(i, d) <= data_sr(i, d - 1);
                        end loop;
                    end if;
                end if;
            end process;

            -- Tap the last of the 2*i delay stages.
            skewed_data(i) <= data_sr(i, 2*i - 1);
        end generate gen_d_row_n;

    end generate gen_data_skew;

end architecture RTL;
