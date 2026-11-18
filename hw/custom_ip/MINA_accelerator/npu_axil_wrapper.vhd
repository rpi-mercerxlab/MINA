-- VHDL-2008. AXI-Lite host wrapper for MINA NPU.
--
-- Drop-in interface/address-map replacement for npu_axil_wrapper(3).vhd.
-- All inputs, including boot_mode and the raw memory ports, use clk.
--
-- Local byte offsets (CPU base address is assigned in Vivado):
--   000000           CONTROL: RUN[0], RESET[1] pulse, CLEAR_IRQ[3] pulse
--   000004           STATUS (read only):
--                      [0] fetch_halted, [1] run_req, [2] AXI owns RAM ports,
--                      [3] reset_pulse, [4] irq, [5] boot handoff pending
--   000008           PC[9:0] (read only)
--   00000C           interrupt address[11:0] (read only)
--   100000..101FFF   1024 instructions, 8 bytes/instruction:
--                      +0 = bits[31:0], +4 = bits[35:32] in RDATA[3:0]
--   200000..207FFF   8192 x 32-bit weight words
--   300000..307FFF   8192 x 32-bit scratchpad words
--
-- One outstanding read and one outstanding write are supported. AW and W
-- may arrive in either order. Responses remain stable until accepted.
-- RAM accesses use the existing one-clock synchronous host read ports;
-- partial writes use read/modify/write. No extra halt restriction is added.
-- Halt/reset the core before changing data that its datapath may still use.
--
-- boot_mode requests raw ownership. An active AXI RAM access completes
-- before ownership changes. Wait for raw_mem_ready before using raw ports;
-- hold boot_mode high for the complete raw transfer. AXI register reads
-- remain available in boot mode, but AXI RAM accesses/control writes fail.
-- raw_mem_ready indicates host-port ownership, not datapath quiescence.
--
-- QUIESCE_CYCLES is retained only for compatibility with packaged instances.
-- It does not insert a halt delay, matching the supplied simplified wrapper.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity npu_axil_wrapper is
    generic (QUIESCE_CYCLES : positive := WRITEBACK_LATENCY + 2);
    port (
        clk, aresetn : in std_logic;
        boot_mode : in std_logic := '0';
        raw_mem_ready : out std_logic;
        s_axi_awaddr : in std_logic_vector(23 downto 0);
        s_axi_awprot : in std_logic_vector(2 downto 0) := "000";
        s_axi_awvalid : in std_logic;
        s_axi_awready : out std_logic;
        s_axi_wdata : in std_logic_vector(31 downto 0);
        s_axi_wstrb : in std_logic_vector(3 downto 0);
        s_axi_wvalid : in std_logic;
        s_axi_wready : out std_logic;
        s_axi_bresp : out std_logic_vector(1 downto 0);
        s_axi_bvalid : out std_logic;
        s_axi_bready : in std_logic;
        s_axi_araddr : in std_logic_vector(23 downto 0);
        s_axi_arprot : in std_logic_vector(2 downto 0) := "000";
        s_axi_arvalid : in std_logic;
        s_axi_arready : out std_logic;
        s_axi_rdata : out std_logic_vector(31 downto 0);
        s_axi_rresp : out std_logic_vector(1 downto 0);
        s_axi_rvalid : out std_logic;
        s_axi_rready : in std_logic;
        raw_instr_we : in std_logic := '0';
        raw_instr_addr : in std_logic_vector(9 downto 0) := (others => '0');
        raw_instr_din : in std_logic_vector(35 downto 0) := (others => '0');
        raw_instr_dout : out std_logic_vector(35 downto 0);
        raw_weight_we : in std_logic := '0';
        raw_weight_addr : in std_logic_vector(12 downto 0) := (others => '0');
        raw_weight_din : in std_logic_vector(31 downto 0) := (others => '0');
        raw_weight_dout : out std_logic_vector(31 downto 0);
        raw_scratchpad_we : in std_logic := '0';
        raw_scratchpad_addr : in std_logic_vector(12 downto 0) := (others => '0');
        raw_scratchpad_din : in std_logic_vector(31 downto 0) := (others => '0');
        raw_scratchpad_dout : out std_logic_vector(31 downto 0);
        interrupt : out std_logic
    );
end entity;

architecture rtl of npu_axil_wrapper is
    subtype addr_t is std_logic_vector(23 downto 0);
    subtype word_t is std_logic_vector(31 downto 0);
    subtype instr_t is std_logic_vector(35 downto 0);
    constant RESP_OKAY   : std_logic_vector(1 downto 0) := "00";
    constant RESP_SLVERR : std_logic_vector(1 downto 0) := "10";

    type target_t is (CONTROL_REG, STATUS_REG, PC_REG, IRQ_REG,
                      INSTR_RAM, WEIGHT_RAM, SCRATCHPAD_RAM, UNMAPPED);
    type state_t is (IDLE, RAM_WAIT, RAM_CAPTURE, RAM_WRITE);
    signal state : state_t := IDLE;

    signal aw_pending, w_pending, ar_pending : std_logic := '0';
    signal write_outstanding, read_outstanding : std_logic := '0';
    signal aw_addr, ar_addr : addr_t := (others => '0');
    signal w_data : word_t := (others => '0');
    signal w_strb : std_logic_vector(3 downto 0) := (others => '0');
    signal take_write, take_read : std_logic;
    signal prefer_write : std_logic := '1';
    signal bvalid_reg, rvalid_reg : std_logic := '0';
    signal bresp_reg, rresp_reg : std_logic_vector(1 downto 0) := RESP_OKAY;
    signal rdata_reg : word_t := (others => '0');

    signal boot_active : std_logic := '0';
    signal run_req, reset_pulse, irq_clear : std_logic := '0';
    signal core_run, core_rst_n, fetch_halted, irq : std_logic;
    signal pc : std_logic_vector(9 downto 0);
    signal irq_addr : std_logic_vector(11 downto 0);

    signal mem_target : target_t := INSTR_RAM;
    signal mem_addr : addr_t := (others => '0');
    signal mem_write : std_logic := '0';
    signal mem_wdata : word_t := (others => '0');
    signal mem_wstrb : std_logic_vector(3 downto 0) := (others => '0');
    signal merged : instr_t := (others => '0');
    signal i_we, w_we, s_we : std_logic;
    signal i_addr : std_logic_vector(9 downto 0);
    signal w_addr, s_addr : std_logic_vector(12 downto 0);
    signal i_din, i_dout : instr_t;
    signal w_din, w_dout, s_din, s_dout : word_t;

    function decode_target(a : addr_t) return target_t is
        variable n : natural := to_integer(unsigned(a));
    begin
        case n is
            when 16#000000# => return CONTROL_REG;
            when 16#000004# => return STATUS_REG;
            when 16#000008# => return PC_REG;
            when 16#00000C# => return IRQ_REG;
            when 16#100000# to 16#101FFF# => return INSTR_RAM;
            when 16#200000# to 16#207FFF# => return WEIGHT_RAM;
            when 16#300000# to 16#307FFF# => return SCRATCHPAD_RAM;
            when others => return UNMAPPED;
        end case;
    end function;

    function merge_write(old_value : instr_t; data : word_t;
                         strb : std_logic_vector(3 downto 0);
                         high_nibble : boolean) return instr_t is
        variable v : instr_t := old_value;
    begin
        if high_nibble then
            if strb(0) = '1' then
                v(35 downto 32) := data(3 downto 0);
            end if;
        else
            for b in 0 to 3 loop
                if strb(b) = '1' then
                    v(8*b+7 downto 8*b) := data(8*b+7 downto 8*b);
                end if;
            end loop;
        end if;
        return v;
    end function;
begin
    -- Protection attributes are accepted but do not restrict this peripheral.
    s_axi_awready <= aresetn and not aw_pending and not write_outstanding;
    s_axi_wready  <= aresetn and not w_pending and not write_outstanding;
    s_axi_arready <= aresetn and not ar_pending and not read_outstanding;
    s_axi_bvalid <= bvalid_reg;
    s_axi_bresp  <= bresp_reg;
    s_axi_rvalid <= rvalid_reg;
    s_axi_rresp  <= rresp_reg;
    s_axi_rdata  <= rdata_reg;

    raw_mem_ready <= aresetn and boot_active and boot_mode;
    core_rst_n <= aresetn and not reset_pulse;
    core_run <= run_req and not boot_mode and not boot_active;
    interrupt <= irq;

    -- Ownership changes only when the RAM engine is idle. A pending AXI
    -- response does not retain the RAM ports after the actual access finishes.
    i_addr <= raw_instr_addr when boot_active = '1' else mem_addr(12 downto 3);
    w_addr <= raw_weight_addr when boot_active = '1' else mem_addr(14 downto 2);
    s_addr <= raw_scratchpad_addr when boot_active = '1' else mem_addr(14 downto 2);
    i_din <= raw_instr_din when boot_active = '1' else merged;
    w_din <= raw_weight_din when boot_active = '1' else merged(31 downto 0);
    s_din <= raw_scratchpad_din when boot_active = '1' else merged(31 downto 0);

    i_we <= '1' when aresetn = '1' and
                ((boot_active = '1' and boot_mode = '1' and raw_instr_we = '1') or
                 (boot_active = '0' and state = RAM_WRITE and mem_target = INSTR_RAM))
            else '0';
    w_we <= '1' when aresetn = '1' and
                ((boot_active = '1' and boot_mode = '1' and raw_weight_we = '1') or
                 (boot_active = '0' and state = RAM_WRITE and mem_target = WEIGHT_RAM))
            else '0';
    s_we <= '1' when aresetn = '1' and
                ((boot_active = '1' and boot_mode = '1' and raw_scratchpad_we = '1') or
                 (boot_active = '0' and state = RAM_WRITE and mem_target = SCRATCHPAD_RAM))
            else '0';

    raw_instr_dout <= i_dout;
    raw_weight_dout <= w_dout;
    raw_scratchpad_dout <= s_dout;

    core: entity work.NPU port map (
        clk => clk, rst_n => core_rst_n, run => core_run,
        halted => fetch_halted, pc_debug => pc,
        instr_we => i_we, instr_addr => i_addr, instr_din => i_din, instr_dout => i_dout,
        weight_we => w_we, weight_addr_a => w_addr, weight_din => w_din, weight_dout => w_dout,
        scratchpad_we => s_we, scratchpad_addr_a => s_addr,
        scratchpad_din => s_din, scratchpad_dout => s_dout,
        clear_int => irq_clear, interrupt => irq, int_addr => irq_addr
    );

    -- Round-robin selection of complete requests. A blocked B response does
    -- not block reads, and a blocked R response does not block writes.
    arbitrate: process(all)
        variable write_ready, read_ready : boolean;
    begin
        take_write <= '0';
        take_read <= '0';
        write_ready := aw_pending = '1' and w_pending = '1' and bvalid_reg = '0';
        read_ready := ar_pending = '1' and rvalid_reg = '0';
        if aresetn = '1' and state = IDLE then
            if write_ready and (not read_ready or prefer_write = '1') then
                take_write <= '1';
            elsif read_ready then
                take_read <= '1';
            end if;
        end if;
    end process;

    -- Independent one-entry request buffers. Nothing is consumed until
    -- VALID/READY handshakes, and both write halves are paired at dispatch.
    requests: process(clk)
    begin
        if rising_edge(clk) then
            if aresetn = '0' then
                aw_pending <= '0'; w_pending <= '0'; ar_pending <= '0';
                write_outstanding <= '0'; read_outstanding <= '0';
                aw_addr <= (others => '0'); ar_addr <= (others => '0');
                w_data <= (others => '0'); w_strb <= (others => '0');
            else
                if s_axi_awvalid = '1' and s_axi_awready = '1' then
                    aw_addr <= s_axi_awaddr; aw_pending <= '1';
                end if;
                if s_axi_wvalid = '1' and s_axi_wready = '1' then
                    w_data <= s_axi_wdata; w_strb <= s_axi_wstrb; w_pending <= '1';
                end if;
                if s_axi_arvalid = '1' and s_axi_arready = '1' then
                    ar_addr <= s_axi_araddr; ar_pending <= '1';
                end if;
                if bvalid_reg = '1' and s_axi_bready = '1' then
                    write_outstanding <= '0';
                end if;
                if rvalid_reg = '1' and s_axi_rready = '1' then
                    read_outstanding <= '0';
                end if;
                if take_write = '1' then
                    aw_pending <= '0'; w_pending <= '0';
                    write_outstanding <= '1';
                end if;
                if take_read = '1' then
                    ar_pending <= '0'; read_outstanding <= '1';
                end if;
            end if;
        end if;
    end process;

    execute: process(clk)
        variable a : addr_t;
        variable t : target_t;
        variable r : word_t;
        variable v : instr_t;
        variable writing, bad, ram_access, no_effect : boolean;
    begin
        if rising_edge(clk) then
            if aresetn = '0' then
                state <= IDLE; prefer_write <= '1'; boot_active <= '0';
                bvalid_reg <= '0'; rvalid_reg <= '0';
                bresp_reg <= RESP_OKAY; rresp_reg <= RESP_OKAY;
                rdata_reg <= (others => '0');
                run_req <= '0'; reset_pulse <= '0'; irq_clear <= '0';
                mem_target <= INSTR_RAM; mem_addr <= (others => '0');
                mem_write <= '0'; mem_wdata <= (others => '0');
                mem_wstrb <= (others => '0'); merged <= (others => '0');
            else
                reset_pulse <= '0'; irq_clear <= '0';
                if bvalid_reg = '1' and s_axi_bready = '1' then
                    bvalid_reg <= '0';
                end if;
                if rvalid_reg = '1' and s_axi_rready = '1' then
                    rvalid_reg <= '0';
                end if;
                if state = IDLE then
                    boot_active <= boot_mode;
                end if;

                case state is
                    when IDLE =>
                        if take_write = '1' or take_read = '1' then
                            writing := take_write = '1';
                            if writing then
                                a := aw_addr; prefer_write <= '0';
                            else
                                a := ar_addr; prefer_write <= '1';
                            end if;
                            t := decode_target(a);
                            r := (others => '0');
                            bad := false; ram_access := false;
                            if a(1 downto 0) /= "00" then
                                bad := true;
                            else
                                case t is
                                    when CONTROL_REG =>
                                        r(0) := run_req;
                                        if writing and w_strb(0) = '1' then
                                            if boot_mode = '1' or boot_active = '1' then
                                                bad := true;
                                            else
                                                -- RESET wins if RUN and RESET are both set.
                                                if w_data(1) = '1' then
                                                    reset_pulse <= '1'; run_req <= '0';
                                                else
                                                    run_req <= w_data(0);
                                                end if;
                                                irq_clear <= w_data(3);
                                            end if;
                                        end if;
                                    when STATUS_REG =>
                                        r(0) := fetch_halted; r(1) := run_req;
                                        r(2) := not (boot_active or boot_mode);
                                        r(3) := reset_pulse; r(4) := irq;
                                        r(5) := boot_active xor boot_mode;
                                        bad := writing;
                                    when PC_REG =>
                                        r(9 downto 0) := pc; bad := writing;
                                    when IRQ_REG =>
                                        r(11 downto 0) := irq_addr; bad := writing;
                                    when INSTR_RAM | WEIGHT_RAM | SCRATCHPAD_RAM =>
                                        if boot_mode = '1' or boot_active = '1' then
                                            bad := true;
                                        else
                                            no_effect := writing and (w_strb = "0000" or
                                                (t = INSTR_RAM and a(2) = '1' and w_strb(0) = '0'));
                                            if not no_effect then
                                                ram_access := true;
                                                mem_target <= t; mem_addr <= a;
                                                mem_write <= take_write;
                                                mem_wdata <= w_data; mem_wstrb <= w_strb;
                                                state <= RAM_WAIT;
                                            end if;
                                        end if;
                                    when UNMAPPED => bad := true;
                                end case;
                            end if;

                            if not ram_access then
                                if writing then
                                    bvalid_reg <= '1';
                                    if bad then bresp_reg <= RESP_SLVERR;
                                    else bresp_reg <= RESP_OKAY; end if;
                                else
                                    rvalid_reg <= '1';
                                    if bad then
                                        rdata_reg <= (others => '0'); rresp_reg <= RESP_SLVERR;
                                    else
                                        rdata_reg <= r; rresp_reg <= RESP_OKAY;
                                    end if;
                                end if;
                            end if;
                        end if;
                    when RAM_WAIT =>
                        -- mem_addr was registered at dispatch. The RAM samples
                        -- it at this edge; its registered output is read next.
                        state <= RAM_CAPTURE;
                    when RAM_CAPTURE =>
                        v := (others => '0'); r := (others => '0');
                        case mem_target is
                            when INSTR_RAM =>
                                v := i_dout;
                                if mem_addr(2) = '0' then r := i_dout(31 downto 0);
                                else r(3 downto 0) := i_dout(35 downto 32); end if;
                            when WEIGHT_RAM => v(31 downto 0) := w_dout; r := w_dout;
                            when others => v(31 downto 0) := s_dout; r := s_dout;
                        end case;
                        if mem_write = '1' then
                            merged <= merge_write(v, mem_wdata, mem_wstrb,
                                                  mem_target = INSTR_RAM and mem_addr(2) = '1');
                            state <= RAM_WRITE;
                        else
                            rdata_reg <= r; rresp_reg <= RESP_OKAY; rvalid_reg <= '1';
                            state <= IDLE;
                        end if;
                    when RAM_WRITE =>
                        -- RAM WE is asserted throughout this state. The write
                        -- commits at this edge, before the response is issued.
                        bvalid_reg <= '1'; bresp_reg <= RESP_OKAY;
                        state <= IDLE;
                end case;

                -- Boot mode always cancels RUN. Leaving boot mode requires an
                -- explicit subsequent START command; it never auto-restarts.
                if boot_mode = '1' or boot_active = '1' then
                    run_req <= '0';
                end if;
            end if;
        end if;
    end process;
end architecture;
