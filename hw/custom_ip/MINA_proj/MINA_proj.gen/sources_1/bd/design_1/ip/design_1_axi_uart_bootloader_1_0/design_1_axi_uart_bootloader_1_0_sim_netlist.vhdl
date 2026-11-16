-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Mon Nov 16 09:45:34 2026
-- Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
-- Command     : write_vhdl -force -mode funcsim
--               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_axi_uart_bootloader_1_0/design_1_axi_uart_bootloader_1_0_sim_netlist.vhdl
-- Design      : design_1_axi_uart_bootloader_1_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s50csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_uart_bootloader_1_0_uart_phy is
  port (
    phy_rx_frame_error : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    uart_tx : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \tx_count_reg[4]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \tx_count_reg[4]_0\ : out STD_LOGIC;
    \rx_data_reg[7]_0\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \boot_state_reg[2]\ : out STD_LOGIC;
    \boot_state_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_0_in : out STD_LOGIC;
    boot_reply_pending_reg : out STD_LOGIC;
    boot_active_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    \tx_count_reg[4]_1\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    tx_rd_ptr0 : out STD_LOGIC;
    \rx_data_reg[1]_0\ : out STD_LOGIC;
    rx_valid_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \boot_state_reg[0]_0\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \boot_state_reg[2]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \boot_state_reg[1]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    boot_data_hi_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    rx_frame_error_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    bram_en_reg : out STD_LOGIC;
    \boot_state_reg[2]_1\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \boot_state_reg[3]\ : out STD_LOGIC;
    rx_frame_error_reg_1 : out STD_LOGIC;
    \boot_state_reg[1]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \boot_checksum_reg[7]\ : out STD_LOGIC;
    \boot_state_reg[1]_1\ : out STD_LOGIC;
    \boot_state_reg[1]_2\ : out STD_LOGIC;
    \boot_state_reg[1]_3\ : out STD_LOGIC;
    boot_active_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aresetn_0 : out STD_LOGIC;
    \boot_state_reg[0]_1\ : out STD_LOGIC;
    rx_frame_error_reg_2 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_aresetn_1 : out STD_LOGIC;
    axi_error_clear_reg : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    rx_rd_ptr0 : in STD_LOGIC;
    boot_reply_pending_reg_0 : in STD_LOGIC;
    \tx_count_reg[0]\ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    boot_reply_pending_reg_1 : in STD_LOGIC;
    phy_tx_data0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \boot_state_reg[0]_2\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \tx_shift_reg[4]_0\ : in STD_LOGIC;
    \tx_shift_reg[1]_0\ : in STD_LOGIC;
    overrun_error_reg : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    \tx_count_reg[0]_0\ : in STD_LOGIC;
    \tx_count_reg[3]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \boot_checksum_reg[7]_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \boot_checksum_reg[0]\ : in STD_LOGIC;
    \npu_data_reg[0]\ : in STD_LOGIC;
    npu_s_we_reg : in STD_LOGIC;
    npu_w_we_reg : in STD_LOGIC;
    npu_i_we_reg : in STD_LOGIC;
    \bram_din_reg_reg[0]\ : in STD_LOGIC;
    \bram_din_reg_reg[0]_0\ : in STD_LOGIC;
    overrun_error_reg_0 : in STD_LOGIC;
    overrun_error : in STD_LOGIC;
    frame_error : in STD_LOGIC;
    uart_rx : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_axi_uart_bootloader_1_0_uart_phy : entity is "uart_phy";
end design_1_axi_uart_bootloader_1_0_uart_phy;

architecture STRUCTURE of design_1_axi_uart_bootloader_1_0_uart_phy is
  signal \FSM_sequential_rx_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rx_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rx_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_rx_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_tx_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_tx_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_tx_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_tx_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_tx_state[1]_i_4_n_0\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^boot_checksum_reg[7]\ : STD_LOGIC;
  signal \boot_command[7]_i_3_n_0\ : STD_LOGIC;
  signal boot_reply_pending22_out : STD_LOGIC;
  signal boot_reply_pending_i_2_n_0 : STD_LOGIC;
  signal boot_reply_pending_i_4_n_0 : STD_LOGIC;
  signal boot_reply_pending_i_5_n_0 : STD_LOGIC;
  signal \boot_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \boot_state[3]_i_4_n_0\ : STD_LOGIC;
  signal \boot_state[3]_i_5_n_0\ : STD_LOGIC;
  signal \^boot_state_reg[0]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^bram_en_reg\ : STD_LOGIC;
  signal bram_en_reg_i_6_n_0 : STD_LOGIC;
  signal bram_en_reg_i_7_n_0 : STD_LOGIC;
  signal bram_en_reg_i_8_n_0 : STD_LOGIC;
  signal \bram_we_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal data1 : STD_LOGIC;
  signal data2 : STD_LOGIC;
  signal data4 : STD_LOGIC;
  signal data5 : STD_LOGIC;
  signal data6 : STD_LOGIC;
  signal overrun_error_i_2_n_0 : STD_LOGIC;
  signal \^phy_rx_frame_error\ : STD_LOGIC;
  signal phy_rx_valid : STD_LOGIC;
  signal phy_tx_data : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal rx_bit_index : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \rx_bit_index[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_bit_index[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_bit_index[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_bit_index_reg_n_0_[0]\ : STD_LOGIC;
  signal \rx_bit_index_reg_n_0_[1]\ : STD_LOGIC;
  signal \rx_bit_index_reg_n_0_[2]\ : STD_LOGIC;
  signal rx_clk_count : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \rx_clk_count[3]_i_2_n_0\ : STD_LOGIC;
  signal \rx_clk_count[4]_i_2_n_0\ : STD_LOGIC;
  signal \rx_clk_count[5]_i_2_n_0\ : STD_LOGIC;
  signal \rx_clk_count[8]_i_2_n_0\ : STD_LOGIC;
  signal \rx_clk_count[9]_i_3_n_0\ : STD_LOGIC;
  signal rx_clk_count_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \rx_clk_count_reg_n_0_[0]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[1]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[2]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[3]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[4]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[5]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[6]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[7]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[8]\ : STD_LOGIC;
  signal \rx_clk_count_reg_n_0_[9]\ : STD_LOGIC;
  signal \rx_count[3]_i_2_n_0\ : STD_LOGIC;
  signal \rx_count[4]_i_3_n_0\ : STD_LOGIC;
  signal \rx_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \^rx_data_reg[1]_0\ : STD_LOGIC;
  signal \^rx_data_reg[7]_0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_frame_error_i_1_n_0 : STD_LOGIC;
  signal \^rx_frame_error_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \rx_shift[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[3]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[3]_i_2_n_0\ : STD_LOGIC;
  signal \rx_shift[4]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[5]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[6]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[7]_i_1_n_0\ : STD_LOGIC;
  signal \rx_shift[7]_i_2_n_0\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[0]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[1]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[2]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[3]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[4]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[5]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[6]\ : STD_LOGIC;
  signal \rx_shift_reg_n_0_[7]\ : STD_LOGIC;
  signal rx_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \tx_bit_index[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_bit_index[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_bit_index[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_bit_index[2]_i_2_n_0\ : STD_LOGIC;
  signal \tx_bit_index_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_bit_index_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_bit_index_reg_n_0_[2]\ : STD_LOGIC;
  signal tx_clk_count : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \tx_clk_count[2]_i_2_n_0\ : STD_LOGIC;
  signal \tx_clk_count[3]_i_2_n_0\ : STD_LOGIC;
  signal \tx_clk_count[4]_i_2_n_0\ : STD_LOGIC;
  signal \tx_clk_count[5]_i_2_n_0\ : STD_LOGIC;
  signal \tx_clk_count[8]_i_2_n_0\ : STD_LOGIC;
  signal \tx_clk_count[8]_i_3_n_0\ : STD_LOGIC;
  signal \tx_clk_count[9]_i_3_n_0\ : STD_LOGIC;
  signal \tx_clk_count[9]_i_4_n_0\ : STD_LOGIC;
  signal tx_clk_count_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \tx_clk_count_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[3]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[4]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[5]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[6]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[7]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[8]\ : STD_LOGIC;
  signal \tx_clk_count_reg_n_0_[9]\ : STD_LOGIC;
  signal \tx_count[4]_i_3_n_0\ : STD_LOGIC;
  signal \^tx_count_reg[4]_0\ : STD_LOGIC;
  signal \^tx_rd_ptr0\ : STD_LOGIC;
  signal \tx_shift[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_shift[5]_i_1_n_0\ : STD_LOGIC;
  signal \tx_shift[6]_i_1_n_0\ : STD_LOGIC;
  signal \tx_shift[7]_i_1_n_0\ : STD_LOGIC;
  signal \tx_shift[7]_i_2_n_0\ : STD_LOGIC;
  signal \tx_shift_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_shift_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_shift_reg_n_0_[4]\ : STD_LOGIC;
  signal tx_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^uart_tx\ : STD_LOGIC;
  signal uart_tx_reg_i_2_n_0 : STD_LOGIC;
  signal uart_tx_reg_i_3_n_0 : STD_LOGIC;
  signal uart_tx_reg_i_4_n_0 : STD_LOGIC;
  signal uart_tx_reg_i_5_n_0 : STD_LOGIC;
  signal uart_tx_reg_i_6_n_0 : STD_LOGIC;
  signal uart_tx_reg_i_7_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[0]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \FSM_sequential_rx_state[1]_i_2\ : label is "soft_lutpair12";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_rx_state_reg[0]\ : label is "rx_start:01,rx_stop:11,rx_idle:00,rx_recv_data:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_rx_state_reg[1]\ : label is "rx_start:01,rx_stop:11,rx_idle:00,rx_recv_data:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_tx_state_reg[0]\ : label is "tx_idle:00,tx_start:01,tx_send_data:10,tx_stop:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_tx_state_reg[1]\ : label is "tx_idle:00,tx_start:01,tx_send_data:10,tx_stop:11";
  attribute SOFT_HLUTNM of \boot_address[15]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \boot_address[7]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \boot_data[23]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \boot_data[31]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \boot_data[7]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \boot_reply[1]_i_3\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of boot_reply_pending_i_4 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of boot_reply_pending_i_5 : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \boot_state[3]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \boot_state[3]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of bram_en_reg_i_1 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \bram_we_reg[3]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of overrun_error_i_2 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \rx_bit_index[0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rx_bit_index[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rx_clk_count[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rx_clk_count[1]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rx_clk_count[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rx_clk_count[3]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rx_clk_count[4]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rx_clk_count[4]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rx_clk_count[9]_i_3\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \rx_count[3]_i_2\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \rx_count[4]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \rx_count[4]_i_3\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of rx_frame_error_i_1 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \rx_shift[3]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \rx_shift[7]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rx_shift[7]_i_2\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \rx_wr_ptr[3]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \tx_bit_index[2]_i_2\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \tx_clk_count[0]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \tx_clk_count[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \tx_clk_count[3]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \tx_clk_count[4]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \tx_clk_count[5]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \tx_clk_count[5]_i_2\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \tx_clk_count[7]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \tx_clk_count[8]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \tx_clk_count[8]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \tx_clk_count[9]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \tx_rd_ptr_rep[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \tx_shift[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \tx_shift[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \tx_shift[5]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \tx_shift[6]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \tx_shift[7]_i_2\ : label is "soft_lutpair22";
begin
  SR(0) <= \^sr\(0);
  \boot_checksum_reg[7]\ <= \^boot_checksum_reg[7]\;
  \boot_state_reg[0]\(0) <= \^boot_state_reg[0]\(0);
  bram_en_reg <= \^bram_en_reg\;
  phy_rx_frame_error <= \^phy_rx_frame_error\;
  \rx_data_reg[1]_0\ <= \^rx_data_reg[1]_0\;
  \rx_data_reg[7]_0\(7 downto 0) <= \^rx_data_reg[7]_0\(7 downto 0);
  rx_frame_error_reg_0(0) <= \^rx_frame_error_reg_0\(0);
  \tx_count_reg[4]_0\ <= \^tx_count_reg[4]_0\;
  tx_rd_ptr0 <= \^tx_rd_ptr0\;
  uart_tx <= \^uart_tx\;
\FSM_sequential_rx_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA03035303"
    )
        port map (
      I0 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I1 => uart_rx,
      I2 => rx_state(1),
      I3 => \rx_bit_index_reg_n_0_[2]\,
      I4 => \FSM_sequential_rx_state[0]_i_2_n_0\,
      I5 => rx_state(0),
      O => \FSM_sequential_rx_state[0]_i_1_n_0\
    );
\FSM_sequential_rx_state[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \rx_bit_index_reg_n_0_[0]\,
      I1 => \rx_bit_index_reg_n_0_[1]\,
      O => \FSM_sequential_rx_state[0]_i_2_n_0\
    );
\FSM_sequential_rx_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A1AA"
    )
        port map (
      I0 => rx_state(1),
      I1 => uart_rx,
      I2 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I3 => rx_state(0),
      O => \FSM_sequential_rx_state[1]_i_1_n_0\
    );
\FSM_sequential_rx_state[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[8]\,
      I1 => \rx_clk_count_reg_n_0_[6]\,
      I2 => \rx_clk_count[8]_i_2_n_0\,
      I3 => \rx_clk_count_reg_n_0_[7]\,
      I4 => \rx_clk_count_reg_n_0_[9]\,
      O => \FSM_sequential_rx_state[1]_i_2_n_0\
    );
\FSM_sequential_rx_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_rx_state[0]_i_1_n_0\,
      Q => rx_state(0),
      R => \^sr\(0)
    );
\FSM_sequential_rx_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_rx_state[1]_i_1_n_0\,
      Q => rx_state(1),
      R => \^sr\(0)
    );
\FSM_sequential_tx_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0045BABA"
    )
        port map (
      I0 => \tx_shift[7]_i_1_n_0\,
      I1 => \FSM_sequential_tx_state[1]_i_2_n_0\,
      I2 => \FSM_sequential_tx_state[1]_i_3_n_0\,
      I3 => uart_tx_reg_i_5_n_0,
      I4 => tx_state(0),
      O => \FSM_sequential_tx_state[0]_i_1_n_0\
    );
\FSM_sequential_tx_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0045FFFFFFBA0000"
    )
        port map (
      I0 => \tx_shift[7]_i_1_n_0\,
      I1 => \FSM_sequential_tx_state[1]_i_2_n_0\,
      I2 => \FSM_sequential_tx_state[1]_i_3_n_0\,
      I3 => uart_tx_reg_i_5_n_0,
      I4 => tx_state(0),
      I5 => tx_state(1),
      O => \FSM_sequential_tx_state[1]_i_1_n_0\
    );
\FSM_sequential_tx_state[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFBFFFF"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[8]\,
      I1 => tx_state(1),
      I2 => tx_state(0),
      I3 => \tx_clk_count[4]_i_2_n_0\,
      I4 => \FSM_sequential_tx_state[1]_i_4_n_0\,
      O => \FSM_sequential_tx_state[1]_i_2_n_0\
    );
\FSM_sequential_tx_state[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \tx_bit_index_reg_n_0_[0]\,
      I1 => \tx_bit_index_reg_n_0_[1]\,
      I2 => \tx_bit_index_reg_n_0_[2]\,
      O => \FSM_sequential_tx_state[1]_i_3_n_0\
    );
\FSM_sequential_tx_state[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001010001"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[1]\,
      I1 => \tx_clk_count_reg_n_0_[2]\,
      I2 => \tx_clk_count_reg_n_0_[0]\,
      I3 => \tx_clk_count_reg_n_0_[3]\,
      I4 => \tx_clk_count_reg_n_0_[4]\,
      I5 => \tx_clk_count_reg_n_0_[5]\,
      O => \FSM_sequential_tx_state[1]_i_4_n_0\
    );
\FSM_sequential_tx_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_tx_state[0]_i_1_n_0\,
      Q => tx_state(0),
      R => \^sr\(0)
    );
\FSM_sequential_tx_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_sequential_tx_state[1]_i_1_n_0\,
      Q => tx_state(1),
      R => \^sr\(0)
    );
\boot_address[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000008"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(2),
      I1 => phy_rx_valid,
      I2 => \^phy_rx_frame_error\,
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      O => \boot_state_reg[2]_0\(1)
    );
\boot_address[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(2),
      I1 => \boot_state_reg[0]_2\(3),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => phy_rx_valid,
      I5 => \^phy_rx_frame_error\,
      O => \boot_state_reg[2]_0\(2)
    );
\boot_address[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000100000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(2),
      I1 => \boot_state_reg[0]_2\(3),
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(0),
      I4 => phy_rx_valid,
      I5 => \^phy_rx_frame_error\,
      O => \boot_state_reg[2]_0\(3)
    );
\boot_address[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(2),
      I1 => phy_rx_valid,
      I2 => \^phy_rx_frame_error\,
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      O => \boot_state_reg[2]_0\(0)
    );
\boot_checksum[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55575554AAA8AAA8"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(0),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \^rx_data_reg[7]_0\(0),
      O => \boot_state_reg[0]_0\(0)
    );
\boot_checksum[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55575554AAA8AAA8"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(1),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \^rx_data_reg[7]_0\(1),
      O => \boot_state_reg[0]_0\(1)
    );
\boot_checksum[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55575554AAA8AAA8"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(2),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \^rx_data_reg[7]_0\(2),
      O => \boot_state_reg[0]_0\(2)
    );
\boot_checksum[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55575554AAA8AAA8"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(3),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \^rx_data_reg[7]_0\(3),
      O => \boot_state_reg[0]_0\(3)
    );
\boot_checksum[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002FFFCFFFE0000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(0),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \^rx_data_reg[7]_0\(4),
      I5 => \boot_checksum_reg[7]_0\(4),
      O => \boot_state_reg[0]_0\(4)
    );
\boot_checksum[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66666666666C6660"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(5),
      I1 => \^rx_data_reg[7]_0\(5),
      I2 => \boot_state_reg[0]_2\(2),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \boot_state_reg[0]_2\(1),
      O => \boot_state_reg[0]_0\(5)
    );
\boot_checksum[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002FFFCFFFE0000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(0),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \^rx_data_reg[7]_0\(6),
      I5 => \boot_checksum_reg[7]_0\(6),
      O => \boot_state_reg[0]_0\(6)
    );
\boot_checksum[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA8AAA8AAA8AAAA"
    )
        port map (
      I0 => \bram_we_reg[3]_i_3_n_0\,
      I1 => \boot_state[1]_i_2_n_0\,
      I2 => \boot_checksum_reg[0]\,
      I3 => \boot_state_reg[0]_2\(2),
      I4 => \boot_state[3]_i_4_n_0\,
      I5 => \boot_state_reg[0]_2\(0),
      O => \boot_state_reg[2]_1\(0)
    );
\boot_checksum[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002FFFCFFFE0000"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(0),
      I1 => \boot_state_reg[0]_2\(2),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \^rx_data_reg[7]_0\(7),
      I5 => \boot_checksum_reg[7]_0\(7),
      O => \boot_state_reg[0]_0\(7)
    );
\boot_command[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000020"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(0),
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \^rx_data_reg[1]_0\,
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(2),
      I5 => \^bram_en_reg\,
      O => \^boot_state_reg[0]\(0)
    );
\boot_command[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"02A8"
    )
        port map (
      I0 => \boot_command[7]_i_3_n_0\,
      I1 => \^rx_data_reg[7]_0\(1),
      I2 => \^rx_data_reg[7]_0\(0),
      I3 => \^rx_data_reg[7]_0\(2),
      O => \^rx_data_reg[1]_0\
    );
\boot_command[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(7),
      I1 => \^rx_data_reg[7]_0\(5),
      I2 => \^rx_data_reg[7]_0\(3),
      I3 => \^rx_data_reg[7]_0\(6),
      I4 => \^rx_data_reg[7]_0\(4),
      O => \boot_command[7]_i_3_n_0\
    );
\boot_data[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10000000"
    )
        port map (
      I0 => \^phy_rx_frame_error\,
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => phy_rx_valid,
      O => rx_frame_error_reg_2(1)
    );
\boot_data[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => \^phy_rx_frame_error\,
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => phy_rx_valid,
      O => rx_frame_error_reg_2(2)
    );
\boot_data[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"40000000"
    )
        port map (
      I0 => \^phy_rx_frame_error\,
      I1 => phy_rx_valid,
      I2 => \boot_state_reg[0]_2\(2),
      I3 => \boot_state_reg[0]_2\(0),
      I4 => \boot_state_reg[0]_2\(1),
      O => rx_frame_error_reg_2(3)
    );
\boot_data[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(3),
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => phy_rx_valid,
      I4 => \^phy_rx_frame_error\,
      O => rx_frame_error_reg_2(0)
    );
\boot_data_hi[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^boot_state_reg[0]\(0),
      I1 => \boot_state_reg[0]_2\(2),
      O => \boot_state_reg[2]\
    );
\boot_data_hi[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \^boot_state_reg[0]\(0),
      I1 => \^rx_frame_error_reg_0\(0),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \boot_state_reg[0]_2\(2),
      I5 => phy_rx_valid,
      O => boot_data_hi_0(0)
    );
\boot_reply[1]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^phy_rx_frame_error\,
      I1 => boot_reply_pending_reg_0,
      O => rx_frame_error_reg_1
    );
\boot_reply[1]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF6FFFFF"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(3),
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(2),
      I4 => phy_rx_valid,
      O => \boot_state_reg[3]\
    );
boot_reply_pending_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FECE000000000000"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \^phy_rx_frame_error\,
      I2 => boot_reply_pending_i_2_n_0,
      I3 => boot_reply_pending22_out,
      I4 => s_axi_aresetn,
      I5 => boot_reply_pending_reg_0,
      O => boot_reply_pending_reg
    );
boot_reply_pending_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF4000FFFF4004"
    )
        port map (
      I0 => boot_reply_pending_i_4_n_0,
      I1 => \boot_state_reg[0]_2\(0),
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => boot_reply_pending_i_5_n_0,
      I5 => \^rx_data_reg[1]_0\,
      O => boot_reply_pending_i_2_n_0
    );
boot_reply_pending_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C00000000000400"
    )
        port map (
      I0 => \^rx_data_reg[1]_0\,
      I1 => phy_rx_valid,
      I2 => \boot_state_reg[0]_2\(2),
      I3 => \boot_state_reg[0]_2\(0),
      I4 => \boot_state_reg[0]_2\(1),
      I5 => \boot_state_reg[0]_2\(3),
      O => boot_reply_pending22_out
    );
boot_reply_pending_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(2),
      I1 => phy_rx_valid,
      O => boot_reply_pending_i_4_n_0
    );
boot_reply_pending_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => tx_state(0),
      I2 => tx_state(1),
      O => boot_reply_pending_i_5_n_0
    );
\boot_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BEBEBEAE"
    )
        port map (
      I0 => \boot_state[1]_i_2_n_0\,
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      I3 => \boot_state_reg[0]_2\(2),
      I4 => \boot_state_reg[0]_2\(3),
      O => \boot_state_reg[1]\(0)
    );
\boot_state[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \^rx_data_reg[1]_0\,
      I1 => \boot_state_reg[0]_2\(1),
      I2 => \boot_state_reg[0]_2\(0),
      O => \boot_state[1]_i_2_n_0\
    );
\boot_state[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => \^phy_rx_frame_error\,
      I1 => s_axi_aresetn,
      I2 => boot_reply_pending_reg_0,
      O => \^rx_frame_error_reg_0\(0)
    );
\boot_state[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAA8AAAA"
    )
        port map (
      I0 => phy_rx_valid,
      I1 => \boot_state_reg[0]_2\(0),
      I2 => \boot_state_reg[0]_2\(2),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state[3]_i_4_n_0\,
      O => rx_valid_reg_0(0)
    );
\boot_state[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4555555555555555"
    )
        port map (
      I0 => \boot_state_reg[0]_2\(1),
      I1 => \boot_state[3]_i_5_n_0\,
      I2 => \^rx_data_reg[7]_0\(6),
      I3 => \^rx_data_reg[7]_0\(4),
      I4 => \^rx_data_reg[7]_0\(2),
      I5 => \^rx_data_reg[7]_0\(0),
      O => \boot_state[3]_i_4_n_0\
    );
\boot_state[3]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(7),
      I1 => \^rx_data_reg[7]_0\(5),
      I2 => \^rx_data_reg[7]_0\(3),
      I3 => \^rx_data_reg[7]_0\(1),
      O => \boot_state[3]_i_5_n_0\
    );
\bram_addr_reg[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000080000000000"
    )
        port map (
      I0 => \bram_din_reg_reg[0]\,
      I1 => \bram_din_reg_reg[0]_0\,
      I2 => \^boot_checksum_reg[7]\,
      I3 => boot_reply_pending_reg_0,
      I4 => \^phy_rx_frame_error\,
      I5 => phy_rx_valid,
      O => boot_active_reg_0(0)
    );
bram_en_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F7FF"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => boot_reply_pending_reg_0,
      I2 => \^phy_rx_frame_error\,
      I3 => phy_rx_valid,
      O => \^bram_en_reg\
    );
bram_en_reg_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008000"
    )
        port map (
      I0 => \bram_din_reg_reg[0]\,
      I1 => \boot_state_reg[0]_2\(0),
      I2 => \boot_state_reg[0]_2\(3),
      I3 => \boot_state_reg[0]_2\(1),
      I4 => \^boot_checksum_reg[7]\,
      O => \boot_state_reg[0]_1\
    );
bram_en_reg_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBEFFFFBE"
    )
        port map (
      I0 => bram_en_reg_i_6_n_0,
      I1 => \boot_checksum_reg[7]_0\(7),
      I2 => \^rx_data_reg[7]_0\(7),
      I3 => \boot_checksum_reg[7]_0\(3),
      I4 => \^rx_data_reg[7]_0\(3),
      I5 => bram_en_reg_i_7_n_0,
      O => \^boot_checksum_reg[7]\
    );
bram_en_reg_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(2),
      I1 => \^rx_data_reg[7]_0\(2),
      I2 => \boot_checksum_reg[7]_0\(6),
      I3 => \^rx_data_reg[7]_0\(6),
      O => bram_en_reg_i_6_n_0
    );
bram_en_reg_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \^rx_data_reg[7]_0\(1),
      I1 => \boot_checksum_reg[7]_0\(1),
      I2 => \^rx_data_reg[7]_0\(5),
      I3 => \boot_checksum_reg[7]_0\(5),
      I4 => bram_en_reg_i_8_n_0,
      O => bram_en_reg_i_7_n_0
    );
bram_en_reg_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => \boot_checksum_reg[7]_0\(0),
      I1 => \^rx_data_reg[7]_0\(0),
      I2 => \boot_checksum_reg[7]_0\(4),
      I3 => \^rx_data_reg[7]_0\(4),
      O => bram_en_reg_i_8_n_0
    );
\bram_we_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => \bram_din_reg_reg[0]\,
      I2 => \bram_din_reg_reg[0]_0\,
      I3 => \^boot_checksum_reg[7]\,
      I4 => boot_reply_pending_reg_0,
      I5 => \bram_we_reg[3]_i_3_n_0\,
      O => s_axi_aresetn_0
    );
\bram_we_reg[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => phy_rx_valid,
      I1 => \^phy_rx_frame_error\,
      O => \bram_we_reg[3]_i_3_n_0\
    );
frame_error_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DC"
    )
        port map (
      I0 => overrun_error_reg_0,
      I1 => \^phy_rx_frame_error\,
      I2 => frame_error,
      O => axi_error_clear_reg
    );
\npu_address[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
        port map (
      I0 => \npu_data_reg[0]\,
      I1 => \^boot_checksum_reg[7]\,
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => \^bram_en_reg\,
      O => \boot_state_reg[1]_0\(0)
    );
npu_i_we_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000000000000000"
    )
        port map (
      I0 => \npu_data_reg[0]\,
      I1 => \^boot_checksum_reg[7]\,
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => npu_i_we_reg,
      O => \boot_state_reg[1]_3\
    );
npu_s_we_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000000000000000"
    )
        port map (
      I0 => \npu_data_reg[0]\,
      I1 => \^boot_checksum_reg[7]\,
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => npu_s_we_reg,
      O => \boot_state_reg[1]_1\
    );
npu_w_we_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
        port map (
      I0 => \npu_data_reg[0]\,
      I1 => \^boot_checksum_reg[7]\,
      I2 => \boot_state_reg[0]_2\(1),
      I3 => \boot_state_reg[0]_2\(3),
      I4 => \boot_state_reg[0]_2\(0),
      I5 => npu_w_we_reg,
      O => \boot_state_reg[1]_2\
    );
overrun_error_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8C88"
    )
        port map (
      I0 => overrun_error_i_2_n_0,
      I1 => s_axi_aresetn,
      I2 => overrun_error_reg_0,
      I3 => overrun_error,
      O => s_axi_aresetn_1
    );
overrun_error_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => phy_rx_valid,
      I1 => boot_reply_pending_reg_0,
      I2 => Q(4),
      I3 => overrun_error_reg,
      O => overrun_error_i_2_n_0
    );
\rx_bit_index[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4FE0"
    )
        port map (
      I0 => rx_state(1),
      I1 => uart_rx,
      I2 => rx_bit_index(0),
      I3 => \rx_bit_index_reg_n_0_[0]\,
      O => \rx_bit_index[0]_i_1_n_0\
    );
\rx_bit_index[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5CFFAC00"
    )
        port map (
      I0 => \rx_bit_index_reg_n_0_[0]\,
      I1 => uart_rx,
      I2 => rx_state(1),
      I3 => rx_bit_index(0),
      I4 => \rx_bit_index_reg_n_0_[1]\,
      O => \rx_bit_index[1]_i_1_n_0\
    );
\rx_bit_index[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000F003000050030"
    )
        port map (
      I0 => \rx_bit_index_reg_n_0_[2]\,
      I1 => uart_rx,
      I2 => rx_state(0),
      I3 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I4 => rx_state(1),
      I5 => \FSM_sequential_rx_state[0]_i_2_n_0\,
      O => rx_bit_index(0)
    );
\rx_bit_index[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAA8AAAAFAA8A"
    )
        port map (
      I0 => \rx_bit_index_reg_n_0_[2]\,
      I1 => uart_rx,
      I2 => rx_state(0),
      I3 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I4 => rx_state(1),
      I5 => \FSM_sequential_rx_state[0]_i_2_n_0\,
      O => \rx_bit_index[2]_i_1_n_0\
    );
\rx_bit_index_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_bit_index[0]_i_1_n_0\,
      Q => \rx_bit_index_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\rx_bit_index_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_bit_index[1]_i_1_n_0\,
      Q => \rx_bit_index_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\rx_bit_index_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_bit_index[2]_i_1_n_0\,
      Q => \rx_bit_index_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\rx_clk_count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => rx_state(1),
      I1 => rx_state(0),
      I2 => \rx_clk_count_reg_n_0_[0]\,
      O => rx_clk_count(0)
    );
\rx_clk_count[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1717FF"
    )
        port map (
      I0 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I1 => rx_state(0),
      I2 => rx_state(1),
      I3 => \rx_clk_count_reg_n_0_[1]\,
      I4 => \rx_clk_count_reg_n_0_[0]\,
      O => rx_clk_count(1)
    );
\rx_clk_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E800E800E80000E8"
    )
        port map (
      I0 => rx_state(0),
      I1 => rx_state(1),
      I2 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I3 => \rx_clk_count_reg_n_0_[2]\,
      I4 => \rx_clk_count_reg_n_0_[0]\,
      I5 => \rx_clk_count_reg_n_0_[1]\,
      O => rx_clk_count(2)
    );
\rx_clk_count[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888882"
    )
        port map (
      I0 => \rx_clk_count[3]_i_2_n_0\,
      I1 => \rx_clk_count_reg_n_0_[3]\,
      I2 => \rx_clk_count_reg_n_0_[1]\,
      I3 => \rx_clk_count_reg_n_0_[0]\,
      I4 => \rx_clk_count_reg_n_0_[2]\,
      O => rx_clk_count(3)
    );
\rx_clk_count[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E8"
    )
        port map (
      I0 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I1 => rx_state(1),
      I2 => rx_state(0),
      O => \rx_clk_count[3]_i_2_n_0\
    );
\rx_clk_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"999090FF"
    )
        port map (
      I0 => \rx_clk_count[4]_i_2_n_0\,
      I1 => \rx_clk_count_reg_n_0_[4]\,
      I2 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I3 => rx_state(1),
      I4 => rx_state(0),
      O => rx_clk_count(4)
    );
\rx_clk_count[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[2]\,
      I1 => \rx_clk_count_reg_n_0_[0]\,
      I2 => \rx_clk_count_reg_n_0_[1]\,
      I3 => \rx_clk_count_reg_n_0_[3]\,
      O => \rx_clk_count[4]_i_2_n_0\
    );
\rx_clk_count[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1717FF"
    )
        port map (
      I0 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I1 => rx_state(0),
      I2 => rx_state(1),
      I3 => \rx_clk_count_reg_n_0_[5]\,
      I4 => \rx_clk_count[5]_i_2_n_0\,
      O => rx_clk_count(5)
    );
\rx_clk_count[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[3]\,
      I1 => \rx_clk_count_reg_n_0_[1]\,
      I2 => \rx_clk_count_reg_n_0_[0]\,
      I3 => \rx_clk_count_reg_n_0_[2]\,
      I4 => \rx_clk_count_reg_n_0_[4]\,
      O => \rx_clk_count[5]_i_2_n_0\
    );
\rx_clk_count[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"999F90F0"
    )
        port map (
      I0 => \rx_clk_count[8]_i_2_n_0\,
      I1 => \rx_clk_count_reg_n_0_[6]\,
      I2 => rx_state(0),
      I3 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I4 => rx_state(1),
      O => rx_clk_count(6)
    );
\rx_clk_count[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E1E1E100E100FFFF"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[6]\,
      I1 => \rx_clk_count[8]_i_2_n_0\,
      I2 => \rx_clk_count_reg_n_0_[7]\,
      I3 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I4 => rx_state(1),
      I5 => rx_state(0),
      O => rx_clk_count(7)
    );
\rx_clk_count[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFEFF010101FF"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[6]\,
      I1 => \rx_clk_count[8]_i_2_n_0\,
      I2 => \rx_clk_count_reg_n_0_[7]\,
      I3 => rx_state(0),
      I4 => rx_state(1),
      I5 => \rx_clk_count_reg_n_0_[8]\,
      O => rx_clk_count(8)
    );
\rx_clk_count[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[4]\,
      I1 => \rx_clk_count_reg_n_0_[2]\,
      I2 => \rx_clk_count_reg_n_0_[0]\,
      I3 => \rx_clk_count_reg_n_0_[1]\,
      I4 => \rx_clk_count_reg_n_0_[3]\,
      I5 => \rx_clk_count_reg_n_0_[5]\,
      O => \rx_clk_count[8]_i_2_n_0\
    );
\rx_clk_count[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB1B"
    )
        port map (
      I0 => rx_state(1),
      I1 => uart_rx,
      I2 => rx_state(0),
      I3 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      O => rx_clk_count_1(0)
    );
\rx_clk_count[9]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C382"
    )
        port map (
      I0 => rx_state(0),
      I1 => \rx_clk_count[9]_i_3_n_0\,
      I2 => \rx_clk_count_reg_n_0_[9]\,
      I3 => rx_state(1),
      O => rx_clk_count(9)
    );
\rx_clk_count[9]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \rx_clk_count_reg_n_0_[7]\,
      I1 => \rx_clk_count[8]_i_2_n_0\,
      I2 => \rx_clk_count_reg_n_0_[6]\,
      I3 => \rx_clk_count_reg_n_0_[8]\,
      O => \rx_clk_count[9]_i_3_n_0\
    );
\rx_clk_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(0),
      Q => \rx_clk_count_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(1),
      Q => \rx_clk_count_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(2),
      Q => \rx_clk_count_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(3),
      Q => \rx_clk_count_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(4),
      Q => \rx_clk_count_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(5),
      Q => \rx_clk_count_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(6),
      Q => \rx_clk_count_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(7),
      Q => \rx_clk_count_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(8),
      Q => \rx_clk_count_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\rx_clk_count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_clk_count_1(0),
      D => rx_clk_count(9),
      Q => \rx_clk_count_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\rx_count[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFB00040004FFFB"
    )
        port map (
      I0 => Q(4),
      I1 => phy_rx_valid,
      I2 => boot_reply_pending_reg_0,
      I3 => rx_rd_ptr0,
      I4 => Q(0),
      I5 => Q(1),
      O => D(0)
    );
\rx_count[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFF1100E"
    )
        port map (
      I0 => rx_rd_ptr0,
      I1 => \rx_count[3]_i_2_n_0\,
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(2),
      O => D(1)
    );
\rx_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFF1000FFF1000E"
    )
        port map (
      I0 => rx_rd_ptr0,
      I1 => \rx_count[3]_i_2_n_0\,
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(3),
      I5 => Q(2),
      O => D(2)
    );
\rx_count[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => Q(4),
      I1 => phy_rx_valid,
      I2 => boot_reply_pending_reg_0,
      O => \rx_count[3]_i_2_n_0\
    );
\rx_count[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA9A"
    )
        port map (
      I0 => rx_rd_ptr0,
      I1 => boot_reply_pending_reg_0,
      I2 => phy_rx_valid,
      I3 => Q(4),
      O => E(0)
    );
\rx_count[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAA9"
    )
        port map (
      I0 => Q(4),
      I1 => Q(3),
      I2 => \rx_count[4]_i_3_n_0\,
      I3 => Q(1),
      I4 => Q(0),
      I5 => Q(2),
      O => D(3)
    );
\rx_count[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
        port map (
      I0 => rx_rd_ptr0,
      I1 => boot_reply_pending_reg_0,
      I2 => phy_rx_valid,
      I3 => Q(4),
      O => \rx_count[4]_i_3_n_0\
    );
\rx_data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => uart_rx,
      I1 => rx_state(1),
      I2 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I3 => rx_state(0),
      O => \rx_data[7]_i_1_n_0\
    );
\rx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[0]\,
      Q => \^rx_data_reg[7]_0\(0),
      R => \^sr\(0)
    );
\rx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[1]\,
      Q => \^rx_data_reg[7]_0\(1),
      R => \^sr\(0)
    );
\rx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[2]\,
      Q => \^rx_data_reg[7]_0\(2),
      R => \^sr\(0)
    );
\rx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[3]\,
      Q => \^rx_data_reg[7]_0\(3),
      R => \^sr\(0)
    );
\rx_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[4]\,
      Q => \^rx_data_reg[7]_0\(4),
      R => \^sr\(0)
    );
\rx_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[5]\,
      Q => \^rx_data_reg[7]_0\(5),
      R => \^sr\(0)
    );
\rx_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[6]\,
      Q => \^rx_data_reg[7]_0\(6),
      R => \^sr\(0)
    );
\rx_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \rx_data[7]_i_1_n_0\,
      D => \rx_shift_reg_n_0_[7]\,
      Q => \^rx_data_reg[7]_0\(7),
      R => \^sr\(0)
    );
rx_fifo_reg_0_15_0_5_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00040000"
    )
        port map (
      I0 => Q(4),
      I1 => phy_rx_valid,
      I2 => boot_reply_pending_reg_0,
      I3 => overrun_error_reg,
      I4 => s_axi_aresetn,
      O => p_0_in
    );
rx_frame_error_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => uart_rx,
      I1 => rx_state(1),
      I2 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I3 => rx_state(0),
      O => rx_frame_error_i_1_n_0
    );
rx_frame_error_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => rx_frame_error_i_1_n_0,
      Q => \^phy_rx_frame_error\,
      R => \^sr\(0)
    );
\rx_shift[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFF0200"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[1]\,
      I2 => \rx_bit_index_reg_n_0_[0]\,
      I3 => \rx_shift[3]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[0]\,
      O => \rx_shift[0]_i_1_n_0\
    );
\rx_shift[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[1]\,
      I2 => \rx_bit_index_reg_n_0_[0]\,
      I3 => \rx_shift[3]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[1]\,
      O => \rx_shift[1]_i_1_n_0\
    );
\rx_shift[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[0]\,
      I2 => \rx_bit_index_reg_n_0_[1]\,
      I3 => \rx_shift[3]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[2]\,
      O => \rx_shift[2]_i_1_n_0\
    );
\rx_shift[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF8000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_shift[3]_i_2_n_0\,
      I2 => \rx_bit_index_reg_n_0_[1]\,
      I3 => \rx_bit_index_reg_n_0_[0]\,
      I4 => \rx_shift_reg_n_0_[3]\,
      O => \rx_shift[3]_i_1_n_0\
    );
\rx_shift[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => rx_state(1),
      I1 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I2 => rx_state(0),
      I3 => \rx_bit_index_reg_n_0_[2]\,
      O => \rx_shift[3]_i_2_n_0\
    );
\rx_shift[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFF0200"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[1]\,
      I2 => \rx_bit_index_reg_n_0_[0]\,
      I3 => \rx_shift[7]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[4]\,
      O => \rx_shift[4]_i_1_n_0\
    );
\rx_shift[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[1]\,
      I2 => \rx_bit_index_reg_n_0_[0]\,
      I3 => \rx_shift[7]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[5]\,
      O => \rx_shift[5]_i_1_n_0\
    );
\rx_shift[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFF2000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_bit_index_reg_n_0_[0]\,
      I2 => \rx_bit_index_reg_n_0_[1]\,
      I3 => \rx_shift[7]_i_2_n_0\,
      I4 => \rx_shift_reg_n_0_[6]\,
      O => \rx_shift[6]_i_1_n_0\
    );
\rx_shift[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF8000"
    )
        port map (
      I0 => uart_rx,
      I1 => \rx_shift[7]_i_2_n_0\,
      I2 => \rx_bit_index_reg_n_0_[1]\,
      I3 => \rx_bit_index_reg_n_0_[0]\,
      I4 => \rx_shift_reg_n_0_[7]\,
      O => \rx_shift[7]_i_1_n_0\
    );
\rx_shift[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0200"
    )
        port map (
      I0 => rx_state(1),
      I1 => \FSM_sequential_rx_state[1]_i_2_n_0\,
      I2 => rx_state(0),
      I3 => \rx_bit_index_reg_n_0_[2]\,
      O => \rx_shift[7]_i_2_n_0\
    );
\rx_shift_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[0]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\rx_shift_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[1]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\rx_shift_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[2]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\rx_shift_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[3]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\rx_shift_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[4]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\rx_shift_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[5]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\rx_shift_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[6]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\rx_shift_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_shift[7]_i_1_n_0\,
      Q => \rx_shift_reg_n_0_[7]\,
      R => \^sr\(0)
    );
rx_valid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rx_data[7]_i_1_n_0\,
      Q => phy_rx_valid,
      R => \^sr\(0)
    );
\rx_wr_ptr[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => boot_reply_pending_reg_0,
      I1 => phy_rx_valid,
      I2 => Q(4),
      O => boot_active_reg(0)
    );
\tx_bit_index[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"338A308A308A308A"
    )
        port map (
      I0 => tx_state(1),
      I1 => \tx_bit_index[2]_i_2_n_0\,
      I2 => \FSM_sequential_tx_state[1]_i_2_n_0\,
      I3 => \tx_bit_index_reg_n_0_[0]\,
      I4 => \tx_bit_index_reg_n_0_[1]\,
      I5 => \tx_bit_index_reg_n_0_[2]\,
      O => \tx_bit_index[0]_i_1_n_0\
    );
\tx_bit_index[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33BA8A0030BA8A00"
    )
        port map (
      I0 => tx_state(1),
      I1 => \tx_bit_index[2]_i_2_n_0\,
      I2 => \FSM_sequential_tx_state[1]_i_2_n_0\,
      I3 => \tx_bit_index_reg_n_0_[0]\,
      I4 => \tx_bit_index_reg_n_0_[1]\,
      I5 => \tx_bit_index_reg_n_0_[2]\,
      O => \tx_bit_index[1]_i_1_n_0\
    );
\tx_bit_index[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33BABABA8A000000"
    )
        port map (
      I0 => tx_state(1),
      I1 => \tx_bit_index[2]_i_2_n_0\,
      I2 => \FSM_sequential_tx_state[1]_i_2_n_0\,
      I3 => \tx_bit_index_reg_n_0_[0]\,
      I4 => \tx_bit_index_reg_n_0_[1]\,
      I5 => \tx_bit_index_reg_n_0_[2]\,
      O => \tx_bit_index[2]_i_1_n_0\
    );
\tx_bit_index[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => uart_tx_reg_i_5_n_0,
      I1 => tx_state(0),
      I2 => tx_state(1),
      O => \tx_bit_index[2]_i_2_n_0\
    );
\tx_bit_index_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \tx_bit_index[0]_i_1_n_0\,
      Q => \tx_bit_index_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\tx_bit_index_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \tx_bit_index[1]_i_1_n_0\,
      Q => \tx_bit_index_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\tx_bit_index_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \tx_bit_index[2]_i_1_n_0\,
      Q => \tx_bit_index_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\tx_clk_count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"57"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[0]\,
      I1 => tx_state(0),
      I2 => tx_state(1),
      O => tx_clk_count(0)
    );
\tx_clk_count[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"999F"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[1]\,
      I1 => \tx_clk_count_reg_n_0_[0]\,
      I2 => tx_state(1),
      I3 => tx_state(0),
      O => tx_clk_count(1)
    );
\tx_clk_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC888800004404"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[0]\,
      I1 => \tx_clk_count[9]_i_3_n_0\,
      I2 => \tx_clk_count[3]_i_2_n_0\,
      I3 => \tx_clk_count[2]_i_2_n_0\,
      I4 => \tx_clk_count_reg_n_0_[1]\,
      I5 => \tx_clk_count_reg_n_0_[2]\,
      O => tx_clk_count(2)
    );
\tx_clk_count[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[5]\,
      I1 => \tx_clk_count_reg_n_0_[4]\,
      I2 => \tx_clk_count_reg_n_0_[3]\,
      O => \tx_clk_count[2]_i_2_n_0\
    );
\tx_clk_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA80000AAA80002"
    )
        port map (
      I0 => \tx_clk_count[9]_i_3_n_0\,
      I1 => \tx_clk_count_reg_n_0_[0]\,
      I2 => \tx_clk_count_reg_n_0_[2]\,
      I3 => \tx_clk_count_reg_n_0_[1]\,
      I4 => \tx_clk_count_reg_n_0_[3]\,
      I5 => \tx_clk_count[3]_i_2_n_0\,
      O => tx_clk_count(3)
    );
\tx_clk_count[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"07"
    )
        port map (
      I0 => tx_state(0),
      I1 => tx_state(1),
      I2 => \tx_clk_count[4]_i_2_n_0\,
      O => \tx_clk_count[3]_i_2_n_0\
    );
\tx_clk_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E80000E8"
    )
        port map (
      I0 => tx_state(0),
      I1 => tx_state(1),
      I2 => \tx_clk_count[4]_i_2_n_0\,
      I3 => \tx_clk_count[5]_i_2_n_0\,
      I4 => \tx_clk_count_reg_n_0_[4]\,
      O => tx_clk_count(4)
    );
\tx_clk_count[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[8]\,
      I1 => \tx_clk_count_reg_n_0_[9]\,
      I2 => \tx_clk_count_reg_n_0_[6]\,
      I3 => \tx_clk_count_reg_n_0_[7]\,
      I4 => \tx_clk_count_reg_n_0_[4]\,
      I5 => \tx_clk_count_reg_n_0_[5]\,
      O => \tx_clk_count[4]_i_2_n_0\
    );
\tx_clk_count[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A9A9A9FF"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[5]\,
      I1 => \tx_clk_count_reg_n_0_[4]\,
      I2 => \tx_clk_count[5]_i_2_n_0\,
      I3 => tx_state(1),
      I4 => tx_state(0),
      O => tx_clk_count(5)
    );
\tx_clk_count[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[3]\,
      I1 => \tx_clk_count_reg_n_0_[1]\,
      I2 => \tx_clk_count_reg_n_0_[2]\,
      I3 => \tx_clk_count_reg_n_0_[0]\,
      O => \tx_clk_count[5]_i_2_n_0\
    );
\tx_clk_count[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EB"
    )
        port map (
      I0 => \tx_clk_count[8]_i_2_n_0\,
      I1 => \tx_clk_count[9]_i_4_n_0\,
      I2 => \tx_clk_count_reg_n_0_[6]\,
      O => tx_clk_count(6)
    );
\tx_clk_count[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E1"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[6]\,
      I1 => \tx_clk_count[9]_i_4_n_0\,
      I2 => \tx_clk_count_reg_n_0_[7]\,
      I3 => \tx_clk_count[8]_i_2_n_0\,
      O => tx_clk_count(7)
    );
\tx_clk_count[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEAAAB"
    )
        port map (
      I0 => \tx_clk_count[8]_i_2_n_0\,
      I1 => \tx_clk_count[9]_i_4_n_0\,
      I2 => \tx_clk_count_reg_n_0_[6]\,
      I3 => \tx_clk_count_reg_n_0_[7]\,
      I4 => \tx_clk_count_reg_n_0_[8]\,
      O => tx_clk_count(8)
    );
\tx_clk_count[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00A20000FFFFFFFF"
    )
        port map (
      I0 => \tx_clk_count[8]_i_3_n_0\,
      I1 => \tx_clk_count_reg_n_0_[3]\,
      I2 => \tx_clk_count_reg_n_0_[4]\,
      I3 => \tx_clk_count_reg_n_0_[5]\,
      I4 => \tx_clk_count[3]_i_2_n_0\,
      I5 => \tx_clk_count[9]_i_3_n_0\,
      O => \tx_clk_count[8]_i_2_n_0\
    );
\tx_clk_count[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[0]\,
      I1 => \tx_clk_count_reg_n_0_[2]\,
      I2 => \tx_clk_count_reg_n_0_[1]\,
      O => \tx_clk_count[8]_i_3_n_0\
    );
\tx_clk_count[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FFFFA3FFFFFFA3"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \^tx_count_reg[4]_0\,
      I2 => boot_reply_pending_reg_0,
      I3 => tx_state(1),
      I4 => tx_state(0),
      I5 => uart_tx_reg_i_5_n_0,
      O => tx_clk_count_0(0)
    );
\tx_clk_count[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFD55555557"
    )
        port map (
      I0 => \tx_clk_count[9]_i_3_n_0\,
      I1 => \tx_clk_count_reg_n_0_[6]\,
      I2 => \tx_clk_count[9]_i_4_n_0\,
      I3 => \tx_clk_count_reg_n_0_[8]\,
      I4 => \tx_clk_count_reg_n_0_[7]\,
      I5 => \tx_clk_count_reg_n_0_[9]\,
      O => tx_clk_count(9)
    );
\tx_clk_count[9]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => tx_state(1),
      I1 => tx_state(0),
      O => \tx_clk_count[9]_i_3_n_0\
    );
\tx_clk_count[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \tx_clk_count_reg_n_0_[5]\,
      I1 => \tx_clk_count_reg_n_0_[4]\,
      I2 => \tx_clk_count_reg_n_0_[0]\,
      I3 => \tx_clk_count_reg_n_0_[2]\,
      I4 => \tx_clk_count_reg_n_0_[1]\,
      I5 => \tx_clk_count_reg_n_0_[3]\,
      O => \tx_clk_count[9]_i_4_n_0\
    );
\tx_clk_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(0),
      Q => \tx_clk_count_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(1),
      Q => \tx_clk_count_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(2),
      Q => \tx_clk_count_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(3),
      Q => \tx_clk_count_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(4),
      Q => \tx_clk_count_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(5),
      Q => \tx_clk_count_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(6),
      Q => \tx_clk_count_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(7),
      Q => \tx_clk_count_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(8),
      Q => \tx_clk_count_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\tx_clk_count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_clk_count_0(0),
      D => tx_clk_count(9),
      Q => \tx_clk_count_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\tx_count[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FD0202FD"
    )
        port map (
      I0 => \tx_count_reg[0]_0\,
      I1 => \tx_count_reg[0]\(4),
      I2 => \^tx_rd_ptr0\,
      I3 => \tx_count_reg[0]\(0),
      I4 => \tx_count_reg[0]\(1),
      O => \tx_count_reg[4]\(0)
    );
\tx_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A9AAAAAAAAAA5655"
    )
        port map (
      I0 => \tx_count_reg[0]\(2),
      I1 => \^tx_rd_ptr0\,
      I2 => \tx_count_reg[0]\(4),
      I3 => \tx_count_reg[0]_0\,
      I4 => \tx_count_reg[0]\(1),
      I5 => \tx_count_reg[0]\(0),
      O => \tx_count_reg[4]\(1)
    );
\tx_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFF4000FFF4000B"
    )
        port map (
      I0 => \^tx_rd_ptr0\,
      I1 => \tx_count_reg[3]\(0),
      I2 => \tx_count_reg[0]\(1),
      I3 => \tx_count_reg[0]\(0),
      I4 => \tx_count_reg[0]\(3),
      I5 => \tx_count_reg[0]\(2),
      O => \tx_count_reg[4]\(2)
    );
\tx_count[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"444444444444444B"
    )
        port map (
      I0 => \tx_count_reg[0]\(4),
      I1 => \tx_count_reg[0]_0\,
      I2 => tx_state(1),
      I3 => tx_state(0),
      I4 => boot_reply_pending_reg_0,
      I5 => \^tx_count_reg[4]_0\,
      O => \tx_count_reg[4]_1\(0)
    );
\tx_count[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A6AAAAAAAAAAAA9A"
    )
        port map (
      I0 => \tx_count_reg[0]\(4),
      I1 => \tx_count_reg[0]\(3),
      I2 => \tx_count[4]_i_3_n_0\,
      I3 => \tx_count_reg[0]\(1),
      I4 => \tx_count_reg[0]\(0),
      I5 => \tx_count_reg[0]\(2),
      O => \tx_count_reg[4]\(3)
    );
\tx_count[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0001FFFFFFFF"
    )
        port map (
      I0 => tx_state(1),
      I1 => tx_state(0),
      I2 => boot_reply_pending_reg_0,
      I3 => \^tx_count_reg[4]_0\,
      I4 => \tx_count_reg[0]\(4),
      I5 => \tx_count_reg[0]_0\,
      O => \tx_count[4]_i_3_n_0\
    );
\tx_rd_ptr_rep[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \^tx_count_reg[4]_0\,
      I1 => boot_reply_pending_reg_0,
      I2 => tx_state(0),
      I3 => tx_state(1),
      O => \^tx_rd_ptr0\
    );
\tx_shift[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80808F80"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \tx_shift_reg[4]_0\,
      I2 => boot_reply_pending_reg_0,
      I3 => phy_tx_data0(0),
      I4 => \^tx_count_reg[4]_0\,
      O => phy_tx_data(0)
    );
\tx_shift[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80808F80"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \tx_shift_reg[1]_0\,
      I2 => boot_reply_pending_reg_0,
      I3 => phy_tx_data0(1),
      I4 => \^tx_count_reg[4]_0\,
      O => phy_tx_data(1)
    );
\tx_shift[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88B8"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => boot_reply_pending_reg_0,
      I2 => phy_tx_data0(2),
      I3 => \^tx_count_reg[4]_0\,
      O => phy_tx_data(2)
    );
\tx_shift[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^tx_count_reg[4]_0\,
      I1 => phy_tx_data0(3),
      I2 => boot_reply_pending_reg_0,
      O => \tx_shift[3]_i_1_n_0\
    );
\tx_shift[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80808F80"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \tx_shift_reg[4]_0\,
      I2 => boot_reply_pending_reg_0,
      I3 => phy_tx_data0(4),
      I4 => \^tx_count_reg[4]_0\,
      O => phy_tx_data(4)
    );
\tx_shift[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^tx_count_reg[4]_0\,
      I1 => phy_tx_data0(5),
      I2 => boot_reply_pending_reg_0,
      O => \tx_shift[5]_i_1_n_0\
    );
\tx_shift[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^tx_count_reg[4]_0\,
      I1 => phy_tx_data0(6),
      I2 => boot_reply_pending_reg_0,
      O => \tx_shift[6]_i_1_n_0\
    );
\tx_shift[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10110001"
    )
        port map (
      I0 => tx_state(0),
      I1 => tx_state(1),
      I2 => boot_reply_pending_reg_0,
      I3 => \^tx_count_reg[4]_0\,
      I4 => boot_reply_pending_reg_1,
      O => \tx_shift[7]_i_1_n_0\
    );
\tx_shift[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^tx_count_reg[4]_0\,
      I1 => phy_tx_data0(7),
      I2 => boot_reply_pending_reg_0,
      O => \tx_shift[7]_i_2_n_0\
    );
\tx_shift_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => phy_tx_data(0),
      Q => \tx_shift_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\tx_shift_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => phy_tx_data(1),
      Q => \tx_shift_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\tx_shift_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => phy_tx_data(2),
      Q => data1,
      R => \^sr\(0)
    );
\tx_shift_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => \tx_shift[3]_i_1_n_0\,
      Q => data2,
      R => \^sr\(0)
    );
\tx_shift_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => phy_tx_data(4),
      Q => \tx_shift_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\tx_shift_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => \tx_shift[5]_i_1_n_0\,
      Q => data4,
      R => \^sr\(0)
    );
\tx_shift_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => \tx_shift[6]_i_1_n_0\,
      Q => data5,
      R => \^sr\(0)
    );
\tx_shift_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \tx_shift[7]_i_1_n_0\,
      D => \tx_shift[7]_i_2_n_0\,
      Q => data6,
      R => \^sr\(0)
    );
uart_irq_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \tx_count_reg[0]\(4),
      I1 => \tx_count_reg[0]\(2),
      I2 => \tx_count_reg[0]\(3),
      I3 => \tx_count_reg[0]\(1),
      I4 => \tx_count_reg[0]\(0),
      O => \^tx_count_reg[4]_0\
    );
uart_tx_reg_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_aresetn,
      O => \^sr\(0)
    );
uart_tx_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFDFCFCCD0D0C0CC"
    )
        port map (
      I0 => uart_tx_reg_i_3_n_0,
      I1 => uart_tx_reg_i_4_n_0,
      I2 => uart_tx_reg_i_5_n_0,
      I3 => tx_state(0),
      I4 => tx_state(1),
      I5 => \^uart_tx\,
      O => uart_tx_reg_i_2_n_0
    );
uart_tx_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00E2E2E2E2E2E2E2"
    )
        port map (
      I0 => uart_tx_reg_i_6_n_0,
      I1 => \tx_bit_index_reg_n_0_[0]\,
      I2 => uart_tx_reg_i_7_n_0,
      I3 => \tx_bit_index_reg_n_0_[1]\,
      I4 => data6,
      I5 => \tx_bit_index_reg_n_0_[2]\,
      O => uart_tx_reg_i_3_n_0
    );
uart_tx_reg_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF00005C005C"
    )
        port map (
      I0 => boot_reply_pending_reg_1,
      I1 => \^tx_count_reg[4]_0\,
      I2 => boot_reply_pending_reg_0,
      I3 => tx_state(1),
      I4 => \tx_shift_reg_n_0_[0]\,
      I5 => tx_state(0),
      O => uart_tx_reg_i_4_n_0
    );
uart_tx_reg_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \tx_clk_count[9]_i_4_n_0\,
      I1 => \tx_clk_count_reg_n_0_[6]\,
      I2 => \tx_clk_count_reg_n_0_[7]\,
      I3 => \tx_clk_count_reg_n_0_[8]\,
      I4 => \tx_clk_count_reg_n_0_[9]\,
      O => uart_tx_reg_i_5_n_0
    );
uart_tx_reg_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF0F5533"
    )
        port map (
      I0 => data4,
      I1 => \tx_shift_reg_n_0_[1]\,
      I2 => data2,
      I3 => \tx_bit_index_reg_n_0_[2]\,
      I4 => \tx_bit_index_reg_n_0_[1]\,
      O => uart_tx_reg_i_6_n_0
    );
uart_tx_reg_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00473347"
    )
        port map (
      I0 => data5,
      I1 => \tx_bit_index_reg_n_0_[2]\,
      I2 => data1,
      I3 => \tx_bit_index_reg_n_0_[1]\,
      I4 => \tx_shift_reg_n_0_[4]\,
      O => uart_tx_reg_i_7_n_0
    );
uart_tx_reg_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_tx_reg_i_2_n_0,
      Q => \^uart_tx\,
      S => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_uart_bootloader_1_0_axi_uart_bootloader is
  port (
    npu_boot_active : out STD_LOGIC;
    rvalid_reg_reg_0 : out STD_LOGIC;
    bvalid_reg_reg_0 : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    bram_en : out STD_LOGIC;
    bram_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    npu_scratchpad_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    npu_instr_din : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    uart_irq : out STD_LOGIC;
    npu_instr_we : out STD_LOGIC;
    npu_weight_we : out STD_LOGIC;
    npu_scratchpad_we : out STD_LOGIC;
    uart_tx : out STD_LOGIC;
    bram_we : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    npu_ready : in STD_LOGIC;
    uart_rx : in STD_LOGIC;
    boot_mode : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_axi_uart_bootloader_1_0_axi_uart_bootloader : entity is "axi_uart_bootloader";
end design_1_axi_uart_bootloader_1_0_axi_uart_bootloader;

architecture STRUCTURE of design_1_axi_uart_bootloader_1_0_axi_uart_bootloader is
  signal aw_hold : STD_LOGIC;
  signal aw_hold0 : STD_LOGIC;
  signal aw_hold_i_1_n_0 : STD_LOGIC;
  signal axi_error_clear : STD_LOGIC;
  signal axi_error_clear_i_2_n_0 : STD_LOGIC;
  signal axi_error_clear_reg_n_0 : STD_LOGIC;
  signal axi_rx_fifo_reset_i_1_n_0 : STD_LOGIC;
  signal axi_rx_fifo_reset_reg_n_0 : STD_LOGIC;
  signal axi_rx_pop : STD_LOGIC;
  signal axi_rx_pop1 : STD_LOGIC;
  signal axi_rx_pop_i_1_n_0 : STD_LOGIC;
  signal axi_tx_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \axi_tx_data__0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_tx_fifo_reset_i_1_n_0 : STD_LOGIC;
  signal axi_tx_fifo_reset_reg_n_0 : STD_LOGIC;
  signal axi_tx_push_i_1_n_0 : STD_LOGIC;
  signal axi_tx_push_reg_n_0 : STD_LOGIC;
  signal boot_address : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \boot_address__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal boot_checksum : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \boot_checksum[7]_i_3_n_0\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[0]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[1]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[2]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[3]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[4]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[5]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[6]\ : STD_LOGIC;
  signal \boot_checksum_reg_n_0_[7]\ : STD_LOGIC;
  signal boot_command : STD_LOGIC_VECTOR ( 7 downto 3 );
  signal boot_command_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \boot_command_reg_n_0_[0]\ : STD_LOGIC;
  signal \boot_command_reg_n_0_[1]\ : STD_LOGIC;
  signal \boot_command_reg_n_0_[2]\ : STD_LOGIC;
  signal boot_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal boot_data_2 : STD_LOGIC_VECTOR ( 31 downto 7 );
  signal boot_data_hi : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal boot_data_hi_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \boot_data_hi_reg_n_0_[4]\ : STD_LOGIC;
  signal \boot_data_hi_reg_n_0_[5]\ : STD_LOGIC;
  signal \boot_data_hi_reg_n_0_[6]\ : STD_LOGIC;
  signal \boot_data_hi_reg_n_0_[7]\ : STD_LOGIC;
  signal boot_meta : STD_LOGIC;
  signal \boot_reply[0]_i_1_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_10_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_11_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_1_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_2_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_4_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_5_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_6_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_8_n_0\ : STD_LOGIC;
  signal \boot_reply[1]_i_9_n_0\ : STD_LOGIC;
  signal boot_reply_pending_reg_n_0 : STD_LOGIC;
  signal \boot_reply_reg_n_0_[0]\ : STD_LOGIC;
  signal \boot_reply_reg_n_0_[1]\ : STD_LOGIC;
  signal \boot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \boot_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \boot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \boot_state[3]_i_3_n_0\ : STD_LOGIC;
  signal \boot_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \boot_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \boot_state_reg_n_0_[2]\ : STD_LOGIC;
  signal \boot_state_reg_n_0_[3]\ : STD_LOGIC;
  signal bram_addr_reg : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bram_en_reg : STD_LOGIC;
  signal bram_en_reg_i_3_n_0 : STD_LOGIC;
  signal bram_en_reg_i_5_n_0 : STD_LOGIC;
  signal \bram_we_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \bresp_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \bresp_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal bvalid_reg_i_1_n_0 : STD_LOGIC;
  signal \^bvalid_reg_reg_0\ : STD_LOGIC;
  signal frame_error : STD_LOGIC;
  signal irq_enable_reg : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \irq_enable_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal npu_address : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \npu_address[12]_i_2_n_0\ : STD_LOGIC;
  signal \^npu_boot_active\ : STD_LOGIC;
  signal npu_i_we_i_2_n_0 : STD_LOGIC;
  signal npu_i_we_i_3_n_0 : STD_LOGIC;
  signal npu_i_we_reg_n_0 : STD_LOGIC;
  signal npu_s_we_i_2_n_0 : STD_LOGIC;
  signal npu_s_we_i_3_n_0 : STD_LOGIC;
  signal npu_s_we_reg_n_0 : STD_LOGIC;
  signal npu_w_we_i_2_n_0 : STD_LOGIC;
  signal npu_w_we_i_3_n_0 : STD_LOGIC;
  signal npu_w_we_i_4_n_0 : STD_LOGIC;
  signal npu_w_we_i_5_n_0 : STD_LOGIC;
  signal npu_w_we_i_6_n_0 : STD_LOGIC;
  signal npu_w_we_i_7_n_0 : STD_LOGIC;
  signal npu_w_we_reg_n_0 : STD_LOGIC;
  signal out0 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal overrun_error : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal p_2_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal p_33_in : STD_LOGIC;
  signal p_5_in : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal phy_rx_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal phy_rx_frame_error : STD_LOGIC;
  signal phy_tx_data0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \rdata_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \rdata_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \rdata_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal \rdata_reg[1]_i_3_n_0\ : STD_LOGIC;
  signal \rdata_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal \rdata_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \rdata_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal \rdata_reg[6]_i_2_n_0\ : STD_LOGIC;
  signal \rdata_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_reg[7]_i_4_n_0\ : STD_LOGIC;
  signal \rresp_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal rvalid_reg_i_1_n_0 : STD_LOGIC;
  signal \^rvalid_reg_reg_0\ : STD_LOGIC;
  signal rx_count : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \rx_count[0]_i_1_n_0\ : STD_LOGIC;
  signal rx_count_reg : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal rx_rd_ptr : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rx_rd_ptr0 : STD_LOGIC;
  signal \rx_rd_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \rx_rd_ptr_rep[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr_rep[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr_rep[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_rd_ptr_rep[3]_i_2_n_0\ : STD_LOGIC;
  signal rx_wr_ptr : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \rx_wr_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_wr_ptr[3]_i_3_n_0\ : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_rresp\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal temp0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal tx_count : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \tx_count[0]_i_1_n_0\ : STD_LOGIC;
  signal tx_count_reg : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal tx_fifo_reg_0_15_0_5_i_1_n_0 : STD_LOGIC;
  signal tx_rd_ptr : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal tx_rd_ptr0 : STD_LOGIC;
  signal \tx_rd_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \tx_rd_ptr_rep[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr_rep[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr_rep[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_rd_ptr_rep[3]_i_2_n_0\ : STD_LOGIC;
  signal tx_wr_ptr : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal tx_wr_ptr0 : STD_LOGIC;
  signal \tx_wr_ptr[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_wr_ptr[3]_i_3_n_0\ : STD_LOGIC;
  signal uart_inst_n_1 : STD_LOGIC;
  signal uart_inst_n_10 : STD_LOGIC;
  signal uart_inst_n_11 : STD_LOGIC;
  signal uart_inst_n_12 : STD_LOGIC;
  signal uart_inst_n_21 : STD_LOGIC;
  signal uart_inst_n_24 : STD_LOGIC;
  signal uart_inst_n_26 : STD_LOGIC;
  signal uart_inst_n_28 : STD_LOGIC;
  signal uart_inst_n_29 : STD_LOGIC;
  signal uart_inst_n_3 : STD_LOGIC;
  signal uart_inst_n_30 : STD_LOGIC;
  signal uart_inst_n_31 : STD_LOGIC;
  signal uart_inst_n_32 : STD_LOGIC;
  signal uart_inst_n_33 : STD_LOGIC;
  signal uart_inst_n_34 : STD_LOGIC;
  signal uart_inst_n_35 : STD_LOGIC;
  signal uart_inst_n_36 : STD_LOGIC;
  signal uart_inst_n_37 : STD_LOGIC;
  signal uart_inst_n_4 : STD_LOGIC;
  signal uart_inst_n_42 : STD_LOGIC;
  signal uart_inst_n_44 : STD_LOGIC;
  signal uart_inst_n_46 : STD_LOGIC;
  signal uart_inst_n_47 : STD_LOGIC;
  signal uart_inst_n_48 : STD_LOGIC;
  signal uart_inst_n_5 : STD_LOGIC;
  signal uart_inst_n_50 : STD_LOGIC;
  signal uart_inst_n_51 : STD_LOGIC;
  signal uart_inst_n_52 : STD_LOGIC;
  signal uart_inst_n_53 : STD_LOGIC;
  signal uart_inst_n_55 : STD_LOGIC;
  signal uart_inst_n_56 : STD_LOGIC;
  signal uart_inst_n_6 : STD_LOGIC;
  signal uart_inst_n_61 : STD_LOGIC;
  signal uart_inst_n_62 : STD_LOGIC;
  signal uart_inst_n_7 : STD_LOGIC;
  signal uart_inst_n_8 : STD_LOGIC;
  signal uart_inst_n_9 : STD_LOGIC;
  signal uart_irq_INST_0_i_1_n_0 : STD_LOGIC;
  signal uart_irq_INST_0_i_3_n_0 : STD_LOGIC;
  signal w_hold0 : STD_LOGIC;
  signal w_hold_i_1_n_0 : STD_LOGIC;
  signal w_hold_reg_n_0 : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[0]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[1]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[2]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[3]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[4]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[5]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[6]\ : STD_LOGIC;
  signal \wdata_hold_reg_n_0_[7]\ : STD_LOGIC;
  signal \wstrb_hold_reg_n_0_[0]\ : STD_LOGIC;
  signal NLW_rx_fifo_reg_0_15_0_5_DOD_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_rx_fifo_reg_0_15_6_7_SPO_UNCONNECTED : STD_LOGIC;
  signal \NLW_rx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED\ : STD_LOGIC;
  signal NLW_tx_fifo_reg_0_15_0_5_DOD_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_tx_fifo_reg_0_15_6_7_SPO_UNCONNECTED : STD_LOGIC;
  signal \NLW_tx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of aw_hold_i_1 : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \boot_reply[1]_i_10\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \boot_state[0]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \boot_state[0]_i_2\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \boot_state[2]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \boot_state[3]_i_3\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \bram_we_reg[3]_i_2\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of bvalid_reg_i_1 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \irq_enable_reg[3]_i_2\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \npu_address[12]_i_2\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of npu_instr_we_INST_0 : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of npu_s_we_i_3 : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of npu_w_we_i_3 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of npu_w_we_i_7 : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of npu_weight_we_INST_0 : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \rdata_reg[1]_i_2\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \rdata_reg[3]_i_2\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \rdata_reg[4]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rdata_reg[5]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rdata_reg[6]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \rdata_reg[7]_i_3\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \rdata_reg[7]_i_4\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \rresp_reg[1]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \rresp_reg[1]_i_2\ : label is "soft_lutpair29";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of rx_fifo_reg_0_15_0_5 : label is "";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of rx_fifo_reg_0_15_0_5 : label is 128;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of rx_fifo_reg_0_15_0_5 : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg";
  attribute RTL_RAM_STYLE : string;
  attribute RTL_RAM_STYLE of rx_fifo_reg_0_15_0_5 : label is "auto";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of rx_fifo_reg_0_15_0_5 : label is "RAM_SDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of rx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of rx_fifo_reg_0_15_0_5 : label is 15;
  attribute ram_offset : integer;
  attribute ram_offset of rx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of rx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of rx_fifo_reg_0_15_0_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of rx_fifo_reg_0_15_6_7 : label is "";
  attribute RTL_RAM_BITS of rx_fifo_reg_0_15_6_7 : label is 128;
  attribute RTL_RAM_NAME of rx_fifo_reg_0_15_6_7 : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg_0_15_6_7";
  attribute RTL_RAM_STYLE of rx_fifo_reg_0_15_6_7 : label is "NONE";
  attribute RTL_RAM_TYPE of rx_fifo_reg_0_15_6_7 : label is "RAM_SDP";
  attribute ram_addr_begin of rx_fifo_reg_0_15_6_7 : label is 0;
  attribute ram_addr_end of rx_fifo_reg_0_15_6_7 : label is 15;
  attribute ram_offset of rx_fifo_reg_0_15_6_7 : label is 0;
  attribute ram_slice_begin of rx_fifo_reg_0_15_6_7 : label is 6;
  attribute ram_slice_end of rx_fifo_reg_0_15_6_7 : label is 6;
  attribute METHODOLOGY_DRC_VIOS of \rx_fifo_reg_0_15_6_7__0\ : label is "";
  attribute RTL_RAM_BITS of \rx_fifo_reg_0_15_6_7__0\ : label is 128;
  attribute RTL_RAM_NAME of \rx_fifo_reg_0_15_6_7__0\ : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg_0_15_6_7";
  attribute RTL_RAM_STYLE of \rx_fifo_reg_0_15_6_7__0\ : label is "NONE";
  attribute RTL_RAM_TYPE of \rx_fifo_reg_0_15_6_7__0\ : label is "RAM_SDP";
  attribute ram_addr_begin of \rx_fifo_reg_0_15_6_7__0\ : label is 0;
  attribute ram_addr_end of \rx_fifo_reg_0_15_6_7__0\ : label is 15;
  attribute ram_offset of \rx_fifo_reg_0_15_6_7__0\ : label is 0;
  attribute ram_slice_begin of \rx_fifo_reg_0_15_6_7__0\ : label is 7;
  attribute ram_slice_end of \rx_fifo_reg_0_15_6_7__0\ : label is 7;
  attribute SOFT_HLUTNM of \rx_rd_ptr[0]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \rx_rd_ptr[1]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \rx_rd_ptr[2]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \rx_rd_ptr[3]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \rx_rd_ptr_rep[0]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \rx_rd_ptr_rep[1]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \rx_rd_ptr_rep[2]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \rx_rd_ptr_rep[3]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \rx_wr_ptr[0]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \rx_wr_ptr[1]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \rx_wr_ptr[2]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \rx_wr_ptr[3]_i_3\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of s_axi_arready_INST_0 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of s_axi_awready_INST_0 : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of s_axi_wready_INST_0 : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \tx_count[0]_i_1\ : label is "soft_lutpair35";
  attribute METHODOLOGY_DRC_VIOS of tx_fifo_reg_0_15_0_5 : label is "";
  attribute RTL_RAM_BITS of tx_fifo_reg_0_15_0_5 : label is 128;
  attribute RTL_RAM_NAME of tx_fifo_reg_0_15_0_5 : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg";
  attribute RTL_RAM_STYLE of tx_fifo_reg_0_15_0_5 : label is "auto";
  attribute RTL_RAM_TYPE of tx_fifo_reg_0_15_0_5 : label is "RAM_SDP";
  attribute ram_addr_begin of tx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_addr_end of tx_fifo_reg_0_15_0_5 : label is 15;
  attribute ram_offset of tx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_slice_begin of tx_fifo_reg_0_15_0_5 : label is 0;
  attribute ram_slice_end of tx_fifo_reg_0_15_0_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of tx_fifo_reg_0_15_6_7 : label is "";
  attribute RTL_RAM_BITS of tx_fifo_reg_0_15_6_7 : label is 128;
  attribute RTL_RAM_NAME of tx_fifo_reg_0_15_6_7 : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg_0_15_6_7";
  attribute RTL_RAM_STYLE of tx_fifo_reg_0_15_6_7 : label is "NONE";
  attribute RTL_RAM_TYPE of tx_fifo_reg_0_15_6_7 : label is "RAM_SDP";
  attribute ram_addr_begin of tx_fifo_reg_0_15_6_7 : label is 0;
  attribute ram_addr_end of tx_fifo_reg_0_15_6_7 : label is 15;
  attribute ram_offset of tx_fifo_reg_0_15_6_7 : label is 0;
  attribute ram_slice_begin of tx_fifo_reg_0_15_6_7 : label is 6;
  attribute ram_slice_end of tx_fifo_reg_0_15_6_7 : label is 6;
  attribute METHODOLOGY_DRC_VIOS of \tx_fifo_reg_0_15_6_7__0\ : label is "";
  attribute RTL_RAM_BITS of \tx_fifo_reg_0_15_6_7__0\ : label is 128;
  attribute RTL_RAM_NAME of \tx_fifo_reg_0_15_6_7__0\ : label is "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg_0_15_6_7";
  attribute RTL_RAM_STYLE of \tx_fifo_reg_0_15_6_7__0\ : label is "NONE";
  attribute RTL_RAM_TYPE of \tx_fifo_reg_0_15_6_7__0\ : label is "RAM_SDP";
  attribute ram_addr_begin of \tx_fifo_reg_0_15_6_7__0\ : label is 0;
  attribute ram_addr_end of \tx_fifo_reg_0_15_6_7__0\ : label is 15;
  attribute ram_offset of \tx_fifo_reg_0_15_6_7__0\ : label is 0;
  attribute ram_slice_begin of \tx_fifo_reg_0_15_6_7__0\ : label is 7;
  attribute ram_slice_end of \tx_fifo_reg_0_15_6_7__0\ : label is 7;
  attribute SOFT_HLUTNM of \tx_rd_ptr[0]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \tx_rd_ptr[1]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \tx_rd_ptr[2]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \tx_rd_ptr[3]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \tx_rd_ptr_rep[0]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \tx_rd_ptr_rep[1]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \tx_rd_ptr_rep[2]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \tx_rd_ptr_rep[3]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \tx_wr_ptr[0]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \tx_wr_ptr[1]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \tx_wr_ptr[2]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \tx_wr_ptr[3]_i_3\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of uart_irq_INST_0_i_3 : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of w_hold_i_1 : label is "soft_lutpair31";
begin
  bvalid_reg_reg_0 <= \^bvalid_reg_reg_0\;
  npu_boot_active <= \^npu_boot_active\;
  rvalid_reg_reg_0 <= \^rvalid_reg_reg_0\;
  s_axi_bresp(0) <= \^s_axi_bresp\(0);
  s_axi_rresp(0) <= \^s_axi_rresp\(0);
aw_hold_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C0C008C8"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_aresetn,
      I2 => aw_hold,
      I3 => w_hold_reg_n_0,
      I4 => \^bvalid_reg_reg_0\,
      O => aw_hold_i_1_n_0
    );
aw_hold_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => aw_hold_i_1_n_0,
      Q => aw_hold,
      R => '0'
    );
\awaddr_hold[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => aw_hold,
      I2 => \^bvalid_reg_reg_0\,
      O => aw_hold0
    );
\awaddr_hold_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => aw_hold0,
      D => s_axi_awaddr(0),
      Q => p_2_in(0),
      R => uart_inst_n_1
    );
\awaddr_hold_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => aw_hold0,
      D => s_axi_awaddr(1),
      Q => p_2_in(1),
      R => uart_inst_n_1
    );
\awaddr_hold_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => aw_hold0,
      D => s_axi_awaddr(2),
      Q => p_2_in(2),
      R => uart_inst_n_1
    );
\awaddr_hold_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => aw_hold0,
      D => s_axi_awaddr(3),
      Q => p_2_in(3),
      R => uart_inst_n_1
    );
axi_error_clear_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFDFFF"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => \^npu_boot_active\,
      I2 => aw_hold,
      I3 => w_hold_reg_n_0,
      I4 => \^bvalid_reg_reg_0\,
      O => axi_error_clear
    );
axi_error_clear_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400000000000000"
    )
        port map (
      I0 => p_2_in(2),
      I1 => \wstrb_hold_reg_n_0_[0]\,
      I2 => p_2_in(3),
      I3 => \wdata_hold_reg_n_0_[2]\,
      I4 => p_2_in(0),
      I5 => p_2_in(1),
      O => axi_error_clear_i_2_n_0
    );
axi_error_clear_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_error_clear_i_2_n_0,
      Q => axi_error_clear_reg_n_0,
      R => axi_error_clear
    );
axi_rx_fifo_reset_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400000000000000"
    )
        port map (
      I0 => p_2_in(2),
      I1 => \wstrb_hold_reg_n_0_[0]\,
      I2 => p_2_in(3),
      I3 => \wdata_hold_reg_n_0_[1]\,
      I4 => p_2_in(0),
      I5 => p_2_in(1),
      O => axi_rx_fifo_reset_i_1_n_0
    );
axi_rx_fifo_reset_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rx_fifo_reset_i_1_n_0,
      Q => axi_rx_fifo_reset_reg_n_0,
      R => axi_error_clear
    );
axi_rx_pop_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000400"
    )
        port map (
      I0 => \rdata_reg[7]_i_4_n_0\,
      I1 => s_axi_aresetn,
      I2 => \^npu_boot_active\,
      I3 => s_axi_arvalid,
      I4 => \^rvalid_reg_reg_0\,
      O => axi_rx_pop_i_1_n_0
    );
axi_rx_pop_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_rx_pop_i_1_n_0,
      Q => axi_rx_pop,
      R => '0'
    );
\axi_tx_data[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00400000"
    )
        port map (
      I0 => \^npu_boot_active\,
      I1 => aw_hold,
      I2 => w_hold_reg_n_0,
      I3 => \^bvalid_reg_reg_0\,
      I4 => axi_tx_push_i_1_n_0,
      O => \axi_tx_data__0\(0)
    );
\axi_tx_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[0]\,
      Q => axi_tx_data(0),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[1]\,
      Q => axi_tx_data(1),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[2]\,
      Q => axi_tx_data(2),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[3]\,
      Q => axi_tx_data(3),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[4]\,
      Q => axi_tx_data(4),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[5]\,
      Q => axi_tx_data(5),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[6]\,
      Q => axi_tx_data(6),
      R => uart_inst_n_1
    );
\axi_tx_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \axi_tx_data__0\(0),
      D => \wdata_hold_reg_n_0_[7]\,
      Q => axi_tx_data(7),
      R => uart_inst_n_1
    );
axi_tx_fifo_reset_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400000000000000"
    )
        port map (
      I0 => p_2_in(2),
      I1 => \wstrb_hold_reg_n_0_[0]\,
      I2 => p_2_in(3),
      I3 => \wdata_hold_reg_n_0_[0]\,
      I4 => p_2_in(0),
      I5 => p_2_in(1),
      O => axi_tx_fifo_reset_i_1_n_0
    );
axi_tx_fifo_reset_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_tx_fifo_reset_i_1_n_0,
      Q => axi_tx_fifo_reset_reg_n_0,
      R => axi_error_clear
    );
axi_tx_push_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000040000"
    )
        port map (
      I0 => p_2_in(1),
      I1 => \wstrb_hold_reg_n_0_[0]\,
      I2 => p_2_in(3),
      I3 => p_2_in(2),
      I4 => p_2_in(0),
      I5 => tx_count_reg(4),
      O => axi_tx_push_i_1_n_0
    );
axi_tx_push_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => axi_tx_push_i_1_n_0,
      Q => axi_tx_push_reg_n_0,
      R => axi_error_clear
    );
boot_active_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => boot_meta,
      Q => \^npu_boot_active\,
      R => uart_inst_n_1
    );
\boot_address[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \^npu_boot_active\,
      I1 => s_axi_aresetn,
      O => boot_checksum(0)
    );
\boot_address_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(0),
      Q => boot_address(0),
      R => boot_checksum(0)
    );
\boot_address_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(2),
      Q => boot_address(10),
      R => boot_checksum(0)
    );
\boot_address_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(3),
      Q => boot_address(11),
      R => boot_checksum(0)
    );
\boot_address_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(4),
      Q => boot_address(12),
      R => boot_checksum(0)
    );
\boot_address_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(5),
      Q => boot_address(13),
      R => boot_checksum(0)
    );
\boot_address_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(6),
      Q => boot_address(14),
      R => boot_checksum(0)
    );
\boot_address_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(7),
      Q => boot_address(15),
      R => boot_checksum(0)
    );
\boot_address_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(0),
      Q => boot_address(16),
      R => boot_checksum(0)
    );
\boot_address_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(1),
      Q => boot_address(17),
      R => boot_checksum(0)
    );
\boot_address_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(2),
      Q => boot_address(18),
      R => boot_checksum(0)
    );
\boot_address_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(3),
      Q => boot_address(19),
      R => boot_checksum(0)
    );
\boot_address_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(1),
      Q => boot_address(1),
      R => boot_checksum(0)
    );
\boot_address_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(4),
      Q => boot_address(20),
      R => boot_checksum(0)
    );
\boot_address_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(5),
      Q => boot_address(21),
      R => boot_checksum(0)
    );
\boot_address_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(6),
      Q => boot_address(22),
      R => boot_checksum(0)
    );
\boot_address_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(23),
      D => phy_rx_data(7),
      Q => boot_address(23),
      R => boot_checksum(0)
    );
\boot_address_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(0),
      Q => boot_address(24),
      R => boot_checksum(0)
    );
\boot_address_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(1),
      Q => boot_address(25),
      R => boot_checksum(0)
    );
\boot_address_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(2),
      Q => boot_address(26),
      R => boot_checksum(0)
    );
\boot_address_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(3),
      Q => boot_address(27),
      R => boot_checksum(0)
    );
\boot_address_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(4),
      Q => boot_address(28),
      R => boot_checksum(0)
    );
\boot_address_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(5),
      Q => boot_address(29),
      R => boot_checksum(0)
    );
\boot_address_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(2),
      Q => boot_address(2),
      R => boot_checksum(0)
    );
\boot_address_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(6),
      Q => boot_address(30),
      R => boot_checksum(0)
    );
\boot_address_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(31),
      D => phy_rx_data(7),
      Q => boot_address(31),
      R => boot_checksum(0)
    );
\boot_address_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(3),
      Q => boot_address(3),
      R => boot_checksum(0)
    );
\boot_address_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(4),
      Q => boot_address(4),
      R => boot_checksum(0)
    );
\boot_address_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(5),
      Q => boot_address(5),
      R => boot_checksum(0)
    );
\boot_address_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(6),
      Q => boot_address(6),
      R => boot_checksum(0)
    );
\boot_address_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(0),
      D => phy_rx_data(7),
      Q => boot_address(7),
      R => boot_checksum(0)
    );
\boot_address_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(0),
      Q => boot_address(8),
      R => boot_checksum(0)
    );
\boot_address_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => \boot_address__0\(15),
      D => phy_rx_data(1),
      Q => boot_address(9),
      R => boot_checksum(0)
    );
\boot_checksum[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \boot_state_reg_n_0_[1]\,
      I1 => \boot_state_reg_n_0_[3]\,
      O => \boot_checksum[7]_i_3_n_0\
    );
\boot_checksum_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_37,
      Q => \boot_checksum_reg_n_0_[0]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_36,
      Q => \boot_checksum_reg_n_0_[1]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_35,
      Q => \boot_checksum_reg_n_0_[2]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_34,
      Q => \boot_checksum_reg_n_0_[3]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_33,
      Q => \boot_checksum_reg_n_0_[4]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_32,
      Q => \boot_checksum_reg_n_0_[5]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_31,
      Q => \boot_checksum_reg_n_0_[6]\,
      R => boot_checksum(0)
    );
\boot_checksum_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_46,
      D => uart_inst_n_30,
      Q => \boot_checksum_reg_n_0_[7]\,
      R => boot_checksum(0)
    );
\boot_command_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(0),
      Q => \boot_command_reg_n_0_[0]\,
      R => '0'
    );
\boot_command_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(1),
      Q => \boot_command_reg_n_0_[1]\,
      R => '0'
    );
\boot_command_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(2),
      Q => \boot_command_reg_n_0_[2]\,
      R => '0'
    );
\boot_command_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(3),
      Q => boot_command(3),
      R => '0'
    );
\boot_command_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(4),
      Q => boot_command(4),
      R => '0'
    );
\boot_command_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(5),
      Q => boot_command(5),
      R => '0'
    );
\boot_command_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(6),
      Q => boot_command(6),
      R => '0'
    );
\boot_command_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_command_1(0),
      D => phy_rx_data(7),
      Q => boot_command(7),
      R => '0'
    );
\boot_data_hi_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(0),
      Q => boot_data_hi(0),
      R => uart_inst_n_21
    );
\boot_data_hi_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(1),
      Q => boot_data_hi(1),
      R => uart_inst_n_21
    );
\boot_data_hi_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(2),
      Q => boot_data_hi(2),
      R => uart_inst_n_21
    );
\boot_data_hi_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(3),
      Q => boot_data_hi(3),
      R => uart_inst_n_21
    );
\boot_data_hi_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(4),
      Q => \boot_data_hi_reg_n_0_[4]\,
      R => uart_inst_n_21
    );
\boot_data_hi_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(5),
      Q => \boot_data_hi_reg_n_0_[5]\,
      R => uart_inst_n_21
    );
\boot_data_hi_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(6),
      Q => \boot_data_hi_reg_n_0_[6]\,
      R => uart_inst_n_21
    );
\boot_data_hi_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_hi_0(0),
      D => phy_rx_data(7),
      Q => \boot_data_hi_reg_n_0_[7]\,
      R => uart_inst_n_21
    );
\boot_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(0),
      Q => boot_data(0),
      R => boot_checksum(0)
    );
\boot_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(2),
      Q => boot_data(10),
      R => boot_checksum(0)
    );
\boot_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(3),
      Q => boot_data(11),
      R => boot_checksum(0)
    );
\boot_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(4),
      Q => boot_data(12),
      R => boot_checksum(0)
    );
\boot_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(5),
      Q => boot_data(13),
      R => boot_checksum(0)
    );
\boot_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(6),
      Q => boot_data(14),
      R => boot_checksum(0)
    );
\boot_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(7),
      Q => boot_data(15),
      R => boot_checksum(0)
    );
\boot_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(0),
      Q => boot_data(16),
      R => boot_checksum(0)
    );
\boot_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(1),
      Q => boot_data(17),
      R => boot_checksum(0)
    );
\boot_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(2),
      Q => boot_data(18),
      R => boot_checksum(0)
    );
\boot_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(3),
      Q => boot_data(19),
      R => boot_checksum(0)
    );
\boot_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(1),
      Q => boot_data(1),
      R => boot_checksum(0)
    );
\boot_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(4),
      Q => boot_data(20),
      R => boot_checksum(0)
    );
\boot_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(5),
      Q => boot_data(21),
      R => boot_checksum(0)
    );
\boot_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(6),
      Q => boot_data(22),
      R => boot_checksum(0)
    );
\boot_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(23),
      D => phy_rx_data(7),
      Q => boot_data(23),
      R => boot_checksum(0)
    );
\boot_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(0),
      Q => boot_data(24),
      R => boot_checksum(0)
    );
\boot_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(1),
      Q => boot_data(25),
      R => boot_checksum(0)
    );
\boot_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(2),
      Q => boot_data(26),
      R => boot_checksum(0)
    );
\boot_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(3),
      Q => boot_data(27),
      R => boot_checksum(0)
    );
\boot_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(4),
      Q => boot_data(28),
      R => boot_checksum(0)
    );
\boot_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(5),
      Q => boot_data(29),
      R => boot_checksum(0)
    );
\boot_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(2),
      Q => boot_data(2),
      R => boot_checksum(0)
    );
\boot_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(6),
      Q => boot_data(30),
      R => boot_checksum(0)
    );
\boot_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(31),
      D => phy_rx_data(7),
      Q => boot_data(31),
      R => boot_checksum(0)
    );
\boot_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(3),
      Q => boot_data(3),
      R => boot_checksum(0)
    );
\boot_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(4),
      Q => boot_data(4),
      R => boot_checksum(0)
    );
\boot_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(5),
      Q => boot_data(5),
      R => boot_checksum(0)
    );
\boot_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(6),
      Q => boot_data(6),
      R => boot_checksum(0)
    );
\boot_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(7),
      D => phy_rx_data(7),
      Q => boot_data(7),
      R => boot_checksum(0)
    );
\boot_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(0),
      Q => boot_data(8),
      R => boot_checksum(0)
    );
\boot_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => boot_data_2(15),
      D => phy_rx_data(1),
      Q => boot_data(9),
      R => boot_checksum(0)
    );
boot_meta_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => boot_mode,
      Q => boot_meta,
      R => uart_inst_n_1
    );
\boot_reply[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFFFFFB0000"
    )
        port map (
      I0 => uart_inst_n_50,
      I1 => \boot_state_reg_n_0_[1]\,
      I2 => \boot_reply[1]_i_2_n_0\,
      I3 => uart_inst_n_48,
      I4 => \boot_reply[1]_i_4_n_0\,
      I5 => \boot_reply_reg_n_0_[0]\,
      O => \boot_reply[0]_i_1_n_0\
    );
\boot_reply[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0004FFFF00040000"
    )
        port map (
      I0 => \boot_reply[1]_i_2_n_0\,
      I1 => \boot_state_reg_n_0_[3]\,
      I2 => uart_inst_n_50,
      I3 => uart_inst_n_48,
      I4 => \boot_reply[1]_i_4_n_0\,
      I5 => \boot_reply_reg_n_0_[1]\,
      O => \boot_reply[1]_i_1_n_0\
    );
\boot_reply[1]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => boot_address(1),
      I1 => boot_address(0),
      I2 => boot_address(14),
      I3 => \boot_data_hi_reg_n_0_[7]\,
      O => \boot_reply[1]_i_10_n_0\
    );
\boot_reply[1]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => boot_address(17),
      I1 => \boot_data_hi_reg_n_0_[6]\,
      I2 => boot_address(13),
      I3 => boot_address(16),
      O => \boot_reply[1]_i_11_n_0\
    );
\boot_reply[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555504040400"
    )
        port map (
      I0 => bram_en_reg_i_3_n_0,
      I1 => npu_w_we_i_2_n_0,
      I2 => npu_s_we_i_2_n_0,
      I3 => \boot_reply[1]_i_5_n_0\,
      I4 => \boot_reply[1]_i_6_n_0\,
      I5 => \npu_address[12]_i_2_n_0\,
      O => \boot_reply[1]_i_2_n_0\
    );
\boot_reply[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF000B00"
    )
        port map (
      I0 => \boot_state_reg_n_0_[1]\,
      I1 => uart_inst_n_28,
      I2 => uart_inst_n_47,
      I3 => \^npu_boot_active\,
      I4 => phy_rx_frame_error,
      O => \boot_reply[1]_i_4_n_0\
    );
\boot_reply[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEFFFFFFFF"
    )
        port map (
      I0 => npu_w_we_i_4_n_0,
      I1 => boot_address(24),
      I2 => boot_address(26),
      I3 => boot_address(21),
      I4 => boot_address(30),
      I5 => npu_w_we_i_6_n_0,
      O => \boot_reply[1]_i_5_n_0\
    );
\boot_reply[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \boot_command_reg_n_0_[0]\,
      I1 => \boot_reply[1]_i_8_n_0\,
      I2 => bram_en_reg_i_5_n_0,
      I3 => \boot_reply[1]_i_9_n_0\,
      I4 => \boot_reply[1]_i_10_n_0\,
      I5 => \boot_reply[1]_i_11_n_0\,
      O => \boot_reply[1]_i_6_n_0\
    );
\boot_reply[1]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \boot_command_reg_n_0_[2]\,
      I1 => \boot_command_reg_n_0_[1]\,
      O => \boot_reply[1]_i_8_n_0\
    );
\boot_reply[1]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => boot_address(15),
      I1 => \boot_data_hi_reg_n_0_[4]\,
      I2 => boot_address(2),
      I3 => \boot_data_hi_reg_n_0_[5]\,
      O => \boot_reply[1]_i_9_n_0\
    );
boot_reply_pending_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_24,
      Q => boot_reply_pending_reg_n_0,
      R => '0'
    );
\boot_reply_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \boot_reply[0]_i_1_n_0\,
      Q => \boot_reply_reg_n_0_[0]\,
      R => uart_inst_n_1
    );
\boot_reply_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \boot_reply[1]_i_1_n_0\,
      Q => \boot_reply_reg_n_0_[1]\,
      S => uart_inst_n_1
    );
\boot_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1000FFFF"
    )
        port map (
      I0 => \boot_state_reg_n_0_[3]\,
      I1 => \boot_state_reg_n_0_[1]\,
      I2 => \boot_state_reg_n_0_[2]\,
      I3 => \boot_state[0]_i_2_n_0\,
      I4 => \boot_state_reg_n_0_[0]\,
      O => \boot_state[0]_i_1_n_0\
    );
\boot_state[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => bram_en_reg_i_5_n_0,
      I1 => \boot_command_reg_n_0_[2]\,
      I2 => \boot_command_reg_n_0_[1]\,
      I3 => \boot_command_reg_n_0_[0]\,
      O => \boot_state[0]_i_2_n_0\
    );
\boot_state[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0078"
    )
        port map (
      I0 => \boot_state_reg_n_0_[0]\,
      I1 => \boot_state_reg_n_0_[1]\,
      I2 => \boot_state_reg_n_0_[2]\,
      I3 => \boot_state_reg_n_0_[3]\,
      O => \boot_state[2]_i_1_n_0\
    );
\boot_state[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3F80"
    )
        port map (
      I0 => \boot_state_reg_n_0_[2]\,
      I1 => \boot_state_reg_n_0_[0]\,
      I2 => \boot_state_reg_n_0_[1]\,
      I3 => \boot_state_reg_n_0_[3]\,
      O => \boot_state[3]_i_3_n_0\
    );
\boot_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_29,
      D => \boot_state[0]_i_1_n_0\,
      Q => \boot_state_reg_n_0_[0]\,
      R => uart_inst_n_44
    );
\boot_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_29,
      D => uart_inst_n_42,
      Q => \boot_state_reg_n_0_[1]\,
      R => uart_inst_n_44
    );
\boot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_29,
      D => \boot_state[2]_i_1_n_0\,
      Q => \boot_state_reg_n_0_[2]\,
      R => uart_inst_n_44
    );
\boot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_29,
      D => \boot_state[3]_i_3_n_0\,
      Q => \boot_state_reg_n_0_[3]\,
      R => uart_inst_n_44
    );
\bram_addr_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(2),
      Q => bram_addr(0),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(12),
      Q => bram_addr(10),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(13),
      Q => bram_addr(11),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(14),
      Q => bram_addr(12),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(15),
      Q => bram_addr(13),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(3),
      Q => bram_addr(1),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(4),
      Q => bram_addr(2),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(5),
      Q => bram_addr(3),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(6),
      Q => bram_addr(4),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(7),
      Q => bram_addr(5),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(8),
      Q => bram_addr(6),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(9),
      Q => bram_addr(7),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(10),
      Q => bram_addr(8),
      R => uart_inst_n_1
    );
\bram_addr_reg_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_address(11),
      Q => bram_addr(9),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(0),
      Q => bram_din(0),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(10),
      Q => bram_din(10),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(11),
      Q => bram_din(11),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(12),
      Q => bram_din(12),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(13),
      Q => bram_din(13),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(14),
      Q => bram_din(14),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(15),
      Q => bram_din(15),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(16),
      Q => bram_din(16),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(17),
      Q => bram_din(17),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(18),
      Q => bram_din(18),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(19),
      Q => bram_din(19),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(1),
      Q => bram_din(1),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(20),
      Q => bram_din(20),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(21),
      Q => bram_din(21),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(22),
      Q => bram_din(22),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(23),
      Q => bram_din(23),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(24),
      Q => bram_din(24),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(25),
      Q => bram_din(25),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(26),
      Q => bram_din(26),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(27),
      Q => bram_din(27),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(28),
      Q => bram_din(28),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(29),
      Q => bram_din(29),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(2),
      Q => bram_din(2),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(30),
      Q => bram_din(30),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(31),
      Q => bram_din(31),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(3),
      Q => bram_din(3),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(4),
      Q => bram_din(4),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(5),
      Q => bram_din(5),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(6),
      Q => bram_din(6),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(7),
      Q => bram_din(7),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(8),
      Q => bram_din(8),
      R => uart_inst_n_1
    );
\bram_din_reg_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bram_addr_reg(0),
      D => boot_data(9),
      Q => bram_din(9),
      R => uart_inst_n_1
    );
bram_en_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => \boot_command_reg_n_0_[2]\,
      I1 => \boot_command_reg_n_0_[0]\,
      I2 => \boot_command_reg_n_0_[1]\,
      I3 => bram_en_reg_i_5_n_0,
      I4 => boot_address(1),
      I5 => boot_address(0),
      O => bram_en_reg_i_3_n_0
    );
bram_en_reg_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => boot_command(5),
      I1 => boot_command(4),
      I2 => boot_command(3),
      I3 => boot_command(7),
      I4 => boot_command(6),
      O => bram_en_reg_i_5_n_0
    );
bram_en_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_56,
      Q => bram_en,
      R => bram_en_reg
    );
\bram_we_reg[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \boot_state_reg_n_0_[0]\,
      I1 => \boot_state_reg_n_0_[3]\,
      I2 => \boot_state_reg_n_0_[1]\,
      O => \bram_we_reg[3]_i_2_n_0\
    );
\bram_we_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_55,
      Q => bram_we(0),
      R => '0'
    );
\bresp_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFFF0000E000"
    )
        port map (
      I0 => \bresp_reg[1]_i_2_n_0\,
      I1 => \^npu_boot_active\,
      I2 => aw_hold,
      I3 => w_hold_reg_n_0,
      I4 => \^bvalid_reg_reg_0\,
      I5 => \^s_axi_bresp\(0),
      O => \bresp_reg[1]_i_1_n_0\
    );
\bresp_reg[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFAFFAEFFFAFFAAF"
    )
        port map (
      I0 => p_2_in(3),
      I1 => \wstrb_hold_reg_n_0_[0]\,
      I2 => p_2_in(0),
      I3 => p_2_in(2),
      I4 => p_2_in(1),
      I5 => tx_count_reg(4),
      O => \bresp_reg[1]_i_2_n_0\
    );
\bresp_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \bresp_reg[1]_i_1_n_0\,
      Q => \^s_axi_bresp\(0),
      R => uart_inst_n_1
    );
bvalid_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7444"
    )
        port map (
      I0 => s_axi_bready,
      I1 => \^bvalid_reg_reg_0\,
      I2 => w_hold_reg_n_0,
      I3 => aw_hold,
      O => bvalid_reg_i_1_n_0
    );
bvalid_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => bvalid_reg_i_1_n_0,
      Q => \^bvalid_reg_reg_0\,
      R => uart_inst_n_1
    );
frame_error_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_62,
      Q => frame_error,
      R => uart_inst_n_1
    );
\irq_enable_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000002000000000"
    )
        port map (
      I0 => \irq_enable_reg[3]_i_2_n_0\,
      I1 => p_2_in(3),
      I2 => \wstrb_hold_reg_n_0_[0]\,
      I3 => p_2_in(1),
      I4 => p_2_in(0),
      I5 => p_2_in(2),
      O => irq_enable_reg(0)
    );
\irq_enable_reg[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => \^bvalid_reg_reg_0\,
      I1 => w_hold_reg_n_0,
      I2 => aw_hold,
      I3 => \^npu_boot_active\,
      O => \irq_enable_reg[3]_i_2_n_0\
    );
\irq_enable_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => irq_enable_reg(0),
      D => \wdata_hold_reg_n_0_[0]\,
      Q => p_5_in(0),
      R => uart_inst_n_1
    );
\irq_enable_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => irq_enable_reg(0),
      D => \wdata_hold_reg_n_0_[1]\,
      Q => p_5_in(1),
      R => uart_inst_n_1
    );
\irq_enable_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => irq_enable_reg(0),
      D => \wdata_hold_reg_n_0_[2]\,
      Q => p_5_in(2),
      R => uart_inst_n_1
    );
\irq_enable_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => irq_enable_reg(0),
      D => \wdata_hold_reg_n_0_[3]\,
      Q => p_5_in(3),
      R => uart_inst_n_1
    );
\npu_address[12]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0004FFFF"
    )
        port map (
      I0 => \boot_command_reg_n_0_[2]\,
      I1 => \boot_command_reg_n_0_[0]\,
      I2 => \boot_command_reg_n_0_[1]\,
      I3 => bram_en_reg_i_5_n_0,
      I4 => npu_ready,
      O => \npu_address[12]_i_2_n_0\
    );
\npu_address_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(10),
      Q => npu_scratchpad_addr(8),
      R => '0'
    );
\npu_address_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(11),
      Q => npu_scratchpad_addr(9),
      R => '0'
    );
\npu_address_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(12),
      Q => npu_scratchpad_addr(10),
      R => '0'
    );
\npu_address_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(13),
      Q => npu_scratchpad_addr(11),
      R => '0'
    );
\npu_address_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(14),
      Q => npu_scratchpad_addr(12),
      R => '0'
    );
\npu_address_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(15),
      Q => npu_scratchpad_addr(13),
      R => '0'
    );
\npu_address_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(16),
      Q => npu_scratchpad_addr(14),
      R => '0'
    );
\npu_address_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(17),
      Q => npu_scratchpad_addr(15),
      R => '0'
    );
\npu_address_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(2),
      Q => npu_scratchpad_addr(0),
      R => '0'
    );
\npu_address_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(3),
      Q => npu_scratchpad_addr(1),
      R => '0'
    );
\npu_address_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(4),
      Q => npu_scratchpad_addr(2),
      R => '0'
    );
\npu_address_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(5),
      Q => npu_scratchpad_addr(3),
      R => '0'
    );
\npu_address_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(6),
      Q => npu_scratchpad_addr(4),
      R => '0'
    );
\npu_address_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(7),
      Q => npu_scratchpad_addr(5),
      R => '0'
    );
\npu_address_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(8),
      Q => npu_scratchpad_addr(6),
      R => '0'
    );
\npu_address_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_address(9),
      Q => npu_scratchpad_addr(7),
      R => '0'
    );
\npu_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(0),
      Q => npu_instr_din(0),
      R => '0'
    );
\npu_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(10),
      Q => npu_instr_din(10),
      R => '0'
    );
\npu_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(11),
      Q => npu_instr_din(11),
      R => '0'
    );
\npu_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(12),
      Q => npu_instr_din(12),
      R => '0'
    );
\npu_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(13),
      Q => npu_instr_din(13),
      R => '0'
    );
\npu_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(14),
      Q => npu_instr_din(14),
      R => '0'
    );
\npu_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(15),
      Q => npu_instr_din(15),
      R => '0'
    );
\npu_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(16),
      Q => npu_instr_din(16),
      R => '0'
    );
\npu_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(17),
      Q => npu_instr_din(17),
      R => '0'
    );
\npu_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(18),
      Q => npu_instr_din(18),
      R => '0'
    );
\npu_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(19),
      Q => npu_instr_din(19),
      R => '0'
    );
\npu_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(1),
      Q => npu_instr_din(1),
      R => '0'
    );
\npu_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(20),
      Q => npu_instr_din(20),
      R => '0'
    );
\npu_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(21),
      Q => npu_instr_din(21),
      R => '0'
    );
\npu_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(22),
      Q => npu_instr_din(22),
      R => '0'
    );
\npu_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(23),
      Q => npu_instr_din(23),
      R => '0'
    );
\npu_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(24),
      Q => npu_instr_din(24),
      R => '0'
    );
\npu_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(25),
      Q => npu_instr_din(25),
      R => '0'
    );
\npu_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(26),
      Q => npu_instr_din(26),
      R => '0'
    );
\npu_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(27),
      Q => npu_instr_din(27),
      R => '0'
    );
\npu_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(28),
      Q => npu_instr_din(28),
      R => '0'
    );
\npu_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(29),
      Q => npu_instr_din(29),
      R => '0'
    );
\npu_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(2),
      Q => npu_instr_din(2),
      R => '0'
    );
\npu_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(30),
      Q => npu_instr_din(30),
      R => '0'
    );
\npu_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(31),
      Q => npu_instr_din(31),
      R => '0'
    );
\npu_data_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data_hi(0),
      Q => npu_instr_din(32),
      R => '0'
    );
\npu_data_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data_hi(1),
      Q => npu_instr_din(33),
      R => '0'
    );
\npu_data_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data_hi(2),
      Q => npu_instr_din(34),
      R => '0'
    );
\npu_data_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data_hi(3),
      Q => npu_instr_din(35),
      R => '0'
    );
\npu_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(3),
      Q => npu_instr_din(3),
      R => '0'
    );
\npu_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(4),
      Q => npu_instr_din(4),
      R => '0'
    );
\npu_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(5),
      Q => npu_instr_din(5),
      R => '0'
    );
\npu_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(6),
      Q => npu_instr_din(6),
      R => '0'
    );
\npu_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(7),
      Q => npu_instr_din(7),
      R => '0'
    );
\npu_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(8),
      Q => npu_instr_din(8),
      R => '0'
    );
\npu_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => npu_address(0),
      D => boot_data(9),
      Q => npu_instr_din(9),
      R => '0'
    );
npu_i_we_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => \boot_reply[1]_i_5_n_0\,
      I1 => npu_i_we_i_3_n_0,
      I2 => bram_en_reg_i_5_n_0,
      I3 => \boot_command_reg_n_0_[2]\,
      I4 => \boot_command_reg_n_0_[1]\,
      I5 => \boot_command_reg_n_0_[0]\,
      O => npu_i_we_i_2_n_0
    );
npu_i_we_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => boot_address(16),
      I1 => boot_address(13),
      I2 => \boot_data_hi_reg_n_0_[6]\,
      I3 => boot_address(17),
      I4 => \boot_reply[1]_i_10_n_0\,
      I5 => \boot_reply[1]_i_9_n_0\,
      O => npu_i_we_i_3_n_0
    );
npu_i_we_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_53,
      Q => npu_i_we_reg_n_0,
      R => bram_en_reg
    );
npu_instr_we_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => npu_i_we_reg_n_0,
      I1 => npu_ready,
      I2 => \^npu_boot_active\,
      I3 => s_axi_aresetn,
      O => npu_instr_we
    );
npu_s_we_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => npu_w_we_i_3_n_0,
      I1 => bram_en_reg_i_5_n_0,
      I2 => npu_w_we_i_4_n_0,
      I3 => npu_w_we_i_5_n_0,
      I4 => npu_w_we_i_6_n_0,
      I5 => npu_s_we_i_3_n_0,
      O => npu_s_we_i_2_n_0
    );
npu_s_we_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => \boot_command_reg_n_0_[0]\,
      I1 => \boot_command_reg_n_0_[2]\,
      I2 => \boot_command_reg_n_0_[1]\,
      O => npu_s_we_i_3_n_0
    );
npu_s_we_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_51,
      Q => npu_s_we_reg_n_0,
      R => bram_en_reg
    );
npu_scratchpad_we_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => npu_s_we_reg_n_0,
      I1 => npu_ready,
      I2 => \^npu_boot_active\,
      I3 => s_axi_aresetn,
      O => npu_scratchpad_we
    );
npu_w_we_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFEFFFF"
    )
        port map (
      I0 => npu_w_we_i_3_n_0,
      I1 => bram_en_reg_i_5_n_0,
      I2 => npu_w_we_i_4_n_0,
      I3 => npu_w_we_i_5_n_0,
      I4 => npu_w_we_i_6_n_0,
      I5 => npu_w_we_i_7_n_0,
      O => npu_w_we_i_2_n_0
    );
npu_w_we_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => boot_address(0),
      I1 => boot_address(1),
      O => npu_w_we_i_3_n_0
    );
npu_w_we_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => boot_address(25),
      I1 => boot_address(28),
      I2 => boot_address(18),
      I3 => boot_address(22),
      O => npu_w_we_i_4_n_0
    );
npu_w_we_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => boot_address(24),
      I1 => boot_address(26),
      I2 => boot_address(21),
      I3 => boot_address(30),
      O => npu_w_we_i_5_n_0
    );
npu_w_we_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => boot_address(20),
      I1 => boot_address(23),
      I2 => boot_address(29),
      I3 => boot_address(19),
      I4 => boot_address(31),
      I5 => boot_address(27),
      O => npu_w_we_i_6_n_0
    );
npu_w_we_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => \boot_command_reg_n_0_[1]\,
      I1 => \boot_command_reg_n_0_[2]\,
      I2 => \boot_command_reg_n_0_[0]\,
      O => npu_w_we_i_7_n_0
    );
npu_w_we_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_52,
      Q => npu_w_we_reg_n_0,
      R => bram_en_reg
    );
npu_weight_we_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => npu_w_we_reg_n_0,
      I1 => npu_ready,
      I2 => \^npu_boot_active\,
      I3 => s_axi_aresetn,
      O => npu_weight_we
    );
overrun_error_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => uart_inst_n_61,
      Q => overrun_error,
      R => '0'
    );
\rdata_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABABABAAAAAAAAAA"
    )
        port map (
      I0 => \rdata_reg[0]_i_2_n_0\,
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(2),
      I3 => temp0(0),
      I4 => s_axi_araddr(1),
      I5 => \rdata_reg[0]_i_3_n_0\,
      O => p_1_in(0)
    );
\rdata_reg[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0100000011001000"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(1),
      I2 => s_axi_araddr(0),
      I3 => s_axi_araddr(2),
      I4 => p_5_in(0),
      I5 => uart_irq_INST_0_i_3_n_0,
      O => \rdata_reg[0]_i_2_n_0\
    );
\rdata_reg[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555555555554"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => rx_count_reg(0),
      I2 => rx_count_reg(1),
      I3 => rx_count_reg(3),
      I4 => rx_count_reg(2),
      I5 => rx_count_reg(4),
      O => \rdata_reg[0]_i_3_n_0\
    );
\rdata_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF44444F44"
    )
        port map (
      I0 => \rdata_reg[7]_i_4_n_0\,
      I1 => temp0(1),
      I2 => \rdata_reg[6]_i_2_n_0\,
      I3 => rx_count_reg(4),
      I4 => \rdata_reg[1]_i_2_n_0\,
      I5 => \rdata_reg[1]_i_3_n_0\,
      O => p_1_in(1)
    );
\rdata_reg[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => rx_count_reg(0),
      I1 => rx_count_reg(1),
      I2 => rx_count_reg(3),
      I3 => rx_count_reg(2),
      O => \rdata_reg[1]_i_2_n_0\
    );
\rdata_reg[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0405000004000000"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => uart_inst_n_12,
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(0),
      I4 => s_axi_araddr(2),
      I5 => p_5_in(1),
      O => \rdata_reg[1]_i_3_n_0\
    );
\rdata_reg[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \rdata_reg[7]_i_4_n_0\,
      I1 => temp0(2),
      I2 => uart_inst_n_12,
      I3 => \rdata_reg[6]_i_2_n_0\,
      I4 => \rdata_reg[2]_i_2_n_0\,
      O => p_1_in(2)
    );
\rdata_reg[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0405000004000000"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => overrun_error,
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(0),
      I4 => s_axi_araddr(2),
      I5 => p_5_in(2),
      O => \rdata_reg[2]_i_2_n_0\
    );
\rdata_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF44444F44"
    )
        port map (
      I0 => \rdata_reg[7]_i_4_n_0\,
      I1 => temp0(3),
      I2 => \rdata_reg[6]_i_2_n_0\,
      I3 => tx_count_reg(4),
      I4 => \rdata_reg[3]_i_2_n_0\,
      I5 => \rdata_reg[3]_i_3_n_0\,
      O => p_1_in(3)
    );
\rdata_reg[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => tx_count_reg(0),
      I1 => tx_count_reg(1),
      I2 => tx_count_reg(3),
      I3 => tx_count_reg(2),
      O => \rdata_reg[3]_i_2_n_0\
    );
\rdata_reg[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0405000004000000"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => frame_error,
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(0),
      I4 => s_axi_araddr(2),
      I5 => p_5_in(3),
      O => \rdata_reg[3]_i_3_n_0\
    );
\rdata_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => temp0(4),
      I1 => \rdata_reg[7]_i_4_n_0\,
      O => p_1_in(4)
    );
\rdata_reg[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F44"
    )
        port map (
      I0 => \rdata_reg[6]_i_2_n_0\,
      I1 => overrun_error,
      I2 => \rdata_reg[7]_i_4_n_0\,
      I3 => temp0(5),
      O => p_1_in(5)
    );
\rdata_reg[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4F44"
    )
        port map (
      I0 => \rdata_reg[7]_i_4_n_0\,
      I1 => temp0(6),
      I2 => \rdata_reg[6]_i_2_n_0\,
      I3 => frame_error,
      O => p_1_in(6)
    );
\rdata_reg[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(2),
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(0),
      O => \rdata_reg[6]_i_2_n_0\
    );
\rdata_reg[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08FF"
    )
        port map (
      I0 => \^npu_boot_active\,
      I1 => s_axi_arvalid,
      I2 => \^rvalid_reg_reg_0\,
      I3 => s_axi_aresetn,
      O => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \^rvalid_reg_reg_0\,
      O => axi_rx_pop1
    );
\rdata_reg[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => temp0(7),
      I1 => \rdata_reg[7]_i_4_n_0\,
      O => p_1_in(7)
    );
\rdata_reg[7]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => uart_irq_INST_0_i_3_n_0,
      I1 => s_axi_araddr(0),
      I2 => s_axi_araddr(2),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(1),
      O => \rdata_reg[7]_i_4_n_0\
    );
\rdata_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(0),
      Q => s_axi_rdata(0),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(1),
      Q => s_axi_rdata(1),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(2),
      Q => s_axi_rdata(2),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(3),
      Q => s_axi_rdata(3),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(4),
      Q => s_axi_rdata(4),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(5),
      Q => s_axi_rdata(5),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(6),
      Q => s_axi_rdata(6),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rdata_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => axi_rx_pop1,
      D => p_1_in(7),
      Q => s_axi_rdata(7),
      R => \rdata_reg[7]_i_1_n_0\
    );
\rresp_reg[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEF00E0"
    )
        port map (
      I0 => out0(1),
      I1 => \^npu_boot_active\,
      I2 => s_axi_arvalid,
      I3 => \^rvalid_reg_reg_0\,
      I4 => \^s_axi_rresp\(0),
      O => \rresp_reg[1]_i_1_n_0\
    );
\rresp_reg[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EBEBEBEA"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(2),
      I2 => s_axi_araddr(1),
      I3 => uart_irq_INST_0_i_3_n_0,
      I4 => s_axi_araddr(0),
      O => out0(1)
    );
\rresp_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \rresp_reg[1]_i_1_n_0\,
      Q => \^s_axi_rresp\(0),
      R => uart_inst_n_1
    );
rvalid_reg_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \^rvalid_reg_reg_0\,
      I2 => s_axi_arvalid,
      O => rvalid_reg_i_1_n_0
    );
rvalid_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => rvalid_reg_i_1_n_0,
      Q => \^rvalid_reg_reg_0\,
      R => uart_inst_n_1
    );
\rx_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rx_count_reg(0),
      O => \rx_count[0]_i_1_n_0\
    );
\rx_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_7,
      D => \rx_count[0]_i_1_n_0\,
      Q => rx_count_reg(0),
      R => rx_count(0)
    );
\rx_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_7,
      D => uart_inst_n_6,
      Q => rx_count_reg(1),
      R => rx_count(0)
    );
\rx_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_7,
      D => uart_inst_n_5,
      Q => rx_count_reg(2),
      R => rx_count(0)
    );
\rx_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_7,
      D => uart_inst_n_4,
      Q => rx_count_reg(3),
      R => rx_count(0)
    );
\rx_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_7,
      D => uart_inst_n_3,
      Q => rx_count_reg(4),
      R => rx_count(0)
    );
rx_fifo_reg_0_15_0_5: unisim.vcomponents.RAM32M
     port map (
      ADDRA(4) => '0',
      ADDRA(3 downto 0) => rx_rd_ptr(3 downto 0),
      ADDRB(4) => '0',
      ADDRB(3 downto 0) => rx_rd_ptr(3 downto 0),
      ADDRC(4) => '0',
      ADDRC(3 downto 0) => rx_rd_ptr(3 downto 0),
      ADDRD(4) => '0',
      ADDRD(3 downto 0) => rx_wr_ptr(3 downto 0),
      DIA(1 downto 0) => phy_rx_data(1 downto 0),
      DIB(1 downto 0) => phy_rx_data(3 downto 2),
      DIC(1 downto 0) => phy_rx_data(5 downto 4),
      DID(1 downto 0) => B"00",
      DOA(1 downto 0) => temp0(1 downto 0),
      DOB(1 downto 0) => temp0(3 downto 2),
      DOC(1 downto 0) => temp0(5 downto 4),
      DOD(1 downto 0) => NLW_rx_fifo_reg_0_15_0_5_DOD_UNCONNECTED(1 downto 0),
      WCLK => s_axi_aclk,
      WE => p_0_in
    );
rx_fifo_reg_0_15_6_7: unisim.vcomponents.RAM32X1D
     port map (
      A0 => rx_wr_ptr(0),
      A1 => rx_wr_ptr(1),
      A2 => rx_wr_ptr(2),
      A3 => rx_wr_ptr(3),
      A4 => '0',
      D => phy_rx_data(6),
      DPO => temp0(6),
      DPRA0 => rx_rd_ptr(0),
      DPRA1 => rx_rd_ptr(1),
      DPRA2 => rx_rd_ptr(2),
      DPRA3 => rx_rd_ptr(3),
      DPRA4 => '0',
      SPO => NLW_rx_fifo_reg_0_15_6_7_SPO_UNCONNECTED,
      WCLK => s_axi_aclk,
      WE => p_0_in
    );
\rx_fifo_reg_0_15_6_7__0\: unisim.vcomponents.RAM32X1D
     port map (
      A0 => rx_wr_ptr(0),
      A1 => rx_wr_ptr(1),
      A2 => rx_wr_ptr(2),
      A3 => rx_wr_ptr(3),
      A4 => '0',
      D => phy_rx_data(7),
      DPO => temp0(7),
      DPRA0 => rx_rd_ptr(0),
      DPRA1 => rx_rd_ptr(1),
      DPRA2 => rx_rd_ptr(2),
      DPRA3 => rx_rd_ptr(3),
      DPRA4 => '0',
      SPO => \NLW_rx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED\,
      WCLK => s_axi_aclk,
      WE => p_0_in
    );
\rx_rd_ptr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \rx_rd_ptr__0\(0),
      O => \rx_rd_ptr[0]_i_1_n_0\
    );
\rx_rd_ptr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \rx_rd_ptr__0\(1),
      I1 => \rx_rd_ptr__0\(0),
      O => \rx_rd_ptr[1]_i_1_n_0\
    );
\rx_rd_ptr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \rx_rd_ptr__0\(1),
      I1 => \rx_rd_ptr__0\(0),
      I2 => \rx_rd_ptr__0\(2),
      O => \rx_rd_ptr[2]_i_1_n_0\
    );
\rx_rd_ptr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \rx_rd_ptr__0\(1),
      I1 => \rx_rd_ptr__0\(0),
      I2 => \rx_rd_ptr__0\(2),
      I3 => \rx_rd_ptr__0\(3),
      O => \rx_rd_ptr[3]_i_1_n_0\
    );
\rx_rd_ptr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr[0]_i_1_n_0\,
      Q => \rx_rd_ptr__0\(0),
      R => rx_count(0)
    );
\rx_rd_ptr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr[1]_i_1_n_0\,
      Q => \rx_rd_ptr__0\(1),
      R => rx_count(0)
    );
\rx_rd_ptr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr[2]_i_1_n_0\,
      Q => \rx_rd_ptr__0\(2),
      R => rx_count(0)
    );
\rx_rd_ptr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr[3]_i_1_n_0\,
      Q => \rx_rd_ptr__0\(3),
      R => rx_count(0)
    );
\rx_rd_ptr_reg_rep[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr_rep[0]_i_1_n_0\,
      Q => rx_rd_ptr(0),
      R => rx_count(0)
    );
\rx_rd_ptr_reg_rep[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr_rep[1]_i_1_n_0\,
      Q => rx_rd_ptr(1),
      R => rx_count(0)
    );
\rx_rd_ptr_reg_rep[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr_rep[2]_i_1_n_0\,
      Q => rx_rd_ptr(2),
      R => rx_count(0)
    );
\rx_rd_ptr_reg_rep[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => rx_rd_ptr0,
      D => \rx_rd_ptr_rep[3]_i_2_n_0\,
      Q => rx_rd_ptr(3),
      R => rx_count(0)
    );
\rx_rd_ptr_rep[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \rx_rd_ptr__0\(0),
      O => \rx_rd_ptr_rep[0]_i_1_n_0\
    );
\rx_rd_ptr_rep[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \rx_rd_ptr__0\(0),
      I1 => \rx_rd_ptr__0\(1),
      O => \rx_rd_ptr_rep[1]_i_1_n_0\
    );
\rx_rd_ptr_rep[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \rx_rd_ptr__0\(2),
      I1 => \rx_rd_ptr__0\(0),
      I2 => \rx_rd_ptr__0\(1),
      O => \rx_rd_ptr_rep[2]_i_1_n_0\
    );
\rx_rd_ptr_rep[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAAA8"
    )
        port map (
      I0 => axi_rx_pop,
      I1 => rx_count_reg(0),
      I2 => rx_count_reg(1),
      I3 => rx_count_reg(3),
      I4 => rx_count_reg(2),
      I5 => rx_count_reg(4),
      O => rx_rd_ptr0
    );
\rx_rd_ptr_rep[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \rx_rd_ptr__0\(3),
      I1 => \rx_rd_ptr__0\(2),
      I2 => \rx_rd_ptr__0\(0),
      I3 => \rx_rd_ptr__0\(1),
      O => \rx_rd_ptr_rep[3]_i_2_n_0\
    );
\rx_wr_ptr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rx_wr_ptr(0),
      O => \rx_wr_ptr[0]_i_1_n_0\
    );
\rx_wr_ptr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => rx_wr_ptr(0),
      I1 => rx_wr_ptr(1),
      O => \rx_wr_ptr[1]_i_1_n_0\
    );
\rx_wr_ptr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => rx_wr_ptr(2),
      I1 => rx_wr_ptr(0),
      I2 => rx_wr_ptr(1),
      O => \rx_wr_ptr[2]_i_1_n_0\
    );
\rx_wr_ptr[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => axi_rx_fifo_reset_reg_n_0,
      I1 => s_axi_aresetn,
      O => rx_count(0)
    );
\rx_wr_ptr[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => rx_wr_ptr(3),
      I1 => rx_wr_ptr(2),
      I2 => rx_wr_ptr(0),
      I3 => rx_wr_ptr(1),
      O => \rx_wr_ptr[3]_i_3_n_0\
    );
\rx_wr_ptr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => p_33_in,
      D => \rx_wr_ptr[0]_i_1_n_0\,
      Q => rx_wr_ptr(0),
      R => rx_count(0)
    );
\rx_wr_ptr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => p_33_in,
      D => \rx_wr_ptr[1]_i_1_n_0\,
      Q => rx_wr_ptr(1),
      R => rx_count(0)
    );
\rx_wr_ptr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => p_33_in,
      D => \rx_wr_ptr[2]_i_1_n_0\,
      Q => rx_wr_ptr(2),
      R => rx_count(0)
    );
\rx_wr_ptr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => p_33_in,
      D => \rx_wr_ptr[3]_i_3_n_0\,
      Q => rx_wr_ptr(3),
      R => rx_count(0)
    );
s_axi_arready_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^rvalid_reg_reg_0\,
      O => s_axi_arready
    );
s_axi_awready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^bvalid_reg_reg_0\,
      I1 => aw_hold,
      O => s_axi_awready
    );
s_axi_wready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^bvalid_reg_reg_0\,
      I1 => w_hold_reg_n_0,
      O => s_axi_wready
    );
\tx_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tx_count_reg(0),
      O => \tx_count[0]_i_1_n_0\
    );
\tx_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_26,
      D => \tx_count[0]_i_1_n_0\,
      Q => tx_count_reg(0),
      R => tx_count(0)
    );
\tx_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_26,
      D => uart_inst_n_11,
      Q => tx_count_reg(1),
      R => tx_count(0)
    );
\tx_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_26,
      D => uart_inst_n_10,
      Q => tx_count_reg(2),
      R => tx_count(0)
    );
\tx_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_26,
      D => uart_inst_n_9,
      Q => tx_count_reg(3),
      R => tx_count(0)
    );
\tx_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => uart_inst_n_26,
      D => uart_inst_n_8,
      Q => tx_count_reg(4),
      R => tx_count(0)
    );
tx_fifo_reg_0_15_0_5: unisim.vcomponents.RAM32M
     port map (
      ADDRA(4) => '0',
      ADDRA(3 downto 0) => tx_rd_ptr(3 downto 0),
      ADDRB(4) => '0',
      ADDRB(3 downto 0) => tx_rd_ptr(3 downto 0),
      ADDRC(4) => '0',
      ADDRC(3 downto 0) => tx_rd_ptr(3 downto 0),
      ADDRD(4) => '0',
      ADDRD(3 downto 0) => tx_wr_ptr(3 downto 0),
      DIA(1 downto 0) => axi_tx_data(1 downto 0),
      DIB(1 downto 0) => axi_tx_data(3 downto 2),
      DIC(1 downto 0) => axi_tx_data(5 downto 4),
      DID(1 downto 0) => B"00",
      DOA(1 downto 0) => phy_tx_data0(1 downto 0),
      DOB(1 downto 0) => phy_tx_data0(3 downto 2),
      DOC(1 downto 0) => phy_tx_data0(5 downto 4),
      DOD(1 downto 0) => NLW_tx_fifo_reg_0_15_0_5_DOD_UNCONNECTED(1 downto 0),
      WCLK => s_axi_aclk,
      WE => tx_fifo_reg_0_15_0_5_i_1_n_0
    );
tx_fifo_reg_0_15_0_5_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => tx_count_reg(4),
      I1 => axi_tx_push_reg_n_0,
      I2 => s_axi_aresetn,
      I3 => axi_tx_fifo_reset_reg_n_0,
      O => tx_fifo_reg_0_15_0_5_i_1_n_0
    );
tx_fifo_reg_0_15_6_7: unisim.vcomponents.RAM32X1D
     port map (
      A0 => tx_wr_ptr(0),
      A1 => tx_wr_ptr(1),
      A2 => tx_wr_ptr(2),
      A3 => tx_wr_ptr(3),
      A4 => '0',
      D => axi_tx_data(6),
      DPO => phy_tx_data0(6),
      DPRA0 => tx_rd_ptr(0),
      DPRA1 => tx_rd_ptr(1),
      DPRA2 => tx_rd_ptr(2),
      DPRA3 => tx_rd_ptr(3),
      DPRA4 => '0',
      SPO => NLW_tx_fifo_reg_0_15_6_7_SPO_UNCONNECTED,
      WCLK => s_axi_aclk,
      WE => tx_fifo_reg_0_15_0_5_i_1_n_0
    );
\tx_fifo_reg_0_15_6_7__0\: unisim.vcomponents.RAM32X1D
     port map (
      A0 => tx_wr_ptr(0),
      A1 => tx_wr_ptr(1),
      A2 => tx_wr_ptr(2),
      A3 => tx_wr_ptr(3),
      A4 => '0',
      D => axi_tx_data(7),
      DPO => phy_tx_data0(7),
      DPRA0 => tx_rd_ptr(0),
      DPRA1 => tx_rd_ptr(1),
      DPRA2 => tx_rd_ptr(2),
      DPRA3 => tx_rd_ptr(3),
      DPRA4 => '0',
      SPO => \NLW_tx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED\,
      WCLK => s_axi_aclk,
      WE => tx_fifo_reg_0_15_0_5_i_1_n_0
    );
\tx_rd_ptr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \tx_rd_ptr__0\(0),
      O => \tx_rd_ptr[0]_i_1_n_0\
    );
\tx_rd_ptr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \tx_rd_ptr__0\(1),
      I1 => \tx_rd_ptr__0\(0),
      O => \tx_rd_ptr[1]_i_1_n_0\
    );
\tx_rd_ptr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \tx_rd_ptr__0\(1),
      I1 => \tx_rd_ptr__0\(0),
      I2 => \tx_rd_ptr__0\(2),
      O => \tx_rd_ptr[2]_i_1_n_0\
    );
\tx_rd_ptr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \tx_rd_ptr__0\(1),
      I1 => \tx_rd_ptr__0\(0),
      I2 => \tx_rd_ptr__0\(2),
      I3 => \tx_rd_ptr__0\(3),
      O => \tx_rd_ptr[3]_i_1_n_0\
    );
\tx_rd_ptr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr[0]_i_1_n_0\,
      Q => \tx_rd_ptr__0\(0),
      R => tx_count(0)
    );
\tx_rd_ptr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr[1]_i_1_n_0\,
      Q => \tx_rd_ptr__0\(1),
      R => tx_count(0)
    );
\tx_rd_ptr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr[2]_i_1_n_0\,
      Q => \tx_rd_ptr__0\(2),
      R => tx_count(0)
    );
\tx_rd_ptr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr[3]_i_1_n_0\,
      Q => \tx_rd_ptr__0\(3),
      R => tx_count(0)
    );
\tx_rd_ptr_reg_rep[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr_rep[0]_i_1_n_0\,
      Q => tx_rd_ptr(0),
      R => tx_count(0)
    );
\tx_rd_ptr_reg_rep[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr_rep[1]_i_1_n_0\,
      Q => tx_rd_ptr(1),
      R => tx_count(0)
    );
\tx_rd_ptr_reg_rep[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr_rep[2]_i_1_n_0\,
      Q => tx_rd_ptr(2),
      R => tx_count(0)
    );
\tx_rd_ptr_reg_rep[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_rd_ptr0,
      D => \tx_rd_ptr_rep[3]_i_2_n_0\,
      Q => tx_rd_ptr(3),
      R => tx_count(0)
    );
\tx_rd_ptr_rep[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \tx_rd_ptr__0\(0),
      O => \tx_rd_ptr_rep[0]_i_1_n_0\
    );
\tx_rd_ptr_rep[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \tx_rd_ptr__0\(0),
      I1 => \tx_rd_ptr__0\(1),
      O => \tx_rd_ptr_rep[1]_i_1_n_0\
    );
\tx_rd_ptr_rep[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \tx_rd_ptr__0\(2),
      I1 => \tx_rd_ptr__0\(0),
      I2 => \tx_rd_ptr__0\(1),
      O => \tx_rd_ptr_rep[2]_i_1_n_0\
    );
\tx_rd_ptr_rep[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \tx_rd_ptr__0\(3),
      I1 => \tx_rd_ptr__0\(2),
      I2 => \tx_rd_ptr__0\(0),
      I3 => \tx_rd_ptr__0\(1),
      O => \tx_rd_ptr_rep[3]_i_2_n_0\
    );
\tx_wr_ptr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tx_wr_ptr(0),
      O => \tx_wr_ptr[0]_i_1_n_0\
    );
\tx_wr_ptr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => tx_wr_ptr(0),
      I1 => tx_wr_ptr(1),
      O => \tx_wr_ptr[1]_i_1_n_0\
    );
\tx_wr_ptr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => tx_wr_ptr(2),
      I1 => tx_wr_ptr(0),
      I2 => tx_wr_ptr(1),
      O => \tx_wr_ptr[2]_i_1_n_0\
    );
\tx_wr_ptr[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => axi_tx_fifo_reset_reg_n_0,
      I1 => s_axi_aresetn,
      O => tx_count(0)
    );
\tx_wr_ptr[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => axi_tx_push_reg_n_0,
      I1 => tx_count_reg(4),
      O => tx_wr_ptr0
    );
\tx_wr_ptr[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => tx_wr_ptr(3),
      I1 => tx_wr_ptr(2),
      I2 => tx_wr_ptr(0),
      I3 => tx_wr_ptr(1),
      O => \tx_wr_ptr[3]_i_3_n_0\
    );
\tx_wr_ptr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_wr_ptr0,
      D => \tx_wr_ptr[0]_i_1_n_0\,
      Q => tx_wr_ptr(0),
      R => tx_count(0)
    );
\tx_wr_ptr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_wr_ptr0,
      D => \tx_wr_ptr[1]_i_1_n_0\,
      Q => tx_wr_ptr(1),
      R => tx_count(0)
    );
\tx_wr_ptr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_wr_ptr0,
      D => \tx_wr_ptr[2]_i_1_n_0\,
      Q => tx_wr_ptr(2),
      R => tx_count(0)
    );
\tx_wr_ptr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => tx_wr_ptr0,
      D => \tx_wr_ptr[3]_i_3_n_0\,
      Q => tx_wr_ptr(3),
      R => tx_count(0)
    );
uart_inst: entity work.design_1_axi_uart_bootloader_1_0_uart_phy
     port map (
      D(3) => uart_inst_n_3,
      D(2) => uart_inst_n_4,
      D(1) => uart_inst_n_5,
      D(0) => uart_inst_n_6,
      E(0) => uart_inst_n_7,
      Q(4 downto 0) => rx_count_reg(4 downto 0),
      SR(0) => uart_inst_n_1,
      axi_error_clear_reg => uart_inst_n_62,
      boot_active_reg(0) => p_33_in,
      boot_active_reg_0(0) => bram_addr_reg(0),
      \boot_checksum_reg[0]\ => \boot_checksum[7]_i_3_n_0\,
      \boot_checksum_reg[7]\ => uart_inst_n_50,
      \boot_checksum_reg[7]_0\(7) => \boot_checksum_reg_n_0_[7]\,
      \boot_checksum_reg[7]_0\(6) => \boot_checksum_reg_n_0_[6]\,
      \boot_checksum_reg[7]_0\(5) => \boot_checksum_reg_n_0_[5]\,
      \boot_checksum_reg[7]_0\(4) => \boot_checksum_reg_n_0_[4]\,
      \boot_checksum_reg[7]_0\(3) => \boot_checksum_reg_n_0_[3]\,
      \boot_checksum_reg[7]_0\(2) => \boot_checksum_reg_n_0_[2]\,
      \boot_checksum_reg[7]_0\(1) => \boot_checksum_reg_n_0_[1]\,
      \boot_checksum_reg[7]_0\(0) => \boot_checksum_reg_n_0_[0]\,
      boot_data_hi_0(0) => boot_data_hi_0(0),
      boot_reply_pending_reg => uart_inst_n_24,
      boot_reply_pending_reg_0 => \^npu_boot_active\,
      boot_reply_pending_reg_1 => boot_reply_pending_reg_n_0,
      \boot_state_reg[0]\(0) => boot_command_1(0),
      \boot_state_reg[0]_0\(7) => uart_inst_n_30,
      \boot_state_reg[0]_0\(6) => uart_inst_n_31,
      \boot_state_reg[0]_0\(5) => uart_inst_n_32,
      \boot_state_reg[0]_0\(4) => uart_inst_n_33,
      \boot_state_reg[0]_0\(3) => uart_inst_n_34,
      \boot_state_reg[0]_0\(2) => uart_inst_n_35,
      \boot_state_reg[0]_0\(1) => uart_inst_n_36,
      \boot_state_reg[0]_0\(0) => uart_inst_n_37,
      \boot_state_reg[0]_1\ => uart_inst_n_56,
      \boot_state_reg[0]_2\(3) => \boot_state_reg_n_0_[3]\,
      \boot_state_reg[0]_2\(2) => \boot_state_reg_n_0_[2]\,
      \boot_state_reg[0]_2\(1) => \boot_state_reg_n_0_[1]\,
      \boot_state_reg[0]_2\(0) => \boot_state_reg_n_0_[0]\,
      \boot_state_reg[1]\(0) => uart_inst_n_42,
      \boot_state_reg[1]_0\(0) => npu_address(0),
      \boot_state_reg[1]_1\ => uart_inst_n_51,
      \boot_state_reg[1]_2\ => uart_inst_n_52,
      \boot_state_reg[1]_3\ => uart_inst_n_53,
      \boot_state_reg[2]\ => uart_inst_n_21,
      \boot_state_reg[2]_0\(3) => \boot_address__0\(31),
      \boot_state_reg[2]_0\(2) => \boot_address__0\(23),
      \boot_state_reg[2]_0\(1) => \boot_address__0\(15),
      \boot_state_reg[2]_0\(0) => \boot_address__0\(0),
      \boot_state_reg[2]_1\(0) => uart_inst_n_46,
      \boot_state_reg[3]\ => uart_inst_n_47,
      \bram_din_reg_reg[0]\ => bram_en_reg_i_3_n_0,
      \bram_din_reg_reg[0]_0\ => \bram_we_reg[3]_i_2_n_0\,
      bram_en_reg => bram_en_reg,
      frame_error => frame_error,
      \npu_data_reg[0]\ => \npu_address[12]_i_2_n_0\,
      npu_i_we_reg => npu_i_we_i_2_n_0,
      npu_s_we_reg => npu_s_we_i_2_n_0,
      npu_w_we_reg => npu_w_we_i_2_n_0,
      overrun_error => overrun_error,
      overrun_error_reg => axi_rx_fifo_reset_reg_n_0,
      overrun_error_reg_0 => axi_error_clear_reg_n_0,
      p_0_in => p_0_in,
      phy_rx_frame_error => phy_rx_frame_error,
      phy_tx_data0(7 downto 0) => phy_tx_data0(7 downto 0),
      \rx_data_reg[1]_0\ => uart_inst_n_28,
      \rx_data_reg[7]_0\(7 downto 0) => phy_rx_data(7 downto 0),
      rx_frame_error_reg_0(0) => uart_inst_n_44,
      rx_frame_error_reg_1 => uart_inst_n_48,
      rx_frame_error_reg_2(3) => boot_data_2(31),
      rx_frame_error_reg_2(2) => boot_data_2(23),
      rx_frame_error_reg_2(1) => boot_data_2(15),
      rx_frame_error_reg_2(0) => boot_data_2(7),
      rx_rd_ptr0 => rx_rd_ptr0,
      rx_valid_reg_0(0) => uart_inst_n_29,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_aresetn_0 => uart_inst_n_55,
      s_axi_aresetn_1 => uart_inst_n_61,
      \tx_count_reg[0]\(4 downto 0) => tx_count_reg(4 downto 0),
      \tx_count_reg[0]_0\ => axi_tx_push_reg_n_0,
      \tx_count_reg[3]\(0) => tx_wr_ptr0,
      \tx_count_reg[4]\(3) => uart_inst_n_8,
      \tx_count_reg[4]\(2) => uart_inst_n_9,
      \tx_count_reg[4]\(1) => uart_inst_n_10,
      \tx_count_reg[4]\(0) => uart_inst_n_11,
      \tx_count_reg[4]_0\ => uart_inst_n_12,
      \tx_count_reg[4]_1\(0) => uart_inst_n_26,
      tx_rd_ptr0 => tx_rd_ptr0,
      \tx_shift_reg[1]_0\ => \boot_reply_reg_n_0_[1]\,
      \tx_shift_reg[4]_0\ => \boot_reply_reg_n_0_[0]\,
      uart_rx => uart_rx,
      uart_tx => uart_tx
    );
uart_irq_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44404040"
    )
        port map (
      I0 => \^npu_boot_active\,
      I1 => s_axi_aresetn,
      I2 => uart_irq_INST_0_i_1_n_0,
      I3 => p_5_in(1),
      I4 => uart_inst_n_12,
      O => uart_irq
    );
uart_irq_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => uart_irq_INST_0_i_3_n_0,
      I1 => p_5_in(0),
      I2 => overrun_error,
      I3 => p_5_in(2),
      I4 => frame_error,
      I5 => p_5_in(3),
      O => uart_irq_INST_0_i_1_n_0
    );
uart_irq_INST_0_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => rx_count_reg(4),
      I1 => rx_count_reg(2),
      I2 => rx_count_reg(3),
      I3 => rx_count_reg(1),
      I4 => rx_count_reg(0),
      O => uart_irq_INST_0_i_3_n_0
    );
w_hold_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CC000C88"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => s_axi_aresetn,
      I2 => aw_hold,
      I3 => w_hold_reg_n_0,
      I4 => \^bvalid_reg_reg_0\,
      O => w_hold_i_1_n_0
    );
w_hold_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => w_hold_i_1_n_0,
      Q => w_hold_reg_n_0,
      R => '0'
    );
\wdata_hold[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => w_hold_reg_n_0,
      I2 => \^bvalid_reg_reg_0\,
      O => w_hold0
    );
\wdata_hold_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(0),
      Q => \wdata_hold_reg_n_0_[0]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(1),
      Q => \wdata_hold_reg_n_0_[1]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(2),
      Q => \wdata_hold_reg_n_0_[2]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(3),
      Q => \wdata_hold_reg_n_0_[3]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(4),
      Q => \wdata_hold_reg_n_0_[4]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(5),
      Q => \wdata_hold_reg_n_0_[5]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(6),
      Q => \wdata_hold_reg_n_0_[6]\,
      R => uart_inst_n_1
    );
\wdata_hold_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wdata(7),
      Q => \wdata_hold_reg_n_0_[7]\,
      R => uart_inst_n_1
    );
\wstrb_hold_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => w_hold0,
      D => s_axi_wstrb(0),
      Q => \wstrb_hold_reg_n_0_[0]\,
      R => uart_inst_n_1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper is
  port (
    npu_boot_active : out STD_LOGIC;
    rvalid_reg_reg : out STD_LOGIC;
    bvalid_reg_reg : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    bram_en : out STD_LOGIC;
    bram_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    npu_scratchpad_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    npu_instr_din : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    uart_irq : out STD_LOGIC;
    npu_instr_we : out STD_LOGIC;
    npu_weight_we : out STD_LOGIC;
    npu_scratchpad_we : out STD_LOGIC;
    uart_tx : out STD_LOGIC;
    bram_we : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    npu_ready : in STD_LOGIC;
    uart_rx : in STD_LOGIC;
    boot_mode : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper : entity is "axi_uart_bootloader_wrapper";
end design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper;

architecture STRUCTURE of design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper is
begin
u_axi_uart_bootloader: entity work.design_1_axi_uart_bootloader_1_0_axi_uart_bootloader
     port map (
      boot_mode => boot_mode,
      bram_addr(13 downto 0) => bram_addr(13 downto 0),
      bram_din(31 downto 0) => bram_din(31 downto 0),
      bram_en => bram_en,
      bram_we(0) => bram_we(0),
      bvalid_reg_reg_0 => bvalid_reg_reg,
      npu_boot_active => npu_boot_active,
      npu_instr_din(35 downto 0) => npu_instr_din(35 downto 0),
      npu_instr_we => npu_instr_we,
      npu_ready => npu_ready,
      npu_scratchpad_addr(15 downto 0) => npu_scratchpad_addr(15 downto 0),
      npu_scratchpad_we => npu_scratchpad_we,
      npu_weight_we => npu_weight_we,
      rvalid_reg_reg_0 => rvalid_reg_reg,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(3 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(3 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => s_axi_bresp(0),
      s_axi_rdata(7 downto 0) => s_axi_rdata(7 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(0) => s_axi_rresp(0),
      s_axi_wdata(7 downto 0) => s_axi_wdata(7 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(0) => s_axi_wstrb(0),
      s_axi_wvalid => s_axi_wvalid,
      uart_irq => uart_irq,
      uart_rx => uart_rx,
      uart_tx => uart_tx
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_uart_bootloader_1_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    boot_mode : in STD_LOGIC;
    uart_rx : in STD_LOGIC;
    uart_tx : out STD_LOGIC;
    uart_irq : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    bram_en : out STD_LOGIC;
    bram_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
    bram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    npu_boot_active : out STD_LOGIC;
    npu_ready : in STD_LOGIC;
    npu_instr_we : out STD_LOGIC;
    npu_instr_addr : out STD_LOGIC_VECTOR ( 9 downto 0 );
    npu_instr_din : out STD_LOGIC_VECTOR ( 35 downto 0 );
    npu_weight_we : out STD_LOGIC;
    npu_weight_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    npu_weight_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
    npu_scratchpad_we : out STD_LOGIC;
    npu_scratchpad_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    npu_scratchpad_din : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_axi_uart_bootloader_1_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_axi_uart_bootloader_1_0 : entity is "design_1_axi_uart_bootloader_1_0,axi_uart_bootloader_wrapper,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_axi_uart_bootloader_1_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_axi_uart_bootloader_1_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_axi_uart_bootloader_1_0 : entity is "axi_uart_bootloader_wrapper,Vivado 2025.2";
end design_1_axi_uart_bootloader_1_0;

architecture STRUCTURE of design_1_axi_uart_bootloader_1_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^bram_we\ : STD_LOGIC_VECTOR ( 2 to 2 );
  signal \^npu_instr_din\ : STD_LOGIC_VECTOR ( 35 downto 32 );
  signal \^npu_scratchpad_addr\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^npu_scratchpad_din\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^s_axi_rdata\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^s_axi_rresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of s_axi_aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s_axi_aclk : signal is "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 s_axi_aresetn RST";
  attribute X_INTERFACE_MODE of s_axi_aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axi_aresetn : signal is "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of uart_irq : signal is "xilinx.com:signal:interrupt:1.0 uart_irq INTERRUPT";
  attribute X_INTERFACE_MODE of uart_irq : signal is "master";
  attribute X_INTERFACE_PARAMETER of uart_irq : signal is "XIL_INTERFACENAME uart_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_MODE of s_axi_awaddr : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s_axi_awaddr : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
begin
  bram_we(3) <= \^bram_we\(2);
  bram_we(2) <= \^bram_we\(2);
  bram_we(1) <= \^bram_we\(2);
  bram_we(0) <= \^bram_we\(2);
  npu_instr_addr(9 downto 0) <= \^npu_scratchpad_addr\(10 downto 1);
  npu_instr_din(35 downto 32) <= \^npu_instr_din\(35 downto 32);
  npu_instr_din(31 downto 0) <= \^npu_scratchpad_din\(31 downto 0);
  npu_scratchpad_addr(15 downto 0) <= \^npu_scratchpad_addr\(15 downto 0);
  npu_scratchpad_din(31 downto 0) <= \^npu_scratchpad_din\(31 downto 0);
  npu_weight_addr(15 downto 0) <= \^npu_scratchpad_addr\(15 downto 0);
  npu_weight_din(31 downto 0) <= \^npu_scratchpad_din\(31 downto 0);
  s_axi_bresp(1) <= \^s_axi_bresp\(1);
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rdata(31) <= \<const0>\;
  s_axi_rdata(30) <= \<const0>\;
  s_axi_rdata(29) <= \<const0>\;
  s_axi_rdata(28) <= \<const0>\;
  s_axi_rdata(27) <= \<const0>\;
  s_axi_rdata(26) <= \<const0>\;
  s_axi_rdata(25) <= \<const0>\;
  s_axi_rdata(24) <= \<const0>\;
  s_axi_rdata(23) <= \<const0>\;
  s_axi_rdata(22) <= \<const0>\;
  s_axi_rdata(21) <= \<const0>\;
  s_axi_rdata(20) <= \<const0>\;
  s_axi_rdata(19) <= \<const0>\;
  s_axi_rdata(18) <= \<const0>\;
  s_axi_rdata(17) <= \<const0>\;
  s_axi_rdata(16) <= \<const0>\;
  s_axi_rdata(15) <= \<const0>\;
  s_axi_rdata(14) <= \<const0>\;
  s_axi_rdata(13) <= \<const0>\;
  s_axi_rdata(12) <= \<const0>\;
  s_axi_rdata(11) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7 downto 0) <= \^s_axi_rdata\(7 downto 0);
  s_axi_rresp(1) <= \^s_axi_rresp\(1);
  s_axi_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper
     port map (
      boot_mode => boot_mode,
      bram_addr(13 downto 0) => bram_addr(13 downto 0),
      bram_din(31 downto 0) => bram_din(31 downto 0),
      bram_en => bram_en,
      bram_we(0) => \^bram_we\(2),
      bvalid_reg_reg => s_axi_bvalid,
      npu_boot_active => npu_boot_active,
      npu_instr_din(35 downto 32) => \^npu_instr_din\(35 downto 32),
      npu_instr_din(31 downto 0) => \^npu_scratchpad_din\(31 downto 0),
      npu_instr_we => npu_instr_we,
      npu_ready => npu_ready,
      npu_scratchpad_addr(15 downto 0) => \^npu_scratchpad_addr\(15 downto 0),
      npu_scratchpad_we => npu_scratchpad_we,
      npu_weight_we => npu_weight_we,
      rvalid_reg_reg => s_axi_rvalid,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(5 downto 2),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(5 downto 2),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => \^s_axi_bresp\(1),
      s_axi_rdata(7 downto 0) => \^s_axi_rdata\(7 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(0) => \^s_axi_rresp\(1),
      s_axi_wdata(7 downto 0) => s_axi_wdata(7 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(0) => s_axi_wstrb(0),
      s_axi_wvalid => s_axi_wvalid,
      uart_irq => uart_irq,
      uart_rx => uart_rx,
      uart_tx => uart_tx
    );
end STRUCTURE;
