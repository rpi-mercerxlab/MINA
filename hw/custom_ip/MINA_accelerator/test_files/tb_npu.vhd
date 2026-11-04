library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_npu is
end entity;

architecture sim of tb_npu is
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
        for test_id in 1 to 2 loop
            wait until falling_edge(clk);
            rst_n <= '0';
            for n in 1 to 4 loop
                wait until rising_edge(clk);
            end loop;

            for r in 0 to 7 loop
                for c in 0 to 7 loop
                    b(r,c) := 8*r+c-32;
                    if test_id = 2 or r = c then
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
            write_word(instr_addr, instr_din, instr_we, 2, x"020100100"); -- DRAIN base=16, mult=256
            write_word(instr_addr, instr_din, instr_we, 3, x"0500C0000"); -- JUMP 3

            wait until falling_edge(clk);
            rst_n <= '1';
            -- No completion port exists. Allow a bounded budget (2 us), well
            -- above the current CLEAR/RUN/flush/DRAIN latency. The sentinel
            -- ensures no-write/hung execution fails output comparisons.
            for n in 1 to 200 loop
                wait until rising_edge(clk);
            end loop;

            for r in 0 to 7 loop
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
                        -- Both test matrices give exact multiples of 16,
                        -- so quant_mult=256, shift_amt=0 is exact division.
                        assert dot_product mod 16 = 0 severity failure;
                        expected := dot_product/16;
                        if expected > 127 then expected := 127; end if;
                        if expected < -128 then expected := -128; end if;
                        actual := to_integer(signed(got(8*lane+7 downto 8*lane)));
                        assert actual = expected
                            report "Test " & integer'image(test_id) &
                                   " row=" & integer'image(r) &
                                   " col=" & integer'image(4*half+lane) &
                                   " expected=" & integer'image(expected) &
                                   " got=" & integer'image(actual)
                            severity failure;
                    end loop;
                end loop;
            end loop;
            for half in 0 to 1 loop
                read_scratch(2*(OUTPUT_BASE-1)+half, got);
                assert got = SENTINEL report "Lower output guard overwritten" severity failure;
                read_scratch(2*(OUTPUT_BASE+8)+half, got);
                assert got = SENTINEL report "Upper output guard overwritten" severity failure;
            end loop;
            report "PASS: matrix test " & integer'image(test_id) & " (64 outputs and guards)" severity note;
        end loop;
        report "ALL TESTS PASSED" severity note;
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
