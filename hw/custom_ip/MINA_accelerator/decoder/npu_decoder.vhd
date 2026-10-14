library ieee;
use ieee.std_logic_1164.all;

entity npu_decoder is
    port (
        instr : in std_logic_vector(51 downto 0);
        PE_RESET : out std_logic
    );
end entity npu_decoder;

architecture rtl of npu_decoder is
begin
    process(all)
    begin
        -- Default Control & Datapath Assignments (Prevents Latches)
        PE_RESET <= 0;

        -- Instruction Decode Switch Tree
        case instr(51 downto 44) is
            when x"00" =>
                null;
            when x"01" =>
                null;
            when x"02" =>
                null;
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
    end process;
end architecture rtl;
