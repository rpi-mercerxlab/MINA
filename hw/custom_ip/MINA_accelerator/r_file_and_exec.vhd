library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity r_file_n_exec is
    port (
        clk                 : in  std_logic;
        rst_n               : in  std_logic;

        add_i_rt : in std_logic_vector(3 downto 0);
        add_i_rs : in std_logic_vector(3 downto 0);
        add_i_imm : in std_logic_vector(15 downto 0);
        add_i_en : in std_logic;
        add_i_done : out std_logic;

        beq_rt : in std_logic_vector(3 downto 0);
        beq_rs : in std_logic_vector(3 downto 0);
        beq_en : in std_logic;
        beq_addr : in std_logic_vector(9 downto 0);
        beq_done : out std_logic;

        jr_rs       : in std_logic_vector(3 downto 0);
        jr_en       : in std_logic;
        jr_done     : out std_logic;

        beq_reg_rt   : in std_logic_vector(3 downto 0);
        beq_reg_rs   : in std_logic_vector(3 downto 0);
        beq_reg_addr : in std_logic_vector(3 downto 0); -- Register holding the jump target
        beq_reg_en   : in std_logic;
        beq_reg_done : out std_logic;

        jump_addr : out std_logic_vector(9 downto 0);
        jump_vo   : out std_logic;

        drv_data_rs   : in std_logic_vector(3 downto 0);
        drv_weight_rs : in std_logic_vector(3 downto 0);
        drn_addr_rs   : in std_logic_vector(3 downto 0);

        exec_pe_data_addr   : out std_logic_vector(11 downto 0);
        exec_pe_weight_addr : out std_logic_vector(11 downto 0);
        exec_pe_drain_addr  : out std_logic_vector(11 downto 0)

    );
end entity r_file_n_exec;

architecture rtl of r_file_n_exec is

    type reg_file is array (0 to 15) of std_logic_vector(15 downto 0);
    signal registers : reg_file;

    signal add_i_rs_val : std_logic_vector(15 downto 0);
    signal beq_rt_val : std_logic_vector(15 downto 0);
    signal beq_rs_val : std_logic_vector(15 downto 0);
    signal jr_rs_val        : std_logic_vector(15 downto 0);
    signal beq_reg_rt_val   : std_logic_vector(15 downto 0);
    signal beq_reg_rs_val   : std_logic_vector(15 downto 0);
    signal beq_reg_addr_val : std_logic_vector(15 downto 0);

begin

    add_i_rs_val <= registers(to_integer(unsigned(add_i_rs)));
    beq_rt_val <= registers(to_integer(unsigned(beq_rt)));
    beq_rs_val <= registers(to_integer(unsigned(beq_rs)));

    exec_pe_data_addr   <= registers(to_integer(unsigned(drv_data_rs)))(11 downto 0);
    exec_pe_weight_addr <= registers(to_integer(unsigned(drv_weight_rs)))(11 downto 0);
    exec_pe_drain_addr  <= registers(to_integer(unsigned(drn_addr_rs)))(11 downto 0);

    jr_rs_val        <= registers(to_integer(unsigned(jr_rs)));
    beq_reg_rt_val   <= registers(to_integer(unsigned(beq_reg_rt)));
    beq_reg_rs_val   <= registers(to_integer(unsigned(beq_reg_rs)));
    beq_reg_addr_val <= registers(to_integer(unsigned(beq_reg_addr)));

    process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                registers <= (others => (others => '0'));
                add_i_done <= '0';
                beq_done   <= '0';
                jump_vo    <= '0';
                jump_addr  <= (others => '0');
                jr_done      <= '0';
                beq_reg_done <= '0';
            else
                add_i_done <= '0';
                beq_done   <= '0';
                jump_vo    <= '0';
                jr_done      <= '0';
                beq_reg_done <= '0';
                -- executes the add_i instruction
                if add_i_en = '1' then
                    registers(to_integer(unsigned(add_i_rt))) <= std_logic_vector(signed(add_i_rs_val) + signed(add_i_imm));
                    add_i_done <= '1';
                end if;

                -- Execute the beq instruction
                if beq_en = '1' then
                    beq_done <= '1'; -- Signal to the fetcher that the instruction is complete
                    
                    -- Compare the two register values
                    if beq_rt_val = beq_rs_val then
                        jump_vo   <= '1';         -- Tell fetcher to jump
                        jump_addr <= beq_addr;    -- Provide the target address
                    end if;
                end if;

                -- Execute Register Source Jump
                if jr_en = '1' then
                    jr_done   <= '1';
                    jump_vo   <= '1';
                    jump_addr <= jr_rs_val(9 downto 0);
                end if;

                -- Execute Register Source BEQ
                if beq_reg_en = '1' then
                    beq_reg_done <= '1';
                    if beq_reg_rt_val = beq_reg_rs_val then
                        jump_vo   <= '1';
                        jump_addr <= beq_reg_addr_val(9 downto 0);
                    end if;
                end if;

            end if;
        end if;
    end process;

end architecture rtl;
