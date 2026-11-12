library ieee;
use ieee.std_logic_1164.all;

entity r_file_n_exec is
    port (
        clk                 : in  std_logic;
        rst_n               : in  std_logic;

        add_i_rt : in std_logic_vector(2 downto 0);
        add_i_rs : in std_logic_vector(2 downto 0);
        add_i_imm : in std_logic_vector(15 downto 0);
        add_i_en : in std_logic;
        add_i_done : out std_logic
    );
end entity r_file_n_exec;

architecture rtl of r_file_n_exec is

    type reg_file is array (0 to 15) of std_logic_vector(15 downto 0);
    signal registers : reg_file;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                registers <= (others => (others => '0'));
            else

            end if;
        end if;
    end process;

end architecture rtl;
