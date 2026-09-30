library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Define types for the array boundaries (can also be put in a separate package)
package pe_pkg is
    constant NUM_ROWS : integer := 16;
    constant NUM_COLS : integer := 16;
    constant DATA_WIDTH : integer := 8;
    constant WEIGHT_WIDTH : integer := 8;
    constant ACC_WIDTH : integer := 32;

    type weight_row_t is array (0 to NUM_COLS-1) of std_logic_vector(WEIGHT_WIDTH-1 downto 0);
    type data_col_t   is array (0 to NUM_ROWS-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type accum_row_t  is array (0 to NUM_COLS-1) of std_logic_vector(ACC_WIDTH-1 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use work.pe_pkg.all;

entity PEarray is
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;

        -- Global Controls (Broadcast to all PEs for this basic example)
        clear_acc: in std_logic;
        valid_in : in std_logic;
        drain    : in std_logic;

        -- Array Boundaries
        top_weights : in  weight_row_t;
        left_data   : in  data_col_t;
        bottom_out  : out accum_row_t
    );
end entity PEarray;

architecture Structural of PEarray is

    -- Internal grid wires
    type weight_grid_t is array (0 to NUM_ROWS, 0 to NUM_COLS-1) of std_logic_vector(WEIGHT_WIDTH-1 downto 0);
    type data_grid_t   is array (0 to NUM_ROWS-1, 0 to NUM_COLS) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type accum_grid_t  is array (0 to NUM_ROWS, 0 to NUM_COLS-1) of std_logic_vector(ACC_WIDTH-1 downto 0);

    signal weight_wires : weight_grid_t;
    signal data_wires   : data_grid_t;
    signal accum_wires  : accum_grid_t;

begin

    -- 1. Drive the boundaries of the grid
    boundary_setup: for j in 0 to NUM_COLS - 1 generate
        weight_wires(0, j) <= top_weights(j);
        accum_wires(0, j)  <= (others => '0'); -- The top row receives 0s when draining
        bottom_out(j)      <= accum_wires(NUM_ROWS, j); -- The final output is grabbed from the bottom
    end generate;

    boundary_setup_data: for i in 0 to NUM_ROWS - 1 generate
        data_wires(i, 0) <= left_data(i);
    end generate;

    -- 2. Generate the PE Array
    gen_rows: for i in 0 to NUM_ROWS - 1 generate
        gen_cols: for j in 0 to NUM_COLS - 1 generate

            pe_inst: entity work.Pengine
                generic map (
                    DATA_WIDTH => DATA_WIDTH,
                    WEIGHT_WIDTH => WEIGHT_WIDTH,
                    ACC_WIDTH => ACC_WIDTH
                )
                port map (
                    clk => clk,
                    rst_n => rst_n,

                    -- Controls
                    clear_acc => clear_acc,
                    valid_in  => valid_in,
                    drain     => drain,

                    -- Inputs coming from the PE above (or top boundary)
                    weight_in => weight_wires(i, j),
                    drain_in  => accum_wires(i, j),
                    
                    -- Inputs coming from the PE to the left (or left boundary)
                    value_in  => data_wires(i, j),

                    -- Outputs going to the PE below
                    weight_passthrough => weight_wires(i + 1, j),
                    output_shift       => accum_wires(i + 1, j),
                    
                    -- Outputs going to the PE to the right
                    value_passthrough  => data_wires(i, j + 1)
                );
        end generate gen_cols;
    end generate gen_rows;

end architecture Structural;
