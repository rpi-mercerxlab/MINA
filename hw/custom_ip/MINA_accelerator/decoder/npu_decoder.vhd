library ieee;
use ieee.std_logic_1164.all;

entity npu_decoder is
    port (
        instr       : in  std_logic_vector(35 downto 0);
        instr_valid : in  std_logic;
        pe_drive_done : in  std_logic;
        pe_drain_done : in  std_logic;
        add_i_done : in  std_logic;
        beq_done : in  std_logic;
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
        jump_addr : out std_logic_vector(9 downto 0);
        activation_function : out std_logic_vector(1 downto 0);
        quant_mult : out std_logic_vector(9 downto 0);
        shift_amt : out std_logic_vector(3 downto 0);
        add_i_rt : out std_logic_vector(3 downto 0);
        add_i_rs : out std_logic_vector(3 downto 0);
        add_i_imm : out std_logic_vector(15 downto 0);
        add_i_en : out std_logic;
        beq_rt : out std_logic_vector(3 downto 0);
        beq_rs : out std_logic_vector(3 downto 0);
        beq_en : out std_logic
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
        activation_function <= "00";
        quant_mult <= "0000000000";
        shift_amt <= "0000";
        add_i_rt <= "0000";
        add_i_rs <= "0000";
        add_i_imm <= "0000000000000000";
        add_i_en <= '0';
        beq_rt <= "0000";
        beq_rs <= "0000";
        beq_en <= '0';

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
                    pe_reset <= '1';
                when x"02" =>
                    instr_done <= pe_drain_done;
                    pe_drain <= '1';
                    pe_drain_addr <= instr(27 downto 16);
                    activation_function <= instr(15 downto 14);
                    quant_mult <= instr(9 downto 0);
                    shift_amt <= instr(13 downto 10);
                when x"03" =>
                    trigger_interrupt <= '1';
                when x"04" =>
                    vo_int_addr <= '1';
                    int_targ_addr <= instr(27 downto 16);
                when x"05" =>
                    jump_addr_vo <= '1';
                    jump_addr <= instr(27 downto 18);
                when x"06" =>
                    instr_done <= add_i_done;
                    add_i_rt <= instr(27 downto 25);
                    add_i_rs <= instr(24 downto 22);
                    add_i_imm <= instr(21 downto 6);
                    add_i_en <= '1';
                when x"07" =>
                    instr_done <= beq_done;
                    beq_rt <= instr(27 downto 25);
                    beq_rs <= instr(24 downto 22);
                    beq_en <= '1';
                when x"08" =>
                    null;
                when x"09" =>
                    null;
                when x"0A" =>
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
