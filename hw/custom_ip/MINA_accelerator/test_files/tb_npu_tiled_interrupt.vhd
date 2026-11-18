library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;
use work.pe_pkg.all;

entity tb_npu_tiled_interrupt is
end entity tb_npu_tiled_interrupt;

architecture sim of tb_npu_tiled_interrupt is
    constant PERIOD : time := 10 ns;

    -- 64x64 Matrix Tiling Configuration (8x8 grid of 8x8 tiles)
    constant NUM_TILES   : natural := 8; -- 8x8 tiles = 64x64 total matrix
    constant MAT_DIM     : natural := NUM_TILES * ARRAY_SIZE; -- 64
    constant VECS_PER_TILE : natural := 8;
    constant TOTAL_TILES : natural := NUM_TILES * NUM_TILES;  -- 64 tiles per matrix
    constant MATRIX_VECS : natural := TOTAL_TILES * VECS_PER_TILE; -- 512 64-bit vectors

    -- Memory Map (in 64-bit vector addresses, Port B view)
    -- Scratchpad [0 .. 511]    : Input Matrix A (64x64, tiled)
    -- Scratchpad [512 .. 1023] : Output Matrix C (64x64, tiled)
    -- Weight RAM [0 .. 511]    : Weight Matrix B (64x64, tiled)
    constant A_BASE_VEC : natural := 0;
    constant B_BASE_VEC : natural := 0;
    constant C_BASE_VEC : natural := 512;
    constant EXPECTED_FINAL_INT_ADDR : natural := C_BASE_VEC + MATRIX_VECS; -- 1024 (0x400)

    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';

    -- Host RAM interfaces
    signal instr_we, weight_we, scratchpad_we : std_logic := '0';
    signal instr_addr : std_logic_vector(9 downto 0) := (others => '0');
    signal instr_din, instr_dout : std_logic_vector(35 downto 0) := (others => '0');
    signal weight_addr_a, scratchpad_addr_a : std_logic_vector(HOST_ADDR_WIDTH-1 downto 0) := (others => '0');
    signal weight_din, weight_dout, scratchpad_din, scratchpad_dout : std_logic_vector(31 downto 0) := (others => '0');

    -- Top-level Interrupt Controller signals
    signal clear_int : std_logic := '0';
    signal interrupt : std_logic;
    signal int_addr  : std_logic_vector(11 downto 0);

    type full_matrix_t is array (0 to MAT_DIM-1, 0 to MAT_DIM-1) of integer;

    -- Helper functions to build 36-bit instructions cleanly
    function encode_addi(rt : natural; rs : natural; imm : integer) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"06";
        res(27 downto 24) := std_logic_vector(to_unsigned(rt, 4));
        res(23 downto 20) := std_logic_vector(to_unsigned(rs, 4));
        res(19 downto 4)  := std_logic_vector(to_signed(imm, 16));
        return res;
    end function;

    function encode_beq(rt : natural; rs : natural; target_pc : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"07";
        res(27 downto 24) := std_logic_vector(to_unsigned(rt, 4));
        res(23 downto 20) := std_logic_vector(to_unsigned(rs, 4));
        res(19 downto 10) := std_logic_vector(to_unsigned(target_pc, 10));
        return res;
    end function;

    function encode_jump(target_pc : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"05";
        res(27 downto 18) := std_logic_vector(to_unsigned(target_pc, 10));
        return res;
    end function;

    function encode_drive_reg(src : std_logic_vector(1 downto 0); data_rs : natural; weight_rs : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"0A";
        res(27 downto 26) := src;
        res(25 downto 22) := std_logic_vector(to_unsigned(data_rs, 4));
        res(21 downto 18) := std_logic_vector(to_unsigned(weight_rs, 4));
        return res;
    end function;

    function encode_drain_reg(addr_rs : natural; act : std_logic_vector(1 downto 0); shift : natural; mult : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"0B";
        res(27 downto 24) := std_logic_vector(to_unsigned(addr_rs, 4));
        res(15 downto 14) := act;
        res(13 downto 10) := std_logic_vector(to_unsigned(shift, 4));
        res(9 downto 0)   := std_logic_vector(to_unsigned(mult, 10));
        return res;
    end function;

    function encode_set_int_reg(addr_rs : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"0C";
        res(27 downto 24) := std_logic_vector(to_unsigned(addr_rs, 4));
        return res;
    end function;

begin
    clk <= not clk after PERIOD / 2;

    dut : entity work.NPU
        port map (
            clk               => clk,
            rst_n             => rst_n,
            instr_we          => instr_we,
            instr_addr        => instr_addr,
            instr_din         => instr_din,
            instr_dout        => instr_dout,
            weight_we         => weight_we,
            weight_addr_a     => weight_addr_a,
            weight_din        => weight_din,
            weight_dout       => weight_dout,
            scratchpad_we     => scratchpad_we,
            scratchpad_addr_a => scratchpad_addr_a,
            scratchpad_din    => scratchpad_din,
            scratchpad_dout   => scratchpad_dout,
            clear_int         => clear_int,
            interrupt         => interrupt,
            int_addr          => int_addr
        );

    stimulus : process
        variable A, B : full_matrix_t;
        variable packed, got : std_logic_vector(31 downto 0);
        variable vec_addr : natural;
        variable dot_product, expected, actual : integer;
        variable start_time, end_time : time;
        variable total_cycles : natural;

        procedure write_word(
            signal addr : out std_logic_vector;
            signal din  : out std_logic_vector;
            signal we   : out std_logic;
            constant address : natural;
            constant value   : std_logic_vector
        ) is
        begin
            wait until falling_edge(clk);
            addr <= std_logic_vector(to_unsigned(address, addr'length));
            din  <= value;
            we   <= '1';
            wait until rising_edge(clk);
            wait for 1 ns;
            we   <= '0';
        end procedure;

        procedure read_scratch(
            constant address : natural;
            variable value   : out std_logic_vector(31 downto 0)
        ) is
        begin
            wait until falling_edge(clk);
            scratchpad_addr_a <= std_logic_vector(to_unsigned(address, scratchpad_addr_a'length));
            wait until rising_edge(clk);
            wait for 1 ns;
            value := scratchpad_dout;
        end procedure;

    begin
        -- 1. Hold Reset during memory initialization
        wait until falling_edge(clk);
        rst_n     <= '0';
        clear_int <= '0';
        for n in 1 to 5 loop
            wait until rising_edge(clk);
        end loop;

        report "Initializing 64x64 matrices A and B in tiled layout (512 tile MACs)..." severity note;

        -- 2. Generate deterministic 64x64 matrices A and B
        -- Using small signed values (-2 to +2) multiplied by 4 so that:
        --   a) 64-element dot products never clip [-128, 127] after scaling
        --   b) Every dot product is an exact multiple of 16 (exact division with quant_mult=256, shift=0)
        for r in 0 to MAT_DIM-1 loop
            for c in 0 to MAT_DIM-1 loop
                A(r, c) := (((r * 3 + c * 5) mod 5) - 2) * 4; -- {-8, -4, 0, 4, 8}
                B(r, c) := (((r * 7 + c * 2) mod 5) - 2) * 4; -- {-8, -4, 0, 4, 8}
            end loop;
        end loop;

        -- 3. Pack A and B into 8x8 tiles in Scratchpad and Weight RAM
        -- Tile (ti, tj) starts at vector address: (ti * NUM_TILES + tj) * 8
        for ti in 0 to NUM_TILES-1 loop
            for tj in 0 to NUM_TILES-1 loop
                for k in 0 to 7 loop
                    vec_addr := (ti * NUM_TILES + tj) * 8 + k;
                    for half in 0 to 1 loop
                        -- Pack column k of tile A(ti, tj)
                        for lane in 0 to 3 loop
                            packed(8*lane+7 downto 8*lane) :=
                                std_logic_vector(to_signed(A(ti*8 + 4*half + lane, tj*8 + k), 8));
                        end loop;
                        write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, 2*(A_BASE_VEC + vec_addr) + half, packed);

                        -- Pack row k of tile B(ti, tj)
                        for lane in 0 to 3 loop
                            packed(8*lane+7 downto 8*lane) :=
                                std_logic_vector(to_signed(B(ti*8 + k, tj*8 + 4*half + lane), 8));
                        end loop;
                        write_word(weight_addr_a, weight_din, weight_we, 2*(B_BASE_VEC + vec_addr) + half, packed);
                    end loop;
                end loop;
            end loop;
        end loop;

        -- 4. Load 24-Instruction Tiled GEMM + Interrupt Program into Instruction BRAM
        report "Loading NPU instruction stream..." severity note;

        -- Setup constants (using even registers R2, R4, R6, R8, R10, R12, R14 for BEQ compatibility)
        write_word(instr_addr, instr_din, instr_we, 0,  encode_addi(2,  0, NUM_TILES));  -- R2  = 8 (NUM_TILES)
        write_word(instr_addr, instr_din, instr_we, 1,  encode_addi(10, 0, C_BASE_VEC)); -- R10 = 512 (C_BASE_VEC)
        write_word(instr_addr, instr_din, instr_we, 2,  encode_addi(4,  0, 0));          -- R4  = 0 (i = 0)
        write_word(instr_addr, instr_din, instr_we, 3,  encode_addi(12, 0, 0));          -- R12 = 0 (a_row_base = 0)

        -- Outer Loop: for i = 0 to 7
        write_word(instr_addr, instr_din, instr_we, 4,  encode_beq(4, 2, 24));           -- if i == 8 goto PC 24 (Done!)
        write_word(instr_addr, instr_din, instr_we, 5,  encode_addi(6,  0, 0));          -- R6  = 0 (j = 0)
        write_word(instr_addr, instr_din, instr_we, 6,  encode_addi(14, 0, 0));          -- R14 = 0 (b_col_base = 0)

        -- Middle Loop: for j = 0 to 7
        write_word(instr_addr, instr_din, instr_we, 7,  encode_beq(6, 2, 21));           -- if j == 8 goto PC 21 (next i)
        write_word(instr_addr, instr_din, instr_we, 8,  x"010000000");                   -- CLEAR accumulators
        write_word(instr_addr, instr_din, instr_we, 9,  encode_addi(8,  0, 0));          -- R8  = 0 (k = 0)
        write_word(instr_addr, instr_din, instr_we, 10, encode_addi(1, 12, 0));          -- R1  = R12 (a_ptr = a_row_base)
        write_word(instr_addr, instr_din, instr_we, 11, encode_addi(3, 14, 0));          -- R3  = R14 (b_ptr = b_col_base)

        -- Inner Loop: for k = 0 to 7 (accumulates 8 tiles into PE array)
        write_word(instr_addr, instr_din, instr_we, 12, encode_beq(8, 2, 18));           -- if k == 8 goto PC 18 (drain)
        write_word(instr_addr, instr_din, instr_we, 13, encode_drive_reg("00", 1, 3));   -- DRIVE_REG A=R1, B=R3
        write_word(instr_addr, instr_din, instr_we, 14, encode_addi(1, 1, 8));           -- R1 += 8  (next A tile in row)
        write_word(instr_addr, instr_din, instr_we, 15, encode_addi(3, 3, 64));          -- R3 += 64 (next B tile in col)
        write_word(instr_addr, instr_din, instr_we, 16, encode_addi(8, 8, 1));           -- R8 += 1  (k++)
        write_word(instr_addr, instr_din, instr_we, 17, encode_jump(12));                -- JUMP to PC 12

        -- Drain completed 8x8 tile C(i, j) to Scratchpad[R10]
        write_word(instr_addr, instr_din, instr_we, 18, encode_drain_reg(10, "00", 0, 256)); -- DRAIN_REG addr=R10, mult=256
        write_word(instr_addr, instr_din, instr_we, 19, encode_addi(10, 10, 8));         -- R10 += 8 (c_ptr += 8)
        write_word(instr_addr, instr_din, instr_we, 20, encode_addi(14, 14, 8));         -- R14 += 8 (b_col_base += 8)
        write_word(instr_addr, instr_din, instr_we, 21, encode_addi(6, 6, 1));           -- R6  += 1 (j++) -- Wait: PC 7 jumps to 22!
        -- Let's align targets cleanly:
        -- Rewrite PC 7 to jump to 22:
        write_word(instr_addr, instr_din, instr_we, 7,  encode_beq(6, 2, 23));           -- if j == 8 goto PC 23 (next i)
        write_word(instr_addr, instr_din, instr_we, 22, encode_jump(7));                 -- JUMP to PC 7 (middle loop)

        -- End of Middle Loop -> Increment i
        write_word(instr_addr, instr_din, instr_we, 23, encode_addi(12, 12, 64));        -- R12 += 64 (a_row_base += 64)
        write_word(instr_addr, instr_din, instr_we, 24, encode_addi(4, 4, 1));           -- R4  += 1  (i++)
        write_word(instr_addr, instr_din, instr_we, 25, encode_jump(4));                 -- JUMP to PC 4 (outer loop)
        -- Update PC 4 to jump to 26 when i == 8:
        write_word(instr_addr, instr_din, instr_we, 4,  encode_beq(4, 2, 26));           -- if i == 8 goto PC 26 (Interrupt!)

        -- Completion Sequence: Set Interrupt Address from R10 (0x0C) and Trigger Interrupt (0x03)
        write_word(instr_addr, instr_din, instr_we, 26, encode_set_int_reg(10));         -- Opcode 0x0C: int_addr <= R10 (1024)
        write_word(instr_addr, instr_din, instr_we, 27, x"030000000");                   -- Opcode 0x03: trigger_interrupt <= '1'
        write_word(instr_addr, instr_din, instr_we, 28, encode_jump(28));                -- Halt loop

        -- 5. Release Reset and Wait for NPU Interrupt!
        report "Releasing reset and waiting for NPU interrupt..." severity note;
        wait until falling_edge(clk);
        start_time := now;
        rst_n <= '1';

        -- Wait dynamically for the NPU to finish all 512 tile drives and 64 tile drains
        wait until rising_edge(clk) and interrupt = '1';
        end_time := now;
        total_cycles := (end_time - start_time) / PERIOD;

        report "INTERRUPT RECEIVED after " & integer'image(total_cycles) & " clock cycles!" severity note;
        report "Interrupt Target Address (int_addr) = " & integer'image(to_integer(unsigned(int_addr))) severity note;

        -- Verify the register-sourced interrupt address (Opcode 0x0C) latched R10 = 1024
        assert to_integer(unsigned(int_addr)) = EXPECTED_FINAL_INT_ADDR
            report "Interrupt address mismatch! Expected " & integer'image(EXPECTED_FINAL_INT_ADDR) &
                   " got " & integer'image(to_integer(unsigned(int_addr)))
            severity failure;

        -- Test clearing the interrupt
        wait until falling_edge(clk);
        clear_int <= '1';
        wait until rising_edge(clk);
        wait for 1 ns;
        clear_int <= '0';
        wait until rising_edge(clk);
        wait for 1 ns;
        assert interrupt = '0'
            report "Interrupt line failed to clear after clear_int = '1'"
            severity failure;

        -- 6. Verify all 4,096 output elements (64 tiles x 64 elements) in Scratchpad RAM
        report "Verifying all 4,096 output elements across 64 8x8 tiles..." severity note;
        for ti in 0 to NUM_TILES-1 loop
            for tj in 0 to NUM_TILES-1 loop
                for r in 0 to 7 loop
                    vec_addr := C_BASE_VEC + (ti * NUM_TILES + tj) * 8 + r;
                    for half in 0 to 1 loop
                        read_scratch(2 * vec_addr + half, got);
                        assert not is_x(got)
                            report "X detected in tile (" & integer'image(ti) & "," & integer'image(tj) & ")"
                            severity failure;

                        for lane in 0 to 3 loop
                            dot_product := 0;
                            for k in 0 to MAT_DIM-1 loop
                                dot_product := dot_product + A(ti*8 + r, k) * B(k, tj*8 + 4*half + lane);
                            end loop;

                            expected := dot_product / 16;
                            if expected > 127 then expected := 127; end if;
                            if expected < -128 then expected := -128; end if;

                            actual := to_integer(signed(got(8*lane+7 downto 8*lane)));
                            assert actual = expected
                                report "Mismatch at Global(" & integer'image(ti*8 + r) & "," &
                                       integer'image(tj*8 + 4*half + lane) & ") [Tile " &
                                       integer'image(ti) & "," & integer'image(tj) & "]: expected=" &
                                       integer'image(expected) & " got=" & integer'image(actual)
                                severity failure;
                        end loop;
                    end loop;
                end loop;
            end loop;
        end loop;

        report "==================================================================" severity note;
        report "PASS: 64x64 Tiled GEMM (512 8x8 Tile MACs, 64 Tile Drains, 4096 Outputs)" severity note;
        report "PASS: Register-sourced Interrupt Address (0x0C) & Trigger (0x03) Verified!" severity note;
        report "==================================================================" severity note;
        finish;
        wait;
    end process;

    -- Safety Watchdog (512 drives + 64 drains takes ~15,500 cycles = ~155 us at 100 MHz)
    watchdog : process
    begin
        wait for 500 us;
        assert false report "Watchdog timeout! NPU interrupt never fired." severity failure;
        wait;
    end process;

end architecture sim;
