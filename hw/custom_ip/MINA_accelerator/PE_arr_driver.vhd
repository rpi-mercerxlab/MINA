library ieee;
use ieee.std_logic_1164.all;

entity PE_arr_driver is
    port (
        clk : in std_logic;
        rst_n : in std_logic;

        pe_reset : in std_logic;
        pe_run : in std_logic;
        
        pe_data_source : in std_logic_vector(1 downto 0);
        pe_data_addr : in std_logic_vector(11 downto 0);
        pe_weight_addr : in std_logic_vector(11 downto 0);
        pe_drain_addr : in std_logic_vector(11 downto 0)

        );
end entity PE_arr_driver;

architecture rtl of PE_arr_driver is

begin

end architecture rtl;
