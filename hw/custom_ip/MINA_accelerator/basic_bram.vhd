library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity basic_dual_port is
    generic (
        DATA_WIDTH : integer := 36;
        ADDR_WIDTH : integer := 10  -- 2^10 = 1024 words
    );
    port (
        -- Port A
        clk_a  : in  std_logic;
        we_a   : in  std_logic;
        addr_a : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
        din_a  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        dout_a : out std_logic_vector(DATA_WIDTH-1 downto 0);
        
        -- Port B
        clk_b  : in  std_logic;
        we_b   : in  std_logic;
        addr_b : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
        din_b  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        dout_b : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end basic_dual_port;

architecture rtl of basic_dual_port is
    -- Define the RAM type based on generics
    constant RAM_DEPTH : integer := 2**ADDR_WIDTH;
    type ram_type is array (0 to RAM_DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    
    -- Shared variable is required for true dual-port inference across two processes
    shared variable RAM : ram_type := (others => (others => '0'));

begin
    -- Port A Process
    process(clk_a)
    begin
        if rising_edge(clk_a) then
            if we_a = '1' then
                RAM(to_integer(unsigned(addr_a))) := din_a;
            end if;
            -- Read-First (Write-through) behavior
            dout_a <= RAM(to_integer(unsigned(addr_a)));
        end if;
    end process;

    -- Port B Process
    process(clk_b)
    begin
        if rising_edge(clk_b) then
            if we_b = '1' then
                RAM(to_integer(unsigned(addr_b))) := din_b;
            end if;
            -- Read-First (Write-through) behavior
            dout_b <= RAM(to_integer(unsigned(addr_b)));
        end if;
    end process;

end rtl;
