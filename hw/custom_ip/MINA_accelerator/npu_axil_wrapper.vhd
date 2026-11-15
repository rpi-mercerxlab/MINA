-- VHDL-2008. One clock domain. 32-bit AXI-Lite, 24-bit BYTE addresses.
-- RAM implementations and their existing word-addressed host ports are unchanged.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity npu_axil_wrapper is
    generic (QUIESCE_CYCLES : positive := WRITEBACK_LATENCY + 2);
    port (
        clk, aresetn : in std_logic;
        -- System mode input, synchronous to clk. 1 requests AXI-Lite RAM access
        -- and a graceful stop; 0 requests raw ownership. Poll STATUS for grant.
        axil_mem : in std_logic := '1';
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
        -- Original host interfaces, selected when STATUS.AXIL_MEM = 0.
        -- Raw addresses are WORD addresses, exactly as on the original NPU.
        raw_instr_we : in std_logic := '0';
        raw_instr_addr : in std_logic_vector(9 downto 0) := (others => '0');
        raw_instr_din : in std_logic_vector(35 downto 0) := (others => '0');
        raw_instr_dout : out std_logic_vector(35 downto 0);
        raw_weight_we : in std_logic := '0';
        raw_weight_addr : in std_logic_vector(HOST_ADDR_WIDTH-1 downto 0) := (others => '0');
        raw_weight_din : in std_logic_vector(31 downto 0) := (others => '0');
        raw_weight_dout : out std_logic_vector(31 downto 0);
        raw_scratchpad_we : in std_logic := '0';
        raw_scratchpad_addr : in std_logic_vector(HOST_ADDR_WIDTH-1 downto 0) := (others => '0');
        raw_scratchpad_din : in std_logic_vector(31 downto 0) := (others => '0');
        raw_scratchpad_dout : out std_logic_vector(31 downto 0);
        interrupt : out std_logic
    );
end entity;

architecture rtl of npu_axil_wrapper is
    type state_t is (IDLE, MEM_WAIT, MEM_CAPTURE, MEM_WRITE);
    signal state : state_t := IDLE;
    signal aw_full, w_full, ar_full : std_logic := '0';
    signal aw_addr, ar_addr : std_logic_vector(23 downto 0);
    signal w_data : std_logic_vector(31 downto 0);
    signal w_strb : std_logic_vector(3 downto 0);
    signal bv, rv : std_logic := '0';
    signal bp, rp : std_logic_vector(1 downto 0) := "00";
    signal rd : std_logic_vector(31 downto 0) := (others => '0');
    signal run_req : std_logic := '0';
    signal mem_owned : std_logic := '1';
    signal reset_pulse, irq_clear : std_logic := '0';
    signal core_rst_n, fetch_halted, safe_halted, irq : std_logic;
    signal pc : std_logic_vector(9 downto 0);
    signal irq_addr : std_logic_vector(11 downto 0);
    signal quiet_count : natural range 0 to QUIESCE_CYCLES := 0;
    signal mem_sel : natural range 1 to 3 := 1;
    signal mem_addr : std_logic_vector(23 downto 0) := (others => '0');
    signal mem_is_write : std_logic := '0';
    signal merged : std_logic_vector(35 downto 0) := (others => '0');
    signal i_we, w_we, s_we : std_logic;
    signal i_addr : std_logic_vector(9 downto 0);
    signal w_addr, s_addr : std_logic_vector(HOST_ADDR_WIDTH-1 downto 0);
    signal i_din, i_dout : std_logic_vector(35 downto 0);
    signal w_din, w_dout, s_din, s_dout : std_logic_vector(31 downto 0);

    function target(a : std_logic_vector(23 downto 0)) return natural is
        variable n : natural := to_integer(unsigned(a));
    begin
        if n >= 16#100000# and n < 16#102000# then return 1;
        elsif n >= 16#200000# and n < 16#200000# + 4*2**HOST_ADDR_WIDTH then return 2;
        elsif n >= 16#300000# and n < 16#300000# + 4*2**HOST_ADDR_WIDTH then return 3;
        else return 0;
        end if;
    end;
begin
    assert HOST_ADDR_WIDTH <= 18 report "RAM host address too wide for 1 MiB window" severity failure;
    core_rst_n <= aresetn and not reset_pulse;
    safe_halted <= '1' when quiet_count = QUIESCE_CYCLES and
        fetch_halted = '1' and reset_pulse = '0' and aresetn = '1' else '0';
    interrupt <= irq;
    s_axi_awready <= not aw_full and aresetn;
    s_axi_wready <= not w_full and aresetn;
    s_axi_arready <= not ar_full and aresetn;
    s_axi_bvalid <= bv; s_axi_bresp <= bp;
    s_axi_rvalid <= rv; s_axi_rresp <= rp; s_axi_rdata <= rd;

    -- Same paradigm as muxed_ram: mux address/data/write-enable, share read data.
    i_addr <= mem_addr(12 downto 3) when mem_owned = '1' else raw_instr_addr;
    w_addr <= mem_addr(HOST_ADDR_WIDTH+1 downto 2) when mem_owned = '1' else raw_weight_addr;
    s_addr <= mem_addr(HOST_ADDR_WIDTH+1 downto 2) when mem_owned = '1' else raw_scratchpad_addr;
    i_din <= merged when mem_owned = '1' else raw_instr_din;
    w_din <= merged(31 downto 0) when mem_owned = '1' else raw_weight_din;
    s_din <= merged(31 downto 0) when mem_owned = '1' else raw_scratchpad_din;
    i_we <= '1' when safe_halted = '1' and
        ((mem_owned = '1' and state = MEM_WRITE and mem_sel = 1) or
         (mem_owned = '0' and axil_mem = '0' and raw_instr_we = '1')) else '0';
    w_we <= '1' when safe_halted = '1' and
        ((mem_owned = '1' and state = MEM_WRITE and mem_sel = 2) or
         (mem_owned = '0' and axil_mem = '0' and raw_weight_we = '1')) else '0';
    s_we <= '1' when safe_halted = '1' and
        ((mem_owned = '1' and state = MEM_WRITE and mem_sel = 3) or
         (mem_owned = '0' and axil_mem = '0' and raw_scratchpad_we = '1')) else '0';
    raw_instr_dout <= i_dout;
    raw_weight_dout <= w_dout;
    raw_scratchpad_dout <= s_dout;

    core: entity work.NPU port map (
        clk => clk, rst_n => core_rst_n, run => run_req,
        halted => fetch_halted, pc_debug => pc,
        instr_we => i_we, instr_addr => i_addr, instr_din => i_din, instr_dout => i_dout,
        weight_we => w_we, weight_addr_a => w_addr, weight_din => w_din, weight_dout => w_dout,
        scratchpad_we => s_we, scratchpad_addr_a => s_addr,
        scratchpad_din => s_din, scratchpad_dout => s_dout,
        clear_int => irq_clear, interrupt => irq, int_addr => irq_addr
    );

    process(clk)
        variable a : std_logic_vector(23 downto 0);
        variable t : natural;
        variable v : std_logic_vector(35 downto 0);
        variable r : std_logic_vector(31 downto 0);
        variable writing, bad : boolean;
    begin
        if rising_edge(clk) then
            if aresetn = '0' then
                state <= IDLE;
                aw_full <= '0'; w_full <= '0'; ar_full <= '0';
                bv <= '0'; rv <= '0'; bp <= "00"; rp <= "00"; rd <= (others => '0');
                run_req <= '0'; mem_owned <= axil_mem;
                reset_pulse <= '0'; irq_clear <= '0';
                quiet_count <= 0;
            else
                reset_pulse <= '0'; irq_clear <= '0';
                -- Keep ownership stable across the entire bridge transaction.
                if safe_halted = '1' and state = IDLE and bv = '0' and rv = '0' then
                    mem_owned <= axil_mem;
                end if;
                if fetch_halted = '0' or run_req = '1' or reset_pulse = '1' then
                    quiet_count <= 0;
                elsif quiet_count < QUIESCE_CYCLES then
                    quiet_count <= quiet_count + 1;
                end if;
                if bv = '1' and s_axi_bready = '1' then bv <= '0'; end if;
                if rv = '1' and s_axi_rready = '1' then rv <= '0'; end if;
                if s_axi_awvalid = '1' and aw_full = '0' then
                    aw_addr <= s_axi_awaddr; aw_full <= '1';
                end if;
                if s_axi_wvalid = '1' and w_full = '0' then
                    w_data <= s_axi_wdata; w_strb <= s_axi_wstrb; w_full <= '1';
                end if;
                if s_axi_arvalid = '1' and ar_full = '0' then
                    ar_addr <= s_axi_araddr; ar_full <= '1';
                end if;
                case state is
                    when IDLE =>
                        if bv = '0' and rv = '0' and
                            ((aw_full = '1' and w_full = '1') or ar_full = '1') then
                            writing := aw_full = '1' and w_full = '1';
                            if writing then
                                a := aw_addr; aw_full <= '0';
                                -- W buffer held throughout RMW; released at completion.
                            else a := ar_addr; ar_full <= '0'; end if;
                            t := target(a); r := (others => '0'); bad := false;
                            if a(1 downto 0) /= "00" then bad := true;
                            elsif t /= 0 then
                                if mem_owned = '0' or axil_mem = '0' or safe_halted = '0' then bad := true;
                                else
                                    mem_addr <= a; mem_sel <= t;
                                    if writing then mem_is_write <= '1'; else mem_is_write <= '0'; end if;
                                    state <= MEM_WAIT;
                                end if;
                            elsif a = x"000000" then
                                r(0) := run_req;
                                if writing and w_strb(0) = '1' then
                                    -- Mode is a pin, not a writable CSR bit.
                                    if w_data(0) = '1' and (mem_owned = '1' or axil_mem = '1' or
                                        reset_pulse = '1' or w_data(1) = '1') then
                                        bad := true;
                                    else
                                        run_req <= w_data(0);
                                        if w_data(1) = '1' then
                                            -- Software reset aborts execution; no instr_done wait.
                                            -- AXI-Lite logic and all RAM contents remain intact.
                                            reset_pulse <= '1'; run_req <= '0'; quiet_count <= 0;
                                        end if;
                                        irq_clear <= w_data(3);
                                    end if;
                                end if;
                            elsif a = x"000004" then
                                r(0) := safe_halted; r(1) := run_req;
                                r(2) := mem_owned; r(3) := reset_pulse;
                                r(4) := irq; r(5) := mem_owned xor axil_mem;
                                if writing then bad := true; end if;
                            elsif a = x"000008" then
                                r(9 downto 0) := pc;
                                if writing then bad := true; end if;
                            elsif a = x"00000C" then
                                r(11 downto 0) := irq_addr;
                                if writing then bad := true; end if;
                            else bad := true;
                            end if;
                            if t = 0 or bad then
                                if writing then
                                    bv <= '1'; w_full <= '0';
                                    if bad then bp <= "10"; else bp <= "00"; end if;
                                else
                                    rv <= '1'; rd <= r;
                                    if bad then rp <= "10"; else rp <= "00"; end if;
                                end if;
                            end if;
                        end if;
                    when MEM_WAIT =>
                        state <= MEM_CAPTURE; -- synchronous RAM samples selected address
                    when MEM_CAPTURE =>
                        v := (others => '0'); r := (others => '0');
                        case mem_sel is
                            when 1 =>
                                v := i_dout;
                                if mem_addr(2) = '0' then r := i_dout(31 downto 0);
                                else r(3 downto 0) := i_dout(35 downto 32); end if;
                            when 2 => v(31 downto 0) := w_dout; r := w_dout;
                            when others => v(31 downto 0) := s_dout; r := s_dout;
                        end case;
                        if mem_is_write = '1' then
                            -- RMW implements byte strobes on existing full-word RAM ports.
                            if mem_sel = 1 and mem_addr(2) = '1' then
                                if w_strb(0) = '1' then v(35 downto 32) := w_data(3 downto 0); end if;
                            else
                                for b in 0 to 3 loop
                                    if w_strb(b) = '1' then v(8*b+7 downto 8*b) := w_data(8*b+7 downto 8*b); end if;
                                end loop;
                            end if;
                            merged <= v; state <= MEM_WRITE;
                        else
                            rd <= r; rp <= "00"; rv <= '1'; state <= IDLE;
                        end if;
                    when MEM_WRITE =>
                        -- RAM write occurs on this edge; only now acknowledge the write.
                        bv <= '1'; bp <= "00"; w_full <= '0'; state <= IDLE;
                end case;
                -- A memory-mode request stops instruction flow automatically.
                -- Returning the pin low does not automatically restart execution.
                if axil_mem = '1' then run_req <= '0'; end if;
            end if;
        end if;
    end process;
end architecture;
