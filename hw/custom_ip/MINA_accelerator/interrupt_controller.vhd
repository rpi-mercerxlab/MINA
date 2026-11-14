library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interrupt_controller is
    port (
        -- Basics
        clk    : in  std_logic;
        rst_n    : in  std_logic;
    
        trg_interrupt : in std_logic;
        
        set_interrupt_addr : in std_logic_vector(11 downto 0);
        interrupt_addr_v : in std_logic;

        interrupt : out std_logic;
        int_addr : out std_logic_vector(11 downto 0);
        clear_int : in std_logic
    );
end entity interrupt_controller;

architecture Behavioral of interrupt_controller is

    signal int_value : std_logic;
    signal int_addr_val : std_logic_vector(11 downto 0);

begin

    interrupt <= int_value;
    int_addr <= int_addr_val;

process (clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            int_value <= '0';
            int_addr_val <= (others => '0');
        else


            if clear_int = '1' then
                int_value <= '0';
            end if;

            if trg_interrupt = '1' then
                int_value <= '1';
            end if;

            if interrupt_addr_v = '1' then
                int_addr_val <= set_interrupt_addr;
            end if;

        end if;
    end if;
end process;

end architecture Behavioral;
