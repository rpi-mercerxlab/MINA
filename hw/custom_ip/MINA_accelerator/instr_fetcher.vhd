library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_fetcher is
    port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;
        run           : in  std_logic := '1';
        halted        : out std_logic;
        pc_debug      : out std_logic_vector(9 downto 0);

        -- Handshake and jump signals with npu_decoder.
        instr_done    : in  std_logic;
        jump_addr_vo  : in  std_logic;
        jump_addr     : in  std_logic_vector(9 downto 0);
        instr_o       : out std_logic_vector(35 downto 0);
        instr_valid_o : out std_logic;

        -- BRAM interface: one-cycle synchronous read latency.
        bram_en       : out std_logic;
        d_in          : in  std_logic_vector(35 downto 0);
        addr_o        : out std_logic_vector(9 downto 0)
    );
end entity instr_fetcher;

architecture rtl of instr_fetcher is
    type state_t is (S_FETCH, S_CAPTURE, S_EXEC);
    signal state       : state_t := S_FETCH;
    signal PC_register : unsigned(9 downto 0) := (others => '0');
    signal instr_reg   : std_logic_vector(35 downto 0) := (others => '0');
begin
    addr_o   <= std_logic_vector(PC_register);
    pc_debug <= std_logic_vector(PC_register);
    bram_en  <= reset_n;

    -- The decoder is driven by the instruction register, not directly by d_in.
    instr_o <= instr_reg;
    instr_valid_o <= '1' when state = S_EXEC and reset_n = '1' else '0';

    -- RUN can stop the fetch sequence. An executing instruction completes
    -- before HALTED asserts, and PC then points to the next instruction.
    halted <= '1' when state = S_FETCH and run = '0' else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if reset_n = '0' then
                PC_register <= (others => '0');
                instr_reg   <= (others => '0');
                state       <= S_FETCH;
            else
                case state is
                    when S_FETCH =>
                        -- PC is stable before this edge. BRAM samples it
                        -- here and updates d_in after the edge. Capture
                        -- that result at the following edge, not this one.
                        if run = '1' then
                            state <= S_CAPTURE;
                        end if;

                    when S_CAPTURE =>
                        if run = '1' then
                            instr_reg <= d_in;
                            state     <= S_EXEC;
                        else
                            -- Halt before starting another instruction.
                            -- Resuming goes through a fresh BRAM read.
                            state <= S_FETCH;
                        end if;

                    when S_EXEC =>
                        -- Hold instr_reg and PC until execution completes.
                        if instr_done = '1' then
                            if jump_addr_vo = '1' then
                                PC_register <= unsigned(jump_addr);
                            else
                                PC_register <= PC_register + 1;
                            end if;
                            state <= S_FETCH;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture rtl;
