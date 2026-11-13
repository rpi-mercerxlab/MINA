library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_npu_loop is
end entity;

architecture sim of tb_npu_loop is
    constant PERIOD      : time := 10 ns;
    constant OUTPUT_BASE : natural := 16; -- 64-bit word address (R5 = 16)
    constant SENTINEL    : std_logic_vector(31 downto 0) := x"5A5A5A5A";

    signal clk   : std_logic := '0';
    signal rst_n : std_logic := '0';
    signal instr_we, weight_we, scratchpad_we : std_logic := '0';
    signal instr_addr : std_logic_vector(9 downto 0) := (others => '0');
    signal instr_din, instr_dout : std_logic_vector(35 downto 0) := (others => '0');
    signal weight_addr_a, scratchpad_addr_a : std_logic_vector(12 downto 0) := (others => '0');
    signal weight_din, weight_dout, scratchpad_din, scratchpad_dout : std_logic_vector(31 downto 0) := (others => '0');

    -- Helper for 0x06 (ADD_I): OPCODE(35:28)=0x06 | RT(27:25) | RS(24:22) | IMM(21:6) | 0(5:0)
    function encode_addi(rt, rs : natural; imm : integer) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"06";
        res(27 downto 25) := std_logic_vector(to_unsigned(rt, 3));
        res(24 downto 22) := std_logic_vector(to_unsigned(rs, 3));
        res(21 downto 6)  := std_logic_vector(to_signed(imm, 16));
        return res;
    end function;

    -- Helper for 0x07 (BEQ): OPCODE(35:28)=0x07 | RT(27:25) | RS(24:22) | ADDR(21:12) | 0(11:0)
    function encode_beq(rt, rs, target_pc : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"07";
        res(27 downto 25) := std_logic_vector(to_unsigned(rt, 3));
        res(24 downto 22) := std_logic_vector(to_unsigned(rs, 3));
        res(21 downto 12) := std_logic_vector(to_unsigned(target_pc, 10));
        return res;
    end function;

    -- Helper for 0x0A (DRIVE_REG): OPCODE(35:28)=0x0A | SRC(27:26) | DATA_RS(25:22) | WGT_RS(21:18)
    function encode_drive_reg(src, data_rs, weight_rs : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"0A";
        res(27 downto 26) := std_logic_vector(to_unsigned(src, 2));
        res(25 downto 22) := std_logic_vector(to_unsigned(data_rs, 4));
        res(21 downto 18) := std_logic_vector(to_unsigned(weight_rs, 4));
        return res;
    end function;

    -- Helper for 0x0B (DRAIN_REG): OPCODE(35:28)=0x0B | DRN_RS(27:24) | ACT(15:14) | SHIFT(13:10) | MULT(9:0)
    function encode_drain_reg(drn_rs, act, shift, mult : natural) return std_logic_vector is
        variable res : std_logic_vector(35 downto 0) := (others => '0');
    begin
        res(35 downto 28) := x"0B";
        res(27 downto 24) := std_logic_vector(to_unsigned(drn_rs, 4));
        res(15 downto 14) := std_logic_vector(to_unsigned(act, 2));
        res(13 downto 10) := std_logic_vector(to_unsigned(shift, 4));
        res(9 downto 0)   := std_logic_vector(to_unsigned(mult, 10));
        return res;
    end function;

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
        variable packed, got : std_logic_vector(31 downto 0);
        variable actual : integer;

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
        -- Reset NPU
        wait until falling_edge(clk);
        rst_n <= '0';
        for n in 1 to 4 loop
            wait until rising_edge(clk);
        end loop;

        -- Load 2 tiles (tile 0 at vector base 0, tile 1 at vector base 8)
        -- Tile 0: A0 = 16*I, B0 = all 2s  (partial product = 32)
        -- Tile 1: A1 = 16*I, B1 = all 3s  (partial product = 48)
        -- Accumulated total = 32 + 48 = 80. With quant_mult=256 (div 16), final output = 5.
        for tile in 0 to 1 loop
            for k in 0 to 7 loop
                for half in 0 to 1 loop
                    -- Pack A tile (16 on diagonal, 0 elsewhere)
                    packed := (others => '0');
                    for lane in 0 to 3 loop
                        if 4*half + lane = k then
                            packed(8*lane+7 downto 8*lane) := std_logic_vector(to_signed(16, 8));
                        end if;
                    end loop;
                    write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, 2*(tile*8 + k) + half, packed);

                    -- Pack B tile (all 2s for tile 0, all 3s for tile 1)
                    packed := (others => '0');
                    for lane in 0 to 3 loop
                        packed(8*lane+7 downto 8*lane) := std_logic_vector(to_signed(tile + 2, 8));
                    end loop;
                    write_word(weight_addr_a, weight_din, weight_we, 2*(tile*8 + k) + half, packed);
                end loop;
            end loop;
        end loop;

        -- Fill output region + guards with SENTINEL
        for address in 2*(OUTPUT_BASE-1) to 2*(OUTPUT_BASE+8)+1 loop
            write_word(scratchpad_addr_a, scratchpad_din, scratchpad_we, address, SENTINEL);
        end loop;

        -- Load NPU Program
        write_word(instr_addr, instr_din, instr_we,  0, x"010000000");               -- PC 0: CLEAR accumulators
        write_word(instr_addr, instr_din, instr_we,  1, encode_addi(1, 0, 0));       -- PC 1: R1 = 0 (loop counter)
        write_word(instr_addr, instr_din, instr_we,  2, encode_addi(2, 0, 2));       -- PC 2: R2 = 2 (loop limit)
        write_word(instr_addr, instr_din, instr_we,  3, encode_addi(3, 0, 0));       -- PC 3: R3 = 0 (data_addr)
        write_word(instr_addr, instr_din, instr_we,  4, encode_addi(4, 0, 0));       -- PC 4: R4 = 0 (weight_addr)
        write_word(instr_addr, instr_din, instr_we,  5, encode_addi(5, 0, 16));      -- PC 5: R5 = 16 (drain_addr)
        
        -- Loop Body (PC 6 to 11)
        write_word(instr_addr, instr_din, instr_we,  6, encode_drive_reg(0, 3, 4));  -- PC 6: DRIVE_REG (data=R3, weight=R4)
        write_word(instr_addr, instr_din, instr_we,  7, encode_addi(3, 3, 8));       -- PC 7: R3 = R3 + 8
        write_word(instr_addr, instr_din, instr_we,  8, encode_addi(4, 4, 8));       -- PC 8: R4 = R4 + 8
        write_word(instr_addr, instr_din, instr_we,  9, encode_addi(1, 1, 1));       -- PC 9: R1 = R1 + 1
        write_word(instr_addr, instr_din, instr_we, 10, encode_beq(1, 2, 12));       -- PC 10: if R1 == R2 jump to PC 12
        write_word(instr_addr, instr_din, instr_we, 11, x"050180000");               -- PC 11: JUMP 6 (loop back)
        
        -- Post-Loop Drain & Halt
        write_word(instr_addr, instr_din, instr_we, 12, encode_drain_reg(5, 0, 0, 256)); -- PC 12: DRAIN_REG to R5=16, mult=256
        write_word(instr_addr, instr_din, instr_we, 13, x"050340000");               -- PC 13: JUMP 13 (halt)

        -- Release Reset and Run
        wait until falling_edge(clk);
        rst_n <= '1';

        -- Wait 350 cycles (plenty for 2 DRIVE passes + arithmetic + 1 DRAIN)
        for n in 1 to 350 loop
            wait until rising_edge(clk);
        end loop;

        -- Verify all 64 outputs equal 5
        for r in 0 to 7 loop
            for half in 0 to 1 loop
                read_scratch(2*(OUTPUT_BASE+r)+half, got);
                assert not is_x(got) report "Unknown output at row " & integer'image(r) severity failure;
                for lane in 0 to 3 loop
                    actual := to_integer(signed(got(8*lane+7 downto 8*lane)));
                    assert actual = 5
                        report "Mismatch at row=" & integer'image(r) &
                               " col=" & integer'image(4*half+lane) &
                               " expected=5 got=" & integer'image(actual)
                        severity failure;
                end loop;
            end loop;
        end loop;

        -- Verify guard words
        for half in 0 to 1 loop
            read_scratch(2*(OUTPUT_BASE-1)+half, got);
            assert got = SENTINEL report "Lower guard overwritten" severity failure;
            read_scratch(2*(OUTPUT_BASE+8)+half, got);
            assert got = SENTINEL report "Upper guard overwritten" severity failure;
        end loop;

        report "PASS: Successive multiplication loop test (ADD_I + BEQ + Reg Drive/Drain)" severity note;
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
