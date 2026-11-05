-- MINA successive matrix multiplication / JUMP test, VHDL-2008.
-- Uses your corrected single-process SkewBuffer, drain base+7 driver, and
-- 13-bit external memory addresses. Compile RTL in the previous dependency order.
-- ghdl -a --std=08 -frelaxed-rules tb_npu_jump.vhd
-- ghdl -e --std=08 -frelaxed-rules tb_npu_jump
-- ghdl -r --std=08 -frelaxed-rules tb_npu_jump --assert-level=error --wave=jump.ghw
-- Fixed instruction loop: PC 0 -> 8 -> 9 -> 10 -> 11 -> 8 -> ...
-- No resets/reloads between iterations. Four distinct results are checked.
-- Stored matrix recurrence: M(next) = transpose(M(previous))/2.
-- This transpose is intentional: RUN consumes columns and DRAIN writes rows.
-- Self-jump traps at PCs 1 and 12 detect fall-through via bounded timeout.
-- Completion is inferred through a changing final-row word, not an exposed
-- done port. Readback fits within the current inter-drain interval.
-- This test checks sequencing/feedback, not all matrix multiply corner cases.
-- Generated reference/encodings checked; GHDL unavailable during preparation.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;
use std.textio.all;

entity tb_npu_jump is
end entity;

architecture sim of tb_npu_jump is
    constant PERIOD : time := 10 ns;
    constant OUTPUT_BASE : natural := 16; -- 64-bit word address
    constant SENTINEL : std_logic_vector(31 downto 0) := x"5A5A5A5A";
    signal clk : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal instr_we, weight_we, scratchpad_we : std_logic := '0';
    signal instr_addr : std_logic_vector(9 downto 0) := (others => '0');
    signal instr_din, instr_dout : std_logic_vector(35 downto 0) := (others => '0');
    signal weight_addr_a, scratchpad_addr_a : std_logic_vector(12 downto 0) := (others => '0');
    signal weight_din, weight_dout, scratchpad_din, scratchpad_dout : std_logic_vector(31 downto 0) := (others => '0');
    -- Port A uses 32-bit word indices; port B uses 64-bit vector indices.
    -- Each iteration reads and overwrites vectors 16..23.
    constant ITERATIONS : positive := 4;
    type matrix_t is array (0 to 7, 0 to 7) of integer;
begin
    clk <= not clk after PERIOD/2;
    dut : entity work.NPU
        port map (
            clk => clk, rst_n => rst_n,
            instr_we => instr_we, instr_addr => instr_addr,
            instr_din => instr_din, instr_dout => instr_dout,
            weight_we => weight_we, weight_addr_a => weight_addr_a,
            weight_din => weight_din, weight_dout => weight_dout,
            scratchpad_we => scratchpad_we, scratchpad_addr_a => scratchpad_addr_a,
            scratchpad_din => scratchpad_din, scratchpad_dout => scratchpad_dout
        );

    stimulus : process
        variable memory_matrix, expected_matrix : matrix_t;
        variable packed, got, marker : std_logic_vector(31 downto 0);
        variable actual, value : integer;
        variable completed : boolean;
        variable row_text : line;

        -- memory_matrix(r,c) describes byte c of stored vector r.
        -- RUN interprets those vectors as matrix columns, hence transpose.
        function pack_half(m : matrix_t; r, half : natural)
            return std_logic_vector is
            variable result : std_logic_vector(31 downto 0);
        begin
            for lane in 0 to 3 loop
                result(8*lane+7 downto 8*lane) :=
                    std_logic_vector(to_signed(m(r,4*half+lane),8));
            end loop;
            return result;
        end function;

        procedure write_word(
            signal addr : out std_logic_vector;
            signal din : out std_logic_vector;
            signal we : out std_logic;
            constant address : natural;
            constant value : std_logic_vector
        ) is
        begin
            wait until falling_edge(clk);
            addr <= std_logic_vector(to_unsigned(address, addr'length));
            din <= value;
            we <= '1';
            wait until rising_edge(clk);
            wait for 1 ns;
            we <= '0';
        end procedure;

        procedure read_scratch(constant address : natural;
                               variable value : out std_logic_vector(31 downto 0)) is
        begin
            wait until falling_edge(clk);
            scratchpad_addr_a <= std_logic_vector(to_unsigned(address, scratchpad_addr_a'length));
            wait until rising_edge(clk);
            wait for 1 ns; -- synchronous RAM + bank-select delta cycles
            value := scratchpad_dout;
        end procedure;
    begin
        -- Reset is asserted only for loading. No resets or host writes occur
        -- after execution starts; only external scratchpad reads are used.
        for n in 1 to 4 loop
            wait until rising_edge(clk);
        end loop;

        -- Initial logical A[r,c] = 16 * (((3*r+5*c) mod 15)-7).
        -- Store its columns. All values are multiples of 16, so four rounds
        -- of divide-by-two are exact, including for negative values.
        for r in 0 to 7 loop
            for c in 0 to 7 loop
                memory_matrix(r,c) := 16 * (((3*c+5*r) mod 15)-7);
            end loop;
            for half in 0 to 1 loop
                write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we,
                           2*(OUTPUT_BASE+r)+half, pack_half(memory_matrix,r,half));
            end loop;
        end loop;

        -- B = 8*I, packed by rows at weight vector addresses 0..7.
        -- With quant_mult=256 and shift=0, result = A*B/16 = A/2.
        for r in 0 to 7 loop
            for half in 0 to 1 loop
                packed := (others => '0');
                for lane in 0 to 3 loop
                    if 4*half+lane = r then value := 8; else value := 0; end if;
                    packed(8*lane+7 downto 8*lane) := std_logic_vector(to_signed(value,8));
                end loop;
                write_word(weight_addr_a, weight_din, weight_we, 2*r+half, packed);
            end loop;
        end loop;
        for half in 0 to 1 loop
            write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we,
                       2*(OUTPUT_BASE-1)+half, SENTINEL);
            write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we,
                       2*(OUTPUT_BASE+8)+half, SENTINEL);
        end loop;

        -- Program: forward jump into a nonzero-address loop; backward jump
        -- repeats CLEAR/RUN/DRAIN. Fall-through traps cause a timeout if either
        -- jump is ignored. Program memory is never patched while running.
        write_word(instr_addr, instr_din, instr_we,  0, x"050200000"); -- JUMP 8
        write_word(instr_addr, instr_din, instr_we,  1, x"050040000"); -- trap: JUMP 1
        write_word(instr_addr, instr_din, instr_we,  8, x"010000000"); -- CLEAR
        write_word(instr_addr, instr_din, instr_we,  9, x"000040000"); -- RUN data=16, weights=0
        write_word(instr_addr, instr_din, instr_we, 10, x"020100100"); -- DRAIN base=16, mult=256
        write_word(instr_addr, instr_din, instr_we, 11, x"050200000"); -- JUMP 8 (backward)
        write_word(instr_addr, instr_din, instr_we, 12, x"050300000"); -- trap: JUMP 12

        wait until falling_edge(clk);
        rst_n <= '1';
        for iteration in 1 to ITERATIONS loop
            for r in 0 to 7 loop
                for c in 0 to 7 loop
                    assert memory_matrix(c,r) mod 2 = 0
                        report "Reference requires exact halving" severity failure;
                    expected_matrix(r,c) := memory_matrix(c,r)/2;
                end loop;
            end loop;

            -- The revised driver writes row 7 first and row 0 last. Polling
            -- the changing low half of row 0 detects a completed matrix.
            -- Its expected value differs from all previous iterations.
            marker := pack_half(expected_matrix,0,0);
            assert marker /= pack_half(memory_matrix,0,0)
                report "Completion marker did not change" severity failure;
            completed := false;
            for poll in 1 to 200 loop
                read_scratch(2*OUTPUT_BASE, got);
                if not is_x(got) and got = marker then
                    completed := true;
                    exit;
                end if;
            end loop;
            assert completed
                report "Timeout waiting for iteration " & integer'image(iteration) &
                       "; expected row0 low=" & to_hstring(marker) &
                       ", last read=" & to_hstring(got)
                severity failure;

            -- The current driver has more than 40 clocks before the next
            -- drain starts. These 16 read clocks plus four guard reads fit
            -- inside that window. Revisit this if RUN/DRAIN latency changes.
            report "Iteration " & integer'image(iteration) & ": actual matrix" severity note;
            for r in 0 to 7 loop
                write(row_text, string'("row "));
                write(row_text, r);
                write(row_text, string'(": "));
                for half in 0 to 1 loop
                    read_scratch(2*(OUTPUT_BASE+r)+half, got);
                    assert not is_x(got)
                        report "Unknown scratchpad output" severity failure;
                    for lane in 0 to 3 loop
                        actual := to_integer(signed(got(8*lane+7 downto 8*lane)));
                        assert actual = expected_matrix(r,4*half+lane)
                            report "Iteration " & integer'image(iteration) &
                                   " row=" & integer'image(r) &
                                   " col=" & integer'image(4*half+lane) &
                                   " expected=" & integer'image(expected_matrix(r,4*half+lane)) &
                                   " got=" & integer'image(actual)
                            severity failure;
                        write(row_text, actual, right, 5);
                    end loop;
                end loop;
                writeline(output,row_text);
            end loop;
            for half in 0 to 1 loop
                read_scratch(2*(OUTPUT_BASE-1)+half, got);
                assert got = SENTINEL report "Lower guard overwritten" severity failure;
                read_scratch(2*(OUTPUT_BASE+8)+half, got);
                assert got = SENTINEL report "Upper guard overwritten" severity failure;
            end loop;
            report "PASS: jump-loop iteration " & integer'image(iteration) &
                   " (64 outputs and guards)" severity note;
            memory_matrix := expected_matrix;
        end loop;
        report "ALL JUMP-LOOP TESTS PASSED (4 successive multiplies, no intervening reset)" severity note;
        finish;
        wait;
    end process;

    watchdog : process
    begin
        wait for 20 us;
        assert false report "Jump test watchdog timeout" severity failure;
        wait;
    end process;
end architecture;
