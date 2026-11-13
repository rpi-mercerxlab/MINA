library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use std.env.all;
use work.pe_pkg.all;

entity tb_npu_16x16 is
end entity tb_npu_16x16;

architecture sim of tb_npu_16x16 is
    constant PERIOD      : time := 10 ns;
    -- Vector-level base address in scratchpad (leaves room for 0..ARRAY_SIZE-1 inputs + guard)
    constant OUTPUT_BASE : natural := 32;
    constant SENTINEL    : std_logic_vector(HOST_DATA_WIDTH-1 downto 0) := x"5A5A5A5A";
    
    -- Number of 8-bit lanes per 32-bit host word (4 lanes per word)
    constant LANES_PER_WORD : positive := HOST_DATA_WIDTH / DATA_WIDTH;

    -- Generous cycle budget accounting for CLEAR + RUN (16) + FLUSH (64) + DRAIN (36)
    constant SIM_WAIT_CYCLES : positive := 400;

    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';

    signal instr_we, weight_we, scratchpad_we : std_logic := '0';
    signal instr_addr : std_logic_vector(9 downto 0) := (others => '0');
    signal instr_din, instr_dout : std_logic_vector(35 downto 0) := (others => '0');

    -- Automatically sizes to 13 downto 0 when ARRAY_SIZE = 16 (RAM_ADDR_WIDTH=12 + BANK_SEL_WIDTH=2)
    signal weight_addr_a     : std_logic_vector(HOST_ADDR_WIDTH-1 downto 0) := (others => '0');
    signal scratchpad_addr_a : std_logic_vector(HOST_ADDR_WIDTH-1 downto 0) := (others => '0');

    signal weight_din, weight_dout         : std_logic_vector(HOST_DATA_WIDTH-1 downto 0) := (others => '0');
    signal scratchpad_din, scratchpad_dout : std_logic_vector(HOST_DATA_WIDTH-1 downto 0) := (others => '0');

    type matrix_t is array (0 to ARRAY_SIZE-1, 0 to ARRAY_SIZE-1) of integer;
begin

    -- Sanity check that pe_pkg.vhd was updated to 16
    assert ARRAY_SIZE = 16
        report "Expected ARRAY_SIZE = 16 in pe_pkg.vhd, but found ARRAY_SIZE = " & integer'image(ARRAY_SIZE)
        severity warning;

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
            scratchpad_dout   => scratchpad_dout
        );

    stimulus : process
        variable a, b : matrix_t;
        variable packed, got : std_logic_vector(HOST_DATA_WIDTH-1 downto 0);
        variable expected, actual, dot_product, raw_b : integer;
        variable drain_instr : std_logic_vector(35 downto 0);
        variable row_line, hdr_line : line;

        procedure write_word(
            signal addr      : out std_logic_vector;
            signal din       : out std_logic_vector;
            signal we        : out std_logic;
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
            variable value   : out std_logic_vector(HOST_DATA_WIDTH-1 downto 0)
        ) is
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

            -- Initialize 16x16 test matrices A and B
            for r in 0 to ARRAY_SIZE-1 loop
                for c in 0 to ARRAY_SIZE-1 loop
                    raw_b := ((4 * r + c) mod 64) - 32;
                    b(r, c) := raw_b;
                    if test_id = 1 then
                        -- Test 1: Scaled Identity Matrix (A = 16 * I)
                        if r = c then
                            a(r, c) := 16;
                        else
                            a(r, c) := 0;
                        end if;
                    else
                        -- Test 2: Full Dense Matrix with varying signed multiples of 16
                        if ((r + c) mod 3) = 0 then
                            a(r, c) := 16;
                        elsif ((r + c) mod 3) = 1 then
                            a(r, c) := -16;
                        else
                            a(r, c) := 0;
                        end if;
                    end if;
                end loop;
            end loop;

            -- Load 16x16 matrices into Scratchpad (columns of A) and Weight RAM (rows of B)
            for k in 0 to ARRAY_SIZE-1 loop
                for bank in 0 to NUM_BANKS-1 loop
                    for lane in 0 to LANES_PER_WORD-1 loop
                        packed(DATA_WIDTH*(lane+1)-1 downto DATA_WIDTH*lane) :=
                            std_logic_vector(to_signed(a(LANES_PER_WORD*bank + lane, k), DATA_WIDTH));
                    end loop;
                    write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, NUM_BANKS*k + bank, packed);

                    for lane in 0 to LANES_PER_WORD-1 loop
                        packed(WEIGHT_WIDTH*(lane+1)-1 downto WEIGHT_WIDTH*lane) :=
                            std_logic_vector(to_signed(b(k, LANES_PER_WORD*bank + lane), WEIGHT_WIDTH));
                    end loop;
                    write_word(weight_addr_a, weight_din, weight_we, NUM_BANKS*k + bank, packed);
                end loop;
            end loop;

            -- Fill output region plus one full 128-bit guard vector on either side with SENTINEL
            for address in NUM_BANKS*(OUTPUT_BASE-1) to NUM_BANKS*(OUTPUT_BASE+ARRAY_SIZE) + NUM_BANKS - 1 loop
                write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, address, SENTINEL);
            end loop;

            -- Construct DRAIN instruction dynamically for OUTPUT_BASE:
            -- [35:28]=0x02 (DRAIN), [27:16]=OUTPUT_BASE, [15:14]="00" (pass-through),
            -- [13:10]="0000" (shift=0 -> real_shift=12), [9:0]=256 (0x100 -> *256 / 4096 = /16)
            drain_instr := x"02" & std_logic_vector(to_unsigned(OUTPUT_BASE, 12)) & "00" & "0000" & std_logic_vector(to_unsigned(256, 10));

            -- Write NPU Program
            write_word(instr_addr, instr_din, instr_we, 0, x"010000000"); -- CLEAR
            write_word(instr_addr, instr_din, instr_we, 1, x"000000000"); -- RUN A=0, B=0
            write_word(instr_addr, instr_din, instr_we, 2, drain_instr);  -- DRAIN to OUTPUT_BASE, mult=256
            write_word(instr_addr, instr_din, instr_we, 3, x"0500C0000"); -- JUMP 3 (halt loop)

            -- Release reset and run NPU
            wait until falling_edge(clk);
            rst_n <= '1';

            for n in 1 to SIM_WAIT_CYCLES loop
                wait until rising_edge(clk);
            end loop;

            -- Print table header for this test
            write(hdr_line, string'("================================================================================"));
            writeline(output, hdr_line);
            write(hdr_line, string'("Test ") & integer'image(test_id) & string'(" - 16x16 Output Matrix (Actual Hardware Output):"));
            writeline(output, hdr_line);
            write(hdr_line, string'("--------------------------------------------------------------------------------"));
            writeline(output, hdr_line);

            -- Verify and print all 16x16 (256) outputs across all 4 banks per row
            for r in 0 to ARRAY_SIZE-1 loop
                write(row_line, string'("Row "));
                write(row_line, r, right, 2);
                write(row_line, string'(" |"));

                for bank in 0 to NUM_BANKS-1 loop
                    read_scratch(NUM_BANKS*(OUTPUT_BASE + r) + bank, got);
                    assert not is_x(got)
                        report "Unknown output in test " & integer'image(test_id) &
                               ", row " & integer'image(r) & ", bank " & integer'image(bank)
                        severity failure;

                    for lane in 0 to LANES_PER_WORD-1 loop
                        dot_product := 0;
                        for k in 0 to ARRAY_SIZE-1 loop
                            dot_product := dot_product + a(r, k) * b(k, LANES_PER_WORD*bank + lane);
                        end loop;

                        -- Since all elements of A are multiples of 16, dot_product is divisible by 16
                        assert dot_product mod 16 = 0 severity failure;
                        expected := dot_product / 16;
                        if expected > 127 then expected := 127; end if;
                        if expected < -128 then expected := -128; end if;

                        actual := to_integer(signed(got(DATA_WIDTH*(lane+1)-1 downto DATA_WIDTH*lane)));

                        -- Append right-aligned 5-character wide integer to the current row string
                        write(row_line, actual, right, 5);

                        assert actual = expected
                            report "Test " & integer'image(test_id) &
                                   " row=" & integer'image(r) &
                                   " col=" & integer'image(LANES_PER_WORD*bank + lane) &
                                   " expected=" & integer'image(expected) &
                                   " got=" & integer'image(actual)
                            severity failure;
                    end loop;
                end loop;

                -- Flush the completed row to stdout
                writeline(output, row_line);
            end loop;

            write(hdr_line, string'("================================================================================"));
            writeline(output, hdr_line);

            -- Verify lower and upper 128-bit guard vectors (4 host words each) were not touched
            for bank in 0 to NUM_BANKS-1 loop
                read_scratch(NUM_BANKS*(OUTPUT_BASE - 1) + bank, got);
                assert got = SENTINEL
                    report "Lower output guard overwritten at bank " & integer'image(bank)
                    severity failure;

                read_scratch(NUM_BANKS*(OUTPUT_BASE + ARRAY_SIZE) + bank, got);
                assert got = SENTINEL
                    report "Upper output guard overwritten at bank " & integer'image(bank)
                    severity failure;
            end loop;

            report "PASS: 16x16 matrix test " & integer'image(test_id) &
                   " (" & integer'image(ARRAY_SIZE * ARRAY_SIZE) & " outputs and guards verified)"
                   severity note;
        end loop;

        report "ALL 16x16 NPU TESTS PASSED" severity note;
        finish;
        wait;
    end process;

    watchdog : process
    begin
        wait for 50 us;
        assert false report "Testbench watchdog timeout" severity failure;
        wait;
    end process;

end architecture sim;
