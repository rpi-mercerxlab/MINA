library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity PE_arr_driver is
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        pe_reset : in std_logic;
        pe_run : in std_logic;
        pe_drain : in std_logic;
             
        pe_data_source : in std_logic_vector(1 downto 0);
        pe_data_addr : in std_logic_vector(11 downto 0);
        pe_weight_addr : in std_logic_vector(11 downto 0);
                 
        pe_data_output : out std_logic_vector(63 downto 0);
        data_addr_out : out std_logic_vector(11 downto 0);
                 
        scratchpad_in : in std_logic_vector(63 downto 0);
        sensor_ram_in : in std_logic_vector(63 downto 0);
                 
        weight_data_in : in std_logic_vector(63 downto 0);
        weight_data_out : out std_logic_vector(63 downto 0);
        weight_addr_out : out std_logic_vector(11 downto 0);
                 
        pe_clear_acc_out : out std_logic;
        pe_valid_out : out std_logic;
        skew_enable_out : out std_logic;
                 
        pe_drive_done : out std_logic;
        drain_addr_start : in std_logic_vector(11 downto 0);
        scratchpad_addr_out : out std_logic_vector(11 downto 0);
        scratchpad_we_out   : out std_logic;
        pe_drain_en : out std_logic;
        pe_drain_done : out std_logic
    );
end entity;

architecture rtl of PE_arr_driver is
    type t_state is (IDLE, PRIME, RUNNING, FLUSHING, COMPLETE, DRAIN, DRAIN_DONE);
    signal state : t_state := IDLE;
    signal source_sel : std_logic_vector(1 downto 0) := "00";
         
    signal data_addr_reg : unsigned(11 downto 0) := (others => '0');
    signal weight_addr_reg : unsigned(11 downto 0) := (others => '0');
         
    signal vector_index : natural range 0 to 31 := 0;
         
    constant FLUSH_CYCLES : positive := 2*(NUM_ROWS-1) + 2*(NUM_COLS-1) + 4;
    signal flush_count : natural range 0 to FLUSH_CYCLES-1 := 0;
    signal drain_addr_reg : unsigned(11 downto 0) := (others => '0');
    
    -- Delay pipeline for post-processing write-back sync (5 cycles)
    type delay_pipe_we_t is array (0 to 4) of std_logic;
    signal we_pipe : delay_pipe_we_t := (others => '0');
    type delay_pipe_addr_t is array (0 to 4) of std_logic_vector(11 downto 0);
    signal drain_addr_pipe : delay_pipe_addr_t := (others => (others => '0'));
         
    signal internal_drain_en : std_logic;
begin
    data_addr_out <= std_logic_vector(data_addr_reg);
    weight_addr_out <= std_logic_vector(weight_addr_reg);
    
    pe_data_output <= scratchpad_in when state = RUNNING and source_sel = "00" else
                      sensor_ram_in when state = RUNNING and source_sel = "01" else
                      (others => '0');
                      
    weight_data_out <= weight_data_in when state = RUNNING else (others => '0');
    
    -- Global PE valid must remain high while operands propagate internally.
    pe_valid_out <= '1' when state = RUNNING or state = FLUSHING else '0';
    
    -- Shift zeros through skew even while idle, preventing stale operands.
    skew_enable_out <= rst_n;
    pe_drive_done <= '1' when state = COMPLETE else '0';
    
    -- Only clear between operations.
    pe_clear_acc_out <= '1' when state = IDLE and pe_reset = '1' else '0';
    pe_drain_done <= '1' when state = DRAIN_DONE else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                state <= IDLE;
                source_sel <= "00";
                data_addr_reg <= (others => '0');
                weight_addr_reg <= (others => '0');
                vector_index <= 0;
                flush_count <= 0;
                drain_addr_reg <= (others => '0');
            else
                case state is
                    when IDLE =>
                        if pe_run = '1' and pe_reset = '0' then
                            source_sel <= pe_data_source;
                            data_addr_reg <= unsigned(pe_data_addr);
                            weight_addr_reg <= unsigned(pe_weight_addr);
                            vector_index <= 0;
                            state <= PRIME;
                        elsif pe_drain = '1' then
                            drain_addr_reg <= unsigned(drain_addr_start) + 7;
                            vector_index <= 0;
                            state <= DRAIN;
                        end if;
                        
                    when PRIME =>
                        data_addr_reg <= data_addr_reg + 1;
                        weight_addr_reg <= weight_addr_reg + 1;
                        state <= RUNNING;
                        
                    when RUNNING =>
                        if vector_index = 7 then
                            flush_count <= 0;
                            state <= FLUSHING;
                        else
                            vector_index <= vector_index + 1;
                            if vector_index < 6 then
                                data_addr_reg <= data_addr_reg + 1;
                                weight_addr_reg <= weight_addr_reg + 1;
                            end if;
                        end if;
                        
                    when FLUSHING =>
                        if flush_count = FLUSH_CYCLES-1 then
                            state <= COMPLETE;
                        else
                            flush_count <= flush_count + 1;
                        end if;
                        
                    when COMPLETE =>
                        if pe_run = '0' then
                            state <= IDLE;
                        end if;
                        
                    when DRAIN =>
                        -- Extend to 20 cycles to allow the 5-stage we_pipe to fully complete writing
                        if vector_index = 20 then
                            state <= DRAIN_DONE;
                        else
                            vector_index <= vector_index + 1;
                            if vector_index < 15 and (vector_index mod 2) = 1 then
                                drain_addr_reg <= drain_addr_reg - 1;
                            end if;
                        end if;
                        
                    when DRAIN_DONE =>
                        if pe_drain = '0' then
                            state <= IDLE;
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Generate base drain pulse only during the 8 active row shifts
    internal_drain_en <= '1' when (state = DRAIN and vector_index < 16 and (vector_index mod 2 = 0)) else '0';
    pe_drain_en <= internal_drain_en;

    -- 5-Cycle Delay Pipeline Process for Post-Processing / Writeback Synchronization
    process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                we_pipe <= (others => '0');
                drain_addr_pipe <= (others => (others => '0'));
            else
                we_pipe(0) <= internal_drain_en;
                we_pipe(1 to 4) <= we_pipe(0 to 3);
                 
                drain_addr_pipe(0) <= std_logic_vector(drain_addr_reg);
                drain_addr_pipe(1 to 4) <= drain_addr_pipe(0 to 3);
            end if;
        end if;
    end process;

    -- Dedicated Scratchpad Memory Controller Output
    scratchpad_we_out <= we_pipe(4);
         
    -- Mux: If writing back (delayed), use delayed drain addr. Otherwise use active read addr.
    scratchpad_addr_out <= drain_addr_pipe(4) when we_pipe(4) = '1' else std_logic_vector(data_addr_reg);

end architecture;
