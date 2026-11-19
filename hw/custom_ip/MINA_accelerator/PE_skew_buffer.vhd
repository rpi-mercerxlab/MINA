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
        -- One complete matrix row per enabled clock, in row 0..N-1 order.
        raw_data       : in  data_col_t;

        skewed_weights : out weight_row_t;
        skewed_data    : out data_col_t
    );
end entity SkewBuffer;

architecture RTL of SkewBuffer is
    type weight_delay_grid_t is array (
        0 to NUM_COLS-1,
        0 to 2*(NUM_COLS-1)-1
    ) of std_logic_vector(WEIGHT_WIDTH-1 downto 0);

    type data_delay_grid_t is array (
        0 to NUM_ROWS-1,
        0 to 2*(NUM_ROWS-1)-1
    ) of std_logic_vector(DATA_WIDTH-1 downto 0);

    signal weight_sr : weight_delay_grid_t :=
        (others => (others => (others => '0')));

    signal data_sr : data_delay_grid_t :=
        (others => (others => (others => '0')));

    signal row_index : natural range 0 to NUM_ROWS-1 := 0;

begin
    assert NUM_ROWS = NUM_COLS and NUM_ROWS >= 2
        report "SkewBuffer transposition requires a square array of size >= 2"
        severity failure;

    assert DRIVE_LENGTH = NUM_ROWS
        report "SkewBuffer expects exactly NUM_ROWS input rows per drive"
        severity failure;

    -- One process owns both arrays: no overlapping drivers.
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            weight_sr <= (others => (others => (others => '0')));
            data_sr   <= (others => (others => (others => '0')));
            row_index <= 0;

        elsif rising_edge(clk) then
            if enable = '1' then
                for j in 1 to NUM_COLS-1 loop
                    weight_sr(j, 0) <= raw_weights(j);

                    for d in 1 to 2*j-1 loop
                        weight_sr(j, d) <= weight_sr(j, d-1);
                    end loop;
                end loop;

                -- Lane i needs N+i-1 registers. Shift toward stage zero,
                -- which is the output, and insert the current row in parallel.
                for i in 0 to NUM_ROWS-1 loop
                    for d in 0 to NUM_ROWS+i-3 loop
                        data_sr(i, d) <= data_sr(i, d+1);
                    end loop;
                    data_sr(i, NUM_ROWS+i-2) <= (others => '0');
                end loop;

                -- Row zero starts immediately, so its first element bypasses
                -- the registers. Its remaining elements follow on later clocks.
                if row_index = 0 then
                    for k in 1 to NUM_ROWS-1 loop
                        data_sr(0, k-1) <= raw_data(k);
                    end loop;
                end if;

                -- Row i arrives i clocks after row zero. Insert its element k
                -- with i+k clocks of delay: output time is 2*i+k, exactly the
                -- existing two-clocks-per-lane skew, with no extra startup.
                for i in 1 to NUM_ROWS-1 loop
                    if row_index = i then
                        for k in 0 to NUM_ROWS-1 loop
                            data_sr(i, i+k-1) <= raw_data(k);
                        end loop;
                    end if;
                end loop;

                -- Wrap after each square tile, including back-to-back drives.
                -- A new row occupies the stages just vacated by the old row;
                -- its still-pending tail remains in the lower stages.
                if row_index = NUM_ROWS-1 then
                    row_index <= 0;
                else
                    row_index <= row_index + 1;
                end if;
            end if;
        end if;
    end process;

    skewed_weights(0) <= raw_weights(0);
    skewed_data(0)    <= raw_data(0) when row_index = 0 else data_sr(0, 0);

    gen_weight_outputs : for j in 1 to NUM_COLS-1 generate
        skewed_weights(j) <= weight_sr(j, 2*j-1);
    end generate;

    gen_data_outputs : for i in 1 to NUM_ROWS-1 generate
        skewed_data(i) <= data_sr(i, 0);
    end generate;

end architecture RTL;
