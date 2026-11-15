library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- UART PHY
-------------------------------------------------------------------------------

entity uart_phy is
    generic (
        CLK_FREQ  : integer := 100_000_000;
        BAUD_RATE : integer := 115200
    );
    port (
        clk     : in  std_logic;
        reset_n : in  std_logic;

        uart_rx : in  std_logic;
        uart_tx : out std_logic;

        rx_data        : out std_logic_vector(7 downto 0);
        rx_valid       : out std_logic;
        rx_frame_error : out std_logic;

        tx_data  : in  std_logic_vector(7 downto 0);
        tx_valid : in  std_logic;
        tx_ready : out std_logic
    );
end entity;

architecture rtl of uart_phy is

    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD_RATE;
    constant HALF_BIT     : integer := CLKS_PER_BIT / 2;

    type tx_state_t is (
        TX_IDLE,
        TX_START,
        TX_SEND_DATA,
        TX_STOP
    );

    type rx_state_t is (
        RX_IDLE,
        RX_START,
        RX_RECV_DATA,
        RX_STOP
    );

    signal tx_state : tx_state_t := TX_IDLE;
    signal rx_state : rx_state_t := RX_IDLE;

    signal tx_clk_count : integer range 0 to CLKS_PER_BIT - 1 := 0;
    signal rx_clk_count : integer range 0 to CLKS_PER_BIT - 1 := 0;

    signal tx_bit_index : integer range 0 to 7 := 0;
    signal rx_bit_index : integer range 0 to 7 := 0;

    signal tx_shift : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_shift : std_logic_vector(7 downto 0) := (others => '0');

    signal uart_tx_reg : std_logic := '1';

begin

    assert CLKS_PER_BIT >= 4
        report "CLK_FREQ / BAUD_RATE must be >= 4"
        severity failure;

    uart_tx <= uart_tx_reg;

    tx_ready <= '1' when tx_state = TX_IDLE else '0';

    ---------------------------------------------------------------------------
    -- TX
    ---------------------------------------------------------------------------

    process(clk)
    begin
        if rising_edge(clk) then

            if reset_n = '0' then

                tx_state     <= TX_IDLE;
                tx_clk_count <= 0;
                tx_bit_index <= 0;
                tx_shift     <= (others => '0');
                uart_tx_reg  <= '1';

            else

                case tx_state is

                    when TX_IDLE =>

                        uart_tx_reg <= '1';

                        if tx_valid = '1' then
                            tx_shift     <= tx_data;
                            uart_tx_reg  <= '0';
                            tx_clk_count <= CLKS_PER_BIT - 1;
                            tx_state     <= TX_START;
                        end if;

                    when TX_START =>

                        if tx_clk_count = 0 then
                            tx_bit_index <= 0;
                            uart_tx_reg  <= tx_shift(0);
                            tx_clk_count <= CLKS_PER_BIT - 1;
                            tx_state     <= TX_SEND_DATA;
                        else
                            tx_clk_count <= tx_clk_count - 1;
                        end if;

                    when TX_SEND_DATA =>

                        if tx_clk_count = 0 then

                            if tx_bit_index = 7 then
                                uart_tx_reg  <= '1';
                                tx_clk_count <= CLKS_PER_BIT - 1;
                                tx_state     <= TX_STOP;
                            else
                                tx_bit_index <= tx_bit_index + 1;
                                uart_tx_reg  <= tx_shift(tx_bit_index + 1);
                                tx_clk_count <= CLKS_PER_BIT - 1;
                            end if;

                        else
                            tx_clk_count <= tx_clk_count - 1;
                        end if;

                    when TX_STOP =>

                        if tx_clk_count = 0 then
                            uart_tx_reg <= '1';
                            tx_state    <= TX_IDLE;
                        else
                            tx_clk_count <= tx_clk_count - 1;
                        end if;

                end case;

            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- RX
    ---------------------------------------------------------------------------

    process(clk)
    begin
        if rising_edge(clk) then

            rx_valid       <= '0';
            rx_frame_error <= '0';

            if reset_n = '0' then

                rx_state     <= RX_IDLE;
                rx_clk_count <= 0;
                rx_bit_index <= 0;
                rx_shift     <= (others => '0');
                rx_data      <= (others => '0');

            else

                case rx_state is

                    when RX_IDLE =>

                        if uart_rx = '0' then
                            rx_clk_count <= HALF_BIT;
                            rx_state     <= RX_START;
                        end if;

                    when RX_START =>

                        if rx_clk_count = 0 then

                            if uart_rx = '0' then
                                rx_bit_index <= 0;
                                rx_clk_count <= CLKS_PER_BIT - 1;
                                rx_state     <= RX_RECV_DATA;
                            else
                                rx_state <= RX_IDLE;
                            end if;

                        else
                            rx_clk_count <= rx_clk_count - 1;
                        end if;

                    when RX_RECV_DATA =>

                        if rx_clk_count = 0 then

                            rx_shift(rx_bit_index) <= uart_rx;

                            if rx_bit_index = 7 then
                                rx_clk_count <= CLKS_PER_BIT - 1;
                                rx_state     <= RX_STOP;
                            else
                                rx_bit_index <= rx_bit_index + 1;
                                rx_clk_count <= CLKS_PER_BIT - 1;
                            end if;

                        else
                            rx_clk_count <= rx_clk_count - 1;
                        end if;

                    when RX_STOP =>

                        if rx_clk_count = 0 then

                            if uart_rx = '1' then
                                rx_data  <= rx_shift;
                                rx_valid <= '1';
                            else
                                rx_frame_error <= '1';
                            end if;

                            rx_state <= RX_IDLE;

                        else
                            rx_clk_count <= rx_clk_count - 1;
                        end if;

                end case;

            end if;

        end if;
    end process;

end architecture;


-------------------------------------------------------------------------------
-- AXI-Lite UART + BRAM bootloader
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi_uart_bootloader is
    generic (
        CLK_FREQ        : integer := 100_000_000;
        BAUD_RATE       : integer := 115200;

        AXI_ADDR_WIDTH  : integer := 32;

        FIFO_DEPTH      : integer := 16;

        -- Number of WORD-address bits on the native 32-bit BRAM port.
        -- Example: BRAM_ADDR_WIDTH = 14 -> 16384 x 32 = 64 KiB.
        BRAM_ADDR_WIDTH : integer := 14;
        NPU_HOST_ADDR_WIDTH : positive := 16
    );
    port (
        -----------------------------------------------------------------------
        -- Clock/reset
        -----------------------------------------------------------------------
        s_axi_aclk    : in std_logic;
        s_axi_aresetn : in std_logic;

        -----------------------------------------------------------------------
        -- Mode
        -----------------------------------------------------------------------
        -- 0 = normal AXI UART
        -- 1 = direct UART-to-BRAM bootloader
        boot_mode : in std_logic;

        -----------------------------------------------------------------------
        -- Physical UART
        -----------------------------------------------------------------------
        uart_rx : in  std_logic;
        uart_tx : out std_logic;

        -----------------------------------------------------------------------
        -- Interrupt output
        -----------------------------------------------------------------------
        -- Level-sensitive interrupt intended for a PLIC/interrupt controller.
        -- Asserted when any enabled interrupt source is active.
        uart_irq : out std_logic;

        -----------------------------------------------------------------------
        -- AXI4-Lite slave
        -----------------------------------------------------------------------

        -- Write address
        s_axi_awaddr  : in  std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
        s_axi_awvalid : in  std_logic;
        s_axi_awready : out std_logic;

        -- Write data
        s_axi_wdata  : in  std_logic_vector(31 downto 0);
        s_axi_wstrb  : in  std_logic_vector(3 downto 0);
        s_axi_wvalid : in  std_logic;
        s_axi_wready : out std_logic;

        -- Write response
        s_axi_bresp  : out std_logic_vector(1 downto 0);
        s_axi_bvalid : out std_logic;
        s_axi_bready : in  std_logic;

        -- Read address
        s_axi_araddr  : in  std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
        s_axi_arvalid : in  std_logic;
        s_axi_arready : out std_logic;

        -- Read data
        s_axi_rdata  : out std_logic_vector(31 downto 0);
        s_axi_rresp  : out std_logic_vector(1 downto 0);
        s_axi_rvalid : out std_logic;
        s_axi_rready : in  std_logic;

        -----------------------------------------------------------------------
        -- Native BRAM write port
        -----------------------------------------------------------------------
        -- Connect to a second port of a true dual-port BRAM.
        -- Use s_axi_aclk as the BRAM clock.
        -----------------------------------------------------------------------
        bram_en   : out std_logic;
        bram_we   : out std_logic_vector(3 downto 0);
        bram_addr : out std_logic_vector(BRAM_ADDR_WIDTH - 1 downto 0);
        bram_din  : out std_logic_vector(31 downto 0);
        -- Same clock as NPU. Connect active/ready to its wrapper.
        npu_boot_active : out std_logic;
        npu_ready : in std_logic := '0';
        npu_instr_we : out std_logic;
        npu_instr_addr : out std_logic_vector(9 downto 0);
        npu_instr_din : out std_logic_vector(35 downto 0);
        npu_weight_we : out std_logic;
        npu_weight_addr : out std_logic_vector(NPU_HOST_ADDR_WIDTH-1 downto 0);
        npu_weight_din : out std_logic_vector(31 downto 0);
        npu_scratchpad_we : out std_logic;
        npu_scratchpad_addr : out std_logic_vector(NPU_HOST_ADDR_WIDTH-1 downto 0);
        npu_scratchpad_din : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of axi_uart_bootloader is

    ---------------------------------------------------------------------------
    -- Constants
    ---------------------------------------------------------------------------

    constant AXI_OKAY   : std_logic_vector(1 downto 0) := "00";
    constant AXI_SLVERR : std_logic_vector(1 downto 0) := "10";

    constant BOOT_SYNC  : std_logic_vector(7 downto 0) := x"55";
    constant CMD_NPU_INSTR : std_logic_vector(7 downto 0) := x"02";
    constant CMD_NPU_WEIGHT : std_logic_vector(7 downto 0) := x"03";
    constant CMD_NPU_SCRATCH : std_logic_vector(7 downto 0) := x"04";
    constant CMD_WRITE  : std_logic_vector(7 downto 0) := x"01";

    constant UART_ACK   : std_logic_vector(7 downto 0) := x"06";
    constant UART_NAK   : std_logic_vector(7 downto 0) := x"15";

    ---------------------------------------------------------------------------
    -- Mode synchronizer
    ---------------------------------------------------------------------------

    signal boot_meta   : std_logic := '0';
    signal boot_active : std_logic := '0';

    ---------------------------------------------------------------------------
    -- UART PHY
    ---------------------------------------------------------------------------

    signal phy_rx_data        : std_logic_vector(7 downto 0);
    signal phy_rx_valid       : std_logic;
    signal phy_rx_frame_error : std_logic;

    signal phy_tx_data  : std_logic_vector(7 downto 0);
    signal phy_tx_valid : std_logic;
    signal phy_tx_ready : std_logic;

    ---------------------------------------------------------------------------
    -- FIFOs
    ---------------------------------------------------------------------------

    type fifo_mem_t is array (
        0 to FIFO_DEPTH - 1
    ) of std_logic_vector(7 downto 0);

    signal rx_fifo : fifo_mem_t;
    signal tx_fifo : fifo_mem_t;

    signal rx_wr_ptr : integer range 0 to FIFO_DEPTH - 1 := 0;
    signal rx_rd_ptr : integer range 0 to FIFO_DEPTH - 1 := 0;
    signal tx_wr_ptr : integer range 0 to FIFO_DEPTH - 1 := 0;
    signal tx_rd_ptr : integer range 0 to FIFO_DEPTH - 1 := 0;

    signal rx_count : integer range 0 to FIFO_DEPTH := 0;
    signal tx_count : integer range 0 to FIFO_DEPTH := 0;

    signal overrun_error : std_logic := '0';
    signal frame_error   : std_logic := '0';

    ---------------------------------------------------------------------------
    -- Interrupt control/status
    --
    -- bit 0 : RX data available
    -- bit 1 : TX FIFO empty
    -- bit 2 : RX overrun error
    -- bit 3 : framing error
    ---------------------------------------------------------------------------

    signal irq_enable_reg : std_logic_vector(3 downto 0)
        := (others => '0');

    signal irq_status_raw : std_logic_vector(3 downto 0);

    ---------------------------------------------------------------------------
    -- AXI -> FIFO control pulses
    ---------------------------------------------------------------------------

    signal axi_tx_push : std_logic := '0';
    signal axi_tx_data : std_logic_vector(7 downto 0) := (others => '0');

    signal axi_rx_pop : std_logic := '0';

    signal axi_tx_fifo_reset : std_logic := '0';
    signal axi_rx_fifo_reset : std_logic := '0';
    signal axi_error_clear   : std_logic := '0';

    ---------------------------------------------------------------------------
    -- AXI write channel storage
    ---------------------------------------------------------------------------

    signal aw_hold : std_logic := '0';
    signal w_hold  : std_logic := '0';

    signal awaddr_hold : std_logic_vector(
        AXI_ADDR_WIDTH - 1 downto 0
    ) := (others => '0');

    signal wdata_hold : std_logic_vector(31 downto 0)
        := (others => '0');

    signal wstrb_hold : std_logic_vector(3 downto 0)
        := (others => '0');

    signal bvalid_reg : std_logic := '0';
    signal bresp_reg  : std_logic_vector(1 downto 0)
        := AXI_OKAY;

    ---------------------------------------------------------------------------
    -- AXI read channel storage
    ---------------------------------------------------------------------------

    signal rvalid_reg : std_logic := '0';

    signal rdata_reg : std_logic_vector(31 downto 0)
        := (others => '0');

    signal rresp_reg : std_logic_vector(1 downto 0)
        := AXI_OKAY;

    ---------------------------------------------------------------------------
    -- Bootloader parser
    ---------------------------------------------------------------------------

    type boot_state_t is (
        BOOT_WAIT_SYNC,
        BOOT_CMD,

        BOOT_ADDR_3,
        BOOT_ADDR_2,
        BOOT_ADDR_1,
        BOOT_ADDR_0,

        BOOT_DATA_4,
        BOOT_DATA_3,
        BOOT_DATA_2,
        BOOT_DATA_1,
        BOOT_DATA_0,

        BOOT_CHECKSUM_BYTE
    );

    signal boot_command : std_logic_vector(7 downto 0) := x"00";
    signal boot_data_hi : std_logic_vector(7 downto 0) := x"00";
    signal npu_i_we, npu_w_we, npu_s_we : std_logic := '0';
    signal npu_address : std_logic_vector(31 downto 0) := (others => '0');
    signal npu_data : std_logic_vector(35 downto 0) := (others => '0');
    signal boot_state : boot_state_t := BOOT_WAIT_SYNC;

    signal boot_address : std_logic_vector(31 downto 0)
        := (others => '0');

    signal boot_data : std_logic_vector(31 downto 0)
        := (others => '0');

    signal boot_checksum : std_logic_vector(7 downto 0)
        := (others => '0');

    signal boot_reply_pending : std_logic := '0';

    signal boot_reply : std_logic_vector(7 downto 0)
        := UART_ACK;

    ---------------------------------------------------------------------------
    -- BRAM registers
    ---------------------------------------------------------------------------

    signal bram_en_reg : std_logic := '0';

    signal bram_we_reg : std_logic_vector(3 downto 0)
        := (others => '0');

    signal bram_addr_reg : std_logic_vector(
        BRAM_ADDR_WIDTH - 1 downto 0
    ) := (others => '0');

    signal bram_din_reg : std_logic_vector(31 downto 0)
        := (others => '0');

begin

    ---------------------------------------------------------------------------
    -- Parameter checks
    ---------------------------------------------------------------------------

    assert AXI_ADDR_WIDTH >= 6
        report "AXI_ADDR_WIDTH must be at least 6"
        severity failure;

    assert BRAM_ADDR_WIDTH <= 30
        report "BRAM_ADDR_WIDTH must be <= 30"
        severity failure;

    assert FIFO_DEPTH >= 1
        report "FIFO_DEPTH must be >= 1"
        severity failure;

    ---------------------------------------------------------------------------
    -- Output assignments
    ---------------------------------------------------------------------------

    s_axi_bvalid <= bvalid_reg;
    s_axi_bresp  <= bresp_reg;

    s_axi_rvalid <= rvalid_reg;
    s_axi_rdata  <= rdata_reg;
    s_axi_rresp  <= rresp_reg;

    assert NPU_HOST_ADDR_WIDTH <= 18
        report "NPU_HOST_ADDR_WIDTH must match pe_pkg.HOST_ADDR_WIDTH (max 18)" severity failure;
    npu_boot_active <= boot_active;
    npu_instr_we <= npu_i_we and boot_active and npu_ready and s_axi_aresetn;
    npu_weight_we <= npu_w_we and boot_active and npu_ready and s_axi_aresetn;
    npu_scratchpad_we <= npu_s_we and boot_active and npu_ready and s_axi_aresetn;
    npu_instr_addr <= npu_address(12 downto 3);
    npu_weight_addr <= npu_address(NPU_HOST_ADDR_WIDTH+1 downto 2);
    npu_scratchpad_addr <= npu_address(NPU_HOST_ADDR_WIDTH+1 downto 2);
    npu_instr_din <= npu_data;
    npu_weight_din <= npu_data(31 downto 0);
    npu_scratchpad_din <= npu_data(31 downto 0);
    bram_en   <= bram_en_reg;
    bram_we   <= bram_we_reg;
    bram_addr <= bram_addr_reg;
    bram_din  <= bram_din_reg;

    ---------------------------------------------------------------------------
    -- Interrupt status and output
    --
    -- RX/TX causes are live level conditions. Error causes are sticky because
    -- overrun_error and frame_error are sticky until CONTROL bit 2 is written.
    -- Interrupts are suppressed while reset is active or while hardware boot
    -- mode owns the UART.
    ---------------------------------------------------------------------------

    irq_status_raw(0) <= '1' when rx_count > 0 else '0';
    irq_status_raw(1) <= '1' when tx_count = 0 else '0';
    irq_status_raw(2) <= overrun_error;
    irq_status_raw(3) <= frame_error;

    uart_irq <= '0'
        when s_axi_aresetn = '0' or boot_active = '1'
        else '1'
        when (irq_enable_reg and irq_status_raw) /= "0000"
        else '0';

    ---------------------------------------------------------------------------
    -- AXI ready generation
    ---------------------------------------------------------------------------

    s_axi_awready <= '1'
        when aw_hold = '0' and bvalid_reg = '0'
        else '0';

    s_axi_wready <= '1'
        when w_hold = '0' and bvalid_reg = '0'
        else '0';

    s_axi_arready <= '1'
        when rvalid_reg = '0'
        else '0';

    ---------------------------------------------------------------------------
    -- Synchronize mode input
    ---------------------------------------------------------------------------

    process(s_axi_aclk)
    begin
        if rising_edge(s_axi_aclk) then

            if s_axi_aresetn = '0' then
                boot_meta   <= '0';
                boot_active <= '0';
            else
                boot_meta   <= boot_mode;
                boot_active <= boot_meta;
            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- UART PHY
    ---------------------------------------------------------------------------

    uart_inst : entity work.uart_phy
        generic map (
            CLK_FREQ  => CLK_FREQ,
            BAUD_RATE => BAUD_RATE
        )
        port map (
            clk     => s_axi_aclk,
            reset_n => s_axi_aresetn,

            uart_rx => uart_rx,
            uart_tx => uart_tx,

            rx_data        => phy_rx_data,
            rx_valid       => phy_rx_valid,
            rx_frame_error => phy_rx_frame_error,

            tx_data  => phy_tx_data,
            tx_valid => phy_tx_valid,
            tx_ready => phy_tx_ready
        );

    ---------------------------------------------------------------------------
    -- UART TX arbitration
    --
    -- Bootloader owns TX completely while boot_active = '1'.
    ---------------------------------------------------------------------------

    process(all)
    begin

        phy_tx_valid <= '0';
        phy_tx_data  <= (others => '0');

        if boot_active = '1' then

            if boot_reply_pending = '1' then
                phy_tx_valid <= '1';
                phy_tx_data  <= boot_reply;
            end if;

        else

            if tx_count > 0 then
                phy_tx_valid <= '1';
                phy_tx_data  <= tx_fifo(tx_rd_ptr);
            end if;

        end if;

    end process;

    ---------------------------------------------------------------------------
    -- RX FIFO
    ---------------------------------------------------------------------------

    process(s_axi_aclk)

        variable do_push : boolean;
        variable do_pop  : boolean;

    begin
        if rising_edge(s_axi_aclk) then

            if s_axi_aresetn = '0' then

                rx_wr_ptr <= 0;
                rx_rd_ptr <= 0;
                rx_count  <= 0;

                overrun_error <= '0';
                frame_error   <= '0';

            else

                ----------------------------------------------------------------
                -- Sticky UART errors
                ----------------------------------------------------------------

                if axi_error_clear = '1' then
                    overrun_error <= '0';
                    frame_error   <= '0';
                end if;

                if phy_rx_frame_error = '1' then
                    frame_error <= '1';
                end if;

                ----------------------------------------------------------------
                -- FIFO reset
                ----------------------------------------------------------------

                if axi_rx_fifo_reset = '1' then

                    rx_wr_ptr <= 0;
                    rx_rd_ptr <= 0;
                    rx_count  <= 0;

                else

                    do_push := false;
                    do_pop  := false;

                    ------------------------------------------------------------
                    -- UART writes RX FIFO only in normal AXI mode.
                    ------------------------------------------------------------

                    if boot_active = '0' and phy_rx_valid = '1' then

                        if rx_count < FIFO_DEPTH then
                            do_push := true;
                        else
                            overrun_error <= '1';
                        end if;

                    end if;

                    ------------------------------------------------------------
                    -- AXI read removes one byte.
                    ------------------------------------------------------------

                    if axi_rx_pop = '1' and rx_count > 0 then
                        do_pop := true;
                    end if;

                    ------------------------------------------------------------
                    -- FIFO memory write
                    ------------------------------------------------------------

                    if do_push then

                        rx_fifo(rx_wr_ptr) <= phy_rx_data;

                        if rx_wr_ptr = FIFO_DEPTH - 1 then
                            rx_wr_ptr <= 0;
                        else
                            rx_wr_ptr <= rx_wr_ptr + 1;
                        end if;

                    end if;

                    ------------------------------------------------------------
                    -- FIFO read pointer
                    ------------------------------------------------------------

                    if do_pop then

                        if rx_rd_ptr = FIFO_DEPTH - 1 then
                            rx_rd_ptr <= 0;
                        else
                            rx_rd_ptr <= rx_rd_ptr + 1;
                        end if;

                    end if;

                    ------------------------------------------------------------
                    -- FIFO count
                    ------------------------------------------------------------

                    if do_push and not do_pop then
                        rx_count <= rx_count + 1;

                    elsif do_pop and not do_push then
                        rx_count <= rx_count - 1;

                    end if;

                end if;

            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- TX FIFO
    ---------------------------------------------------------------------------

    process(s_axi_aclk)

        variable do_push : boolean;
        variable do_pop  : boolean;

    begin
        if rising_edge(s_axi_aclk) then

            if s_axi_aresetn = '0' then

                tx_wr_ptr <= 0;
                tx_rd_ptr <= 0;
                tx_count  <= 0;

            else

                if axi_tx_fifo_reset = '1' then

                    tx_wr_ptr <= 0;
                    tx_rd_ptr <= 0;
                    tx_count  <= 0;

                else

                    do_push := false;
                    do_pop  := false;

                    ------------------------------------------------------------
                    -- AXI pushes byte into TX FIFO.
                    ------------------------------------------------------------

                    if axi_tx_push = '1' and tx_count < FIFO_DEPTH then
                        do_push := true;
                    end if;

                    ------------------------------------------------------------
                    -- UART accepts current front byte.
                    ------------------------------------------------------------

                    if boot_active = '0'
                        and tx_count > 0
                        and phy_tx_ready = '1'
                    then
                        do_pop := true;
                    end if;

                    ------------------------------------------------------------
                    -- FIFO memory write
                    ------------------------------------------------------------

                    if do_push then

                        tx_fifo(tx_wr_ptr) <= axi_tx_data;

                        if tx_wr_ptr = FIFO_DEPTH - 1 then
                            tx_wr_ptr <= 0;
                        else
                            tx_wr_ptr <= tx_wr_ptr + 1;
                        end if;

                    end if;

                    ------------------------------------------------------------
                    -- FIFO read pointer
                    ------------------------------------------------------------

                    if do_pop then

                        if tx_rd_ptr = FIFO_DEPTH - 1 then
                            tx_rd_ptr <= 0;
                        else
                            tx_rd_ptr <= tx_rd_ptr + 1;
                        end if;

                    end if;

                    ------------------------------------------------------------
                    -- FIFO count
                    ------------------------------------------------------------

                    if do_push and not do_pop then
                        tx_count <= tx_count + 1;

                    elsif do_pop and not do_push then
                        tx_count <= tx_count - 1;

                    end if;

                end if;

            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- AXI WRITE interface
    ---------------------------------------------------------------------------

    process(s_axi_aclk)

        variable reg_index : integer;

    begin
        if rising_edge(s_axi_aclk) then

            axi_tx_push       <= '0';
            axi_tx_fifo_reset <= '0';
            axi_rx_fifo_reset <= '0';
            axi_error_clear   <= '0';

            if s_axi_aresetn = '0' then

                aw_hold <= '0';
                w_hold  <= '0';

                awaddr_hold <= (others => '0');
                wdata_hold  <= (others => '0');
                wstrb_hold  <= (others => '0');

                axi_tx_data    <= (others => '0');
                irq_enable_reg <= (others => '0');

                bvalid_reg <= '0';
                bresp_reg  <= AXI_OKAY;

            else

                ----------------------------------------------------------------
                -- Capture AW independently.
                ----------------------------------------------------------------

                if s_axi_awvalid = '1'
                    and s_axi_awready = '1'
                then
                    awaddr_hold <= s_axi_awaddr;
                    aw_hold     <= '1';
                end if;

                ----------------------------------------------------------------
                -- Capture W independently.
                ----------------------------------------------------------------

                if s_axi_wvalid = '1'
                    and s_axi_wready = '1'
                then
                    wdata_hold <= s_axi_wdata;
                    wstrb_hold <= s_axi_wstrb;
                    w_hold     <= '1';
                end if;

                ----------------------------------------------------------------
                -- Response consumed.
                ----------------------------------------------------------------

                if bvalid_reg = '1'
                    and s_axi_bready = '1'
                then
                    bvalid_reg <= '0';
                end if;

                ----------------------------------------------------------------
                -- Execute transaction once both AW and W have been captured.
                ----------------------------------------------------------------

                if aw_hold = '1'
                    and w_hold = '1'
                    and bvalid_reg = '0'
                then

                    bresp_reg <= AXI_OKAY;

                    ------------------------------------------------------------
                    -- AXI UART interface is blocked during hardware boot mode.
                    ------------------------------------------------------------

                    if boot_active = '1' then

                        bresp_reg <= AXI_SLVERR;

                    else

                        reg_index :=
                            to_integer(unsigned(
                                awaddr_hold(5 downto 2)
                            ));

                        case reg_index is

                            ----------------------------------------------------
                            -- 0x04 : TX FIFO
                            ----------------------------------------------------

                            when 1 =>

                                if wstrb_hold(0) = '1' then

                                    if tx_count < FIFO_DEPTH then
                                        axi_tx_data <= wdata_hold(7 downto 0);
                                        axi_tx_push <= '1';
                                    else
                                        bresp_reg <= AXI_SLVERR;
                                    end if;

                                end if;

                            ----------------------------------------------------
                            -- 0x0C : CONTROL
                            ----------------------------------------------------

                            when 3 =>

                                if wstrb_hold(0) = '1' then

                                    -- bit 0: reset TX FIFO
                                    if wdata_hold(0) = '1' then
                                        axi_tx_fifo_reset <= '1';
                                    end if;

                                    -- bit 1: reset RX FIFO
                                    if wdata_hold(1) = '1' then
                                        axi_rx_fifo_reset <= '1';
                                    end if;

                                    -- bit 2: clear sticky errors
                                    if wdata_hold(2) = '1' then
                                        axi_error_clear <= '1';
                                    end if;

                                end if;

                            ----------------------------------------------------
                            -- 0x10 : IRQ_ENABLE
                            --
                            -- bit 0: RX data available interrupt enable
                            -- bit 1: TX FIFO empty interrupt enable
                            -- bit 2: RX overrun interrupt enable
                            -- bit 3: framing error interrupt enable
                            ----------------------------------------------------

                            when 4 =>

                                if wstrb_hold(0) = '1' then
                                    irq_enable_reg <= wdata_hold(3 downto 0);
                                end if;

                            ----------------------------------------------------
                            -- Invalid/read-only register
                            ----------------------------------------------------

                            when others =>
                                bresp_reg <= AXI_SLVERR;

                        end case;

                    end if;

                    aw_hold <= '0';
                    w_hold  <= '0';

                    bvalid_reg <= '1';

                end if;

            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- AXI READ interface
    ---------------------------------------------------------------------------

    process(s_axi_aclk)

        variable reg_index : integer;
        variable temp      : std_logic_vector(31 downto 0);

    begin
        if rising_edge(s_axi_aclk) then

            axi_rx_pop <= '0';

            if s_axi_aresetn = '0' then

                rvalid_reg <= '0';
                rdata_reg  <= (others => '0');
                rresp_reg  <= AXI_OKAY;

            else

                ----------------------------------------------------------------
                -- Existing response accepted.
                ----------------------------------------------------------------

                if rvalid_reg = '1'
                    and s_axi_rready = '1'
                then
                    rvalid_reg <= '0';
                end if;

                ----------------------------------------------------------------
                -- New read.
                ----------------------------------------------------------------

                if s_axi_arvalid = '1'
                    and s_axi_arready = '1'
                then

                    temp      := (others => '0');
                    rresp_reg <= AXI_OKAY;

                    if boot_active = '1' then

                        rresp_reg <= AXI_SLVERR;

                    else

                        reg_index :=
                            to_integer(unsigned(
                                s_axi_araddr(5 downto 2)
                            ));

                        case reg_index is

                            ----------------------------------------------------
                            -- 0x00 : RX FIFO
                            ----------------------------------------------------

                            when 0 =>

                                if rx_count > 0 then

                                    temp(7 downto 0) :=
                                        rx_fifo(rx_rd_ptr);

                                    axi_rx_pop <= '1';

                                else
                                    rresp_reg <= AXI_SLVERR;
                                end if;

                            ----------------------------------------------------
                            -- 0x08 : STATUS
                            ----------------------------------------------------

                            when 2 =>

                                -- bit 0: RX data available
                                if rx_count > 0 then
                                    temp(0) := '1';
                                end if;

                                -- bit 1: RX FIFO full
                                if rx_count = FIFO_DEPTH then
                                    temp(1) := '1';
                                end if;

                                -- bit 2: TX FIFO empty
                                if tx_count = 0 then
                                    temp(2) := '1';
                                end if;

                                -- bit 3: TX FIFO full
                                if tx_count = FIFO_DEPTH then
                                    temp(3) := '1';
                                end if;

                                -- bit 4: boot mode active
                                temp(4) := boot_active;

                                -- bit 5: RX overrun
                                temp(5) := overrun_error;

                                -- bit 6: framing error
                                temp(6) := frame_error;

                            ----------------------------------------------------
                            -- 0x0C : CONTROL (reads as zero)
                            ----------------------------------------------------

                            when 3 =>
                                temp := (others => '0');

                            ----------------------------------------------------
                            -- 0x10 : IRQ_ENABLE
                            ----------------------------------------------------

                            when 4 =>
                                temp(3 downto 0) := irq_enable_reg;

                            ----------------------------------------------------
                            -- 0x14 : IRQ_STATUS (raw interrupt causes)
                            --
                            -- bit 0: RX data available
                            -- bit 1: TX FIFO empty
                            -- bit 2: RX overrun error
                            -- bit 3: framing error
                            ----------------------------------------------------

                            when 5 =>
                                temp(3 downto 0) := irq_status_raw;

                            ----------------------------------------------------
                            -- Invalid register
                            ----------------------------------------------------

                            when others =>
                                rresp_reg <= AXI_SLVERR;

                        end case;

                    end if;

                    rdata_reg  <= temp;
                    rvalid_reg <= '1';

                end if;

            end if;

        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Hardware bootloader
    ---------------------------------------------------------------------------

    process(s_axi_aclk)
    begin
        if rising_edge(s_axi_aclk) then

            -------------------------------------------------------------------
            -- BRAM write controls are one-cycle pulses.
            -------------------------------------------------------------------

            npu_i_we <= '0'; npu_w_we <= '0'; npu_s_we <= '0';
            bram_en_reg <= '0';
            bram_we_reg <= (others => '0');

            if s_axi_aresetn = '0' then

                boot_state         <= BOOT_WAIT_SYNC;
                boot_address       <= (others => '0');
                boot_data          <= (others => '0');
                boot_checksum      <= (others => '0');
                boot_reply_pending <= '0';
                boot_reply         <= UART_ACK;

                bram_addr_reg <= (others => '0');
                bram_din_reg  <= (others => '0');

            elsif boot_active = '0' then

                -- Leaving boot mode aborts any partial packet.
                boot_state         <= BOOT_WAIT_SYNC;
                boot_address       <= (others => '0');
                boot_data          <= (others => '0');
                boot_checksum      <= (others => '0');
                boot_reply_pending <= '0';

            else

                ----------------------------------------------------------------
                -- UART accepted pending ACK/NAK.
                ----------------------------------------------------------------

                if boot_reply_pending = '1'
                    and phy_tx_ready = '1'
                then
                    boot_reply_pending <= '0';
                end if;

                ----------------------------------------------------------------
                -- Parse incoming packet.
                ----------------------------------------------------------------

                if phy_rx_frame_error = '1' then
                    boot_state <= BOOT_WAIT_SYNC;
                    boot_reply <= UART_NAK; boot_reply_pending <= '1';
                elsif phy_rx_valid = '1' then

                    case boot_state is

                        --------------------------------------------------------
                        -- Wait for 0x55 sync byte.
                        --------------------------------------------------------

                        when BOOT_WAIT_SYNC =>

                            if phy_rx_data = BOOT_SYNC then

                                boot_checksum <= (others => '0');
                                boot_state    <= BOOT_CMD;

                            end if;

                        --------------------------------------------------------
                        -- Command byte.
                        --------------------------------------------------------

                        when BOOT_CMD =>

                            if phy_rx_data = CMD_WRITE or phy_rx_data = CMD_NPU_INSTR or
                               phy_rx_data = CMD_NPU_WEIGHT or phy_rx_data = CMD_NPU_SCRATCH then
                                boot_command <= phy_rx_data;
                                boot_data_hi <= (others => '0');

                                boot_checksum <= phy_rx_data;
                                boot_state    <= BOOT_ADDR_3;

                            else

                                boot_reply         <= UART_NAK;
                                boot_reply_pending <= '1';
                                boot_state         <= BOOT_WAIT_SYNC;

                            end if;

                        --------------------------------------------------------
                        -- Address [31:24]
                        --------------------------------------------------------

                        when BOOT_ADDR_3 =>

                            boot_address(31 downto 24) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_ADDR_2;

                        --------------------------------------------------------
                        -- Address [23:16]
                        --------------------------------------------------------

                        when BOOT_ADDR_2 =>

                            boot_address(23 downto 16) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_ADDR_1;

                        --------------------------------------------------------
                        -- Address [15:8]
                        --------------------------------------------------------

                        when BOOT_ADDR_1 =>

                            boot_address(15 downto 8) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_ADDR_0;

                        --------------------------------------------------------
                        -- Address [7:0]
                        --------------------------------------------------------

                        when BOOT_ADDR_0 =>

                            boot_address(7 downto 0) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            if boot_command = CMD_NPU_INSTR then
                                boot_state <= BOOT_DATA_4;
                            else
                                boot_state <= BOOT_DATA_3;
                            end if;

                        when BOOT_DATA_4 =>
                            boot_data_hi <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_DATA_3;

                        --------------------------------------------------------
                        -- Data [31:24]
                        --------------------------------------------------------

                        when BOOT_DATA_3 =>

                            boot_data(31 downto 24) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_DATA_2;

                        --------------------------------------------------------
                        -- Data [23:16]
                        --------------------------------------------------------

                        when BOOT_DATA_2 =>

                            boot_data(23 downto 16) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_DATA_1;

                        --------------------------------------------------------
                        -- Data [15:8]
                        --------------------------------------------------------

                        when BOOT_DATA_1 =>

                            boot_data(15 downto 8) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_DATA_0;

                        --------------------------------------------------------
                        -- Data [7:0]
                        --------------------------------------------------------

                        when BOOT_DATA_0 =>

                            boot_data(7 downto 0) <= phy_rx_data;
                            boot_checksum <= boot_checksum xor phy_rx_data;
                            boot_state <= BOOT_CHECKSUM_BYTE;

                        --------------------------------------------------------
                        -- Check checksum and perform write.
                        --------------------------------------------------------

                        when BOOT_CHECKSUM_BYTE =>

                            -- Default failure: no memory is touched unless every
                            -- check passes. NPU addresses are local byte offsets.
                            boot_reply <= UART_NAK;
                            boot_reply_pending <= '1';
                            if phy_rx_data = boot_checksum then
                                if boot_command = CMD_WRITE then
                                    -- Preserve CPU address aliasing and 32-bit format.
                                    if boot_address(1 downto 0) = "00" then
                                        bram_addr_reg <= boot_address(BRAM_ADDR_WIDTH+1 downto 2);
                                        bram_din_reg <= boot_data;
                                        bram_en_reg <= '1'; bram_we_reg <= "1111";
                                        boot_reply <= UART_ACK;
                                    end if;
                                elsif npu_ready = '1' then
                                    npu_address <= boot_address;
                                    npu_data <= boot_data_hi(3 downto 0) & boot_data;
                                    if boot_command = CMD_NPU_INSTR then
                                        if unsigned(boot_address) < 8192 and
                                           boot_address(2 downto 0) = "000" and
                                           boot_data_hi(7 downto 4) = "0000" then
                                            npu_i_we <= '1'; boot_reply <= UART_ACK;
                                        end if;
                                    elsif boot_address(1 downto 0) = "00" and
                                          unsigned(boot_address) < 2**(NPU_HOST_ADDR_WIDTH+2) then
                                        if boot_command = CMD_NPU_WEIGHT then
                                            npu_w_we <= '1'; boot_reply <= UART_ACK;
                                        elsif boot_command = CMD_NPU_SCRATCH then
                                            npu_s_we <= '1'; boot_reply <= UART_ACK;
                                        end if;
                                    end if;
                                end if;
                            end if;

                            boot_state <= BOOT_WAIT_SYNC;

                    end case;

                end if;

            end if;

        end if;
    end process;

end architecture;
