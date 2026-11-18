-- Minimal whole-SoC NPU read probe for the same design_1_wrapper as
-- npu_integrated_stimulus.vhd. Set tb_npu_read_probe as simulation top.
-- VHDL-2008; no external firmware files or compiler are required.
--
-- Uploads only 20 CPU instructions (80 bytes), then releases cpu_rst.
-- No C startup, stack, interrupt setup, CPU RAM stores or UART printing.
-- The CPU never starts or writes to the NPU. Optional bootloader seeding
-- provides known RAM contents while the CPU/NPU are halted.
--
-- First NPU access: LW at CPU PC 0x10 reads 0x40000004 (STATUS).
--
-- CPU PC  Load address  Destination     Expected if core remains halted
--   10     40000004     s0 / x8         STATUS (normally 00000005)
--   14     40000000     s1 / x9         CONTROL = 00000000
--   18     40000008     s2 / x18        NPU PC = 00000000
--   1C     4000000C     s3 / x19        IRQ address (reset value)
--   24     40100000     s4 / x20        instruction low = 12345678 *
--   28     40100004     s5 / x21        instruction high = 0000000A *
--   30     40200000     s6 / x22        weight = 11223344 *
--   38     40300000     s7 / x23        scratchpad = 55667788 *
--   * When SEED_NPU_RAM = true. Unseeded RAM may contain X in simulation.
--
-- After all loads retire: CPU loops at PC 0x3C.
-- On an exception: CPU handler at 0x40 captures the CSRs and loops at 0x4C:
--   a0 / x10 = mcause, a1 / x11 = mtval, a2 / x12 = mepc.
-- Example original fault: x10=00000005, x11=40000004, x12=00000010.
-- A stalled load with no response may reach neither loop.
--
-- Add CPU PC/writeback and the CPU-side/NPU-side AXI AR/R channels to Waves.
-- Include ARADDR/ARVALID/ARREADY, RRESP/RVALID/RREADY/RDATA and, on full AXI,
-- ARLEN/ARSIZE/RLAST. A cache-line fill can generate more bus reads than
-- the eight architectural LW instructions shown above.
--
-- The testbench stops after OBSERVE_TIME; that is a capture window, NOT an
-- automatic pass verdict. The full Vivado design is required for execution.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_npu_read_probe is
    generic (
        -- Must match the UART baud rate configured in the DUT.
        -- 115200 baud: 8680556 ps. At 10 Mbaud, use 100 ns in BOTH places.
        UART_BIT_PERIOD : time := 8680556 ps;
        OBSERVE_TIME : time := 100 us;
        SEED_NPU_RAM : boolean := true
    );
end entity;

architecture sim of tb_npu_read_probe is
    component design_1_wrapper
        port (
            GPIO_0_tri_io  : inout std_logic_vector(3 downto 0);
            IOBUF_scl      : inout std_logic_vector(0 downto 0);
            IOBUF_sda      : inout std_logic_vector(0 downto 0);
            SPI_0_0_io0_io : inout std_logic;
            SPI_0_0_io1_io : inout std_logic;
            SPI_0_0_sck_io : inout std_logic;
            SPI_0_0_ss_io  : inout std_logic_vector(0 downto 0);
            cpu_rst       : in std_logic;
            in_clk        : in std_logic;
            sys_rst       : in std_logic;
            uart_rx_0     : in std_logic;
            uart_tx_0     : out std_logic
        );
    end component;

    constant CLK_PERIOD : time := 10 ns;
    type words_t is array (natural range <>) of std_logic_vector(31 downto 0);
    constant FW : words_t(0 to 19) := (
         0 => x"30001073", -- 00: csrw mstatus,zero       disable machine interrupts
         1 => x"04000293", -- 04: addi t0,zero,0x40       trap handler byte address
         2 => x"30529073", -- 08: csrw mtvec,t0
         3 => x"40000337", -- 0C: lui t1,0x40000          t1 = 40000000
         4 => x"00432403", -- 10: lw s0,4(t1)             STATUS: original failing access
         5 => x"00032483", -- 14: lw s1,0(t1)             CONTROL
         6 => x"00832903", -- 18: lw s2,8(t1)             NPU PC
         7 => x"00C32983", -- 1C: lw s3,12(t1)            IRQ address
         8 => x"40100337", -- 20: lui t1,0x40100          t1 = 40100000
         9 => x"00032A03", -- 24: lw s4,0(t1)             instruction bits 31:0
        10 => x"00432A83", -- 28: lw s5,4(t1)             instruction bits 35:32
        11 => x"40200337", -- 2C: lui t1,0x40200          t1 = 40200000
        12 => x"00032B03", -- 30: lw s6,0(t1)             weight RAM
        13 => x"40300337", -- 34: lui t1,0x40300          t1 = 40300000
        14 => x"00032B83", -- 38: lw s7,0(t1)             scratchpad RAM
        15 => x"0000006F", -- 3C: jal zero,0              SUCCESS LOOP
        16 => x"34202573", -- 40: csrr a0,mcause
        17 => x"343025F3", -- 44: csrr a1,mtval
        18 => x"34102673", -- 48: csrr a2,mepc
        19 => x"0000006F"  -- 4C: jal zero,0              FAULT LOOP
    );

    signal gpio : std_logic_vector(3 downto 0) := (others => 'Z');
    signal scl, sda : std_logic_vector(0 downto 0) := (others => 'H');
    signal spi_io0, spi_io1, spi_sck : std_logic := 'Z';
    signal spi_ss : std_logic_vector(0 downto 0) := (others => 'Z');
    signal cpu_rst, in_clk, sys_rst : std_logic := '0';
    signal uart_rx : std_logic := '1';
    signal uart_tx : std_logic;
    signal upload_started, cpu_released : std_logic := '0';
    signal ack_count : natural := 0;

    -- Local formatter avoids relying on the std_logic_vector to_hstring
    -- overload, which is unavailable in some Vivado library configurations.
    function hex_image(value : std_logic_vector) return string is
        constant DIGITS : positive := (value'length + 3) / 4;
        variable padded : std_logic_vector(DIGITS*4-1 downto 0) := (others => '0');
        variable nibble : std_logic_vector(3 downto 0);
        variable result : string(1 to DIGITS);
    begin
        padded(value'length-1 downto 0) := value;
        for i in 1 to DIGITS loop
            nibble := padded((DIGITS-i)*4+3 downto (DIGITS-i)*4);
            case nibble is
                when "0000" => result(i) := '0';
                when "0001" => result(i) := '1';
                when "0010" => result(i) := '2';
                when "0011" => result(i) := '3';
                when "0100" => result(i) := '4';
                when "0101" => result(i) := '5';
                when "0110" => result(i) := '6';
                when "0111" => result(i) := '7';
                when "1000" => result(i) := '8';
                when "1001" => result(i) := '9';
                when "1010" => result(i) := 'A';
                when "1011" => result(i) := 'B';
                when "1100" => result(i) := 'C';
                when "1101" => result(i) := 'D';
                when "1110" => result(i) := 'E';
                when "1111" => result(i) := 'F';
                when "ZZZZ" => result(i) := 'Z';
                when others => result(i) := 'X';
            end case;
        end loop;
        return result;
    end function;

    procedure send_byte(signal rx : out std_logic;
                        constant b : std_logic_vector(7 downto 0)) is
    begin
        rx <= '0'; wait for UART_BIT_PERIOD;
        for bit_index in 0 to 7 loop
            rx <= b(bit_index); wait for UART_BIT_PERIOD;
        end loop;
        rx <= '1'; wait for UART_BIT_PERIOD;
    end procedure;

    -- Same boot protocol as the supplied testbench: multibyte address/data
    -- fields are MSB-first; UART sends bits within each byte LSB-first.
    -- CMD 01/03/04: 55,cmd,addr[4],data[4],xor = 11 bytes.
    -- CMD 02:      55,02,addr[4],zero+high-nibble,data[4],xor = 12 bytes.
    procedure boot_write(signal rx : out std_logic;
                         signal acknowledgments : in natural;
                         constant cmd : std_logic_vector(7 downto 0);
                         constant address : std_logic_vector(31 downto 0);
                         constant data : std_logic_vector(35 downto 0)) is
        variable checksum : std_logic_vector(7 downto 0);
        variable ack_before : natural;
    begin
        ack_before := acknowledgments;
        checksum := cmd;
        send_byte(rx, x"55"); send_byte(rx, cmd);
        for i in 3 downto 0 loop
            checksum := checksum xor address(8*i+7 downto 8*i);
            send_byte(rx, address(8*i+7 downto 8*i));
        end loop;
        if cmd = x"02" then
            checksum := checksum xor ("0000" & data(35 downto 32));
            send_byte(rx, "0000" & data(35 downto 32));
        end if;
        for i in 3 downto 0 loop
            checksum := checksum xor data(8*i+7 downto 8*i);
            send_byte(rx, data(8*i+7 downto 8*i));
        end loop;
        send_byte(rx, checksum);
        -- The independent listener also catches an ACK that starts before
        -- send_byte finishes the last stop bit.
        if acknowledgments = ack_before then
            wait until acknowledgments /= ack_before for 30 * UART_BIT_PERIOD;
        end if;
        assert acknowledgments = ack_before + 1
            report "Missing/extra boot ACK: cmd=" & hex_image(cmd) &
                   " address=" & hex_image(address) severity failure;
        wait for UART_BIT_PERIOD;
    end procedure;
begin
    in_clk <= not in_clk after CLK_PERIOD / 2;

    dut : design_1_wrapper port map (
        GPIO_0_tri_io => gpio, IOBUF_scl => scl, IOBUF_sda => sda,
        SPI_0_0_io0_io => spi_io0, SPI_0_0_io1_io => spi_io1,
        SPI_0_0_sck_io => spi_sck, SPI_0_0_ss_io => spi_ss,
        cpu_rst => cpu_rst, in_clk => in_clk, sys_rst => sys_rst,
        uart_rx_0 => uart_rx, uart_tx_0 => uart_tx
    );

    ack_listener : process
        variable b : std_logic_vector(7 downto 0);
    begin
        wait until upload_started = '1';
        loop
            wait until falling_edge(uart_tx);
            wait for UART_BIT_PERIOD + UART_BIT_PERIOD / 2;
            for i in 0 to 7 loop
                b(i) := uart_tx; wait for UART_BIT_PERIOD;
            end loop;
            assert uart_tx = '1' report "UART ACK framing error" severity failure;
            assert b = x"06"
                report "Expected boot ACK 06, received " & hex_image(b) &
                       " (15 means NACK)" severity failure;
            ack_count <= ack_count + 1;
            -- Return at the middle of the stop bit, ready for the next start.
        end loop;
    end process;

    stimulus : process
    begin
        cpu_rst <= '0'; sys_rst <= '0'; uart_rx <= '1';
        wait for 20 * CLK_PERIOD;
        sys_rst <= '1';
        wait for 5 us; -- same clock/reset settling interval as supplied TB
        upload_started <= '1';

        if SEED_NPU_RAM then
            report "Seeding one NPU instruction, one weight word and one scratchpad word";
            boot_write(uart_rx, ack_count, x"02", x"00000000", x"A12345678");
            boot_write(uart_rx, ack_count, x"03", x"00000000", x"011223344");
            boot_write(uart_rx, ack_count, x"04", x"00000000", x"055667788");
        end if;

        report "Uploading 20 CPU instructions (80 bytes)";
        for i in FW'range loop
            boot_write(uart_rx, ack_count, x"01",
                       std_logic_vector(to_unsigned(i * 4, 32)), "0000" & FW(i));
        end loop;

        wait for 10 us;
        report "Releasing CPU: first NPU read is 40000004 at CPU PC 00000010";
        report "Watch PC: success loop=0000003C; fault loop=0000004C";
        report "On fault: a0/x10=mcause, a1/x11=mtval, a2/x12=mepc";
        cpu_released <= '1'; cpu_rst <= '1';

        wait for OBSERVE_TIME;
        report "Capture window complete. Inspect CPU PC/registers and AXI waveforms.";
        stop;
        wait;
    end process;

    watchdog : process
    begin
        wait for (FW'length + 3) * 150 * UART_BIT_PERIOD + 1 ms + OBSERVE_TIME;
        assert false report "Testbench timeout during upload/execution window" severity failure;
    end process;
end architecture;