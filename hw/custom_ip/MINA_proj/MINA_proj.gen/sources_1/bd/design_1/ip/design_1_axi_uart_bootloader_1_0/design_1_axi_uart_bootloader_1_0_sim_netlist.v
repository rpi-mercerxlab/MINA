// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Mon Nov 16 09:45:34 2026
// Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
// Command     : write_verilog -force -mode funcsim
//               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_axi_uart_bootloader_1_0/design_1_axi_uart_bootloader_1_0_sim_netlist.v
// Design      : design_1_axi_uart_bootloader_1_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_uart_bootloader_1_0,axi_uart_bootloader_wrapper,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axi_uart_bootloader_wrapper,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_axi_uart_bootloader_1_0
   (s_axi_aclk,
    s_axi_aresetn,
    boot_mode,
    uart_rx,
    uart_tx,
    uart_irq,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    bram_en,
    bram_we,
    bram_addr,
    bram_din,
    npu_boot_active,
    npu_ready,
    npu_instr_we,
    npu_instr_addr,
    npu_instr_din,
    npu_weight_we,
    npu_weight_addr,
    npu_weight_din,
    npu_scratchpad_we,
    npu_scratchpad_addr,
    npu_scratchpad_din);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_aclk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_aresetn RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  input boot_mode;
  input uart_rx;
  output uart_tx;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 uart_irq INTERRUPT" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME uart_irq, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output uart_irq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [31:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [31:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;
  output bram_en;
  output [3:0]bram_we;
  output [13:0]bram_addr;
  output [31:0]bram_din;
  output npu_boot_active;
  input npu_ready;
  output npu_instr_we;
  output [9:0]npu_instr_addr;
  output [35:0]npu_instr_din;
  output npu_weight_we;
  output [15:0]npu_weight_addr;
  output [31:0]npu_weight_din;
  output npu_scratchpad_we;
  output [15:0]npu_scratchpad_addr;
  output [31:0]npu_scratchpad_din;

  wire \<const0> ;
  wire boot_mode;
  wire [13:0]bram_addr;
  wire [31:0]bram_din;
  wire bram_en;
  wire [2:2]\^bram_we ;
  wire npu_boot_active;
  wire [35:32]\^npu_instr_din ;
  wire npu_instr_we;
  wire npu_ready;
  wire [15:0]npu_scratchpad_addr;
  wire [31:0]npu_scratchpad_din;
  wire npu_scratchpad_we;
  wire npu_weight_we;
  wire s_axi_aclk;
  wire [31:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:1]\^s_axi_bresp ;
  wire s_axi_bvalid;
  wire [7:0]\^s_axi_rdata ;
  wire s_axi_rready;
  wire [1:1]\^s_axi_rresp ;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire uart_irq;
  wire uart_rx;
  wire uart_tx;

  assign bram_we[3] = \^bram_we [2];
  assign bram_we[2] = \^bram_we [2];
  assign bram_we[1] = \^bram_we [2];
  assign bram_we[0] = \^bram_we [2];
  assign npu_instr_addr[9:0] = npu_scratchpad_addr[10:1];
  assign npu_instr_din[35:32] = \^npu_instr_din [35:32];
  assign npu_instr_din[31:0] = npu_scratchpad_din;
  assign npu_weight_addr[15:0] = npu_scratchpad_addr;
  assign npu_weight_din[31:0] = npu_scratchpad_din;
  assign s_axi_bresp[1] = \^s_axi_bresp [1];
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7:0] = \^s_axi_rdata [7:0];
  assign s_axi_rresp[1] = \^s_axi_rresp [1];
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper inst
       (.boot_mode(boot_mode),
        .bram_addr(bram_addr),
        .bram_din(bram_din),
        .bram_en(bram_en),
        .bram_we(\^bram_we ),
        .bvalid_reg_reg(s_axi_bvalid),
        .npu_boot_active(npu_boot_active),
        .npu_instr_din({\^npu_instr_din ,npu_scratchpad_din}),
        .npu_instr_we(npu_instr_we),
        .npu_ready(npu_ready),
        .npu_scratchpad_addr(npu_scratchpad_addr),
        .npu_scratchpad_we(npu_scratchpad_we),
        .npu_weight_we(npu_weight_we),
        .rvalid_reg_reg(s_axi_rvalid),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[5:2]),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[5:2]),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(\^s_axi_bresp ),
        .s_axi_rdata(\^s_axi_rdata ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(\^s_axi_rresp ),
        .s_axi_wdata(s_axi_wdata[7:0]),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb[0]),
        .s_axi_wvalid(s_axi_wvalid),
        .uart_irq(uart_irq),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx));
endmodule

(* ORIG_REF_NAME = "axi_uart_bootloader" *) 
module design_1_axi_uart_bootloader_1_0_axi_uart_bootloader
   (npu_boot_active,
    rvalid_reg_reg_0,
    bvalid_reg_reg_0,
    s_axi_bresp,
    s_axi_rdata,
    s_axi_rresp,
    bram_en,
    bram_addr,
    bram_din,
    npu_scratchpad_addr,
    npu_instr_din,
    s_axi_wready,
    s_axi_awready,
    s_axi_arready,
    uart_irq,
    npu_instr_we,
    npu_weight_we,
    npu_scratchpad_we,
    uart_tx,
    bram_we,
    s_axi_aclk,
    s_axi_arvalid,
    s_axi_aresetn,
    s_axi_araddr,
    npu_ready,
    uart_rx,
    boot_mode,
    s_axi_awaddr,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_rready);
  output npu_boot_active;
  output rvalid_reg_reg_0;
  output bvalid_reg_reg_0;
  output [0:0]s_axi_bresp;
  output [7:0]s_axi_rdata;
  output [0:0]s_axi_rresp;
  output bram_en;
  output [13:0]bram_addr;
  output [31:0]bram_din;
  output [15:0]npu_scratchpad_addr;
  output [35:0]npu_instr_din;
  output s_axi_wready;
  output s_axi_awready;
  output s_axi_arready;
  output uart_irq;
  output npu_instr_we;
  output npu_weight_we;
  output npu_scratchpad_we;
  output uart_tx;
  output [0:0]bram_we;
  input s_axi_aclk;
  input s_axi_arvalid;
  input s_axi_aresetn;
  input [3:0]s_axi_araddr;
  input npu_ready;
  input uart_rx;
  input boot_mode;
  input [3:0]s_axi_awaddr;
  input [7:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input s_axi_bready;
  input s_axi_rready;

  wire aw_hold;
  wire aw_hold0;
  wire aw_hold_i_1_n_0;
  wire axi_error_clear;
  wire axi_error_clear_i_2_n_0;
  wire axi_error_clear_reg_n_0;
  wire axi_rx_fifo_reset_i_1_n_0;
  wire axi_rx_fifo_reset_reg_n_0;
  wire axi_rx_pop;
  wire axi_rx_pop1;
  wire axi_rx_pop_i_1_n_0;
  wire [7:0]axi_tx_data;
  wire [0:0]axi_tx_data__0;
  wire axi_tx_fifo_reset_i_1_n_0;
  wire axi_tx_fifo_reset_reg_n_0;
  wire axi_tx_push_i_1_n_0;
  wire axi_tx_push_reg_n_0;
  wire [31:0]boot_address;
  wire [31:0]boot_address__0;
  wire [0:0]boot_checksum;
  wire \boot_checksum[7]_i_3_n_0 ;
  wire \boot_checksum_reg_n_0_[0] ;
  wire \boot_checksum_reg_n_0_[1] ;
  wire \boot_checksum_reg_n_0_[2] ;
  wire \boot_checksum_reg_n_0_[3] ;
  wire \boot_checksum_reg_n_0_[4] ;
  wire \boot_checksum_reg_n_0_[5] ;
  wire \boot_checksum_reg_n_0_[6] ;
  wire \boot_checksum_reg_n_0_[7] ;
  wire [7:3]boot_command;
  wire [0:0]boot_command_1;
  wire \boot_command_reg_n_0_[0] ;
  wire \boot_command_reg_n_0_[1] ;
  wire \boot_command_reg_n_0_[2] ;
  wire [31:0]boot_data;
  wire [31:7]boot_data_2;
  wire [3:0]boot_data_hi;
  wire [0:0]boot_data_hi_0;
  wire \boot_data_hi_reg_n_0_[4] ;
  wire \boot_data_hi_reg_n_0_[5] ;
  wire \boot_data_hi_reg_n_0_[6] ;
  wire \boot_data_hi_reg_n_0_[7] ;
  wire boot_meta;
  wire boot_mode;
  wire \boot_reply[0]_i_1_n_0 ;
  wire \boot_reply[1]_i_10_n_0 ;
  wire \boot_reply[1]_i_11_n_0 ;
  wire \boot_reply[1]_i_1_n_0 ;
  wire \boot_reply[1]_i_2_n_0 ;
  wire \boot_reply[1]_i_4_n_0 ;
  wire \boot_reply[1]_i_5_n_0 ;
  wire \boot_reply[1]_i_6_n_0 ;
  wire \boot_reply[1]_i_8_n_0 ;
  wire \boot_reply[1]_i_9_n_0 ;
  wire boot_reply_pending_reg_n_0;
  wire \boot_reply_reg_n_0_[0] ;
  wire \boot_reply_reg_n_0_[1] ;
  wire \boot_state[0]_i_1_n_0 ;
  wire \boot_state[0]_i_2_n_0 ;
  wire \boot_state[2]_i_1_n_0 ;
  wire \boot_state[3]_i_3_n_0 ;
  wire \boot_state_reg_n_0_[0] ;
  wire \boot_state_reg_n_0_[1] ;
  wire \boot_state_reg_n_0_[2] ;
  wire \boot_state_reg_n_0_[3] ;
  wire [13:0]bram_addr;
  wire [0:0]bram_addr_reg;
  wire [31:0]bram_din;
  wire bram_en;
  wire bram_en_reg;
  wire bram_en_reg_i_3_n_0;
  wire bram_en_reg_i_5_n_0;
  wire [0:0]bram_we;
  wire \bram_we_reg[3]_i_2_n_0 ;
  wire \bresp_reg[1]_i_1_n_0 ;
  wire \bresp_reg[1]_i_2_n_0 ;
  wire bvalid_reg_i_1_n_0;
  wire bvalid_reg_reg_0;
  wire frame_error;
  wire [0:0]irq_enable_reg;
  wire \irq_enable_reg[3]_i_2_n_0 ;
  wire [0:0]npu_address;
  wire \npu_address[12]_i_2_n_0 ;
  wire npu_boot_active;
  wire npu_i_we_i_2_n_0;
  wire npu_i_we_i_3_n_0;
  wire npu_i_we_reg_n_0;
  wire [35:0]npu_instr_din;
  wire npu_instr_we;
  wire npu_ready;
  wire npu_s_we_i_2_n_0;
  wire npu_s_we_i_3_n_0;
  wire npu_s_we_reg_n_0;
  wire [15:0]npu_scratchpad_addr;
  wire npu_scratchpad_we;
  wire npu_w_we_i_2_n_0;
  wire npu_w_we_i_3_n_0;
  wire npu_w_we_i_4_n_0;
  wire npu_w_we_i_5_n_0;
  wire npu_w_we_i_6_n_0;
  wire npu_w_we_i_7_n_0;
  wire npu_w_we_reg_n_0;
  wire npu_weight_we;
  wire [1:1]out0;
  wire overrun_error;
  wire p_0_in;
  wire [7:0]p_1_in;
  wire [3:0]p_2_in;
  wire p_33_in;
  wire [3:0]p_5_in;
  wire [7:0]phy_rx_data;
  wire phy_rx_frame_error;
  wire [7:0]phy_tx_data0;
  wire \rdata_reg[0]_i_2_n_0 ;
  wire \rdata_reg[0]_i_3_n_0 ;
  wire \rdata_reg[1]_i_2_n_0 ;
  wire \rdata_reg[1]_i_3_n_0 ;
  wire \rdata_reg[2]_i_2_n_0 ;
  wire \rdata_reg[3]_i_2_n_0 ;
  wire \rdata_reg[3]_i_3_n_0 ;
  wire \rdata_reg[6]_i_2_n_0 ;
  wire \rdata_reg[7]_i_1_n_0 ;
  wire \rdata_reg[7]_i_4_n_0 ;
  wire \rresp_reg[1]_i_1_n_0 ;
  wire rvalid_reg_i_1_n_0;
  wire rvalid_reg_reg_0;
  wire [0:0]rx_count;
  wire \rx_count[0]_i_1_n_0 ;
  wire [4:0]rx_count_reg;
  wire [3:0]rx_rd_ptr;
  wire rx_rd_ptr0;
  wire \rx_rd_ptr[0]_i_1_n_0 ;
  wire \rx_rd_ptr[1]_i_1_n_0 ;
  wire \rx_rd_ptr[2]_i_1_n_0 ;
  wire \rx_rd_ptr[3]_i_1_n_0 ;
  wire [3:0]rx_rd_ptr__0;
  wire \rx_rd_ptr_rep[0]_i_1_n_0 ;
  wire \rx_rd_ptr_rep[1]_i_1_n_0 ;
  wire \rx_rd_ptr_rep[2]_i_1_n_0 ;
  wire \rx_rd_ptr_rep[3]_i_2_n_0 ;
  wire [3:0]rx_wr_ptr;
  wire \rx_wr_ptr[0]_i_1_n_0 ;
  wire \rx_wr_ptr[1]_i_1_n_0 ;
  wire \rx_wr_ptr[2]_i_1_n_0 ;
  wire \rx_wr_ptr[3]_i_3_n_0 ;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [3:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire [7:0]s_axi_rdata;
  wire s_axi_rready;
  wire [0:0]s_axi_rresp;
  wire [7:0]s_axi_wdata;
  wire s_axi_wready;
  wire [0:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire [7:0]temp0;
  wire [0:0]tx_count;
  wire \tx_count[0]_i_1_n_0 ;
  wire [4:0]tx_count_reg;
  wire tx_fifo_reg_0_15_0_5_i_1_n_0;
  wire [3:0]tx_rd_ptr;
  wire tx_rd_ptr0;
  wire \tx_rd_ptr[0]_i_1_n_0 ;
  wire \tx_rd_ptr[1]_i_1_n_0 ;
  wire \tx_rd_ptr[2]_i_1_n_0 ;
  wire \tx_rd_ptr[3]_i_1_n_0 ;
  wire [3:0]tx_rd_ptr__0;
  wire \tx_rd_ptr_rep[0]_i_1_n_0 ;
  wire \tx_rd_ptr_rep[1]_i_1_n_0 ;
  wire \tx_rd_ptr_rep[2]_i_1_n_0 ;
  wire \tx_rd_ptr_rep[3]_i_2_n_0 ;
  wire [3:0]tx_wr_ptr;
  wire tx_wr_ptr0;
  wire \tx_wr_ptr[0]_i_1_n_0 ;
  wire \tx_wr_ptr[1]_i_1_n_0 ;
  wire \tx_wr_ptr[2]_i_1_n_0 ;
  wire \tx_wr_ptr[3]_i_3_n_0 ;
  wire uart_inst_n_1;
  wire uart_inst_n_10;
  wire uart_inst_n_11;
  wire uart_inst_n_12;
  wire uart_inst_n_21;
  wire uart_inst_n_24;
  wire uart_inst_n_26;
  wire uart_inst_n_28;
  wire uart_inst_n_29;
  wire uart_inst_n_3;
  wire uart_inst_n_30;
  wire uart_inst_n_31;
  wire uart_inst_n_32;
  wire uart_inst_n_33;
  wire uart_inst_n_34;
  wire uart_inst_n_35;
  wire uart_inst_n_36;
  wire uart_inst_n_37;
  wire uart_inst_n_4;
  wire uart_inst_n_42;
  wire uart_inst_n_44;
  wire uart_inst_n_46;
  wire uart_inst_n_47;
  wire uart_inst_n_48;
  wire uart_inst_n_5;
  wire uart_inst_n_50;
  wire uart_inst_n_51;
  wire uart_inst_n_52;
  wire uart_inst_n_53;
  wire uart_inst_n_55;
  wire uart_inst_n_56;
  wire uart_inst_n_6;
  wire uart_inst_n_61;
  wire uart_inst_n_62;
  wire uart_inst_n_7;
  wire uart_inst_n_8;
  wire uart_inst_n_9;
  wire uart_irq;
  wire uart_irq_INST_0_i_1_n_0;
  wire uart_irq_INST_0_i_3_n_0;
  wire uart_rx;
  wire uart_tx;
  wire w_hold0;
  wire w_hold_i_1_n_0;
  wire w_hold_reg_n_0;
  wire \wdata_hold_reg_n_0_[0] ;
  wire \wdata_hold_reg_n_0_[1] ;
  wire \wdata_hold_reg_n_0_[2] ;
  wire \wdata_hold_reg_n_0_[3] ;
  wire \wdata_hold_reg_n_0_[4] ;
  wire \wdata_hold_reg_n_0_[5] ;
  wire \wdata_hold_reg_n_0_[6] ;
  wire \wdata_hold_reg_n_0_[7] ;
  wire \wstrb_hold_reg_n_0_[0] ;
  wire [1:0]NLW_rx_fifo_reg_0_15_0_5_DOD_UNCONNECTED;
  wire NLW_rx_fifo_reg_0_15_6_7_SPO_UNCONNECTED;
  wire NLW_rx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED;
  wire [1:0]NLW_tx_fifo_reg_0_15_0_5_DOD_UNCONNECTED;
  wire NLW_tx_fifo_reg_0_15_6_7_SPO_UNCONNECTED;
  wire NLW_tx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'hC0C008C8)) 
    aw_hold_i_1
       (.I0(s_axi_awvalid),
        .I1(s_axi_aresetn),
        .I2(aw_hold),
        .I3(w_hold_reg_n_0),
        .I4(bvalid_reg_reg_0),
        .O(aw_hold_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    aw_hold_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(aw_hold_i_1_n_0),
        .Q(aw_hold),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h02)) 
    \awaddr_hold[5]_i_1 
       (.I0(s_axi_awvalid),
        .I1(aw_hold),
        .I2(bvalid_reg_reg_0),
        .O(aw_hold0));
  FDRE #(
    .INIT(1'b0)) 
    \awaddr_hold_reg[2] 
       (.C(s_axi_aclk),
        .CE(aw_hold0),
        .D(s_axi_awaddr[0]),
        .Q(p_2_in[0]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \awaddr_hold_reg[3] 
       (.C(s_axi_aclk),
        .CE(aw_hold0),
        .D(s_axi_awaddr[1]),
        .Q(p_2_in[1]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \awaddr_hold_reg[4] 
       (.C(s_axi_aclk),
        .CE(aw_hold0),
        .D(s_axi_awaddr[2]),
        .Q(p_2_in[2]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \awaddr_hold_reg[5] 
       (.C(s_axi_aclk),
        .CE(aw_hold0),
        .D(s_axi_awaddr[3]),
        .Q(p_2_in[3]),
        .R(uart_inst_n_1));
  LUT5 #(
    .INIT(32'hFFFFDFFF)) 
    axi_error_clear_i_1
       (.I0(s_axi_aresetn),
        .I1(npu_boot_active),
        .I2(aw_hold),
        .I3(w_hold_reg_n_0),
        .I4(bvalid_reg_reg_0),
        .O(axi_error_clear));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    axi_error_clear_i_2
       (.I0(p_2_in[2]),
        .I1(\wstrb_hold_reg_n_0_[0] ),
        .I2(p_2_in[3]),
        .I3(\wdata_hold_reg_n_0_[2] ),
        .I4(p_2_in[0]),
        .I5(p_2_in[1]),
        .O(axi_error_clear_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_error_clear_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_error_clear_i_2_n_0),
        .Q(axi_error_clear_reg_n_0),
        .R(axi_error_clear));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    axi_rx_fifo_reset_i_1
       (.I0(p_2_in[2]),
        .I1(\wstrb_hold_reg_n_0_[0] ),
        .I2(p_2_in[3]),
        .I3(\wdata_hold_reg_n_0_[1] ),
        .I4(p_2_in[0]),
        .I5(p_2_in[1]),
        .O(axi_rx_fifo_reset_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_rx_fifo_reset_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_rx_fifo_reset_i_1_n_0),
        .Q(axi_rx_fifo_reset_reg_n_0),
        .R(axi_error_clear));
  LUT5 #(
    .INIT(32'h00000400)) 
    axi_rx_pop_i_1
       (.I0(\rdata_reg[7]_i_4_n_0 ),
        .I1(s_axi_aresetn),
        .I2(npu_boot_active),
        .I3(s_axi_arvalid),
        .I4(rvalid_reg_reg_0),
        .O(axi_rx_pop_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_rx_pop_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_rx_pop_i_1_n_0),
        .Q(axi_rx_pop),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00400000)) 
    \axi_tx_data[7]_i_1 
       (.I0(npu_boot_active),
        .I1(aw_hold),
        .I2(w_hold_reg_n_0),
        .I3(bvalid_reg_reg_0),
        .I4(axi_tx_push_i_1_n_0),
        .O(axi_tx_data__0));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[0] ),
        .Q(axi_tx_data[0]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[1] ),
        .Q(axi_tx_data[1]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[2] ),
        .Q(axi_tx_data[2]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[3] ),
        .Q(axi_tx_data[3]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[4] ),
        .Q(axi_tx_data[4]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[5] ),
        .Q(axi_tx_data[5]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[6] ),
        .Q(axi_tx_data[6]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \axi_tx_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(axi_tx_data__0),
        .D(\wdata_hold_reg_n_0_[7] ),
        .Q(axi_tx_data[7]),
        .R(uart_inst_n_1));
  LUT6 #(
    .INIT(64'h0400000000000000)) 
    axi_tx_fifo_reset_i_1
       (.I0(p_2_in[2]),
        .I1(\wstrb_hold_reg_n_0_[0] ),
        .I2(p_2_in[3]),
        .I3(\wdata_hold_reg_n_0_[0] ),
        .I4(p_2_in[0]),
        .I5(p_2_in[1]),
        .O(axi_tx_fifo_reset_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_tx_fifo_reset_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_tx_fifo_reset_i_1_n_0),
        .Q(axi_tx_fifo_reset_reg_n_0),
        .R(axi_error_clear));
  LUT6 #(
    .INIT(64'h0000000000040000)) 
    axi_tx_push_i_1
       (.I0(p_2_in[1]),
        .I1(\wstrb_hold_reg_n_0_[0] ),
        .I2(p_2_in[3]),
        .I3(p_2_in[2]),
        .I4(p_2_in[0]),
        .I5(tx_count_reg[4]),
        .O(axi_tx_push_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    axi_tx_push_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(axi_tx_push_i_1_n_0),
        .Q(axi_tx_push_reg_n_0),
        .R(axi_error_clear));
  FDRE #(
    .INIT(1'b0)) 
    boot_active_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(boot_meta),
        .Q(npu_boot_active),
        .R(uart_inst_n_1));
  LUT2 #(
    .INIT(4'h7)) 
    \boot_address[31]_i_1 
       (.I0(npu_boot_active),
        .I1(s_axi_aresetn),
        .O(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[0] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[0]),
        .Q(boot_address[0]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[10] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[2]),
        .Q(boot_address[10]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[11] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[3]),
        .Q(boot_address[11]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[12] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[4]),
        .Q(boot_address[12]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[13] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[5]),
        .Q(boot_address[13]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[14] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[6]),
        .Q(boot_address[14]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[15] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[7]),
        .Q(boot_address[15]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[16] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[0]),
        .Q(boot_address[16]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[17] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[1]),
        .Q(boot_address[17]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[18] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[2]),
        .Q(boot_address[18]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[19] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[3]),
        .Q(boot_address[19]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[1] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[1]),
        .Q(boot_address[1]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[20] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[4]),
        .Q(boot_address[20]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[21] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[5]),
        .Q(boot_address[21]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[22] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[6]),
        .Q(boot_address[22]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[23] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[23]),
        .D(phy_rx_data[7]),
        .Q(boot_address[23]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[24] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[0]),
        .Q(boot_address[24]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[25] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[1]),
        .Q(boot_address[25]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[26] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[2]),
        .Q(boot_address[26]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[27] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[3]),
        .Q(boot_address[27]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[28] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[4]),
        .Q(boot_address[28]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[29] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[5]),
        .Q(boot_address[29]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[2] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[2]),
        .Q(boot_address[2]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[30] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[6]),
        .Q(boot_address[30]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[31] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[31]),
        .D(phy_rx_data[7]),
        .Q(boot_address[31]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[3] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[3]),
        .Q(boot_address[3]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[4] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[4]),
        .Q(boot_address[4]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[5] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[5]),
        .Q(boot_address[5]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[6] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[6]),
        .Q(boot_address[6]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[7] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[0]),
        .D(phy_rx_data[7]),
        .Q(boot_address[7]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[8] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[0]),
        .Q(boot_address[8]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_address_reg[9] 
       (.C(s_axi_aclk),
        .CE(boot_address__0[15]),
        .D(phy_rx_data[1]),
        .Q(boot_address[9]),
        .R(boot_checksum));
  LUT2 #(
    .INIT(4'h6)) 
    \boot_checksum[7]_i_3 
       (.I0(\boot_state_reg_n_0_[1] ),
        .I1(\boot_state_reg_n_0_[3] ),
        .O(\boot_checksum[7]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[0] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_37),
        .Q(\boot_checksum_reg_n_0_[0] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[1] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_36),
        .Q(\boot_checksum_reg_n_0_[1] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[2] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_35),
        .Q(\boot_checksum_reg_n_0_[2] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[3] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_34),
        .Q(\boot_checksum_reg_n_0_[3] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[4] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_33),
        .Q(\boot_checksum_reg_n_0_[4] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[5] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_32),
        .Q(\boot_checksum_reg_n_0_[5] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[6] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_31),
        .Q(\boot_checksum_reg_n_0_[6] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_checksum_reg[7] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_46),
        .D(uart_inst_n_30),
        .Q(\boot_checksum_reg_n_0_[7] ),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[0] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[0]),
        .Q(\boot_command_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[1] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[1]),
        .Q(\boot_command_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[2] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[2]),
        .Q(\boot_command_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[3] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[3]),
        .Q(boot_command[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[4] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[4]),
        .Q(boot_command[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[5] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[5]),
        .Q(boot_command[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[6] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[6]),
        .Q(boot_command[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_command_reg[7] 
       (.C(s_axi_aclk),
        .CE(boot_command_1),
        .D(phy_rx_data[7]),
        .Q(boot_command[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[0] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[0]),
        .Q(boot_data_hi[0]),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[1] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[1]),
        .Q(boot_data_hi[1]),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[2] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[2]),
        .Q(boot_data_hi[2]),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[3] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[3]),
        .Q(boot_data_hi[3]),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[4] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[4]),
        .Q(\boot_data_hi_reg_n_0_[4] ),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[5] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[5]),
        .Q(\boot_data_hi_reg_n_0_[5] ),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[6] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[6]),
        .Q(\boot_data_hi_reg_n_0_[6] ),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_hi_reg[7] 
       (.C(s_axi_aclk),
        .CE(boot_data_hi_0),
        .D(phy_rx_data[7]),
        .Q(\boot_data_hi_reg_n_0_[7] ),
        .R(uart_inst_n_21));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[0]),
        .Q(boot_data[0]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[10] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[2]),
        .Q(boot_data[10]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[11] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[3]),
        .Q(boot_data[11]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[12] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[4]),
        .Q(boot_data[12]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[13] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[5]),
        .Q(boot_data[13]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[14] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[6]),
        .Q(boot_data[14]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[15] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[7]),
        .Q(boot_data[15]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[16] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[0]),
        .Q(boot_data[16]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[17] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[1]),
        .Q(boot_data[17]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[18] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[2]),
        .Q(boot_data[18]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[19] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[3]),
        .Q(boot_data[19]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[1]),
        .Q(boot_data[1]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[20] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[4]),
        .Q(boot_data[20]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[21] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[5]),
        .Q(boot_data[21]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[22] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[6]),
        .Q(boot_data[22]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[23] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[23]),
        .D(phy_rx_data[7]),
        .Q(boot_data[23]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[24] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[0]),
        .Q(boot_data[24]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[25] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[1]),
        .Q(boot_data[25]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[26] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[2]),
        .Q(boot_data[26]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[27] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[3]),
        .Q(boot_data[27]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[28] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[4]),
        .Q(boot_data[28]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[29] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[5]),
        .Q(boot_data[29]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[2]),
        .Q(boot_data[2]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[30] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[6]),
        .Q(boot_data[30]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[31] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[31]),
        .D(phy_rx_data[7]),
        .Q(boot_data[31]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[3]),
        .Q(boot_data[3]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[4]),
        .Q(boot_data[4]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[5]),
        .Q(boot_data[5]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[6]),
        .Q(boot_data[6]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[7]),
        .D(phy_rx_data[7]),
        .Q(boot_data[7]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[8] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[0]),
        .Q(boot_data[8]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    \boot_data_reg[9] 
       (.C(s_axi_aclk),
        .CE(boot_data_2[15]),
        .D(phy_rx_data[1]),
        .Q(boot_data[9]),
        .R(boot_checksum));
  FDRE #(
    .INIT(1'b0)) 
    boot_meta_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(boot_mode),
        .Q(boot_meta),
        .R(uart_inst_n_1));
  LUT6 #(
    .INIT(64'hFFFBFFFFFFFB0000)) 
    \boot_reply[0]_i_1 
       (.I0(uart_inst_n_50),
        .I1(\boot_state_reg_n_0_[1] ),
        .I2(\boot_reply[1]_i_2_n_0 ),
        .I3(uart_inst_n_48),
        .I4(\boot_reply[1]_i_4_n_0 ),
        .I5(\boot_reply_reg_n_0_[0] ),
        .O(\boot_reply[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0004FFFF00040000)) 
    \boot_reply[1]_i_1 
       (.I0(\boot_reply[1]_i_2_n_0 ),
        .I1(\boot_state_reg_n_0_[3] ),
        .I2(uart_inst_n_50),
        .I3(uart_inst_n_48),
        .I4(\boot_reply[1]_i_4_n_0 ),
        .I5(\boot_reply_reg_n_0_[1] ),
        .O(\boot_reply[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \boot_reply[1]_i_10 
       (.I0(boot_address[1]),
        .I1(boot_address[0]),
        .I2(boot_address[14]),
        .I3(\boot_data_hi_reg_n_0_[7] ),
        .O(\boot_reply[1]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \boot_reply[1]_i_11 
       (.I0(boot_address[17]),
        .I1(\boot_data_hi_reg_n_0_[6] ),
        .I2(boot_address[13]),
        .I3(boot_address[16]),
        .O(\boot_reply[1]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h5555555504040400)) 
    \boot_reply[1]_i_2 
       (.I0(bram_en_reg_i_3_n_0),
        .I1(npu_w_we_i_2_n_0),
        .I2(npu_s_we_i_2_n_0),
        .I3(\boot_reply[1]_i_5_n_0 ),
        .I4(\boot_reply[1]_i_6_n_0 ),
        .I5(\npu_address[12]_i_2_n_0 ),
        .O(\boot_reply[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFF000B00)) 
    \boot_reply[1]_i_4 
       (.I0(\boot_state_reg_n_0_[1] ),
        .I1(uart_inst_n_28),
        .I2(uart_inst_n_47),
        .I3(npu_boot_active),
        .I4(phy_rx_frame_error),
        .O(\boot_reply[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \boot_reply[1]_i_5 
       (.I0(npu_w_we_i_4_n_0),
        .I1(boot_address[24]),
        .I2(boot_address[26]),
        .I3(boot_address[21]),
        .I4(boot_address[30]),
        .I5(npu_w_we_i_6_n_0),
        .O(\boot_reply[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \boot_reply[1]_i_6 
       (.I0(\boot_command_reg_n_0_[0] ),
        .I1(\boot_reply[1]_i_8_n_0 ),
        .I2(bram_en_reg_i_5_n_0),
        .I3(\boot_reply[1]_i_9_n_0 ),
        .I4(\boot_reply[1]_i_10_n_0 ),
        .I5(\boot_reply[1]_i_11_n_0 ),
        .O(\boot_reply[1]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \boot_reply[1]_i_8 
       (.I0(\boot_command_reg_n_0_[2] ),
        .I1(\boot_command_reg_n_0_[1] ),
        .O(\boot_reply[1]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \boot_reply[1]_i_9 
       (.I0(boot_address[15]),
        .I1(\boot_data_hi_reg_n_0_[4] ),
        .I2(boot_address[2]),
        .I3(\boot_data_hi_reg_n_0_[5] ),
        .O(\boot_reply[1]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    boot_reply_pending_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_24),
        .Q(boot_reply_pending_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \boot_reply_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\boot_reply[0]_i_1_n_0 ),
        .Q(\boot_reply_reg_n_0_[0] ),
        .R(uart_inst_n_1));
  FDSE #(
    .INIT(1'b1)) 
    \boot_reply_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\boot_reply[1]_i_1_n_0 ),
        .Q(\boot_reply_reg_n_0_[1] ),
        .S(uart_inst_n_1));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'h1000FFFF)) 
    \boot_state[0]_i_1 
       (.I0(\boot_state_reg_n_0_[3] ),
        .I1(\boot_state_reg_n_0_[1] ),
        .I2(\boot_state_reg_n_0_[2] ),
        .I3(\boot_state[0]_i_2_n_0 ),
        .I4(\boot_state_reg_n_0_[0] ),
        .O(\boot_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \boot_state[0]_i_2 
       (.I0(bram_en_reg_i_5_n_0),
        .I1(\boot_command_reg_n_0_[2] ),
        .I2(\boot_command_reg_n_0_[1] ),
        .I3(\boot_command_reg_n_0_[0] ),
        .O(\boot_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \boot_state[2]_i_1 
       (.I0(\boot_state_reg_n_0_[0] ),
        .I1(\boot_state_reg_n_0_[1] ),
        .I2(\boot_state_reg_n_0_[2] ),
        .I3(\boot_state_reg_n_0_[3] ),
        .O(\boot_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'h3F80)) 
    \boot_state[3]_i_3 
       (.I0(\boot_state_reg_n_0_[2] ),
        .I1(\boot_state_reg_n_0_[0] ),
        .I2(\boot_state_reg_n_0_[1] ),
        .I3(\boot_state_reg_n_0_[3] ),
        .O(\boot_state[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \boot_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_29),
        .D(\boot_state[0]_i_1_n_0 ),
        .Q(\boot_state_reg_n_0_[0] ),
        .R(uart_inst_n_44));
  FDRE #(
    .INIT(1'b0)) 
    \boot_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_29),
        .D(uart_inst_n_42),
        .Q(\boot_state_reg_n_0_[1] ),
        .R(uart_inst_n_44));
  FDRE #(
    .INIT(1'b0)) 
    \boot_state_reg[2] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_29),
        .D(\boot_state[2]_i_1_n_0 ),
        .Q(\boot_state_reg_n_0_[2] ),
        .R(uart_inst_n_44));
  FDRE #(
    .INIT(1'b0)) 
    \boot_state_reg[3] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_29),
        .D(\boot_state[3]_i_3_n_0 ),
        .Q(\boot_state_reg_n_0_[3] ),
        .R(uart_inst_n_44));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[2]),
        .Q(bram_addr[0]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[12]),
        .Q(bram_addr[10]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[13]),
        .Q(bram_addr[11]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[14]),
        .Q(bram_addr[12]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[15]),
        .Q(bram_addr[13]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[3]),
        .Q(bram_addr[1]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[4]),
        .Q(bram_addr[2]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[5]),
        .Q(bram_addr[3]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[6]),
        .Q(bram_addr[4]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[7]),
        .Q(bram_addr[5]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[8]),
        .Q(bram_addr[6]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[9]),
        .Q(bram_addr[7]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[10]),
        .Q(bram_addr[8]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_addr_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_address[11]),
        .Q(bram_addr[9]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[0]),
        .Q(bram_din[0]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[10]),
        .Q(bram_din[10]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[11]),
        .Q(bram_din[11]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[12]),
        .Q(bram_din[12]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[13]),
        .Q(bram_din[13]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[14]),
        .Q(bram_din[14]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[15]),
        .Q(bram_din[15]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[16]),
        .Q(bram_din[16]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[17]),
        .Q(bram_din[17]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[18]),
        .Q(bram_din[18]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[19]),
        .Q(bram_din[19]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[1]),
        .Q(bram_din[1]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[20]),
        .Q(bram_din[20]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[21]),
        .Q(bram_din[21]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[22]),
        .Q(bram_din[22]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[23]),
        .Q(bram_din[23]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[24]),
        .Q(bram_din[24]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[25]),
        .Q(bram_din[25]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[26]),
        .Q(bram_din[26]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[27]),
        .Q(bram_din[27]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[28]),
        .Q(bram_din[28]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[29]),
        .Q(bram_din[29]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[2]),
        .Q(bram_din[2]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[30]),
        .Q(bram_din[30]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[31]),
        .Q(bram_din[31]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[3]),
        .Q(bram_din[3]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[4]),
        .Q(bram_din[4]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[5]),
        .Q(bram_din[5]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[6]),
        .Q(bram_din[6]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[7]),
        .Q(bram_din[7]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[8]),
        .Q(bram_din[8]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \bram_din_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(bram_addr_reg),
        .D(boot_data[9]),
        .Q(bram_din[9]),
        .R(uart_inst_n_1));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    bram_en_reg_i_3
       (.I0(\boot_command_reg_n_0_[2] ),
        .I1(\boot_command_reg_n_0_[0] ),
        .I2(\boot_command_reg_n_0_[1] ),
        .I3(bram_en_reg_i_5_n_0),
        .I4(boot_address[1]),
        .I5(boot_address[0]),
        .O(bram_en_reg_i_3_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    bram_en_reg_i_5
       (.I0(boot_command[5]),
        .I1(boot_command[4]),
        .I2(boot_command[3]),
        .I3(boot_command[7]),
        .I4(boot_command[6]),
        .O(bram_en_reg_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    bram_en_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_56),
        .Q(bram_en),
        .R(bram_en_reg));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \bram_we_reg[3]_i_2 
       (.I0(\boot_state_reg_n_0_[0] ),
        .I1(\boot_state_reg_n_0_[3] ),
        .I2(\boot_state_reg_n_0_[1] ),
        .O(\bram_we_reg[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bram_we_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_55),
        .Q(bram_we),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFEFFF0000E000)) 
    \bresp_reg[1]_i_1 
       (.I0(\bresp_reg[1]_i_2_n_0 ),
        .I1(npu_boot_active),
        .I2(aw_hold),
        .I3(w_hold_reg_n_0),
        .I4(bvalid_reg_reg_0),
        .I5(s_axi_bresp),
        .O(\bresp_reg[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFAFFAEFFFAFFAAF)) 
    \bresp_reg[1]_i_2 
       (.I0(p_2_in[3]),
        .I1(\wstrb_hold_reg_n_0_[0] ),
        .I2(p_2_in[0]),
        .I3(p_2_in[2]),
        .I4(p_2_in[1]),
        .I5(tx_count_reg[4]),
        .O(\bresp_reg[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \bresp_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bresp_reg[1]_i_1_n_0 ),
        .Q(s_axi_bresp),
        .R(uart_inst_n_1));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h7444)) 
    bvalid_reg_i_1
       (.I0(s_axi_bready),
        .I1(bvalid_reg_reg_0),
        .I2(w_hold_reg_n_0),
        .I3(aw_hold),
        .O(bvalid_reg_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    bvalid_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bvalid_reg_i_1_n_0),
        .Q(bvalid_reg_reg_0),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    frame_error_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_62),
        .Q(frame_error),
        .R(uart_inst_n_1));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \irq_enable_reg[3]_i_1 
       (.I0(\irq_enable_reg[3]_i_2_n_0 ),
        .I1(p_2_in[3]),
        .I2(\wstrb_hold_reg_n_0_[0] ),
        .I3(p_2_in[1]),
        .I4(p_2_in[0]),
        .I5(p_2_in[2]),
        .O(irq_enable_reg));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    \irq_enable_reg[3]_i_2 
       (.I0(bvalid_reg_reg_0),
        .I1(w_hold_reg_n_0),
        .I2(aw_hold),
        .I3(npu_boot_active),
        .O(\irq_enable_reg[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \irq_enable_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(irq_enable_reg),
        .D(\wdata_hold_reg_n_0_[0] ),
        .Q(p_5_in[0]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \irq_enable_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(irq_enable_reg),
        .D(\wdata_hold_reg_n_0_[1] ),
        .Q(p_5_in[1]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \irq_enable_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(irq_enable_reg),
        .D(\wdata_hold_reg_n_0_[2] ),
        .Q(p_5_in[2]),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \irq_enable_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(irq_enable_reg),
        .D(\wdata_hold_reg_n_0_[3] ),
        .Q(p_5_in[3]),
        .R(uart_inst_n_1));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h0004FFFF)) 
    \npu_address[12]_i_2 
       (.I0(\boot_command_reg_n_0_[2] ),
        .I1(\boot_command_reg_n_0_[0] ),
        .I2(\boot_command_reg_n_0_[1] ),
        .I3(bram_en_reg_i_5_n_0),
        .I4(npu_ready),
        .O(\npu_address[12]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[10] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[10]),
        .Q(npu_scratchpad_addr[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[11] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[11]),
        .Q(npu_scratchpad_addr[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[12] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[12]),
        .Q(npu_scratchpad_addr[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[13] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[13]),
        .Q(npu_scratchpad_addr[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[14] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[14]),
        .Q(npu_scratchpad_addr[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[15] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[15]),
        .Q(npu_scratchpad_addr[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[16] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[16]),
        .Q(npu_scratchpad_addr[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[17] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[17]),
        .Q(npu_scratchpad_addr[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[2] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[2]),
        .Q(npu_scratchpad_addr[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[3] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[3]),
        .Q(npu_scratchpad_addr[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[4] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[4]),
        .Q(npu_scratchpad_addr[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[5] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[5]),
        .Q(npu_scratchpad_addr[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[6] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[6]),
        .Q(npu_scratchpad_addr[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[7] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[7]),
        .Q(npu_scratchpad_addr[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[8] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[8]),
        .Q(npu_scratchpad_addr[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_address_reg[9] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_address[9]),
        .Q(npu_scratchpad_addr[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[0]),
        .Q(npu_instr_din[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[10] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[10]),
        .Q(npu_instr_din[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[11] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[11]),
        .Q(npu_instr_din[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[12] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[12]),
        .Q(npu_instr_din[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[13] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[13]),
        .Q(npu_instr_din[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[14] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[14]),
        .Q(npu_instr_din[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[15] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[15]),
        .Q(npu_instr_din[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[16] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[16]),
        .Q(npu_instr_din[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[17] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[17]),
        .Q(npu_instr_din[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[18] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[18]),
        .Q(npu_instr_din[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[19] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[19]),
        .Q(npu_instr_din[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[1]),
        .Q(npu_instr_din[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[20] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[20]),
        .Q(npu_instr_din[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[21] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[21]),
        .Q(npu_instr_din[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[22] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[22]),
        .Q(npu_instr_din[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[23] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[23]),
        .Q(npu_instr_din[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[24] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[24]),
        .Q(npu_instr_din[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[25] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[25]),
        .Q(npu_instr_din[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[26] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[26]),
        .Q(npu_instr_din[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[27] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[27]),
        .Q(npu_instr_din[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[28] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[28]),
        .Q(npu_instr_din[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[29] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[29]),
        .Q(npu_instr_din[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[2]),
        .Q(npu_instr_din[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[30] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[30]),
        .Q(npu_instr_din[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[31] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[31]),
        .Q(npu_instr_din[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[32] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data_hi[0]),
        .Q(npu_instr_din[32]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[33] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data_hi[1]),
        .Q(npu_instr_din[33]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[34] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data_hi[2]),
        .Q(npu_instr_din[34]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[35] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data_hi[3]),
        .Q(npu_instr_din[35]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[3]),
        .Q(npu_instr_din[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[4]),
        .Q(npu_instr_din[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[5]),
        .Q(npu_instr_din[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[6]),
        .Q(npu_instr_din[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[7]),
        .Q(npu_instr_din[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[8] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[8]),
        .Q(npu_instr_din[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \npu_data_reg[9] 
       (.C(s_axi_aclk),
        .CE(npu_address),
        .D(boot_data[9]),
        .Q(npu_instr_din[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    npu_i_we_i_2
       (.I0(\boot_reply[1]_i_5_n_0 ),
        .I1(npu_i_we_i_3_n_0),
        .I2(bram_en_reg_i_5_n_0),
        .I3(\boot_command_reg_n_0_[2] ),
        .I4(\boot_command_reg_n_0_[1] ),
        .I5(\boot_command_reg_n_0_[0] ),
        .O(npu_i_we_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    npu_i_we_i_3
       (.I0(boot_address[16]),
        .I1(boot_address[13]),
        .I2(\boot_data_hi_reg_n_0_[6] ),
        .I3(boot_address[17]),
        .I4(\boot_reply[1]_i_10_n_0 ),
        .I5(\boot_reply[1]_i_9_n_0 ),
        .O(npu_i_we_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    npu_i_we_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_53),
        .Q(npu_i_we_reg_n_0),
        .R(bram_en_reg));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    npu_instr_we_INST_0
       (.I0(npu_i_we_reg_n_0),
        .I1(npu_ready),
        .I2(npu_boot_active),
        .I3(s_axi_aresetn),
        .O(npu_instr_we));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    npu_s_we_i_2
       (.I0(npu_w_we_i_3_n_0),
        .I1(bram_en_reg_i_5_n_0),
        .I2(npu_w_we_i_4_n_0),
        .I3(npu_w_we_i_5_n_0),
        .I4(npu_w_we_i_6_n_0),
        .I5(npu_s_we_i_3_n_0),
        .O(npu_s_we_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    npu_s_we_i_3
       (.I0(\boot_command_reg_n_0_[0] ),
        .I1(\boot_command_reg_n_0_[2] ),
        .I2(\boot_command_reg_n_0_[1] ),
        .O(npu_s_we_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    npu_s_we_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_51),
        .Q(npu_s_we_reg_n_0),
        .R(bram_en_reg));
  LUT4 #(
    .INIT(16'h8000)) 
    npu_scratchpad_we_INST_0
       (.I0(npu_s_we_reg_n_0),
        .I1(npu_ready),
        .I2(npu_boot_active),
        .I3(s_axi_aresetn),
        .O(npu_scratchpad_we));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFFFF)) 
    npu_w_we_i_2
       (.I0(npu_w_we_i_3_n_0),
        .I1(bram_en_reg_i_5_n_0),
        .I2(npu_w_we_i_4_n_0),
        .I3(npu_w_we_i_5_n_0),
        .I4(npu_w_we_i_6_n_0),
        .I5(npu_w_we_i_7_n_0),
        .O(npu_w_we_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'hE)) 
    npu_w_we_i_3
       (.I0(boot_address[0]),
        .I1(boot_address[1]),
        .O(npu_w_we_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    npu_w_we_i_4
       (.I0(boot_address[25]),
        .I1(boot_address[28]),
        .I2(boot_address[18]),
        .I3(boot_address[22]),
        .O(npu_w_we_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    npu_w_we_i_5
       (.I0(boot_address[24]),
        .I1(boot_address[26]),
        .I2(boot_address[21]),
        .I3(boot_address[30]),
        .O(npu_w_we_i_5_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    npu_w_we_i_6
       (.I0(boot_address[20]),
        .I1(boot_address[23]),
        .I2(boot_address[29]),
        .I3(boot_address[19]),
        .I4(boot_address[31]),
        .I5(boot_address[27]),
        .O(npu_w_we_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    npu_w_we_i_7
       (.I0(\boot_command_reg_n_0_[1] ),
        .I1(\boot_command_reg_n_0_[2] ),
        .I2(\boot_command_reg_n_0_[0] ),
        .O(npu_w_we_i_7_n_0));
  FDRE #(
    .INIT(1'b0)) 
    npu_w_we_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_52),
        .Q(npu_w_we_reg_n_0),
        .R(bram_en_reg));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    npu_weight_we_INST_0
       (.I0(npu_w_we_reg_n_0),
        .I1(npu_ready),
        .I2(npu_boot_active),
        .I3(s_axi_aresetn),
        .O(npu_weight_we));
  FDRE #(
    .INIT(1'b0)) 
    overrun_error_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_inst_n_61),
        .Q(overrun_error),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hABABABAAAAAAAAAA)) 
    \rdata_reg[0]_i_1 
       (.I0(\rdata_reg[0]_i_2_n_0 ),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[2]),
        .I3(temp0[0]),
        .I4(s_axi_araddr[1]),
        .I5(\rdata_reg[0]_i_3_n_0 ),
        .O(p_1_in[0]));
  LUT6 #(
    .INIT(64'h0100000011001000)) 
    \rdata_reg[0]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[1]),
        .I2(s_axi_araddr[0]),
        .I3(s_axi_araddr[2]),
        .I4(p_5_in[0]),
        .I5(uart_irq_INST_0_i_3_n_0),
        .O(\rdata_reg[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h5555555555555554)) 
    \rdata_reg[0]_i_3 
       (.I0(s_axi_araddr[0]),
        .I1(rx_count_reg[0]),
        .I2(rx_count_reg[1]),
        .I3(rx_count_reg[3]),
        .I4(rx_count_reg[2]),
        .I5(rx_count_reg[4]),
        .O(\rdata_reg[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF44444F44)) 
    \rdata_reg[1]_i_1 
       (.I0(\rdata_reg[7]_i_4_n_0 ),
        .I1(temp0[1]),
        .I2(\rdata_reg[6]_i_2_n_0 ),
        .I3(rx_count_reg[4]),
        .I4(\rdata_reg[1]_i_2_n_0 ),
        .I5(\rdata_reg[1]_i_3_n_0 ),
        .O(p_1_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rdata_reg[1]_i_2 
       (.I0(rx_count_reg[0]),
        .I1(rx_count_reg[1]),
        .I2(rx_count_reg[3]),
        .I3(rx_count_reg[2]),
        .O(\rdata_reg[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0405000004000000)) 
    \rdata_reg[1]_i_3 
       (.I0(s_axi_araddr[3]),
        .I1(uart_inst_n_12),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[0]),
        .I4(s_axi_araddr[2]),
        .I5(p_5_in[1]),
        .O(\rdata_reg[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \rdata_reg[2]_i_1 
       (.I0(\rdata_reg[7]_i_4_n_0 ),
        .I1(temp0[2]),
        .I2(uart_inst_n_12),
        .I3(\rdata_reg[6]_i_2_n_0 ),
        .I4(\rdata_reg[2]_i_2_n_0 ),
        .O(p_1_in[2]));
  LUT6 #(
    .INIT(64'h0405000004000000)) 
    \rdata_reg[2]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(overrun_error),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[0]),
        .I4(s_axi_araddr[2]),
        .I5(p_5_in[2]),
        .O(\rdata_reg[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF44444F44)) 
    \rdata_reg[3]_i_1 
       (.I0(\rdata_reg[7]_i_4_n_0 ),
        .I1(temp0[3]),
        .I2(\rdata_reg[6]_i_2_n_0 ),
        .I3(tx_count_reg[4]),
        .I4(\rdata_reg[3]_i_2_n_0 ),
        .I5(\rdata_reg[3]_i_3_n_0 ),
        .O(p_1_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rdata_reg[3]_i_2 
       (.I0(tx_count_reg[0]),
        .I1(tx_count_reg[1]),
        .I2(tx_count_reg[3]),
        .I3(tx_count_reg[2]),
        .O(\rdata_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0405000004000000)) 
    \rdata_reg[3]_i_3 
       (.I0(s_axi_araddr[3]),
        .I1(frame_error),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[0]),
        .I4(s_axi_araddr[2]),
        .I5(p_5_in[3]),
        .O(\rdata_reg[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \rdata_reg[4]_i_1 
       (.I0(temp0[4]),
        .I1(\rdata_reg[7]_i_4_n_0 ),
        .O(p_1_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    \rdata_reg[5]_i_1 
       (.I0(\rdata_reg[6]_i_2_n_0 ),
        .I1(overrun_error),
        .I2(\rdata_reg[7]_i_4_n_0 ),
        .I3(temp0[5]),
        .O(p_1_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'h4F44)) 
    \rdata_reg[6]_i_1 
       (.I0(\rdata_reg[7]_i_4_n_0 ),
        .I1(temp0[6]),
        .I2(\rdata_reg[6]_i_2_n_0 ),
        .I3(frame_error),
        .O(p_1_in[6]));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \rdata_reg[6]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[2]),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[0]),
        .O(\rdata_reg[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h08FF)) 
    \rdata_reg[7]_i_1 
       (.I0(npu_boot_active),
        .I1(s_axi_arvalid),
        .I2(rvalid_reg_reg_0),
        .I3(s_axi_aresetn),
        .O(\rdata_reg[7]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \rdata_reg[7]_i_2 
       (.I0(s_axi_arvalid),
        .I1(rvalid_reg_reg_0),
        .O(axi_rx_pop1));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \rdata_reg[7]_i_3 
       (.I0(temp0[7]),
        .I1(\rdata_reg[7]_i_4_n_0 ),
        .O(p_1_in[7]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \rdata_reg[7]_i_4 
       (.I0(uart_irq_INST_0_i_3_n_0),
        .I1(s_axi_araddr[0]),
        .I2(s_axi_araddr[2]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[1]),
        .O(\rdata_reg[7]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[0]),
        .Q(s_axi_rdata[0]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[1]),
        .Q(s_axi_rdata[1]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[2]),
        .Q(s_axi_rdata[2]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[3]),
        .Q(s_axi_rdata[3]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[4]),
        .Q(s_axi_rdata[4]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[5]),
        .Q(s_axi_rdata[5]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[6]),
        .Q(s_axi_rdata[6]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rdata_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(axi_rx_pop1),
        .D(p_1_in[7]),
        .Q(s_axi_rdata[7]),
        .R(\rdata_reg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'hFFEF00E0)) 
    \rresp_reg[1]_i_1 
       (.I0(out0),
        .I1(npu_boot_active),
        .I2(s_axi_arvalid),
        .I3(rvalid_reg_reg_0),
        .I4(s_axi_rresp),
        .O(\rresp_reg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'hEBEBEBEA)) 
    \rresp_reg[1]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[2]),
        .I2(s_axi_araddr[1]),
        .I3(uart_irq_INST_0_i_3_n_0),
        .I4(s_axi_araddr[0]),
        .O(out0));
  FDRE #(
    .INIT(1'b0)) 
    \rresp_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rresp_reg[1]_i_1_n_0 ),
        .Q(s_axi_rresp),
        .R(uart_inst_n_1));
  LUT3 #(
    .INIT(8'h74)) 
    rvalid_reg_i_1
       (.I0(s_axi_rready),
        .I1(rvalid_reg_reg_0),
        .I2(s_axi_arvalid),
        .O(rvalid_reg_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    rvalid_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rvalid_reg_i_1_n_0),
        .Q(rvalid_reg_reg_0),
        .R(uart_inst_n_1));
  LUT1 #(
    .INIT(2'h1)) 
    \rx_count[0]_i_1 
       (.I0(rx_count_reg[0]),
        .O(\rx_count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_7),
        .D(\rx_count[0]_i_1_n_0 ),
        .Q(rx_count_reg[0]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_7),
        .D(uart_inst_n_6),
        .Q(rx_count_reg[1]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_7),
        .D(uart_inst_n_5),
        .Q(rx_count_reg[2]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_7),
        .D(uart_inst_n_4),
        .Q(rx_count_reg[3]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_7),
        .D(uart_inst_n_3),
        .Q(rx_count_reg[4]),
        .R(rx_count));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M rx_fifo_reg_0_15_0_5
       (.ADDRA({1'b0,rx_rd_ptr}),
        .ADDRB({1'b0,rx_rd_ptr}),
        .ADDRC({1'b0,rx_rd_ptr}),
        .ADDRD({1'b0,rx_wr_ptr}),
        .DIA(phy_rx_data[1:0]),
        .DIB(phy_rx_data[3:2]),
        .DIC(phy_rx_data[5:4]),
        .DID({1'b0,1'b0}),
        .DOA(temp0[1:0]),
        .DOB(temp0[3:2]),
        .DOC(temp0[5:4]),
        .DOD(NLW_rx_fifo_reg_0_15_0_5_DOD_UNCONNECTED[1:0]),
        .WCLK(s_axi_aclk),
        .WE(p_0_in));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg_0_15_6_7" *) 
  (* RTL_RAM_STYLE = "NONE" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM32X1D rx_fifo_reg_0_15_6_7
       (.A0(rx_wr_ptr[0]),
        .A1(rx_wr_ptr[1]),
        .A2(rx_wr_ptr[2]),
        .A3(rx_wr_ptr[3]),
        .A4(1'b0),
        .D(phy_rx_data[6]),
        .DPO(temp0[6]),
        .DPRA0(rx_rd_ptr[0]),
        .DPRA1(rx_rd_ptr[1]),
        .DPRA2(rx_rd_ptr[2]),
        .DPRA3(rx_rd_ptr[3]),
        .DPRA4(1'b0),
        .SPO(NLW_rx_fifo_reg_0_15_6_7_SPO_UNCONNECTED),
        .WCLK(s_axi_aclk),
        .WE(p_0_in));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/rx_fifo_reg_0_15_6_7" *) 
  (* RTL_RAM_STYLE = "NONE" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM32X1D rx_fifo_reg_0_15_6_7__0
       (.A0(rx_wr_ptr[0]),
        .A1(rx_wr_ptr[1]),
        .A2(rx_wr_ptr[2]),
        .A3(rx_wr_ptr[3]),
        .A4(1'b0),
        .D(phy_rx_data[7]),
        .DPO(temp0[7]),
        .DPRA0(rx_rd_ptr[0]),
        .DPRA1(rx_rd_ptr[1]),
        .DPRA2(rx_rd_ptr[2]),
        .DPRA3(rx_rd_ptr[3]),
        .DPRA4(1'b0),
        .SPO(NLW_rx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED),
        .WCLK(s_axi_aclk),
        .WE(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rx_rd_ptr[0]_i_1 
       (.I0(rx_rd_ptr__0[0]),
        .O(\rx_rd_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rx_rd_ptr[1]_i_1 
       (.I0(rx_rd_ptr__0[1]),
        .I1(rx_rd_ptr__0[0]),
        .O(\rx_rd_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \rx_rd_ptr[2]_i_1 
       (.I0(rx_rd_ptr__0[1]),
        .I1(rx_rd_ptr__0[0]),
        .I2(rx_rd_ptr__0[2]),
        .O(\rx_rd_ptr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \rx_rd_ptr[3]_i_1 
       (.I0(rx_rd_ptr__0[1]),
        .I1(rx_rd_ptr__0[0]),
        .I2(rx_rd_ptr__0[2]),
        .I3(rx_rd_ptr__0[3]),
        .O(\rx_rd_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg[0] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr[0]_i_1_n_0 ),
        .Q(rx_rd_ptr__0[0]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg[1] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr[1]_i_1_n_0 ),
        .Q(rx_rd_ptr__0[1]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg[2] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr[2]_i_1_n_0 ),
        .Q(rx_rd_ptr__0[2]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg[3] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr[3]_i_1_n_0 ),
        .Q(rx_rd_ptr__0[3]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg_rep[0] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr_rep[0]_i_1_n_0 ),
        .Q(rx_rd_ptr[0]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg_rep[1] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr_rep[1]_i_1_n_0 ),
        .Q(rx_rd_ptr[1]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg_rep[2] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr_rep[2]_i_1_n_0 ),
        .Q(rx_rd_ptr[2]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_rd_ptr_reg_rep[3] 
       (.C(s_axi_aclk),
        .CE(rx_rd_ptr0),
        .D(\rx_rd_ptr_rep[3]_i_2_n_0 ),
        .Q(rx_rd_ptr[3]),
        .R(rx_count));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rx_rd_ptr_rep[0]_i_1 
       (.I0(rx_rd_ptr__0[0]),
        .O(\rx_rd_ptr_rep[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rx_rd_ptr_rep[1]_i_1 
       (.I0(rx_rd_ptr__0[0]),
        .I1(rx_rd_ptr__0[1]),
        .O(\rx_rd_ptr_rep[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rx_rd_ptr_rep[2]_i_1 
       (.I0(rx_rd_ptr__0[2]),
        .I1(rx_rd_ptr__0[0]),
        .I2(rx_rd_ptr__0[1]),
        .O(\rx_rd_ptr_rep[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \rx_rd_ptr_rep[3]_i_1 
       (.I0(axi_rx_pop),
        .I1(rx_count_reg[0]),
        .I2(rx_count_reg[1]),
        .I3(rx_count_reg[3]),
        .I4(rx_count_reg[2]),
        .I5(rx_count_reg[4]),
        .O(rx_rd_ptr0));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rx_rd_ptr_rep[3]_i_2 
       (.I0(rx_rd_ptr__0[3]),
        .I1(rx_rd_ptr__0[2]),
        .I2(rx_rd_ptr__0[0]),
        .I3(rx_rd_ptr__0[1]),
        .O(\rx_rd_ptr_rep[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \rx_wr_ptr[0]_i_1 
       (.I0(rx_wr_ptr[0]),
        .O(\rx_wr_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \rx_wr_ptr[1]_i_1 
       (.I0(rx_wr_ptr[0]),
        .I1(rx_wr_ptr[1]),
        .O(\rx_wr_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \rx_wr_ptr[2]_i_1 
       (.I0(rx_wr_ptr[2]),
        .I1(rx_wr_ptr[0]),
        .I2(rx_wr_ptr[1]),
        .O(\rx_wr_ptr[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \rx_wr_ptr[3]_i_1 
       (.I0(axi_rx_fifo_reset_reg_n_0),
        .I1(s_axi_aresetn),
        .O(rx_count));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \rx_wr_ptr[3]_i_3 
       (.I0(rx_wr_ptr[3]),
        .I1(rx_wr_ptr[2]),
        .I2(rx_wr_ptr[0]),
        .I3(rx_wr_ptr[1]),
        .O(\rx_wr_ptr[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_wr_ptr_reg[0] 
       (.C(s_axi_aclk),
        .CE(p_33_in),
        .D(\rx_wr_ptr[0]_i_1_n_0 ),
        .Q(rx_wr_ptr[0]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_wr_ptr_reg[1] 
       (.C(s_axi_aclk),
        .CE(p_33_in),
        .D(\rx_wr_ptr[1]_i_1_n_0 ),
        .Q(rx_wr_ptr[1]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_wr_ptr_reg[2] 
       (.C(s_axi_aclk),
        .CE(p_33_in),
        .D(\rx_wr_ptr[2]_i_1_n_0 ),
        .Q(rx_wr_ptr[2]),
        .R(rx_count));
  FDRE #(
    .INIT(1'b0)) 
    \rx_wr_ptr_reg[3] 
       (.C(s_axi_aclk),
        .CE(p_33_in),
        .D(\rx_wr_ptr[3]_i_3_n_0 ),
        .Q(rx_wr_ptr[3]),
        .R(rx_count));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT1 #(
    .INIT(2'h1)) 
    s_axi_arready_INST_0
       (.I0(rvalid_reg_reg_0),
        .O(s_axi_arready));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h1)) 
    s_axi_awready_INST_0
       (.I0(bvalid_reg_reg_0),
        .I1(aw_hold),
        .O(s_axi_awready));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h1)) 
    s_axi_wready_INST_0
       (.I0(bvalid_reg_reg_0),
        .I1(w_hold_reg_n_0),
        .O(s_axi_wready));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \tx_count[0]_i_1 
       (.I0(tx_count_reg[0]),
        .O(\tx_count[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_26),
        .D(\tx_count[0]_i_1_n_0 ),
        .Q(tx_count_reg[0]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_26),
        .D(uart_inst_n_11),
        .Q(tx_count_reg[1]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_26),
        .D(uart_inst_n_10),
        .Q(tx_count_reg[2]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_26),
        .D(uart_inst_n_9),
        .Q(tx_count_reg[3]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(uart_inst_n_26),
        .D(uart_inst_n_8),
        .Q(tx_count_reg[4]),
        .R(tx_count));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "5" *) 
  RAM32M tx_fifo_reg_0_15_0_5
       (.ADDRA({1'b0,tx_rd_ptr}),
        .ADDRB({1'b0,tx_rd_ptr}),
        .ADDRC({1'b0,tx_rd_ptr}),
        .ADDRD({1'b0,tx_wr_ptr}),
        .DIA(axi_tx_data[1:0]),
        .DIB(axi_tx_data[3:2]),
        .DIC(axi_tx_data[5:4]),
        .DID({1'b0,1'b0}),
        .DOA(phy_tx_data0[1:0]),
        .DOB(phy_tx_data0[3:2]),
        .DOC(phy_tx_data0[5:4]),
        .DOD(NLW_tx_fifo_reg_0_15_0_5_DOD_UNCONNECTED[1:0]),
        .WCLK(s_axi_aclk),
        .WE(tx_fifo_reg_0_15_0_5_i_1_n_0));
  LUT4 #(
    .INIT(16'h0040)) 
    tx_fifo_reg_0_15_0_5_i_1
       (.I0(tx_count_reg[4]),
        .I1(axi_tx_push_reg_n_0),
        .I2(s_axi_aresetn),
        .I3(axi_tx_fifo_reset_reg_n_0),
        .O(tx_fifo_reg_0_15_0_5_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg_0_15_6_7" *) 
  (* RTL_RAM_STYLE = "NONE" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "6" *) 
  RAM32X1D tx_fifo_reg_0_15_6_7
       (.A0(tx_wr_ptr[0]),
        .A1(tx_wr_ptr[1]),
        .A2(tx_wr_ptr[2]),
        .A3(tx_wr_ptr[3]),
        .A4(1'b0),
        .D(axi_tx_data[6]),
        .DPO(phy_tx_data0[6]),
        .DPRA0(tx_rd_ptr[0]),
        .DPRA1(tx_rd_ptr[1]),
        .DPRA2(tx_rd_ptr[2]),
        .DPRA3(tx_rd_ptr[3]),
        .DPRA4(1'b0),
        .SPO(NLW_tx_fifo_reg_0_15_6_7_SPO_UNCONNECTED),
        .WCLK(s_axi_aclk),
        .WE(tx_fifo_reg_0_15_0_5_i_1_n_0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "128" *) 
  (* RTL_RAM_NAME = "design_1_axi_uart_bootloader_1_0/inst/u_axi_uart_bootloader/tx_fifo_reg_0_15_6_7" *) 
  (* RTL_RAM_STYLE = "NONE" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "7" *) 
  (* ram_slice_end = "7" *) 
  RAM32X1D tx_fifo_reg_0_15_6_7__0
       (.A0(tx_wr_ptr[0]),
        .A1(tx_wr_ptr[1]),
        .A2(tx_wr_ptr[2]),
        .A3(tx_wr_ptr[3]),
        .A4(1'b0),
        .D(axi_tx_data[7]),
        .DPO(phy_tx_data0[7]),
        .DPRA0(tx_rd_ptr[0]),
        .DPRA1(tx_rd_ptr[1]),
        .DPRA2(tx_rd_ptr[2]),
        .DPRA3(tx_rd_ptr[3]),
        .DPRA4(1'b0),
        .SPO(NLW_tx_fifo_reg_0_15_6_7__0_SPO_UNCONNECTED),
        .WCLK(s_axi_aclk),
        .WE(tx_fifo_reg_0_15_0_5_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \tx_rd_ptr[0]_i_1 
       (.I0(tx_rd_ptr__0[0]),
        .O(\tx_rd_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \tx_rd_ptr[1]_i_1 
       (.I0(tx_rd_ptr__0[1]),
        .I1(tx_rd_ptr__0[0]),
        .O(\tx_rd_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \tx_rd_ptr[2]_i_1 
       (.I0(tx_rd_ptr__0[1]),
        .I1(tx_rd_ptr__0[0]),
        .I2(tx_rd_ptr__0[2]),
        .O(\tx_rd_ptr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \tx_rd_ptr[3]_i_1 
       (.I0(tx_rd_ptr__0[1]),
        .I1(tx_rd_ptr__0[0]),
        .I2(tx_rd_ptr__0[2]),
        .I3(tx_rd_ptr__0[3]),
        .O(\tx_rd_ptr[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg[0] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr[0]_i_1_n_0 ),
        .Q(tx_rd_ptr__0[0]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg[1] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr[1]_i_1_n_0 ),
        .Q(tx_rd_ptr__0[1]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg[2] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr[2]_i_1_n_0 ),
        .Q(tx_rd_ptr__0[2]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg[3] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr[3]_i_1_n_0 ),
        .Q(tx_rd_ptr__0[3]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg_rep[0] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr_rep[0]_i_1_n_0 ),
        .Q(tx_rd_ptr[0]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg_rep[1] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr_rep[1]_i_1_n_0 ),
        .Q(tx_rd_ptr[1]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg_rep[2] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr_rep[2]_i_1_n_0 ),
        .Q(tx_rd_ptr[2]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_rd_ptr_reg_rep[3] 
       (.C(s_axi_aclk),
        .CE(tx_rd_ptr0),
        .D(\tx_rd_ptr_rep[3]_i_2_n_0 ),
        .Q(tx_rd_ptr[3]),
        .R(tx_count));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \tx_rd_ptr_rep[0]_i_1 
       (.I0(tx_rd_ptr__0[0]),
        .O(\tx_rd_ptr_rep[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \tx_rd_ptr_rep[1]_i_1 
       (.I0(tx_rd_ptr__0[0]),
        .I1(tx_rd_ptr__0[1]),
        .O(\tx_rd_ptr_rep[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \tx_rd_ptr_rep[2]_i_1 
       (.I0(tx_rd_ptr__0[2]),
        .I1(tx_rd_ptr__0[0]),
        .I2(tx_rd_ptr__0[1]),
        .O(\tx_rd_ptr_rep[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \tx_rd_ptr_rep[3]_i_2 
       (.I0(tx_rd_ptr__0[3]),
        .I1(tx_rd_ptr__0[2]),
        .I2(tx_rd_ptr__0[0]),
        .I3(tx_rd_ptr__0[1]),
        .O(\tx_rd_ptr_rep[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \tx_wr_ptr[0]_i_1 
       (.I0(tx_wr_ptr[0]),
        .O(\tx_wr_ptr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \tx_wr_ptr[1]_i_1 
       (.I0(tx_wr_ptr[0]),
        .I1(tx_wr_ptr[1]),
        .O(\tx_wr_ptr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \tx_wr_ptr[2]_i_1 
       (.I0(tx_wr_ptr[2]),
        .I1(tx_wr_ptr[0]),
        .I2(tx_wr_ptr[1]),
        .O(\tx_wr_ptr[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \tx_wr_ptr[3]_i_1 
       (.I0(axi_tx_fifo_reset_reg_n_0),
        .I1(s_axi_aresetn),
        .O(tx_count));
  LUT2 #(
    .INIT(4'h2)) 
    \tx_wr_ptr[3]_i_2 
       (.I0(axi_tx_push_reg_n_0),
        .I1(tx_count_reg[4]),
        .O(tx_wr_ptr0));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \tx_wr_ptr[3]_i_3 
       (.I0(tx_wr_ptr[3]),
        .I1(tx_wr_ptr[2]),
        .I2(tx_wr_ptr[0]),
        .I3(tx_wr_ptr[1]),
        .O(\tx_wr_ptr[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_wr_ptr_reg[0] 
       (.C(s_axi_aclk),
        .CE(tx_wr_ptr0),
        .D(\tx_wr_ptr[0]_i_1_n_0 ),
        .Q(tx_wr_ptr[0]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_wr_ptr_reg[1] 
       (.C(s_axi_aclk),
        .CE(tx_wr_ptr0),
        .D(\tx_wr_ptr[1]_i_1_n_0 ),
        .Q(tx_wr_ptr[1]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_wr_ptr_reg[2] 
       (.C(s_axi_aclk),
        .CE(tx_wr_ptr0),
        .D(\tx_wr_ptr[2]_i_1_n_0 ),
        .Q(tx_wr_ptr[2]),
        .R(tx_count));
  FDRE #(
    .INIT(1'b0)) 
    \tx_wr_ptr_reg[3] 
       (.C(s_axi_aclk),
        .CE(tx_wr_ptr0),
        .D(\tx_wr_ptr[3]_i_3_n_0 ),
        .Q(tx_wr_ptr[3]),
        .R(tx_count));
  design_1_axi_uart_bootloader_1_0_uart_phy uart_inst
       (.D({uart_inst_n_3,uart_inst_n_4,uart_inst_n_5,uart_inst_n_6}),
        .E(uart_inst_n_7),
        .Q(rx_count_reg),
        .SR(uart_inst_n_1),
        .axi_error_clear_reg(uart_inst_n_62),
        .boot_active_reg(p_33_in),
        .boot_active_reg_0(bram_addr_reg),
        .\boot_checksum_reg[0] (\boot_checksum[7]_i_3_n_0 ),
        .\boot_checksum_reg[7] (uart_inst_n_50),
        .\boot_checksum_reg[7]_0 ({\boot_checksum_reg_n_0_[7] ,\boot_checksum_reg_n_0_[6] ,\boot_checksum_reg_n_0_[5] ,\boot_checksum_reg_n_0_[4] ,\boot_checksum_reg_n_0_[3] ,\boot_checksum_reg_n_0_[2] ,\boot_checksum_reg_n_0_[1] ,\boot_checksum_reg_n_0_[0] }),
        .boot_data_hi_0(boot_data_hi_0),
        .boot_reply_pending_reg(uart_inst_n_24),
        .boot_reply_pending_reg_0(npu_boot_active),
        .boot_reply_pending_reg_1(boot_reply_pending_reg_n_0),
        .\boot_state_reg[0] (boot_command_1),
        .\boot_state_reg[0]_0 ({uart_inst_n_30,uart_inst_n_31,uart_inst_n_32,uart_inst_n_33,uart_inst_n_34,uart_inst_n_35,uart_inst_n_36,uart_inst_n_37}),
        .\boot_state_reg[0]_1 (uart_inst_n_56),
        .\boot_state_reg[0]_2 ({\boot_state_reg_n_0_[3] ,\boot_state_reg_n_0_[2] ,\boot_state_reg_n_0_[1] ,\boot_state_reg_n_0_[0] }),
        .\boot_state_reg[1] (uart_inst_n_42),
        .\boot_state_reg[1]_0 (npu_address),
        .\boot_state_reg[1]_1 (uart_inst_n_51),
        .\boot_state_reg[1]_2 (uart_inst_n_52),
        .\boot_state_reg[1]_3 (uart_inst_n_53),
        .\boot_state_reg[2] (uart_inst_n_21),
        .\boot_state_reg[2]_0 ({boot_address__0[31],boot_address__0[23],boot_address__0[15],boot_address__0[0]}),
        .\boot_state_reg[2]_1 (uart_inst_n_46),
        .\boot_state_reg[3] (uart_inst_n_47),
        .\bram_din_reg_reg[0] (bram_en_reg_i_3_n_0),
        .\bram_din_reg_reg[0]_0 (\bram_we_reg[3]_i_2_n_0 ),
        .bram_en_reg(bram_en_reg),
        .frame_error(frame_error),
        .\npu_data_reg[0] (\npu_address[12]_i_2_n_0 ),
        .npu_i_we_reg(npu_i_we_i_2_n_0),
        .npu_s_we_reg(npu_s_we_i_2_n_0),
        .npu_w_we_reg(npu_w_we_i_2_n_0),
        .overrun_error(overrun_error),
        .overrun_error_reg(axi_rx_fifo_reset_reg_n_0),
        .overrun_error_reg_0(axi_error_clear_reg_n_0),
        .p_0_in(p_0_in),
        .phy_rx_frame_error(phy_rx_frame_error),
        .phy_tx_data0(phy_tx_data0),
        .\rx_data_reg[1]_0 (uart_inst_n_28),
        .\rx_data_reg[7]_0 (phy_rx_data),
        .rx_frame_error_reg_0(uart_inst_n_44),
        .rx_frame_error_reg_1(uart_inst_n_48),
        .rx_frame_error_reg_2({boot_data_2[31],boot_data_2[23],boot_data_2[15],boot_data_2[7]}),
        .rx_rd_ptr0(rx_rd_ptr0),
        .rx_valid_reg_0(uart_inst_n_29),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(uart_inst_n_55),
        .s_axi_aresetn_1(uart_inst_n_61),
        .\tx_count_reg[0] (tx_count_reg),
        .\tx_count_reg[0]_0 (axi_tx_push_reg_n_0),
        .\tx_count_reg[3] (tx_wr_ptr0),
        .\tx_count_reg[4] ({uart_inst_n_8,uart_inst_n_9,uart_inst_n_10,uart_inst_n_11}),
        .\tx_count_reg[4]_0 (uart_inst_n_12),
        .\tx_count_reg[4]_1 (uart_inst_n_26),
        .tx_rd_ptr0(tx_rd_ptr0),
        .\tx_shift_reg[1]_0 (\boot_reply_reg_n_0_[1] ),
        .\tx_shift_reg[4]_0 (\boot_reply_reg_n_0_[0] ),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx));
  LUT5 #(
    .INIT(32'h44404040)) 
    uart_irq_INST_0
       (.I0(npu_boot_active),
        .I1(s_axi_aresetn),
        .I2(uart_irq_INST_0_i_1_n_0),
        .I3(p_5_in[1]),
        .I4(uart_inst_n_12),
        .O(uart_irq));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    uart_irq_INST_0_i_1
       (.I0(uart_irq_INST_0_i_3_n_0),
        .I1(p_5_in[0]),
        .I2(overrun_error),
        .I3(p_5_in[2]),
        .I4(frame_error),
        .I5(p_5_in[3]),
        .O(uart_irq_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    uart_irq_INST_0_i_3
       (.I0(rx_count_reg[4]),
        .I1(rx_count_reg[2]),
        .I2(rx_count_reg[3]),
        .I3(rx_count_reg[1]),
        .I4(rx_count_reg[0]),
        .O(uart_irq_INST_0_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'hCC000C88)) 
    w_hold_i_1
       (.I0(s_axi_wvalid),
        .I1(s_axi_aresetn),
        .I2(aw_hold),
        .I3(w_hold_reg_n_0),
        .I4(bvalid_reg_reg_0),
        .O(w_hold_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    w_hold_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(w_hold_i_1_n_0),
        .Q(w_hold_reg_n_0),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h02)) 
    \wdata_hold[7]_i_1 
       (.I0(s_axi_wvalid),
        .I1(w_hold_reg_n_0),
        .I2(bvalid_reg_reg_0),
        .O(w_hold0));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[0] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[0]),
        .Q(\wdata_hold_reg_n_0_[0] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[1] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[1]),
        .Q(\wdata_hold_reg_n_0_[1] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[2] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[2]),
        .Q(\wdata_hold_reg_n_0_[2] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[3] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[3]),
        .Q(\wdata_hold_reg_n_0_[3] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[4] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[4]),
        .Q(\wdata_hold_reg_n_0_[4] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[5] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[5]),
        .Q(\wdata_hold_reg_n_0_[5] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[6] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[6]),
        .Q(\wdata_hold_reg_n_0_[6] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wdata_hold_reg[7] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wdata[7]),
        .Q(\wdata_hold_reg_n_0_[7] ),
        .R(uart_inst_n_1));
  FDRE #(
    .INIT(1'b0)) 
    \wstrb_hold_reg[0] 
       (.C(s_axi_aclk),
        .CE(w_hold0),
        .D(s_axi_wstrb),
        .Q(\wstrb_hold_reg_n_0_[0] ),
        .R(uart_inst_n_1));
endmodule

(* ORIG_REF_NAME = "axi_uart_bootloader_wrapper" *) 
module design_1_axi_uart_bootloader_1_0_axi_uart_bootloader_wrapper
   (npu_boot_active,
    rvalid_reg_reg,
    bvalid_reg_reg,
    s_axi_bresp,
    s_axi_rdata,
    s_axi_rresp,
    bram_en,
    bram_addr,
    bram_din,
    npu_scratchpad_addr,
    npu_instr_din,
    s_axi_wready,
    s_axi_awready,
    s_axi_arready,
    uart_irq,
    npu_instr_we,
    npu_weight_we,
    npu_scratchpad_we,
    uart_tx,
    bram_we,
    s_axi_aclk,
    s_axi_arvalid,
    s_axi_aresetn,
    s_axi_araddr,
    npu_ready,
    uart_rx,
    boot_mode,
    s_axi_awaddr,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_rready);
  output npu_boot_active;
  output rvalid_reg_reg;
  output bvalid_reg_reg;
  output [0:0]s_axi_bresp;
  output [7:0]s_axi_rdata;
  output [0:0]s_axi_rresp;
  output bram_en;
  output [13:0]bram_addr;
  output [31:0]bram_din;
  output [15:0]npu_scratchpad_addr;
  output [35:0]npu_instr_din;
  output s_axi_wready;
  output s_axi_awready;
  output s_axi_arready;
  output uart_irq;
  output npu_instr_we;
  output npu_weight_we;
  output npu_scratchpad_we;
  output uart_tx;
  output [0:0]bram_we;
  input s_axi_aclk;
  input s_axi_arvalid;
  input s_axi_aresetn;
  input [3:0]s_axi_araddr;
  input npu_ready;
  input uart_rx;
  input boot_mode;
  input [3:0]s_axi_awaddr;
  input [7:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input s_axi_bready;
  input s_axi_rready;

  wire boot_mode;
  wire [13:0]bram_addr;
  wire [31:0]bram_din;
  wire bram_en;
  wire [0:0]bram_we;
  wire bvalid_reg_reg;
  wire npu_boot_active;
  wire [35:0]npu_instr_din;
  wire npu_instr_we;
  wire npu_ready;
  wire [15:0]npu_scratchpad_addr;
  wire npu_scratchpad_we;
  wire npu_weight_we;
  wire rvalid_reg_reg;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [3:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire [7:0]s_axi_rdata;
  wire s_axi_rready;
  wire [0:0]s_axi_rresp;
  wire [7:0]s_axi_wdata;
  wire s_axi_wready;
  wire [0:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire uart_irq;
  wire uart_rx;
  wire uart_tx;

  design_1_axi_uart_bootloader_1_0_axi_uart_bootloader u_axi_uart_bootloader
       (.boot_mode(boot_mode),
        .bram_addr(bram_addr),
        .bram_din(bram_din),
        .bram_en(bram_en),
        .bram_we(bram_we),
        .bvalid_reg_reg_0(bvalid_reg_reg),
        .npu_boot_active(npu_boot_active),
        .npu_instr_din(npu_instr_din),
        .npu_instr_we(npu_instr_we),
        .npu_ready(npu_ready),
        .npu_scratchpad_addr(npu_scratchpad_addr),
        .npu_scratchpad_we(npu_scratchpad_we),
        .npu_weight_we(npu_weight_we),
        .rvalid_reg_reg_0(rvalid_reg_reg),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .uart_irq(uart_irq),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx));
endmodule

(* ORIG_REF_NAME = "uart_phy" *) 
module design_1_axi_uart_bootloader_1_0_uart_phy
   (phy_rx_frame_error,
    SR,
    uart_tx,
    D,
    E,
    \tx_count_reg[4] ,
    \tx_count_reg[4]_0 ,
    \rx_data_reg[7]_0 ,
    \boot_state_reg[2] ,
    \boot_state_reg[0] ,
    p_0_in,
    boot_reply_pending_reg,
    boot_active_reg,
    \tx_count_reg[4]_1 ,
    tx_rd_ptr0,
    \rx_data_reg[1]_0 ,
    rx_valid_reg_0,
    \boot_state_reg[0]_0 ,
    \boot_state_reg[2]_0 ,
    \boot_state_reg[1] ,
    boot_data_hi_0,
    rx_frame_error_reg_0,
    bram_en_reg,
    \boot_state_reg[2]_1 ,
    \boot_state_reg[3] ,
    rx_frame_error_reg_1,
    \boot_state_reg[1]_0 ,
    \boot_checksum_reg[7] ,
    \boot_state_reg[1]_1 ,
    \boot_state_reg[1]_2 ,
    \boot_state_reg[1]_3 ,
    boot_active_reg_0,
    s_axi_aresetn_0,
    \boot_state_reg[0]_1 ,
    rx_frame_error_reg_2,
    s_axi_aresetn_1,
    axi_error_clear_reg,
    s_axi_aclk,
    Q,
    rx_rd_ptr0,
    boot_reply_pending_reg_0,
    \tx_count_reg[0] ,
    boot_reply_pending_reg_1,
    phy_tx_data0,
    \boot_state_reg[0]_2 ,
    \tx_shift_reg[4]_0 ,
    \tx_shift_reg[1]_0 ,
    overrun_error_reg,
    s_axi_aresetn,
    \tx_count_reg[0]_0 ,
    \tx_count_reg[3] ,
    \boot_checksum_reg[7]_0 ,
    \boot_checksum_reg[0] ,
    \npu_data_reg[0] ,
    npu_s_we_reg,
    npu_w_we_reg,
    npu_i_we_reg,
    \bram_din_reg_reg[0] ,
    \bram_din_reg_reg[0]_0 ,
    overrun_error_reg_0,
    overrun_error,
    frame_error,
    uart_rx);
  output phy_rx_frame_error;
  output [0:0]SR;
  output uart_tx;
  output [3:0]D;
  output [0:0]E;
  output [3:0]\tx_count_reg[4] ;
  output \tx_count_reg[4]_0 ;
  output [7:0]\rx_data_reg[7]_0 ;
  output \boot_state_reg[2] ;
  output [0:0]\boot_state_reg[0] ;
  output p_0_in;
  output boot_reply_pending_reg;
  output [0:0]boot_active_reg;
  output [0:0]\tx_count_reg[4]_1 ;
  output tx_rd_ptr0;
  output \rx_data_reg[1]_0 ;
  output [0:0]rx_valid_reg_0;
  output [7:0]\boot_state_reg[0]_0 ;
  output [3:0]\boot_state_reg[2]_0 ;
  output [0:0]\boot_state_reg[1] ;
  output [0:0]boot_data_hi_0;
  output [0:0]rx_frame_error_reg_0;
  output bram_en_reg;
  output [0:0]\boot_state_reg[2]_1 ;
  output \boot_state_reg[3] ;
  output rx_frame_error_reg_1;
  output [0:0]\boot_state_reg[1]_0 ;
  output \boot_checksum_reg[7] ;
  output \boot_state_reg[1]_1 ;
  output \boot_state_reg[1]_2 ;
  output \boot_state_reg[1]_3 ;
  output [0:0]boot_active_reg_0;
  output s_axi_aresetn_0;
  output \boot_state_reg[0]_1 ;
  output [3:0]rx_frame_error_reg_2;
  output s_axi_aresetn_1;
  output axi_error_clear_reg;
  input s_axi_aclk;
  input [4:0]Q;
  input rx_rd_ptr0;
  input boot_reply_pending_reg_0;
  input [4:0]\tx_count_reg[0] ;
  input boot_reply_pending_reg_1;
  input [7:0]phy_tx_data0;
  input [3:0]\boot_state_reg[0]_2 ;
  input \tx_shift_reg[4]_0 ;
  input \tx_shift_reg[1]_0 ;
  input overrun_error_reg;
  input s_axi_aresetn;
  input \tx_count_reg[0]_0 ;
  input [0:0]\tx_count_reg[3] ;
  input [7:0]\boot_checksum_reg[7]_0 ;
  input \boot_checksum_reg[0] ;
  input \npu_data_reg[0] ;
  input npu_s_we_reg;
  input npu_w_we_reg;
  input npu_i_we_reg;
  input \bram_din_reg_reg[0] ;
  input \bram_din_reg_reg[0]_0 ;
  input overrun_error_reg_0;
  input overrun_error;
  input frame_error;
  input uart_rx;

  wire [3:0]D;
  wire [0:0]E;
  wire \FSM_sequential_rx_state[0]_i_1_n_0 ;
  wire \FSM_sequential_rx_state[0]_i_2_n_0 ;
  wire \FSM_sequential_rx_state[1]_i_1_n_0 ;
  wire \FSM_sequential_rx_state[1]_i_2_n_0 ;
  wire \FSM_sequential_tx_state[0]_i_1_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_1_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_2_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_3_n_0 ;
  wire \FSM_sequential_tx_state[1]_i_4_n_0 ;
  wire [4:0]Q;
  wire [0:0]SR;
  wire axi_error_clear_reg;
  wire [0:0]boot_active_reg;
  wire [0:0]boot_active_reg_0;
  wire \boot_checksum_reg[0] ;
  wire \boot_checksum_reg[7] ;
  wire [7:0]\boot_checksum_reg[7]_0 ;
  wire \boot_command[7]_i_3_n_0 ;
  wire [0:0]boot_data_hi_0;
  wire boot_reply_pending22_out;
  wire boot_reply_pending_i_2_n_0;
  wire boot_reply_pending_i_4_n_0;
  wire boot_reply_pending_i_5_n_0;
  wire boot_reply_pending_reg;
  wire boot_reply_pending_reg_0;
  wire boot_reply_pending_reg_1;
  wire \boot_state[1]_i_2_n_0 ;
  wire \boot_state[3]_i_4_n_0 ;
  wire \boot_state[3]_i_5_n_0 ;
  wire [0:0]\boot_state_reg[0] ;
  wire [7:0]\boot_state_reg[0]_0 ;
  wire \boot_state_reg[0]_1 ;
  wire [3:0]\boot_state_reg[0]_2 ;
  wire [0:0]\boot_state_reg[1] ;
  wire [0:0]\boot_state_reg[1]_0 ;
  wire \boot_state_reg[1]_1 ;
  wire \boot_state_reg[1]_2 ;
  wire \boot_state_reg[1]_3 ;
  wire \boot_state_reg[2] ;
  wire [3:0]\boot_state_reg[2]_0 ;
  wire [0:0]\boot_state_reg[2]_1 ;
  wire \boot_state_reg[3] ;
  wire \bram_din_reg_reg[0] ;
  wire \bram_din_reg_reg[0]_0 ;
  wire bram_en_reg;
  wire bram_en_reg_i_6_n_0;
  wire bram_en_reg_i_7_n_0;
  wire bram_en_reg_i_8_n_0;
  wire \bram_we_reg[3]_i_3_n_0 ;
  wire data1;
  wire data2;
  wire data4;
  wire data5;
  wire data6;
  wire frame_error;
  wire \npu_data_reg[0] ;
  wire npu_i_we_reg;
  wire npu_s_we_reg;
  wire npu_w_we_reg;
  wire overrun_error;
  wire overrun_error_i_2_n_0;
  wire overrun_error_reg;
  wire overrun_error_reg_0;
  wire p_0_in;
  wire phy_rx_frame_error;
  wire phy_rx_valid;
  wire [4:0]phy_tx_data;
  wire [7:0]phy_tx_data0;
  wire [0:0]rx_bit_index;
  wire \rx_bit_index[0]_i_1_n_0 ;
  wire \rx_bit_index[1]_i_1_n_0 ;
  wire \rx_bit_index[2]_i_1_n_0 ;
  wire \rx_bit_index_reg_n_0_[0] ;
  wire \rx_bit_index_reg_n_0_[1] ;
  wire \rx_bit_index_reg_n_0_[2] ;
  wire [9:0]rx_clk_count;
  wire \rx_clk_count[3]_i_2_n_0 ;
  wire \rx_clk_count[4]_i_2_n_0 ;
  wire \rx_clk_count[5]_i_2_n_0 ;
  wire \rx_clk_count[8]_i_2_n_0 ;
  wire \rx_clk_count[9]_i_3_n_0 ;
  wire [0:0]rx_clk_count_1;
  wire \rx_clk_count_reg_n_0_[0] ;
  wire \rx_clk_count_reg_n_0_[1] ;
  wire \rx_clk_count_reg_n_0_[2] ;
  wire \rx_clk_count_reg_n_0_[3] ;
  wire \rx_clk_count_reg_n_0_[4] ;
  wire \rx_clk_count_reg_n_0_[5] ;
  wire \rx_clk_count_reg_n_0_[6] ;
  wire \rx_clk_count_reg_n_0_[7] ;
  wire \rx_clk_count_reg_n_0_[8] ;
  wire \rx_clk_count_reg_n_0_[9] ;
  wire \rx_count[3]_i_2_n_0 ;
  wire \rx_count[4]_i_3_n_0 ;
  wire \rx_data[7]_i_1_n_0 ;
  wire \rx_data_reg[1]_0 ;
  wire [7:0]\rx_data_reg[7]_0 ;
  wire rx_frame_error_i_1_n_0;
  wire [0:0]rx_frame_error_reg_0;
  wire rx_frame_error_reg_1;
  wire [3:0]rx_frame_error_reg_2;
  wire rx_rd_ptr0;
  wire \rx_shift[0]_i_1_n_0 ;
  wire \rx_shift[1]_i_1_n_0 ;
  wire \rx_shift[2]_i_1_n_0 ;
  wire \rx_shift[3]_i_1_n_0 ;
  wire \rx_shift[3]_i_2_n_0 ;
  wire \rx_shift[4]_i_1_n_0 ;
  wire \rx_shift[5]_i_1_n_0 ;
  wire \rx_shift[6]_i_1_n_0 ;
  wire \rx_shift[7]_i_1_n_0 ;
  wire \rx_shift[7]_i_2_n_0 ;
  wire \rx_shift_reg_n_0_[0] ;
  wire \rx_shift_reg_n_0_[1] ;
  wire \rx_shift_reg_n_0_[2] ;
  wire \rx_shift_reg_n_0_[3] ;
  wire \rx_shift_reg_n_0_[4] ;
  wire \rx_shift_reg_n_0_[5] ;
  wire \rx_shift_reg_n_0_[6] ;
  wire \rx_shift_reg_n_0_[7] ;
  wire [1:0]rx_state;
  wire [0:0]rx_valid_reg_0;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire s_axi_aresetn_1;
  wire \tx_bit_index[0]_i_1_n_0 ;
  wire \tx_bit_index[1]_i_1_n_0 ;
  wire \tx_bit_index[2]_i_1_n_0 ;
  wire \tx_bit_index[2]_i_2_n_0 ;
  wire \tx_bit_index_reg_n_0_[0] ;
  wire \tx_bit_index_reg_n_0_[1] ;
  wire \tx_bit_index_reg_n_0_[2] ;
  wire [9:0]tx_clk_count;
  wire \tx_clk_count[2]_i_2_n_0 ;
  wire \tx_clk_count[3]_i_2_n_0 ;
  wire \tx_clk_count[4]_i_2_n_0 ;
  wire \tx_clk_count[5]_i_2_n_0 ;
  wire \tx_clk_count[8]_i_2_n_0 ;
  wire \tx_clk_count[8]_i_3_n_0 ;
  wire \tx_clk_count[9]_i_3_n_0 ;
  wire \tx_clk_count[9]_i_4_n_0 ;
  wire [0:0]tx_clk_count_0;
  wire \tx_clk_count_reg_n_0_[0] ;
  wire \tx_clk_count_reg_n_0_[1] ;
  wire \tx_clk_count_reg_n_0_[2] ;
  wire \tx_clk_count_reg_n_0_[3] ;
  wire \tx_clk_count_reg_n_0_[4] ;
  wire \tx_clk_count_reg_n_0_[5] ;
  wire \tx_clk_count_reg_n_0_[6] ;
  wire \tx_clk_count_reg_n_0_[7] ;
  wire \tx_clk_count_reg_n_0_[8] ;
  wire \tx_clk_count_reg_n_0_[9] ;
  wire \tx_count[4]_i_3_n_0 ;
  wire [4:0]\tx_count_reg[0] ;
  wire \tx_count_reg[0]_0 ;
  wire [0:0]\tx_count_reg[3] ;
  wire [3:0]\tx_count_reg[4] ;
  wire \tx_count_reg[4]_0 ;
  wire [0:0]\tx_count_reg[4]_1 ;
  wire tx_rd_ptr0;
  wire \tx_shift[3]_i_1_n_0 ;
  wire \tx_shift[5]_i_1_n_0 ;
  wire \tx_shift[6]_i_1_n_0 ;
  wire \tx_shift[7]_i_1_n_0 ;
  wire \tx_shift[7]_i_2_n_0 ;
  wire \tx_shift_reg[1]_0 ;
  wire \tx_shift_reg[4]_0 ;
  wire \tx_shift_reg_n_0_[0] ;
  wire \tx_shift_reg_n_0_[1] ;
  wire \tx_shift_reg_n_0_[4] ;
  wire [1:0]tx_state;
  wire uart_rx;
  wire uart_tx;
  wire uart_tx_reg_i_2_n_0;
  wire uart_tx_reg_i_3_n_0;
  wire uart_tx_reg_i_4_n_0;
  wire uart_tx_reg_i_5_n_0;
  wire uart_tx_reg_i_6_n_0;
  wire uart_tx_reg_i_7_n_0;

  LUT6 #(
    .INIT(64'hAAAAAAAA03035303)) 
    \FSM_sequential_rx_state[0]_i_1 
       (.I0(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I1(uart_rx),
        .I2(rx_state[1]),
        .I3(\rx_bit_index_reg_n_0_[2] ),
        .I4(\FSM_sequential_rx_state[0]_i_2_n_0 ),
        .I5(rx_state[0]),
        .O(\FSM_sequential_rx_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \FSM_sequential_rx_state[0]_i_2 
       (.I0(\rx_bit_index_reg_n_0_[0] ),
        .I1(\rx_bit_index_reg_n_0_[1] ),
        .O(\FSM_sequential_rx_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hA1AA)) 
    \FSM_sequential_rx_state[1]_i_1 
       (.I0(rx_state[1]),
        .I1(uart_rx),
        .I2(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I3(rx_state[0]),
        .O(\FSM_sequential_rx_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_rx_state[1]_i_2 
       (.I0(\rx_clk_count_reg_n_0_[8] ),
        .I1(\rx_clk_count_reg_n_0_[6] ),
        .I2(\rx_clk_count[8]_i_2_n_0 ),
        .I3(\rx_clk_count_reg_n_0_[7] ),
        .I4(\rx_clk_count_reg_n_0_[9] ),
        .O(\FSM_sequential_rx_state[1]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "rx_start:01,rx_stop:11,rx_idle:00,rx_recv_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_rx_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_rx_state[0]_i_1_n_0 ),
        .Q(rx_state[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "rx_start:01,rx_stop:11,rx_idle:00,rx_recv_data:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_rx_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_rx_state[1]_i_1_n_0 ),
        .Q(rx_state[1]),
        .R(SR));
  LUT5 #(
    .INIT(32'h0045BABA)) 
    \FSM_sequential_tx_state[0]_i_1 
       (.I0(\tx_shift[7]_i_1_n_0 ),
        .I1(\FSM_sequential_tx_state[1]_i_2_n_0 ),
        .I2(\FSM_sequential_tx_state[1]_i_3_n_0 ),
        .I3(uart_tx_reg_i_5_n_0),
        .I4(tx_state[0]),
        .O(\FSM_sequential_tx_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0045FFFFFFBA0000)) 
    \FSM_sequential_tx_state[1]_i_1 
       (.I0(\tx_shift[7]_i_1_n_0 ),
        .I1(\FSM_sequential_tx_state[1]_i_2_n_0 ),
        .I2(\FSM_sequential_tx_state[1]_i_3_n_0 ),
        .I3(uart_tx_reg_i_5_n_0),
        .I4(tx_state[0]),
        .I5(tx_state[1]),
        .O(\FSM_sequential_tx_state[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFBFFFF)) 
    \FSM_sequential_tx_state[1]_i_2 
       (.I0(\tx_clk_count_reg_n_0_[8] ),
        .I1(tx_state[1]),
        .I2(tx_state[0]),
        .I3(\tx_clk_count[4]_i_2_n_0 ),
        .I4(\FSM_sequential_tx_state[1]_i_4_n_0 ),
        .O(\FSM_sequential_tx_state[1]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_sequential_tx_state[1]_i_3 
       (.I0(\tx_bit_index_reg_n_0_[0] ),
        .I1(\tx_bit_index_reg_n_0_[1] ),
        .I2(\tx_bit_index_reg_n_0_[2] ),
        .O(\FSM_sequential_tx_state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000001010001)) 
    \FSM_sequential_tx_state[1]_i_4 
       (.I0(\tx_clk_count_reg_n_0_[1] ),
        .I1(\tx_clk_count_reg_n_0_[2] ),
        .I2(\tx_clk_count_reg_n_0_[0] ),
        .I3(\tx_clk_count_reg_n_0_[3] ),
        .I4(\tx_clk_count_reg_n_0_[4] ),
        .I5(\tx_clk_count_reg_n_0_[5] ),
        .O(\FSM_sequential_tx_state[1]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "tx_idle:00,tx_start:01,tx_send_data:10,tx_stop:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_tx_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_tx_state[0]_i_1_n_0 ),
        .Q(tx_state[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "tx_idle:00,tx_start:01,tx_send_data:10,tx_stop:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_tx_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_sequential_tx_state[1]_i_1_n_0 ),
        .Q(tx_state[1]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \boot_address[15]_i_1 
       (.I0(\boot_state_reg[0]_2 [2]),
        .I1(phy_rx_valid),
        .I2(phy_rx_frame_error),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .O(\boot_state_reg[2]_0 [1]));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \boot_address[23]_i_1 
       (.I0(\boot_state_reg[0]_2 [2]),
        .I1(\boot_state_reg[0]_2 [3]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(phy_rx_valid),
        .I5(phy_rx_frame_error),
        .O(\boot_state_reg[2]_0 [2]));
  LUT6 #(
    .INIT(64'h0000000000100000)) 
    \boot_address[31]_i_2 
       (.I0(\boot_state_reg[0]_2 [2]),
        .I1(\boot_state_reg[0]_2 [3]),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [0]),
        .I4(phy_rx_valid),
        .I5(phy_rx_frame_error),
        .O(\boot_state_reg[2]_0 [3]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00080000)) 
    \boot_address[7]_i_1 
       (.I0(\boot_state_reg[0]_2 [2]),
        .I1(phy_rx_valid),
        .I2(phy_rx_frame_error),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .O(\boot_state_reg[2]_0 [0]));
  LUT6 #(
    .INIT(64'h55575554AAA8AAA8)) 
    \boot_checksum[0]_i_1 
       (.I0(\boot_checksum_reg[7]_0 [0]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(\rx_data_reg[7]_0 [0]),
        .O(\boot_state_reg[0]_0 [0]));
  LUT6 #(
    .INIT(64'h55575554AAA8AAA8)) 
    \boot_checksum[1]_i_1 
       (.I0(\boot_checksum_reg[7]_0 [1]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(\rx_data_reg[7]_0 [1]),
        .O(\boot_state_reg[0]_0 [1]));
  LUT6 #(
    .INIT(64'h55575554AAA8AAA8)) 
    \boot_checksum[2]_i_1 
       (.I0(\boot_checksum_reg[7]_0 [2]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(\rx_data_reg[7]_0 [2]),
        .O(\boot_state_reg[0]_0 [2]));
  LUT6 #(
    .INIT(64'h55575554AAA8AAA8)) 
    \boot_checksum[3]_i_1 
       (.I0(\boot_checksum_reg[7]_0 [3]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(\rx_data_reg[7]_0 [3]),
        .O(\boot_state_reg[0]_0 [3]));
  LUT6 #(
    .INIT(64'h0002FFFCFFFE0000)) 
    \boot_checksum[4]_i_1 
       (.I0(\boot_state_reg[0]_2 [0]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\rx_data_reg[7]_0 [4]),
        .I5(\boot_checksum_reg[7]_0 [4]),
        .O(\boot_state_reg[0]_0 [4]));
  LUT6 #(
    .INIT(64'h66666666666C6660)) 
    \boot_checksum[5]_i_1 
       (.I0(\boot_checksum_reg[7]_0 [5]),
        .I1(\rx_data_reg[7]_0 [5]),
        .I2(\boot_state_reg[0]_2 [2]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(\boot_state_reg[0]_2 [1]),
        .O(\boot_state_reg[0]_0 [5]));
  LUT6 #(
    .INIT(64'h0002FFFCFFFE0000)) 
    \boot_checksum[6]_i_1 
       (.I0(\boot_state_reg[0]_2 [0]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\rx_data_reg[7]_0 [6]),
        .I5(\boot_checksum_reg[7]_0 [6]),
        .O(\boot_state_reg[0]_0 [6]));
  LUT6 #(
    .INIT(64'hAAA8AAA8AAA8AAAA)) 
    \boot_checksum[7]_i_1 
       (.I0(\bram_we_reg[3]_i_3_n_0 ),
        .I1(\boot_state[1]_i_2_n_0 ),
        .I2(\boot_checksum_reg[0] ),
        .I3(\boot_state_reg[0]_2 [2]),
        .I4(\boot_state[3]_i_4_n_0 ),
        .I5(\boot_state_reg[0]_2 [0]),
        .O(\boot_state_reg[2]_1 ));
  LUT6 #(
    .INIT(64'h0002FFFCFFFE0000)) 
    \boot_checksum[7]_i_2 
       (.I0(\boot_state_reg[0]_2 [0]),
        .I1(\boot_state_reg[0]_2 [2]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\rx_data_reg[7]_0 [7]),
        .I5(\boot_checksum_reg[7]_0 [7]),
        .O(\boot_state_reg[0]_0 [7]));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \boot_command[7]_i_1 
       (.I0(\boot_state_reg[0]_2 [0]),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\rx_data_reg[1]_0 ),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [2]),
        .I5(bram_en_reg),
        .O(\boot_state_reg[0] ));
  LUT4 #(
    .INIT(16'h02A8)) 
    \boot_command[7]_i_2 
       (.I0(\boot_command[7]_i_3_n_0 ),
        .I1(\rx_data_reg[7]_0 [1]),
        .I2(\rx_data_reg[7]_0 [0]),
        .I3(\rx_data_reg[7]_0 [2]),
        .O(\rx_data_reg[1]_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \boot_command[7]_i_3 
       (.I0(\rx_data_reg[7]_0 [7]),
        .I1(\rx_data_reg[7]_0 [5]),
        .I2(\rx_data_reg[7]_0 [3]),
        .I3(\rx_data_reg[7]_0 [6]),
        .I4(\rx_data_reg[7]_0 [4]),
        .O(\boot_command[7]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h10000000)) 
    \boot_data[15]_i_1 
       (.I0(phy_rx_frame_error),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(phy_rx_valid),
        .O(rx_frame_error_reg_2[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h01000000)) 
    \boot_data[23]_i_1 
       (.I0(phy_rx_frame_error),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(phy_rx_valid),
        .O(rx_frame_error_reg_2[2]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h40000000)) 
    \boot_data[31]_i_1 
       (.I0(phy_rx_frame_error),
        .I1(phy_rx_valid),
        .I2(\boot_state_reg[0]_2 [2]),
        .I3(\boot_state_reg[0]_2 [0]),
        .I4(\boot_state_reg[0]_2 [1]),
        .O(rx_frame_error_reg_2[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h00000800)) 
    \boot_data[7]_i_1 
       (.I0(\boot_state_reg[0]_2 [3]),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(phy_rx_valid),
        .I4(phy_rx_frame_error),
        .O(rx_frame_error_reg_2[0]));
  LUT2 #(
    .INIT(4'h2)) 
    \boot_data_hi[7]_i_1 
       (.I0(\boot_state_reg[0] ),
        .I1(\boot_state_reg[0]_2 [2]),
        .O(\boot_state_reg[2] ));
  LUT6 #(
    .INIT(64'hABAAAAAAAAAAAAAA)) 
    \boot_data_hi[7]_i_2 
       (.I0(\boot_state_reg[0] ),
        .I1(rx_frame_error_reg_0),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_state_reg[0]_2 [2]),
        .I5(phy_rx_valid),
        .O(boot_data_hi_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \boot_reply[1]_i_3 
       (.I0(phy_rx_frame_error),
        .I1(boot_reply_pending_reg_0),
        .O(rx_frame_error_reg_1));
  LUT5 #(
    .INIT(32'hFF6FFFFF)) 
    \boot_reply[1]_i_7 
       (.I0(\boot_state_reg[0]_2 [3]),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [2]),
        .I4(phy_rx_valid),
        .O(\boot_state_reg[3] ));
  LUT6 #(
    .INIT(64'hFECE000000000000)) 
    boot_reply_pending_i_1
       (.I0(boot_reply_pending_reg_1),
        .I1(phy_rx_frame_error),
        .I2(boot_reply_pending_i_2_n_0),
        .I3(boot_reply_pending22_out),
        .I4(s_axi_aresetn),
        .I5(boot_reply_pending_reg_0),
        .O(boot_reply_pending_reg));
  LUT6 #(
    .INIT(64'hFFFF4000FFFF4004)) 
    boot_reply_pending_i_2
       (.I0(boot_reply_pending_i_4_n_0),
        .I1(\boot_state_reg[0]_2 [0]),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(boot_reply_pending_i_5_n_0),
        .I5(\rx_data_reg[1]_0 ),
        .O(boot_reply_pending_i_2_n_0));
  LUT6 #(
    .INIT(64'h0C00000000000400)) 
    boot_reply_pending_i_3
       (.I0(\rx_data_reg[1]_0 ),
        .I1(phy_rx_valid),
        .I2(\boot_state_reg[0]_2 [2]),
        .I3(\boot_state_reg[0]_2 [0]),
        .I4(\boot_state_reg[0]_2 [1]),
        .I5(\boot_state_reg[0]_2 [3]),
        .O(boot_reply_pending22_out));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hB)) 
    boot_reply_pending_i_4
       (.I0(\boot_state_reg[0]_2 [2]),
        .I1(phy_rx_valid),
        .O(boot_reply_pending_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h02)) 
    boot_reply_pending_i_5
       (.I0(boot_reply_pending_reg_1),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .O(boot_reply_pending_i_5_n_0));
  LUT5 #(
    .INIT(32'hBEBEBEAE)) 
    \boot_state[1]_i_1 
       (.I0(\boot_state[1]_i_2_n_0 ),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .I3(\boot_state_reg[0]_2 [2]),
        .I4(\boot_state_reg[0]_2 [3]),
        .O(\boot_state_reg[1] ));
  LUT3 #(
    .INIT(8'h20)) 
    \boot_state[1]_i_2 
       (.I0(\rx_data_reg[1]_0 ),
        .I1(\boot_state_reg[0]_2 [1]),
        .I2(\boot_state_reg[0]_2 [0]),
        .O(\boot_state[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    \boot_state[3]_i_1 
       (.I0(phy_rx_frame_error),
        .I1(s_axi_aresetn),
        .I2(boot_reply_pending_reg_0),
        .O(rx_frame_error_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hAAA8AAAA)) 
    \boot_state[3]_i_2 
       (.I0(phy_rx_valid),
        .I1(\boot_state_reg[0]_2 [0]),
        .I2(\boot_state_reg[0]_2 [2]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state[3]_i_4_n_0 ),
        .O(rx_valid_reg_0));
  LUT6 #(
    .INIT(64'h4555555555555555)) 
    \boot_state[3]_i_4 
       (.I0(\boot_state_reg[0]_2 [1]),
        .I1(\boot_state[3]_i_5_n_0 ),
        .I2(\rx_data_reg[7]_0 [6]),
        .I3(\rx_data_reg[7]_0 [4]),
        .I4(\rx_data_reg[7]_0 [2]),
        .I5(\rx_data_reg[7]_0 [0]),
        .O(\boot_state[3]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \boot_state[3]_i_5 
       (.I0(\rx_data_reg[7]_0 [7]),
        .I1(\rx_data_reg[7]_0 [5]),
        .I2(\rx_data_reg[7]_0 [3]),
        .I3(\rx_data_reg[7]_0 [1]),
        .O(\boot_state[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000080000000000)) 
    \bram_addr_reg[13]_i_1 
       (.I0(\bram_din_reg_reg[0] ),
        .I1(\bram_din_reg_reg[0]_0 ),
        .I2(\boot_checksum_reg[7] ),
        .I3(boot_reply_pending_reg_0),
        .I4(phy_rx_frame_error),
        .I5(phy_rx_valid),
        .O(boot_active_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hF7FF)) 
    bram_en_reg_i_1
       (.I0(s_axi_aresetn),
        .I1(boot_reply_pending_reg_0),
        .I2(phy_rx_frame_error),
        .I3(phy_rx_valid),
        .O(bram_en_reg));
  LUT5 #(
    .INIT(32'h00008000)) 
    bram_en_reg_i_2
       (.I0(\bram_din_reg_reg[0] ),
        .I1(\boot_state_reg[0]_2 [0]),
        .I2(\boot_state_reg[0]_2 [3]),
        .I3(\boot_state_reg[0]_2 [1]),
        .I4(\boot_checksum_reg[7] ),
        .O(\boot_state_reg[0]_1 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBEFFFFBE)) 
    bram_en_reg_i_4
       (.I0(bram_en_reg_i_6_n_0),
        .I1(\boot_checksum_reg[7]_0 [7]),
        .I2(\rx_data_reg[7]_0 [7]),
        .I3(\boot_checksum_reg[7]_0 [3]),
        .I4(\rx_data_reg[7]_0 [3]),
        .I5(bram_en_reg_i_7_n_0),
        .O(\boot_checksum_reg[7] ));
  LUT4 #(
    .INIT(16'h6FF6)) 
    bram_en_reg_i_6
       (.I0(\boot_checksum_reg[7]_0 [2]),
        .I1(\rx_data_reg[7]_0 [2]),
        .I2(\boot_checksum_reg[7]_0 [6]),
        .I3(\rx_data_reg[7]_0 [6]),
        .O(bram_en_reg_i_6_n_0));
  LUT5 #(
    .INIT(32'hFFFF6FF6)) 
    bram_en_reg_i_7
       (.I0(\rx_data_reg[7]_0 [1]),
        .I1(\boot_checksum_reg[7]_0 [1]),
        .I2(\rx_data_reg[7]_0 [5]),
        .I3(\boot_checksum_reg[7]_0 [5]),
        .I4(bram_en_reg_i_8_n_0),
        .O(bram_en_reg_i_7_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    bram_en_reg_i_8
       (.I0(\boot_checksum_reg[7]_0 [0]),
        .I1(\rx_data_reg[7]_0 [0]),
        .I2(\boot_checksum_reg[7]_0 [4]),
        .I3(\rx_data_reg[7]_0 [4]),
        .O(bram_en_reg_i_8_n_0));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \bram_we_reg[3]_i_1 
       (.I0(s_axi_aresetn),
        .I1(\bram_din_reg_reg[0] ),
        .I2(\bram_din_reg_reg[0]_0 ),
        .I3(\boot_checksum_reg[7] ),
        .I4(boot_reply_pending_reg_0),
        .I5(\bram_we_reg[3]_i_3_n_0 ),
        .O(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \bram_we_reg[3]_i_3 
       (.I0(phy_rx_valid),
        .I1(phy_rx_frame_error),
        .O(\bram_we_reg[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hDC)) 
    frame_error_i_1
       (.I0(overrun_error_reg_0),
        .I1(phy_rx_frame_error),
        .I2(frame_error),
        .O(axi_error_clear_reg));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \npu_address[12]_i_1 
       (.I0(\npu_data_reg[0] ),
        .I1(\boot_checksum_reg[7] ),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(bram_en_reg),
        .O(\boot_state_reg[1]_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    npu_i_we_i_1
       (.I0(\npu_data_reg[0] ),
        .I1(\boot_checksum_reg[7] ),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(npu_i_we_reg),
        .O(\boot_state_reg[1]_3 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    npu_s_we_i_1
       (.I0(\npu_data_reg[0] ),
        .I1(\boot_checksum_reg[7] ),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(npu_s_we_reg),
        .O(\boot_state_reg[1]_1 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    npu_w_we_i_1
       (.I0(\npu_data_reg[0] ),
        .I1(\boot_checksum_reg[7] ),
        .I2(\boot_state_reg[0]_2 [1]),
        .I3(\boot_state_reg[0]_2 [3]),
        .I4(\boot_state_reg[0]_2 [0]),
        .I5(npu_w_we_reg),
        .O(\boot_state_reg[1]_2 ));
  LUT4 #(
    .INIT(16'h8C88)) 
    overrun_error_i_1
       (.I0(overrun_error_i_2_n_0),
        .I1(s_axi_aresetn),
        .I2(overrun_error_reg_0),
        .I3(overrun_error),
        .O(s_axi_aresetn_1));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h0020)) 
    overrun_error_i_2
       (.I0(phy_rx_valid),
        .I1(boot_reply_pending_reg_0),
        .I2(Q[4]),
        .I3(overrun_error_reg),
        .O(overrun_error_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h4FE0)) 
    \rx_bit_index[0]_i_1 
       (.I0(rx_state[1]),
        .I1(uart_rx),
        .I2(rx_bit_index),
        .I3(\rx_bit_index_reg_n_0_[0] ),
        .O(\rx_bit_index[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h5CFFAC00)) 
    \rx_bit_index[1]_i_1 
       (.I0(\rx_bit_index_reg_n_0_[0] ),
        .I1(uart_rx),
        .I2(rx_state[1]),
        .I3(rx_bit_index),
        .I4(\rx_bit_index_reg_n_0_[1] ),
        .O(\rx_bit_index[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000F003000050030)) 
    \rx_bit_index[1]_i_2 
       (.I0(\rx_bit_index_reg_n_0_[2] ),
        .I1(uart_rx),
        .I2(rx_state[0]),
        .I3(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I4(rx_state[1]),
        .I5(\FSM_sequential_rx_state[0]_i_2_n_0 ),
        .O(rx_bit_index));
  LUT6 #(
    .INIT(64'hAAAAAA8AAAAFAA8A)) 
    \rx_bit_index[2]_i_1 
       (.I0(\rx_bit_index_reg_n_0_[2] ),
        .I1(uart_rx),
        .I2(rx_state[0]),
        .I3(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I4(rx_state[1]),
        .I5(\FSM_sequential_rx_state[0]_i_2_n_0 ),
        .O(\rx_bit_index[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_bit_index_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_bit_index[0]_i_1_n_0 ),
        .Q(\rx_bit_index_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_bit_index_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_bit_index[1]_i_1_n_0 ),
        .Q(\rx_bit_index_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_bit_index_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_bit_index[2]_i_1_n_0 ),
        .Q(\rx_bit_index_reg_n_0_[2] ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \rx_clk_count[0]_i_1 
       (.I0(rx_state[1]),
        .I1(rx_state[0]),
        .I2(\rx_clk_count_reg_n_0_[0] ),
        .O(rx_clk_count[0]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFF1717FF)) 
    \rx_clk_count[1]_i_1 
       (.I0(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(\rx_clk_count_reg_n_0_[1] ),
        .I4(\rx_clk_count_reg_n_0_[0] ),
        .O(rx_clk_count[1]));
  LUT6 #(
    .INIT(64'hE800E800E80000E8)) 
    \rx_clk_count[2]_i_1 
       (.I0(rx_state[0]),
        .I1(rx_state[1]),
        .I2(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I3(\rx_clk_count_reg_n_0_[2] ),
        .I4(\rx_clk_count_reg_n_0_[0] ),
        .I5(\rx_clk_count_reg_n_0_[1] ),
        .O(rx_clk_count[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h88888882)) 
    \rx_clk_count[3]_i_1 
       (.I0(\rx_clk_count[3]_i_2_n_0 ),
        .I1(\rx_clk_count_reg_n_0_[3] ),
        .I2(\rx_clk_count_reg_n_0_[1] ),
        .I3(\rx_clk_count_reg_n_0_[0] ),
        .I4(\rx_clk_count_reg_n_0_[2] ),
        .O(rx_clk_count[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \rx_clk_count[3]_i_2 
       (.I0(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I1(rx_state[1]),
        .I2(rx_state[0]),
        .O(\rx_clk_count[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h999090FF)) 
    \rx_clk_count[4]_i_1 
       (.I0(\rx_clk_count[4]_i_2_n_0 ),
        .I1(\rx_clk_count_reg_n_0_[4] ),
        .I2(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I3(rx_state[1]),
        .I4(rx_state[0]),
        .O(rx_clk_count[4]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rx_clk_count[4]_i_2 
       (.I0(\rx_clk_count_reg_n_0_[2] ),
        .I1(\rx_clk_count_reg_n_0_[0] ),
        .I2(\rx_clk_count_reg_n_0_[1] ),
        .I3(\rx_clk_count_reg_n_0_[3] ),
        .O(\rx_clk_count[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFF1717FF)) 
    \rx_clk_count[5]_i_1 
       (.I0(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I1(rx_state[0]),
        .I2(rx_state[1]),
        .I3(\rx_clk_count_reg_n_0_[5] ),
        .I4(\rx_clk_count[5]_i_2_n_0 ),
        .O(rx_clk_count[5]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \rx_clk_count[5]_i_2 
       (.I0(\rx_clk_count_reg_n_0_[3] ),
        .I1(\rx_clk_count_reg_n_0_[1] ),
        .I2(\rx_clk_count_reg_n_0_[0] ),
        .I3(\rx_clk_count_reg_n_0_[2] ),
        .I4(\rx_clk_count_reg_n_0_[4] ),
        .O(\rx_clk_count[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h999F90F0)) 
    \rx_clk_count[6]_i_1 
       (.I0(\rx_clk_count[8]_i_2_n_0 ),
        .I1(\rx_clk_count_reg_n_0_[6] ),
        .I2(rx_state[0]),
        .I3(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I4(rx_state[1]),
        .O(rx_clk_count[6]));
  LUT6 #(
    .INIT(64'hE1E1E100E100FFFF)) 
    \rx_clk_count[7]_i_1 
       (.I0(\rx_clk_count_reg_n_0_[6] ),
        .I1(\rx_clk_count[8]_i_2_n_0 ),
        .I2(\rx_clk_count_reg_n_0_[7] ),
        .I3(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I4(rx_state[1]),
        .I5(rx_state[0]),
        .O(rx_clk_count[7]));
  LUT6 #(
    .INIT(64'hFEFEFEFF010101FF)) 
    \rx_clk_count[8]_i_1 
       (.I0(\rx_clk_count_reg_n_0_[6] ),
        .I1(\rx_clk_count[8]_i_2_n_0 ),
        .I2(\rx_clk_count_reg_n_0_[7] ),
        .I3(rx_state[0]),
        .I4(rx_state[1]),
        .I5(\rx_clk_count_reg_n_0_[8] ),
        .O(rx_clk_count[8]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \rx_clk_count[8]_i_2 
       (.I0(\rx_clk_count_reg_n_0_[4] ),
        .I1(\rx_clk_count_reg_n_0_[2] ),
        .I2(\rx_clk_count_reg_n_0_[0] ),
        .I3(\rx_clk_count_reg_n_0_[1] ),
        .I4(\rx_clk_count_reg_n_0_[3] ),
        .I5(\rx_clk_count_reg_n_0_[5] ),
        .O(\rx_clk_count[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFB1B)) 
    \rx_clk_count[9]_i_1 
       (.I0(rx_state[1]),
        .I1(uart_rx),
        .I2(rx_state[0]),
        .I3(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .O(rx_clk_count_1));
  LUT4 #(
    .INIT(16'hC382)) 
    \rx_clk_count[9]_i_2 
       (.I0(rx_state[0]),
        .I1(\rx_clk_count[9]_i_3_n_0 ),
        .I2(\rx_clk_count_reg_n_0_[9] ),
        .I3(rx_state[1]),
        .O(rx_clk_count[9]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rx_clk_count[9]_i_3 
       (.I0(\rx_clk_count_reg_n_0_[7] ),
        .I1(\rx_clk_count[8]_i_2_n_0 ),
        .I2(\rx_clk_count_reg_n_0_[6] ),
        .I3(\rx_clk_count_reg_n_0_[8] ),
        .O(\rx_clk_count[9]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[0]),
        .Q(\rx_clk_count_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[1]),
        .Q(\rx_clk_count_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[2]),
        .Q(\rx_clk_count_reg_n_0_[2] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[3]),
        .Q(\rx_clk_count_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[4]),
        .Q(\rx_clk_count_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[5]),
        .Q(\rx_clk_count_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[6]),
        .Q(\rx_clk_count_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[7]),
        .Q(\rx_clk_count_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[8]),
        .Q(\rx_clk_count_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_clk_count_reg[9] 
       (.C(s_axi_aclk),
        .CE(rx_clk_count_1),
        .D(rx_clk_count[9]),
        .Q(\rx_clk_count_reg_n_0_[9] ),
        .R(SR));
  LUT6 #(
    .INIT(64'hFFFB00040004FFFB)) 
    \rx_count[1]_i_1 
       (.I0(Q[4]),
        .I1(phy_rx_valid),
        .I2(boot_reply_pending_reg_0),
        .I3(rx_rd_ptr0),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(D[0]));
  LUT5 #(
    .INIT(32'hEFF1100E)) 
    \rx_count[2]_i_1 
       (.I0(rx_rd_ptr0),
        .I1(\rx_count[3]_i_2_n_0 ),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hEFFF1000FFF1000E)) 
    \rx_count[3]_i_1 
       (.I0(rx_rd_ptr0),
        .I1(\rx_count[3]_i_2_n_0 ),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[3]),
        .I5(Q[2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rx_count[3]_i_2 
       (.I0(Q[4]),
        .I1(phy_rx_valid),
        .I2(boot_reply_pending_reg_0),
        .O(\rx_count[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hAA9A)) 
    \rx_count[4]_i_1 
       (.I0(rx_rd_ptr0),
        .I1(boot_reply_pending_reg_0),
        .I2(phy_rx_valid),
        .I3(Q[4]),
        .O(E));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAA9)) 
    \rx_count[4]_i_2 
       (.I0(Q[4]),
        .I1(Q[3]),
        .I2(\rx_count[4]_i_3_n_0 ),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    \rx_count[4]_i_3 
       (.I0(rx_rd_ptr0),
        .I1(boot_reply_pending_reg_0),
        .I2(phy_rx_valid),
        .I3(Q[4]),
        .O(\rx_count[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \rx_data[7]_i_1 
       (.I0(uart_rx),
        .I1(rx_state[1]),
        .I2(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I3(rx_state[0]),
        .O(\rx_data[7]_i_1_n_0 ));
  FDRE \rx_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[0] ),
        .Q(\rx_data_reg[7]_0 [0]),
        .R(SR));
  FDRE \rx_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[1] ),
        .Q(\rx_data_reg[7]_0 [1]),
        .R(SR));
  FDRE \rx_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[2] ),
        .Q(\rx_data_reg[7]_0 [2]),
        .R(SR));
  FDRE \rx_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[3] ),
        .Q(\rx_data_reg[7]_0 [3]),
        .R(SR));
  FDRE \rx_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[4] ),
        .Q(\rx_data_reg[7]_0 [4]),
        .R(SR));
  FDRE \rx_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[5] ),
        .Q(\rx_data_reg[7]_0 [5]),
        .R(SR));
  FDRE \rx_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[6] ),
        .Q(\rx_data_reg[7]_0 [6]),
        .R(SR));
  FDRE \rx_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(\rx_data[7]_i_1_n_0 ),
        .D(\rx_shift_reg_n_0_[7] ),
        .Q(\rx_data_reg[7]_0 [7]),
        .R(SR));
  LUT5 #(
    .INIT(32'h00040000)) 
    rx_fifo_reg_0_15_0_5_i_1
       (.I0(Q[4]),
        .I1(phy_rx_valid),
        .I2(boot_reply_pending_reg_0),
        .I3(overrun_error_reg),
        .I4(s_axi_aresetn),
        .O(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    rx_frame_error_i_1
       (.I0(uart_rx),
        .I1(rx_state[1]),
        .I2(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I3(rx_state[0]),
        .O(rx_frame_error_i_1_n_0));
  FDRE rx_frame_error_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rx_frame_error_i_1_n_0),
        .Q(phy_rx_frame_error),
        .R(SR));
  LUT5 #(
    .INIT(32'hFEFF0200)) 
    \rx_shift[0]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[1] ),
        .I2(\rx_bit_index_reg_n_0_[0] ),
        .I3(\rx_shift[3]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[0] ),
        .O(\rx_shift[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hEFFF2000)) 
    \rx_shift[1]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[1] ),
        .I2(\rx_bit_index_reg_n_0_[0] ),
        .I3(\rx_shift[3]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[1] ),
        .O(\rx_shift[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hEFFF2000)) 
    \rx_shift[2]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[0] ),
        .I2(\rx_bit_index_reg_n_0_[1] ),
        .I3(\rx_shift[3]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[2] ),
        .O(\rx_shift[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    \rx_shift[3]_i_1 
       (.I0(uart_rx),
        .I1(\rx_shift[3]_i_2_n_0 ),
        .I2(\rx_bit_index_reg_n_0_[1] ),
        .I3(\rx_bit_index_reg_n_0_[0] ),
        .I4(\rx_shift_reg_n_0_[3] ),
        .O(\rx_shift[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \rx_shift[3]_i_2 
       (.I0(rx_state[1]),
        .I1(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I2(rx_state[0]),
        .I3(\rx_bit_index_reg_n_0_[2] ),
        .O(\rx_shift[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200)) 
    \rx_shift[4]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[1] ),
        .I2(\rx_bit_index_reg_n_0_[0] ),
        .I3(\rx_shift[7]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[4] ),
        .O(\rx_shift[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hEFFF2000)) 
    \rx_shift[5]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[1] ),
        .I2(\rx_bit_index_reg_n_0_[0] ),
        .I3(\rx_shift[7]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[5] ),
        .O(\rx_shift[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hEFFF2000)) 
    \rx_shift[6]_i_1 
       (.I0(uart_rx),
        .I1(\rx_bit_index_reg_n_0_[0] ),
        .I2(\rx_bit_index_reg_n_0_[1] ),
        .I3(\rx_shift[7]_i_2_n_0 ),
        .I4(\rx_shift_reg_n_0_[6] ),
        .O(\rx_shift[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    \rx_shift[7]_i_1 
       (.I0(uart_rx),
        .I1(\rx_shift[7]_i_2_n_0 ),
        .I2(\rx_bit_index_reg_n_0_[1] ),
        .I3(\rx_bit_index_reg_n_0_[0] ),
        .I4(\rx_shift_reg_n_0_[7] ),
        .O(\rx_shift[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h0200)) 
    \rx_shift[7]_i_2 
       (.I0(rx_state[1]),
        .I1(\FSM_sequential_rx_state[1]_i_2_n_0 ),
        .I2(rx_state[0]),
        .I3(\rx_bit_index_reg_n_0_[2] ),
        .O(\rx_shift[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[0]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[1]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[2]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[2] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[3]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[4]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[5]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[6]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \rx_shift_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_shift[7]_i_1_n_0 ),
        .Q(\rx_shift_reg_n_0_[7] ),
        .R(SR));
  FDRE rx_valid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\rx_data[7]_i_1_n_0 ),
        .Q(phy_rx_valid),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \rx_wr_ptr[3]_i_2 
       (.I0(boot_reply_pending_reg_0),
        .I1(phy_rx_valid),
        .I2(Q[4]),
        .O(boot_active_reg));
  LUT6 #(
    .INIT(64'h338A308A308A308A)) 
    \tx_bit_index[0]_i_1 
       (.I0(tx_state[1]),
        .I1(\tx_bit_index[2]_i_2_n_0 ),
        .I2(\FSM_sequential_tx_state[1]_i_2_n_0 ),
        .I3(\tx_bit_index_reg_n_0_[0] ),
        .I4(\tx_bit_index_reg_n_0_[1] ),
        .I5(\tx_bit_index_reg_n_0_[2] ),
        .O(\tx_bit_index[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h33BA8A0030BA8A00)) 
    \tx_bit_index[1]_i_1 
       (.I0(tx_state[1]),
        .I1(\tx_bit_index[2]_i_2_n_0 ),
        .I2(\FSM_sequential_tx_state[1]_i_2_n_0 ),
        .I3(\tx_bit_index_reg_n_0_[0] ),
        .I4(\tx_bit_index_reg_n_0_[1] ),
        .I5(\tx_bit_index_reg_n_0_[2] ),
        .O(\tx_bit_index[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h33BABABA8A000000)) 
    \tx_bit_index[2]_i_1 
       (.I0(tx_state[1]),
        .I1(\tx_bit_index[2]_i_2_n_0 ),
        .I2(\FSM_sequential_tx_state[1]_i_2_n_0 ),
        .I3(\tx_bit_index_reg_n_0_[0] ),
        .I4(\tx_bit_index_reg_n_0_[1] ),
        .I5(\tx_bit_index_reg_n_0_[2] ),
        .O(\tx_bit_index[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \tx_bit_index[2]_i_2 
       (.I0(uart_tx_reg_i_5_n_0),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .O(\tx_bit_index[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_bit_index_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\tx_bit_index[0]_i_1_n_0 ),
        .Q(\tx_bit_index_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_bit_index_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\tx_bit_index[1]_i_1_n_0 ),
        .Q(\tx_bit_index_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_bit_index_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\tx_bit_index[2]_i_1_n_0 ),
        .Q(\tx_bit_index_reg_n_0_[2] ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h57)) 
    \tx_clk_count[0]_i_1 
       (.I0(\tx_clk_count_reg_n_0_[0] ),
        .I1(tx_state[0]),
        .I2(tx_state[1]),
        .O(tx_clk_count[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h999F)) 
    \tx_clk_count[1]_i_1 
       (.I0(\tx_clk_count_reg_n_0_[1] ),
        .I1(\tx_clk_count_reg_n_0_[0] ),
        .I2(tx_state[1]),
        .I3(tx_state[0]),
        .O(tx_clk_count[1]));
  LUT6 #(
    .INIT(64'hCCCC888800004404)) 
    \tx_clk_count[2]_i_1 
       (.I0(\tx_clk_count_reg_n_0_[0] ),
        .I1(\tx_clk_count[9]_i_3_n_0 ),
        .I2(\tx_clk_count[3]_i_2_n_0 ),
        .I3(\tx_clk_count[2]_i_2_n_0 ),
        .I4(\tx_clk_count_reg_n_0_[1] ),
        .I5(\tx_clk_count_reg_n_0_[2] ),
        .O(tx_clk_count[2]));
  LUT3 #(
    .INIT(8'hBA)) 
    \tx_clk_count[2]_i_2 
       (.I0(\tx_clk_count_reg_n_0_[5] ),
        .I1(\tx_clk_count_reg_n_0_[4] ),
        .I2(\tx_clk_count_reg_n_0_[3] ),
        .O(\tx_clk_count[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAA80000AAA80002)) 
    \tx_clk_count[3]_i_1 
       (.I0(\tx_clk_count[9]_i_3_n_0 ),
        .I1(\tx_clk_count_reg_n_0_[0] ),
        .I2(\tx_clk_count_reg_n_0_[2] ),
        .I3(\tx_clk_count_reg_n_0_[1] ),
        .I4(\tx_clk_count_reg_n_0_[3] ),
        .I5(\tx_clk_count[3]_i_2_n_0 ),
        .O(tx_clk_count[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \tx_clk_count[3]_i_2 
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(\tx_clk_count[4]_i_2_n_0 ),
        .O(\tx_clk_count[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hE80000E8)) 
    \tx_clk_count[4]_i_1 
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(\tx_clk_count[4]_i_2_n_0 ),
        .I3(\tx_clk_count[5]_i_2_n_0 ),
        .I4(\tx_clk_count_reg_n_0_[4] ),
        .O(tx_clk_count[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \tx_clk_count[4]_i_2 
       (.I0(\tx_clk_count_reg_n_0_[8] ),
        .I1(\tx_clk_count_reg_n_0_[9] ),
        .I2(\tx_clk_count_reg_n_0_[6] ),
        .I3(\tx_clk_count_reg_n_0_[7] ),
        .I4(\tx_clk_count_reg_n_0_[4] ),
        .I5(\tx_clk_count_reg_n_0_[5] ),
        .O(\tx_clk_count[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hA9A9A9FF)) 
    \tx_clk_count[5]_i_1 
       (.I0(\tx_clk_count_reg_n_0_[5] ),
        .I1(\tx_clk_count_reg_n_0_[4] ),
        .I2(\tx_clk_count[5]_i_2_n_0 ),
        .I3(tx_state[1]),
        .I4(tx_state[0]),
        .O(tx_clk_count[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \tx_clk_count[5]_i_2 
       (.I0(\tx_clk_count_reg_n_0_[3] ),
        .I1(\tx_clk_count_reg_n_0_[1] ),
        .I2(\tx_clk_count_reg_n_0_[2] ),
        .I3(\tx_clk_count_reg_n_0_[0] ),
        .O(\tx_clk_count[5]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hEB)) 
    \tx_clk_count[6]_i_1 
       (.I0(\tx_clk_count[8]_i_2_n_0 ),
        .I1(\tx_clk_count[9]_i_4_n_0 ),
        .I2(\tx_clk_count_reg_n_0_[6] ),
        .O(tx_clk_count[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h00E1)) 
    \tx_clk_count[7]_i_1 
       (.I0(\tx_clk_count_reg_n_0_[6] ),
        .I1(\tx_clk_count[9]_i_4_n_0 ),
        .I2(\tx_clk_count_reg_n_0_[7] ),
        .I3(\tx_clk_count[8]_i_2_n_0 ),
        .O(tx_clk_count[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFFFEAAAB)) 
    \tx_clk_count[8]_i_1 
       (.I0(\tx_clk_count[8]_i_2_n_0 ),
        .I1(\tx_clk_count[9]_i_4_n_0 ),
        .I2(\tx_clk_count_reg_n_0_[6] ),
        .I3(\tx_clk_count_reg_n_0_[7] ),
        .I4(\tx_clk_count_reg_n_0_[8] ),
        .O(tx_clk_count[8]));
  LUT6 #(
    .INIT(64'h00A20000FFFFFFFF)) 
    \tx_clk_count[8]_i_2 
       (.I0(\tx_clk_count[8]_i_3_n_0 ),
        .I1(\tx_clk_count_reg_n_0_[3] ),
        .I2(\tx_clk_count_reg_n_0_[4] ),
        .I3(\tx_clk_count_reg_n_0_[5] ),
        .I4(\tx_clk_count[3]_i_2_n_0 ),
        .I5(\tx_clk_count[9]_i_3_n_0 ),
        .O(\tx_clk_count[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \tx_clk_count[8]_i_3 
       (.I0(\tx_clk_count_reg_n_0_[0] ),
        .I1(\tx_clk_count_reg_n_0_[2] ),
        .I2(\tx_clk_count_reg_n_0_[1] ),
        .O(\tx_clk_count[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00FFFFA3FFFFFFA3)) 
    \tx_clk_count[9]_i_1 
       (.I0(boot_reply_pending_reg_1),
        .I1(\tx_count_reg[4]_0 ),
        .I2(boot_reply_pending_reg_0),
        .I3(tx_state[1]),
        .I4(tx_state[0]),
        .I5(uart_tx_reg_i_5_n_0),
        .O(tx_clk_count_0));
  LUT6 #(
    .INIT(64'hFFFFFFFD55555557)) 
    \tx_clk_count[9]_i_2 
       (.I0(\tx_clk_count[9]_i_3_n_0 ),
        .I1(\tx_clk_count_reg_n_0_[6] ),
        .I2(\tx_clk_count[9]_i_4_n_0 ),
        .I3(\tx_clk_count_reg_n_0_[8] ),
        .I4(\tx_clk_count_reg_n_0_[7] ),
        .I5(\tx_clk_count_reg_n_0_[9] ),
        .O(tx_clk_count[9]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \tx_clk_count[9]_i_3 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .O(\tx_clk_count[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \tx_clk_count[9]_i_4 
       (.I0(\tx_clk_count_reg_n_0_[5] ),
        .I1(\tx_clk_count_reg_n_0_[4] ),
        .I2(\tx_clk_count_reg_n_0_[0] ),
        .I3(\tx_clk_count_reg_n_0_[2] ),
        .I4(\tx_clk_count_reg_n_0_[1] ),
        .I5(\tx_clk_count_reg_n_0_[3] ),
        .O(\tx_clk_count[9]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[0]),
        .Q(\tx_clk_count_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[1]),
        .Q(\tx_clk_count_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[2]),
        .Q(\tx_clk_count_reg_n_0_[2] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[3]),
        .Q(\tx_clk_count_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[4]),
        .Q(\tx_clk_count_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[5]),
        .Q(\tx_clk_count_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[6]),
        .Q(\tx_clk_count_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[7]),
        .Q(\tx_clk_count_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[8]),
        .Q(\tx_clk_count_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_clk_count_reg[9] 
       (.C(s_axi_aclk),
        .CE(tx_clk_count_0),
        .D(tx_clk_count[9]),
        .Q(\tx_clk_count_reg_n_0_[9] ),
        .R(SR));
  LUT5 #(
    .INIT(32'hFD0202FD)) 
    \tx_count[1]_i_1 
       (.I0(\tx_count_reg[0]_0 ),
        .I1(\tx_count_reg[0] [4]),
        .I2(tx_rd_ptr0),
        .I3(\tx_count_reg[0] [0]),
        .I4(\tx_count_reg[0] [1]),
        .O(\tx_count_reg[4] [0]));
  LUT6 #(
    .INIT(64'hA9AAAAAAAAAA5655)) 
    \tx_count[2]_i_1 
       (.I0(\tx_count_reg[0] [2]),
        .I1(tx_rd_ptr0),
        .I2(\tx_count_reg[0] [4]),
        .I3(\tx_count_reg[0]_0 ),
        .I4(\tx_count_reg[0] [1]),
        .I5(\tx_count_reg[0] [0]),
        .O(\tx_count_reg[4] [1]));
  LUT6 #(
    .INIT(64'hBFFF4000FFF4000B)) 
    \tx_count[3]_i_1 
       (.I0(tx_rd_ptr0),
        .I1(\tx_count_reg[3] ),
        .I2(\tx_count_reg[0] [1]),
        .I3(\tx_count_reg[0] [0]),
        .I4(\tx_count_reg[0] [3]),
        .I5(\tx_count_reg[0] [2]),
        .O(\tx_count_reg[4] [2]));
  LUT6 #(
    .INIT(64'h444444444444444B)) 
    \tx_count[4]_i_1 
       (.I0(\tx_count_reg[0] [4]),
        .I1(\tx_count_reg[0]_0 ),
        .I2(tx_state[1]),
        .I3(tx_state[0]),
        .I4(boot_reply_pending_reg_0),
        .I5(\tx_count_reg[4]_0 ),
        .O(\tx_count_reg[4]_1 ));
  LUT6 #(
    .INIT(64'hA6AAAAAAAAAAAA9A)) 
    \tx_count[4]_i_2 
       (.I0(\tx_count_reg[0] [4]),
        .I1(\tx_count_reg[0] [3]),
        .I2(\tx_count[4]_i_3_n_0 ),
        .I3(\tx_count_reg[0] [1]),
        .I4(\tx_count_reg[0] [0]),
        .I5(\tx_count_reg[0] [2]),
        .O(\tx_count_reg[4] [3]));
  LUT6 #(
    .INIT(64'hFFFF0001FFFFFFFF)) 
    \tx_count[4]_i_3 
       (.I0(tx_state[1]),
        .I1(tx_state[0]),
        .I2(boot_reply_pending_reg_0),
        .I3(\tx_count_reg[4]_0 ),
        .I4(\tx_count_reg[0] [4]),
        .I5(\tx_count_reg[0]_0 ),
        .O(\tx_count[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \tx_rd_ptr_rep[3]_i_1 
       (.I0(\tx_count_reg[4]_0 ),
        .I1(boot_reply_pending_reg_0),
        .I2(tx_state[0]),
        .I3(tx_state[1]),
        .O(tx_rd_ptr0));
  LUT5 #(
    .INIT(32'h80808F80)) 
    \tx_shift[0]_i_1 
       (.I0(boot_reply_pending_reg_1),
        .I1(\tx_shift_reg[4]_0 ),
        .I2(boot_reply_pending_reg_0),
        .I3(phy_tx_data0[0]),
        .I4(\tx_count_reg[4]_0 ),
        .O(phy_tx_data[0]));
  LUT5 #(
    .INIT(32'h80808F80)) 
    \tx_shift[1]_i_1 
       (.I0(boot_reply_pending_reg_1),
        .I1(\tx_shift_reg[1]_0 ),
        .I2(boot_reply_pending_reg_0),
        .I3(phy_tx_data0[1]),
        .I4(\tx_count_reg[4]_0 ),
        .O(phy_tx_data[1]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h88B8)) 
    \tx_shift[2]_i_1 
       (.I0(boot_reply_pending_reg_1),
        .I1(boot_reply_pending_reg_0),
        .I2(phy_tx_data0[2]),
        .I3(\tx_count_reg[4]_0 ),
        .O(phy_tx_data[2]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \tx_shift[3]_i_1 
       (.I0(\tx_count_reg[4]_0 ),
        .I1(phy_tx_data0[3]),
        .I2(boot_reply_pending_reg_0),
        .O(\tx_shift[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80808F80)) 
    \tx_shift[4]_i_1 
       (.I0(boot_reply_pending_reg_1),
        .I1(\tx_shift_reg[4]_0 ),
        .I2(boot_reply_pending_reg_0),
        .I3(phy_tx_data0[4]),
        .I4(\tx_count_reg[4]_0 ),
        .O(phy_tx_data[4]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \tx_shift[5]_i_1 
       (.I0(\tx_count_reg[4]_0 ),
        .I1(phy_tx_data0[5]),
        .I2(boot_reply_pending_reg_0),
        .O(\tx_shift[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \tx_shift[6]_i_1 
       (.I0(\tx_count_reg[4]_0 ),
        .I1(phy_tx_data0[6]),
        .I2(boot_reply_pending_reg_0),
        .O(\tx_shift[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h10110001)) 
    \tx_shift[7]_i_1 
       (.I0(tx_state[0]),
        .I1(tx_state[1]),
        .I2(boot_reply_pending_reg_0),
        .I3(\tx_count_reg[4]_0 ),
        .I4(boot_reply_pending_reg_1),
        .O(\tx_shift[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \tx_shift[7]_i_2 
       (.I0(\tx_count_reg[4]_0 ),
        .I1(phy_tx_data0[7]),
        .I2(boot_reply_pending_reg_0),
        .O(\tx_shift[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[0] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(phy_tx_data[0]),
        .Q(\tx_shift_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[1] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(phy_tx_data[1]),
        .Q(\tx_shift_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[2] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(phy_tx_data[2]),
        .Q(data1),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[3] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(\tx_shift[3]_i_1_n_0 ),
        .Q(data2),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[4] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(phy_tx_data[4]),
        .Q(\tx_shift_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[5] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(\tx_shift[5]_i_1_n_0 ),
        .Q(data4),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[6] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(\tx_shift[6]_i_1_n_0 ),
        .Q(data5),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \tx_shift_reg[7] 
       (.C(s_axi_aclk),
        .CE(\tx_shift[7]_i_1_n_0 ),
        .D(\tx_shift[7]_i_2_n_0 ),
        .Q(data6),
        .R(SR));
  LUT5 #(
    .INIT(32'h00000001)) 
    uart_irq_INST_0_i_2
       (.I0(\tx_count_reg[0] [4]),
        .I1(\tx_count_reg[0] [2]),
        .I2(\tx_count_reg[0] [3]),
        .I3(\tx_count_reg[0] [1]),
        .I4(\tx_count_reg[0] [0]),
        .O(\tx_count_reg[4]_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    uart_tx_reg_i_1
       (.I0(s_axi_aresetn),
        .O(SR));
  LUT6 #(
    .INIT(64'hDFDFCFCCD0D0C0CC)) 
    uart_tx_reg_i_2
       (.I0(uart_tx_reg_i_3_n_0),
        .I1(uart_tx_reg_i_4_n_0),
        .I2(uart_tx_reg_i_5_n_0),
        .I3(tx_state[0]),
        .I4(tx_state[1]),
        .I5(uart_tx),
        .O(uart_tx_reg_i_2_n_0));
  LUT6 #(
    .INIT(64'h00E2E2E2E2E2E2E2)) 
    uart_tx_reg_i_3
       (.I0(uart_tx_reg_i_6_n_0),
        .I1(\tx_bit_index_reg_n_0_[0] ),
        .I2(uart_tx_reg_i_7_n_0),
        .I3(\tx_bit_index_reg_n_0_[1] ),
        .I4(data6),
        .I5(\tx_bit_index_reg_n_0_[2] ),
        .O(uart_tx_reg_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFF00005C005C)) 
    uart_tx_reg_i_4
       (.I0(boot_reply_pending_reg_1),
        .I1(\tx_count_reg[4]_0 ),
        .I2(boot_reply_pending_reg_0),
        .I3(tx_state[1]),
        .I4(\tx_shift_reg_n_0_[0] ),
        .I5(tx_state[0]),
        .O(uart_tx_reg_i_4_n_0));
  LUT5 #(
    .INIT(32'h00000001)) 
    uart_tx_reg_i_5
       (.I0(\tx_clk_count[9]_i_4_n_0 ),
        .I1(\tx_clk_count_reg_n_0_[6] ),
        .I2(\tx_clk_count_reg_n_0_[7] ),
        .I3(\tx_clk_count_reg_n_0_[8] ),
        .I4(\tx_clk_count_reg_n_0_[9] ),
        .O(uart_tx_reg_i_5_n_0));
  LUT5 #(
    .INIT(32'hFF0F5533)) 
    uart_tx_reg_i_6
       (.I0(data4),
        .I1(\tx_shift_reg_n_0_[1] ),
        .I2(data2),
        .I3(\tx_bit_index_reg_n_0_[2] ),
        .I4(\tx_bit_index_reg_n_0_[1] ),
        .O(uart_tx_reg_i_6_n_0));
  LUT5 #(
    .INIT(32'h00473347)) 
    uart_tx_reg_i_7
       (.I0(data5),
        .I1(\tx_bit_index_reg_n_0_[2] ),
        .I2(data1),
        .I3(\tx_bit_index_reg_n_0_[1] ),
        .I4(\tx_shift_reg_n_0_[4] ),
        .O(uart_tx_reg_i_7_n_0));
  FDSE #(
    .INIT(1'b1)) 
    uart_tx_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(uart_tx_reg_i_2_n_0),
        .Q(uart_tx),
        .S(SR));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
