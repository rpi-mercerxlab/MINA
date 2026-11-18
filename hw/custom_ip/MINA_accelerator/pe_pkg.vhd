library ieee;
use ieee.std_logic_1164.all;

package pe_pkg is
    function clog2(n : positive) return natural;

    -- Main configuration
    constant ARRAY_SIZE : positive := 8;

    -- Existing modules can keep using these names.
    constant NUM_ROWS : positive := ARRAY_SIZE;
    constant NUM_COLS : positive := ARRAY_SIZE;

    -- Keep numerical formats fixed for this change.
    constant DATA_WIDTH   : positive := 8;
    constant WEIGHT_WIDTH : positive := 8;
    constant ACC_WIDTH    : positive := 32;

    -- All three packed vectors have the same width here.
    constant VECTOR_WIDTH : positive := ARRAY_SIZE * DATA_WIDTH;

    -- One drive instruction processes this many K elements.
    -- ARRAY_SIZE preserves the square-tile convention.
    constant DRIVE_LENGTH : positive := ARRAY_SIZE;

    -- Memory configuration
    constant HOST_DATA_WIDTH : positive := 32;
    constant RAM_ADDR_WIDTH  : positive := 12;

    constant NUM_BANKS : positive :=
        VECTOR_WIDTH / HOST_DATA_WIDTH;

    constant BANK_SEL_WIDTH : natural := clog2(NUM_BANKS);

    constant HOST_ADDR_WIDTH : positive :=
        RAM_ADDR_WIDTH + BANK_SEL_WIDTH;

    -- Existing post-processing/write-enable alignment
    constant WRITEBACK_LATENCY : positive := 6;

    type weight_row_t is array (0 to NUM_COLS-1)
        of std_logic_vector(WEIGHT_WIDTH-1 downto 0);

    type data_col_t is array (0 to NUM_ROWS-1)
        of std_logic_vector(DATA_WIDTH-1 downto 0);

    type accum_row_t is array (0 to NUM_COLS-1)
        of std_logic_vector(ACC_WIDTH-1 downto 0);
end package;

package body pe_pkg is
    function clog2(n : positive) return natural is
        variable v : natural := n - 1;
        variable r : natural := 0;
    begin
        while v > 0 loop
            v := v / 2;
            r := r + 1;
        end loop;
        return r;
    end function;
end package body;
