library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_fetcher is
    port (
        clk           : in  std_logic;
        reset_n       : in  std_logic;

        -- Handshake & Jump signals with npu_decoder
        instr_done    : in  std_logic;
        jump_addr_vo  : in  std_logic;
        jump_addr     : in  std_logic_vector(9 downto 0);
        instr_o       : out std_logic_vector(35 downto 0);
        instr_valid_o : out std_logic;

        -- BRAM interface (1-cycle synchronous read latency)
        bram_en       : out std_logic;
        d_in          : in  std_logic_vector(35 downto 0);
        addr_o        : out std_logic_vector(9 downto 0)
    );
end entity instr_fetcher;

architecture rtl of instr_fetcher is

    type state_t is (S_FETCH, S_EXEC);
    signal state       : state_t := S_FETCH;
    signal PC_register : unsigned(9 downto 0) := (others => '0');

begin

    -- Wire PC and BRAM data straight through combinationally
    addr_o  <= std_logic_vector(PC_register);
    bram_en <= '1';
    instr_o <= d_in;

    -- Decoder only sees valid instruction during S_EXEC (after BRAM read completes)
    instr_valid_o <= '1' when state = S_EXEC else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if reset_n = '0' then
                PC_register <= (others => '0');
                state       <= S_FETCH;
            else
                case state is
                    when S_FETCH =>
                        -- Wait 1 clock cycle for synchronous BRAM to output data for PC_register
                        state <= S_EXEC;

                    when S_EXEC =>
                        -- Hold PC steady until the decoder reports the instruction is done
                        if instr_done = '1' then
                            if jump_addr_vo = '1' then
                                PC_register <= unsigned(jump_addr);
                            else
                                PC_register <= PC_register + 1;
                            end if;
                            -- New address is now on addr_o; wait 1 cycle for BRAM fetch
                            state <= S_FETCH;
                        end if;
                end case;
            end if;
        end if;
    end process;

end architecture rtl;
