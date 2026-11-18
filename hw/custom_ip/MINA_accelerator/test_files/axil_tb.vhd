library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity axil_tb is
end entity axil_tb;

architecture sim of axil_tb is
    constant CLK_PERIOD : time := 10 ns;

    signal clk          : std_logic := '0';
    signal aresetn      : std_logic := '0';
    signal boot_mode    : std_logic := '0';
    signal raw_mem_ready: std_logic;

    -- AXI4-Lite Write Address Channel
    signal s_axi_awaddr  : std_logic_vector(23 downto 0) := (others => '0');
    signal s_axi_awprot  : std_logic_vector(2 downto 0)  := "000";
    signal s_axi_awvalid : std_logic := '0';
    signal s_axi_awready : std_logic;

    -- AXI4-Lite Write Data Channel
    signal s_axi_wdata   : std_logic_vector(31 downto 0) := (others => '0');
    signal s_axi_wstrb   : std_logic_vector(3 downto 0)  := "1111";
    signal s_axi_wvalid  : std_logic := '0';
    signal s_axi_wready  : std_logic;

    -- AXI4-Lite Write Response Channel
    signal s_axi_bresp   : std_logic_vector(1 downto 0);
    signal s_axi_bvalid  : std_logic;
    signal s_axi_bready  : std_logic := '0';

    -- AXI4-Lite Read Address Channel
    signal s_axi_araddr  : std_logic_vector(23 downto 0) := (others => '0');
    signal s_axi_arprot  : std_logic_vector(2 downto 0)  := "000";
    signal s_axi_arvalid : std_logic := '0';
    signal s_axi_arready : std_logic;

    -- AXI4-Lite Read Data Channel
    signal s_axi_rdata   : std_logic_vector(31 downto 0);
    signal s_axi_rresp   : std_logic_vector(1 downto 0);
    signal s_axi_rvalid  : std_logic;
    signal s_axi_rready  : std_logic := '0';

    -- Raw Bootloader Ports
    signal raw_instr_dout      : std_logic_vector(35 downto 0);
    signal raw_weight_dout     : std_logic_vector(31 downto 0);
    signal raw_scratchpad_dout : std_logic_vector(31 downto 0);
    signal interrupt           : std_logic;

begin

    -- Clock generation (100 MHz)
    clk <= not clk after CLK_PERIOD / 2;

    -- DUT Instantiation
    dut : entity work.npu_axil_wrapper
        port map (
            clk                 => clk,
            aresetn             => aresetn,
            boot_mode           => boot_mode,
            raw_mem_ready       => raw_mem_ready,
            s_axi_awaddr        => s_axi_awaddr,
            s_axi_awprot        => s_axi_awprot,
            s_axi_awvalid       => s_axi_awvalid,
            s_axi_awready       => s_axi_awready,
            s_axi_wdata         => s_axi_wdata,
            s_axi_wstrb         => s_axi_wstrb,
            s_axi_wvalid        => s_axi_wvalid,
            s_axi_wready        => s_axi_wready,
            s_axi_bresp         => s_axi_bresp,
            s_axi_bvalid        => s_axi_bvalid,
            s_axi_bready        => s_axi_bready,
            s_axi_araddr        => s_axi_araddr,
            s_axi_arprot        => s_axi_arprot,
            s_axi_arvalid       => s_axi_arvalid,
            s_axi_arready       => s_axi_arready,
            s_axi_rdata         => s_axi_rdata,
            s_axi_rresp         => s_axi_rresp,
            s_axi_rvalid        => s_axi_rvalid,
            s_axi_rready        => s_axi_rready,
            raw_instr_dout      => raw_instr_dout,
            raw_weight_dout     => raw_weight_dout,
            raw_scratchpad_dout => raw_scratchpad_dout,
            interrupt           => interrupt
        );

    -- Stimulus Process
    stim_proc : process
        -- Helper procedure for AXI-Lite Read
        procedure axil_read(
            constant addr : in  std_logic_vector(23 downto 0);
            variable data : out std_logic_vector(31 downto 0);
            variable resp : out std_logic_vector(1 downto 0)
        ) is
        begin
            wait until rising_edge(clk);
            s_axi_araddr  <= addr;
            s_axi_arvalid <= '1';
            s_axi_rready  <= '1';

            -- Wait for ARREADY handshake
            loop
                wait until rising_edge(clk);
                exit when s_axi_arready = '1';
            end loop;
            s_axi_arvalid <= '0';

            -- Wait for RVALID response
            while s_axi_rvalid = '0' loop
                wait until rising_edge(clk);
            end loop;

            data := s_axi_rdata;
            resp := s_axi_rresp;
            s_axi_rready <= '0';
        end procedure;

        -- Helper procedure for AXI-Lite Write
        procedure axil_write(
            constant addr : in  std_logic_vector(23 downto 0);
            constant data : in  std_logic_vector(31 downto 0);
            variable resp : out std_logic_vector(1 downto 0)
        ) is
            variable aw_done, w_done : boolean := false;
        begin
            wait until rising_edge(clk);
            s_axi_awaddr  <= addr;
            s_axi_awvalid <= '1';
            s_axi_wdata   <= data;
            s_axi_wstrb   <= "1111";
            s_axi_wvalid  <= '1';
            s_axi_bready  <= '1';

            while not (aw_done and w_done) loop
                wait until rising_edge(clk);
                if s_axi_awvalid = '1' and s_axi_awready = '1' then
                    s_axi_awvalid <= '0';
                    aw_done := true;
                end if;
                if s_axi_wvalid = '1' and s_axi_wready = '1' then
                    s_axi_wvalid <= '0';
                    w_done := true;
                end if;
            end loop;

            while s_axi_bvalid = '0' loop
                wait until rising_edge(clk);
            end loop;

            resp := s_axi_bresp;
            s_axi_bready <= '0';
        end procedure;

        variable rdata : std_logic_vector(31 downto 0);
        variable rresp : std_logic_vector(1 downto 0);
        variable bresp : std_logic_vector(1 downto 0);
    begin
        -- 1. Reset sequence
        aresetn   <= '0';
        boot_mode <= '0';
        wait for 5 * CLK_PERIOD;
        wait until rising_edge(clk);
        aresetn <= '1';
        wait for 2 * CLK_PERIOD;

        -- 2. Test 1: Direct Read of NPU_STATUS (0x000004) in normal mode
        report "TEST 1: Reading NPU_STATUS (0x000004) with boot_mode = 0";
        axil_read(x"000004", rdata, rresp);
        report "  -> RDATA = 0x" & to_hstring(rdata) & " | RRESP = " & to_string(rresp);
        assert rresp = "00"
            report "FAIL: NPU_STATUS read returned SLVERR/DECERR (" & to_string(rresp) & ")!"
            severity error;
        assert rdata(0) = '1'
            report "FAIL: Expected fetch_halted (bit 0) = '1'"
            severity error;

        -- 3. Test 2: Exact sequence from npu_test.c:110-112
        --    NPU_RESET() (*0x40000000 = 0x02) followed by NPU_IS_HALTED() (*0x40000004)
        report "TEST 2: Writing NPU_RESET (0x02) to 0x000000 then reading 0x000004";
        axil_write(x"000000", x"00000002", bresp);
        report "  -> Write BRESP = " & to_string(bresp);
        assert bresp = "00"
            report "FAIL: NPU_RESET write returned SLVERR!"
            severity error;

        axil_read(x"000004", rdata, rresp);
        report "  -> Read  RDATA = 0x" & to_hstring(rdata) & " | RRESP = " & to_string(rresp);
        assert rresp = "00"
            report "FAIL: Post-reset NPU_STATUS read returned SLVERR!"
            severity error;

        -- 4. Test 3: Check what happens if boot_mode = '1' during AXI read
        report "TEST 3: Reading NPU_STATUS (0x000004) with boot_mode = 1";
        boot_mode <= '1';
        wait until rising_edge(clk);
        report "  -> raw_mem_ready when boot_mode=1 is: " & std_logic'image(raw_mem_ready);
        axil_read(x"000004", rdata, rresp);
        report "  -> RDATA = 0x" & to_hstring(rdata) & " | RRESP = " & to_string(rresp);

        report "All tests finished.";
        std.env.stop;
        wait;
    end process;

end architecture sim;
