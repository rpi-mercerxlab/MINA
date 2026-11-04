-- MINA top-level sigmoid testbench, VHDL-2008.
-- Requires the corrected single-process SkewBuffer, updated drain driver,
-- and 13-bit external RAM addresses discussed in the review.
-- Tests 1..4: A=16I, B sweeps all 256 signed byte values across four tiles.
-- Test 5: A filled with 16, B[r,c]=4*(8*r+c)-128.
-- Quantization: multiplier 256, shift field 0 => divide by 16 then clip.
-- Sigmoid output encoding: floor(127*sigmoid(q*0.046875)).
-- Prints actual matrices and writes sigmoid_results.csv in the run directory.
-- Fixed 200-cycle execution budget per test; assertions and 20 us watchdog.
-- Reference values checked against supplied sigmoidLUT.vhd. Not GHDL-run here.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;
use std.textio.all;

entity tb_npu_sigmoid is
end entity;

architecture sim of tb_npu_sigmoid is
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
    -- Independent reference: floor(127 / (1 + exp(-q * 0.046875))).
    -- Indexed by signed quantized input; no DUT LUT instance in scoreboard.
    type sigmoid_table_t is array (-128 to 127) of natural range 0 to 127;
    constant SIGMOID_REF : sigmoid_table_t := (
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2,
        2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5,
        6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 10, 10, 11, 11,
        12, 12, 13, 13, 14, 14, 15, 16, 16, 17, 18, 19, 19, 20, 21, 22,
        23, 24, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 38, 39,
        40, 42, 43, 44, 46, 47, 48, 50, 51, 53, 54, 56, 57, 59, 60, 62,
        63, 64, 66, 67, 69, 70, 72, 73, 75, 76, 78, 79, 80, 82, 83, 84,
        86, 87, 88, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 102,
        103, 104, 105, 106, 107, 107, 108, 109, 110, 110, 111, 112, 112, 113, 113, 114,
        114, 115, 115, 116, 116, 117, 117, 118, 118, 118, 119, 119, 119, 120, 120, 120,
        120, 121, 121, 121, 121, 122, 122, 122, 122, 122, 123, 123, 123, 123, 123, 123,
        124, 124, 124, 124, 124, 124, 124, 124, 124, 125, 125, 125, 125, 125, 125, 125,
        125, 125, 125, 125, 125, 125, 125, 125, 126, 126, 126, 126, 126, 126, 126, 126,
        126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126
    );
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
        file results : text open write_mode is "sigmoid_results.csv";
        variable csv_line, row_line : line;
        variable q : integer;
        variable a, b : matrix_t;
        variable packed, got : std_logic_vector(31 downto 0);
        variable expected, actual, dot_product : integer;

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
        write(csv_line, string'("test,row,col,accumulator,quantized_input,expected_sigmoid,actual_sigmoid"));
        writeline(results, csv_line);
        -- Four identity tests cover every signed 8-bit LUT input. The fifth
        -- uses a dense A to exercise accumulation and quantization clipping.
        for test_id in 1 to 5 loop
            wait until falling_edge(clk);
            rst_n <= '0';
            for n in 1 to 4 loop
                wait until rising_edge(clk);
            end loop;

            for r in 0 to 7 loop
                for c in 0 to 7 loop
                    if test_id <= 4 then
                        b(r,c) := 64*(test_id-1) + 8*r+c-128;
                    else
                        b(r,c) := 4*(8*r+c)-128;
                    end if;
                    if test_id = 5 or r = c then
                        a(r,c) := 16;
                    else
                        a(r,c) := 0;
                    end if;
                end loop;
            end loop;

            -- Scratchpad vectors contain columns of A; weight vectors rows of B.
            -- Lane zero is the least significant byte; port A uses 32-bit words.
            for k in 0 to 7 loop
                for half in 0 to 1 loop
                    for lane in 0 to 3 loop
                        packed(8*lane+7 downto 8*lane) :=
                            std_logic_vector(to_signed(a(4*half+lane,k),8));
                    end loop;
                    write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, 2*k+half, packed);
                    for lane in 0 to 3 loop
                        packed(8*lane+7 downto 8*lane) :=
                            std_logic_vector(to_signed(b(k,4*half+lane),8));
                    end loop;
                    write_word(weight_addr_a, weight_din, weight_we, 2*k+half, packed);
                end loop;
            end loop;

            -- Output region plus one 64-bit guard word on either side.
            for address in 2*(OUTPUT_BASE-1) to 2*(OUTPUT_BASE+8)+1 loop
                write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, address, SENTINEL);
            end loop;
            write_word(instr_addr, instr_din, instr_we, 0, x"010000000"); -- CLEAR
            write_word(instr_addr, instr_din, instr_we, 1, x"000000000"); -- RUN A=0, B=0
            write_word(instr_addr, instr_din, instr_we, 2, x"02010C100"); -- DRAIN base=16, sigmoid=11, shift=0, mult=256
            write_word(instr_addr, instr_din, instr_we, 3, x"0500C0000"); -- JUMP 3

            wait until falling_edge(clk);
            rst_n <= '1';
            -- No completion port exists. Allow a bounded budget (2 us), well
            -- above the current CLEAR/RUN/flush/DRAIN latency. The sentinel
            -- ensures no-write/hung execution fails output comparisons.
            for n in 1 to 200 loop
                wait until rising_edge(clk);
            end loop;

            report "Sigmoid test " & integer'image(test_id) & ": actual 8x8 output" severity note;
            for r in 0 to 7 loop
                write(row_line, string'("row "));
                write(row_line, r);
                write(row_line, string'(": "));
                for half in 0 to 1 loop
                    read_scratch(2*(OUTPUT_BASE+r)+half, got);
                    assert not is_x(got)
                        report "Unknown output in test " & integer'image(test_id) &
                               ", row " & integer'image(r) severity failure;
                    for lane in 0 to 3 loop
                        dot_product := 0;
                        for k in 0 to 7 loop
                            dot_product := dot_product + a(r,k)*b(k,4*half+lane);
                        end loop;
                        -- All test matrices give exact multiples of 16,
                        -- so quant_mult=256, shift_amt=0 is exact division.
                        assert dot_product mod 16 = 0 severity failure;
                        q := dot_product/16;
                        if q > 127 then q := 127; end if;
                        if q < -128 then q := -128; end if;
                        expected := SIGMOID_REF(q);
                        actual := to_integer(unsigned(got(8*lane+7 downto 8*lane)));
                        write(row_line, actual, right, 4);
                        write(csv_line, integer'image(test_id) & "," &
                            integer'image(r) & "," & integer'image(4*half+lane) & "," &
                            integer'image(dot_product) & "," & integer'image(q) & "," &
                            integer'image(expected) & "," & integer'image(actual));
                        writeline(results, csv_line);
                        assert actual = expected
                            report "Test " & integer'image(test_id) &
                                   " row=" & integer'image(r) &
                                   " col=" & integer'image(4*half+lane) &
                                   " expected=" & integer'image(expected) &
                                   " got=" & integer'image(actual)
                            severity failure;
                    end loop;
                end loop;
                writeline(output, row_line);
            end loop;
            for half in 0 to 1 loop
                read_scratch(2*(OUTPUT_BASE-1)+half, got);
                assert got = SENTINEL report "Lower output guard overwritten" severity failure;
                read_scratch(2*(OUTPUT_BASE+8)+half, got);
                assert got = SENTINEL report "Upper output guard overwritten" severity failure;
            end loop;
            report "PASS: sigmoid test " & integer'image(test_id) & " (64 outputs and guards)" severity note;
        end loop;
        report "ALL SIGMOID TESTS PASSED" severity note;
        file_close(results);
        finish;
        wait;
    end process;

    watchdog : process
    begin
        wait for 20 us;
        assert false report "Testbench watchdog timeout" severity failure;
        wait;
    end process;
end architecture;
