library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pe_pkg.all;

entity NPU is
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        -- connections to port B of instruction RAM
        instr_we : in std_logic;
        instr_addr : in std_logic_vector(9 downto 0);
        instr_din : in std_logic_vector(35 downto 0);
        instr_dout : out std_logic_vector(35 downto 0);

        -- connections to port A of weight RAM
        weight_we : in std_logic;
        weight_din : in std_logic_vector(31 downto 0);
        weight_dout : out std_logic_vector(31 downto 0);
        weight_addr_a : in std_logic_vector(HOST_ADDR_WIDTH-1 downto 0);

        -- connections to port A of scratchpad RAM
        scratchpad_we     : in std_logic;
        scratchpad_din    : in std_logic_vector(31 downto 0);
        scratchpad_dout   : out std_logic_vector(31 downto 0);
        scratchpad_addr_a : in std_logic_vector(HOST_ADDR_WIDTH-1 downto 0);

        -- Top-level Interrupt Controller interface
        clear_int : in  std_logic := '0';
        interrupt : out std_logic;
        int_addr  : out std_logic_vector(11 downto 0)
    );
end entity NPU;

architecture Structural of NPU is
    -- BUFFERS FOR INSTR FETCHER
    signal instr_done_buf : std_logic;
    signal jump_addr_vo_buf : std_logic;
    signal jump_addr_buf : std_logic_vector(9 downto 0);
    signal instr_o_buf : std_logic_vector(35 downto 0);
    signal instr_valid_o_buf : std_logic;
    signal instr_bram_en_buf : std_logic;
    signal instr_d_in_buf : std_logic_vector(35 downto 0);
    signal instr_addr_o_buf : std_logic_vector(9 downto 0);

    -- BUFFERS FOR PE_ARR
    signal pe_clear_acc_buf : std_logic;
    signal pe_valid_in : std_logic;
    signal pe_drain : std_logic;
    signal pe_top_weights_buf : weight_row_t;
    signal pe_left_data_buf : data_col_t;
    signal pe_bottom_out_buf : accum_row_t; 

    -- BUFFERS FOR WEIGHT RAM
    signal weight_addr : std_logic_vector(11 downto 0);
    signal weight_ram_din : std_logic_vector(VECTOR_WIDTH-1 downto 0);

    -- BUFFERS FOR DECODER
    signal pe_drive_done_buf : std_logic;
    signal pe_drain_done_buf : std_logic;
    signal pe_reset_buf : std_logic;
    signal pe_run_buf : std_logic;
    signal pe_drain_buf : std_logic;
    signal pe_data_source_buf : std_logic_vector(1 downto 0);
    signal pe_data_addr_buf : std_logic_vector(11 downto 0);
    signal pe_weight_addr_buf : std_logic_vector(11 downto 0);
    signal pe_drain_addr_buf : std_logic_vector(11 downto 0);
    signal trigger_interrupt_buf : std_logic;
    signal vo_int_addr_buf : std_logic;
    signal int_targ_addr_buf : std_logic_vector(11 downto 0);

    -- BUFFERS FOR DRIVER
    signal weight_vector_drv : std_logic_vector(VECTOR_WIDTH-1 downto 0);
    signal skew_en_out_buf : std_logic;
    signal data_vector_drv : std_logic_vector(VECTOR_WIDTH-1 downto 0);

    signal pe_activation_function_buf : std_logic_vector(1 downto 0);
    signal pe_quant_mult_buf          : std_logic_vector(9 downto 0);
    signal pe_shift_amt_buf           : std_logic_vector(3 downto 0);
    signal pe_quantized_row_buf       : std_logic_vector(VECTOR_WIDTH-1 downto 0);

    signal scratchpad_we_drv   : std_logic;
    signal scratchpad_addr_drv : std_logic_vector(11 downto 0);
    signal scratchpad_dout_b : std_logic_vector(VECTOR_WIDTH-1 downto 0);
    signal raw_weights_unpacked : weight_row_t;
    signal raw_data_unpacked    : data_col_t;

    -- BUFFERS FOR JUMP MULTIPLEXING
    signal dec_jump_vo      : std_logic;
    signal dec_jump_addr    : std_logic_vector(9 downto 0);
    signal exec_jump_vo     : std_logic;
    signal exec_jump_addr   : std_logic_vector(9 downto 0);

    -- BUFFERS FOR REGISTER FILE & EXECUTOR
    signal add_i_rt_buf     : std_logic_vector(3 downto 0);
    signal add_i_rs_buf     : std_logic_vector(3 downto 0);
    signal add_i_imm_buf    : std_logic_vector(15 downto 0);
    signal add_i_en_buf     : std_logic;
    signal add_i_done_buf   : std_logic;

    signal beq_rt_buf       : std_logic_vector(3 downto 0);
    signal beq_rs_buf       : std_logic_vector(3 downto 0);
    signal beq_addr_buf     : std_logic_vector(9 downto 0);
    signal beq_en_buf       : std_logic;
    signal beq_done_buf     : std_logic;

    signal jr_rs_buf        : std_logic_vector(3 downto 0);
    signal jr_en_buf        : std_logic;
    signal jr_done_buf      : std_logic;

    signal beq_reg_rt_buf   : std_logic_vector(3 downto 0);
    signal beq_reg_rs_buf   : std_logic_vector(3 downto 0);
    signal beq_reg_addr_buf : std_logic_vector(3 downto 0);
    signal beq_reg_en_buf   : std_logic;
    signal beq_reg_done_buf : std_logic;

    -- Decoder outputs for immediate addresses
    signal dec_pe_data_addr   : std_logic_vector(11 downto 0);
    signal dec_pe_weight_addr : std_logic_vector(11 downto 0);
    signal dec_pe_drain_addr  : std_logic_vector(11 downto 0);
    signal dec_int_targ_addr  : std_logic_vector(11 downto 0);

    -- Executor outputs for register addresses
    signal exec_pe_data_addr   : std_logic_vector(11 downto 0);
    signal exec_pe_weight_addr : std_logic_vector(11 downto 0);
    signal exec_pe_drain_addr  : std_logic_vector(11 downto 0);
    signal exec_int_targ_addr  : std_logic_vector(11 downto 0);

    -- Control flags & Register targets
    signal drv_use_reg_buf   : std_logic;
    signal drn_use_reg_buf   : std_logic;
    signal int_use_reg_buf   : std_logic;
    signal drv_data_rs_buf   : std_logic_vector(3 downto 0);
    signal drv_weight_rs_buf : std_logic_vector(3 downto 0);
    signal drn_addr_rs_buf   : std_logic_vector(3 downto 0);
    signal int_addr_rs_buf   : std_logic_vector(3 downto 0);
begin
    assert ARRAY_SIZE >= 4 and ARRAY_SIZE = 2**clog2(ARRAY_SIZE)
        report "ARRAY_SIZE must be a power of two and at least 4"
        severity failure;

    UNPACK_VECS: for i in 0 to ARRAY_SIZE-1 generate
        raw_weights_unpacked(i) <=
            weight_vector_drv(
                (i+1)*WEIGHT_WIDTH-1 downto i*WEIGHT_WIDTH
            );
        raw_data_unpacked(i) <=
            data_vector_drv(
                (i+1)*DATA_WIDTH-1 downto i*DATA_WIDTH
            );
    end generate;

    jump_addr_vo_buf <= dec_jump_vo or exec_jump_vo;
    jump_addr_buf    <= exec_jump_addr when exec_jump_vo = '1' else dec_jump_addr;

    pe_data_addr_buf   <= exec_pe_data_addr   when drv_use_reg_buf = '1' else dec_pe_data_addr;
    pe_weight_addr_buf <= exec_pe_weight_addr when drv_use_reg_buf = '1' else dec_pe_weight_addr;
    pe_drain_addr_buf  <= exec_pe_drain_addr  when drn_use_reg_buf = '1' else dec_pe_drain_addr;
    int_targ_addr_buf  <= exec_int_targ_addr  when int_use_reg_buf = '1' else dec_int_targ_addr;

    PE_WEIGHT_RAM: entity work.PE_weight_ram
        port map (
            clk => clk,
            addr_a => weight_addr_a,
            we_a => weight_we,
            din_a => weight_din,
            dout_a => weight_dout,
            addr_b => weight_addr,
            dout_b => weight_ram_din
        );

    INSTR_fetch: entity work.instr_fetcher
        port map (
            clk => clk,
            reset_n => rst_n,
            instr_done => instr_done_buf,
            jump_addr_vo => jump_addr_vo_buf,
            jump_addr => jump_addr_buf,
            instr_o => instr_o_buf,
            instr_valid_o => instr_valid_o_buf,
            bram_en => instr_bram_en_buf,
            d_in => instr_d_in_buf,
            addr_o => instr_addr_o_buf
        );

    INSTR_bram: entity work.instr_bram
        port map (
            clk_a => clk,
            we_a => '0',
            addr_a => instr_addr_o_buf,
            din_a => (others => '0'),
            dout_a => instr_d_in_buf,
            clk_b => clk,
            we_b => instr_we,
            addr_b => instr_addr,
            din_b => instr_din,
            dout_b => instr_dout
        );
        
    PE_SKEW_BUFFER: entity work.SkewBuffer
        port map (
            clk => clk,
            rst_n => rst_n,
            enable => skew_en_out_buf,
            raw_weights => raw_weights_unpacked,
            raw_data => raw_data_unpacked,
            skewed_weights => pe_top_weights_buf,
            skewed_data => pe_left_data_buf
        );

    PE_arr: entity work.PEarray
        port map (
            clk => clk,
            rst_n => rst_n,
            clear_acc => pe_clear_acc_buf,
            valid_in => pe_valid_in,
            drain => pe_drain,
            top_weights => pe_top_weights_buf,
            left_data => pe_left_data_buf,
            bottom_out => pe_bottom_out_buf
        );

    PE_arr_dr: entity work.PE_arr_driver
        port map (
            clk => clk,
            rst_n => rst_n,
            pe_reset => pe_reset_buf,
            pe_run => pe_run_buf,
            pe_drain => pe_drain_buf,
            pe_data_source => pe_data_source_buf,
            pe_data_addr => pe_data_addr_buf,
            pe_weight_addr => pe_weight_addr_buf,
            pe_data_output => data_vector_drv,
            data_addr_out => open,
            scratchpad_in => scratchpad_dout_b,
            sensor_ram_in => (others => '0'),
            weight_data_in => weight_ram_din,
            weight_data_out => weight_vector_drv,
            weight_addr_out => weight_addr,
            pe_clear_acc_out => pe_clear_acc_buf,
            pe_valid_out => pe_valid_in,
            skew_enable_out => skew_en_out_buf,
            pe_drive_done => pe_drive_done_buf,
            drain_addr_start => pe_drain_addr_buf,
            scratchpad_addr_out => scratchpad_addr_drv,
            scratchpad_we_out   => scratchpad_we_drv,
            pe_drain_en => pe_drain,
            pe_drain_done => pe_drain_done_buf
        );

    NPU_decoder: entity work.npu_decoder
        port map (
            instr               => instr_o_buf,
            instr_valid         => instr_valid_o_buf,
            
            -- Handshake inputs
            pe_drive_done       => pe_drive_done_buf,
            pe_drain_done       => pe_drain_done_buf,
            add_i_done          => add_i_done_buf,
            beq_done            => beq_done_buf,
            jr_done             => jr_done_buf,
            beq_reg_done        => beq_reg_done_buf,
            
            instr_done          => instr_done_buf,
            
            -- PE Controls
            pe_reset            => pe_reset_buf,
            pe_run              => pe_run_buf,
            pe_drain            => pe_drain_buf,
            pe_data_source      => pe_data_source_buf,
            pe_data_addr        => dec_pe_data_addr,
            pe_weight_addr      => dec_pe_weight_addr,
            pe_drain_addr       => dec_pe_drain_addr,
            activation_function => pe_activation_function_buf,
            quant_mult          => pe_quant_mult_buf,
            shift_amt           => pe_shift_amt_buf,
            
            -- Interrupts
            trigger_interrupt   => trigger_interrupt_buf,
            vo_int_addr         => vo_int_addr_buf,
            int_targ_addr       => dec_int_targ_addr,
            
            -- Immediate Jump (Routed to Mux)
            jump_addr_vo        => dec_jump_vo,
            jump_addr           => dec_jump_addr,
            
            -- Executor fields
            add_i_rt            => add_i_rt_buf,
            add_i_rs            => add_i_rs_buf,
            add_i_imm           => add_i_imm_buf,
            add_i_en            => add_i_en_buf,
            
            beq_rt              => beq_rt_buf,
            beq_rs              => beq_rs_buf,
            beq_addr            => beq_addr_buf,
            beq_en              => beq_en_buf,
            
            jr_rs               => jr_rs_buf,
            jr_en               => jr_en_buf,
            
            beq_reg_rt          => beq_reg_rt_buf,
            beq_reg_rs          => beq_reg_rs_buf,
            beq_reg_addr        => beq_reg_addr_buf,
            beq_reg_en          => beq_reg_en_buf,

            drv_use_reg         => drv_use_reg_buf,
            drn_use_reg         => drn_use_reg_buf,
            drv_data_rs         => drv_data_rs_buf,
            drv_weight_rs       => drv_weight_rs_buf,
            drn_addr_rs         => drn_addr_rs_buf,
            int_use_reg         => int_use_reg_buf,
            int_addr_rs         => int_addr_rs_buf
        );

    PE_POST_PROC: entity work.processing_row
        port map (
            clk                 => clk,
            rst_n               => rst_n,
            activation_function => pe_activation_function_buf,
            quant_mult          => pe_quant_mult_buf,
            shift_amt           => pe_shift_amt_buf,
            row_in              => pe_bottom_out_buf,
            row_out             => pe_quantized_row_buf
        );

    PE_SCRATCHPAD_RAM: entity work.PE_scratchpad_ram
        port map (
            clk    => clk,
            -- Port A (Top Level - RISC-V)
            addr_a => scratchpad_addr_a,
            we_a   => scratchpad_we,
            din_a  => scratchpad_din,
            dout_a => scratchpad_dout,
            -- Port B (Internal Datapath)
            addr_b => scratchpad_addr_drv,           -- Direct from driver
            we_b   => scratchpad_we_drv,             -- Direct from driver
            din_b  => pe_quantized_row_buf,          -- Direct from post-proc row
            dout_b => scratchpad_dout_b              -- Direct back to driver read port
        );

    REG_FILE_EXEC: entity work.r_file_n_exec
        port map (
            clk                 => clk,
            rst_n               => rst_n,
            -- add_i ports
            add_i_rt            => add_i_rt_buf,
            add_i_rs            => add_i_rs_buf,
            add_i_imm           => add_i_imm_buf,
            add_i_en            => add_i_en_buf,
            add_i_done          => add_i_done_buf,
            -- beq immediate ports
            beq_rt              => beq_rt_buf,
            beq_rs              => beq_rs_buf,
            beq_addr            => beq_addr_buf,
            beq_en              => beq_en_buf,
            beq_done            => beq_done_buf,
            -- jr ports
            jr_rs               => jr_rs_buf,
            jr_en               => jr_en_buf,
            jr_done             => jr_done_buf,
            -- beq register ports
            beq_reg_rt          => beq_reg_rt_buf,
            beq_reg_rs          => beq_reg_rs_buf,
            beq_reg_addr        => beq_reg_addr_buf,
            beq_reg_en          => beq_reg_en_buf,
            beq_reg_done        => beq_reg_done_buf,
            -- Register-based Jump Outputs (Routed to Mux)
            jump_addr           => exec_jump_addr,
            jump_vo             => exec_jump_vo,
            -- Inputs from decoder
            drv_data_rs         => drv_data_rs_buf,
            drv_weight_rs       => drv_weight_rs_buf,
            drn_addr_rs         => drn_addr_rs_buf,
            int_addr_rs         => int_addr_rs_buf,
            -- Outputs to the multiplexers
            exec_pe_data_addr   => exec_pe_data_addr,
            exec_pe_weight_addr => exec_pe_weight_addr,
            exec_pe_drain_addr  => exec_pe_drain_addr,
            exec_int_targ_addr  => exec_int_targ_addr
        );

    INT_CTRL: entity work.interrupt_controller
        port map (
            clk                => clk,
            rst_n              => rst_n,
            trg_interrupt      => trigger_interrupt_buf,
            set_interrupt_addr => int_targ_addr_buf,
            interrupt_addr_v   => vo_int_addr_buf,
            interrupt          => interrupt,
            int_addr           => int_addr,
            clear_int          => clear_int
        );
end architecture Structural;
