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

begin
    -- One process owns both arrays: no overlapping drivers.
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            weight_sr <= (others => (others => (others => '0')));
            data_sr   <= (others => (others => (others => '0')));

        elsif rising_edge(clk) then
            if enable = '1' then
                for j in 1 to NUM_COLS-1 loop
                    weight_sr(j, 0) <= raw_weights(j);

                    for d in 1 to 2*j-1 loop
                        weight_sr(j, d) <= weight_sr(j, d-1);
                    end loop;
                end loop;

                for i in 1 to NUM_ROWS-1 loop
                    data_sr(i, 0) <= raw_data(i);

                    for d in 1 to 2*i-1 loop
                        data_sr(i, d) <= data_sr(i, d-1);
                    end loop;
                end loop;
            end if;
        end if;
    end process;

    -- Lane zero has no skew delay.
    skewed_weights(0) <= raw_weights(0);
    skewed_data(0)    <= raw_data(0);

    gen_weight_outputs : for j in 1 to NUM_COLS-1 generate
        skewed_weights(j) <= weight_sr(j, 2*j-1);
    end generate;

    gen_data_outputs : for i in 1 to NUM_ROWS-1 generate
        skewed_data(i) <= data_sr(i, 2*i-1);
    end generate;

end architecture RTL;
