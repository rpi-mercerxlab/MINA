library ieee;
use ieee.std_logic_1164.all;

entity npu_decoder is
    port (
        instr       : in  std_logic_vector(51 downto 0);
        instr_valid : in  std_logic;
        pe_drive_done : in  std_logic;
        instr_done  : out std_logic;
        pe_reset : out std_logic;
        pe_run : out std_logic;
        pe_data_source : out std_logic_vector(1 downto 0);
        pe_data_addr : out std_logic_vector(11 downto 0);
        pe_weight_addr : out std_logic_vector(11 downto 0);
        pe_drain_addr : out std_logic_vector(11 downto 0)
    );
end entity npu_decoder;

architecture rtl of npu_decoder is
begin
    process(all)
    begin
        -- Safe Inactive Defaults (when instr_valid = '0', nothing triggers and PC waits)
        instr_done <= '0';
        pe_reset <= '0';
        pe_run <= '0';
        pe_data_source <= "00";
        pe_data_addr <= "000000000000";
        pe_weight_addr <= "000000000000";
        pe_drain_addr <= "000000000000";

        if instr_valid = '1' then
            -- Active Default: Single-cycle instructions complete immediately unless overridden
            instr_done <= '1';

            -- Instruction Decode Switch Tree
            case instr(51 downto 44) is
                when x"00" =>
                    instr_done <= pe_drive_done;
                    pe_run <= '1';
                    pe_data_source <= instr(43 downto 42);
                    pe_data_addr <= instr(41 downto 30);
                    pe_weight_addr <= instr(29 downto 18);
                when x"01" =>
                    pe_reset <= '0';
                when x"02" =>
                    pe_drain_addr <= instr(43 downto 32);
                when x"03" =>
                    null;
                when x"04" =>
                    null;
                when x"05" =>
                    case instr(43 downto 40) is
                        when others =>
                            null;
                    end case;
                when others =>
                    null;
            end case;
        end if;
    end process;
end architecture rtl;
