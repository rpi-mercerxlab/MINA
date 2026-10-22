library ieee;
use ieee.std_logic_1164.all;

entity npu_decoder is
    port (
        instr       : in  std_logic_vector(35 downto 0);
        instr_valid : in  std_logic;
        pe_drive_done : in  std_logic;
        pe_drain_done : in  std_logic;
        instr_done  : out std_logic;
        pe_reset : out std_logic;
        pe_run : out std_logic;
        pe_drain : out std_logic;
        pe_data_source : out std_logic_vector(1 downto 0);
        pe_data_addr : out std_logic_vector(11 downto 0);
        pe_weight_addr : out std_logic_vector(11 downto 0);
        pe_drain_addr : out std_logic_vector(11 downto 0);
        trigger_interrupt : out std_logic;
        vo_int_addr : out std_logic;
        int_targ_addr : out std_logic_vector(11 downto 0);
        jump_addr_vo : out std_logic;
        jump_addr : out std_logic_vector(9 downto 0)
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
        pe_drain <= '0';
        pe_data_source <= "00";
        pe_data_addr <= "000000000000";
        pe_weight_addr <= "000000000000";
        pe_drain_addr <= "000000000000";
        trigger_interrupt <= '0';
        vo_int_addr <= '0';
        int_targ_addr <= "000000000000";
        jump_addr_vo <= '0';
        jump_addr <= "0000000000";

        if instr_valid = '1' then
            -- Active Default: Single-cycle instructions complete immediately unless overridden
            instr_done <= '1';

            -- Instruction Decode Switch Tree
            case instr(35 downto 28) is
                when x"00" =>
                    instr_done <= pe_drive_done;
                    pe_run <= '1';
                    pe_data_source <= instr(27 downto 26);
                    pe_data_addr <= instr(25 downto 14);
                    pe_weight_addr <= instr(13 downto 2);
                when x"01" =>
                    pe_reset <= '0';
                when x"02" =>
                    instr_done <= pe_drain_done;
                    pe_drain <= '1';
                    pe_drain_addr <= instr(27 downto 16);
                when x"03" =>
                    trigger_interrupt <= '1';
                when x"04" =>
                    vo_int_addr <= '1';
                    int_targ_addr <= instr(27 downto 16);
                when x"05" =>
                    jump_addr_vo <= '1';
                    jump_addr <= instr(27 downto 18);
                when x"06" =>
                    case instr(27 downto 24) is
                        when others =>
                            null;
                    end case;
                when others =>
                    null;
            end case;
        end if;
    end process;
end architecture rtl;
