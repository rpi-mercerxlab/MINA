//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
//Date        : Tue Nov 17 21:14:38 2026
//Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module cpu_reset_controller_imp_Y312CB
   (clk,
    cpu_reset,
    reset,
    sys_reset);
  input clk;
  input cpu_reset;
  output reset;
  input sys_reset;

  wire clk;
  wire cpu_reset;
  wire negation_0_b;
  wire negation_1_b;
  wire reset;
  wire sys_reset;

  design_1_basic_or_0_0 basic_or_0
       (.a(negation_0_b),
        .b(negation_1_b),
        .c(reset),
        .clk(clk));
  design_1_negation_0_0 negation_0
       (.a(cpu_reset),
        .b(negation_0_b),
        .clk(clk));
  design_1_negation_0_1 negation_1
       (.a(sys_reset),
        .b(negation_1_b),
        .clk(clk));
endmodule

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=30,numReposBlks=27,numNonXlnxBlks=0,numHierBlks=3,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=14,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (GPIO_0_tri_i,
    GPIO_0_tri_o,
    GPIO_0_tri_t,
    IOBUF_scl,
    IOBUF_sda,
    SPI_0_0_io0_i,
    SPI_0_0_io0_o,
    SPI_0_0_io0_t,
    SPI_0_0_io1_i,
    SPI_0_0_io1_o,
    SPI_0_0_io1_t,
    SPI_0_0_sck_i,
    SPI_0_0_sck_o,
    SPI_0_0_sck_t,
    SPI_0_0_ss_i,
    SPI_0_0_ss_o,
    SPI_0_0_ss_t,
    cpu_rst,
    in_clk,
    sys_rst,
    uart_rx_0,
    uart_tx_0);
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_I" *) (* X_INTERFACE_MODE = "Master" *) input [3:0]GPIO_0_tri_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_O" *) output [3:0]GPIO_0_tri_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_T" *) output [3:0]GPIO_0_tri_t;
  inout [0:0]IOBUF_scl;
  inout [0:0]IOBUF_sda;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO0_I" *) (* X_INTERFACE_MODE = "Master" *) input SPI_0_0_io0_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO0_O" *) output SPI_0_0_io0_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO0_T" *) output SPI_0_0_io0_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO1_I" *) input SPI_0_0_io1_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO1_O" *) output SPI_0_0_io1_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 IO1_T" *) output SPI_0_0_io1_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SCK_I" *) input SPI_0_0_sck_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SCK_O" *) output SPI_0_0_sck_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SCK_T" *) output SPI_0_0_sck_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SS_I" *) input [0:0]SPI_0_0_ss_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SS_O" *) output [0:0]SPI_0_0_ss_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_0_0 SS_T" *) output SPI_0_0_ss_t;
  input cpu_rst;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.IN_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.IN_CLK, CLK_DOMAIN design_1_in_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input in_clk;
  input sys_rst;
  input uart_rx_0;
  output uart_tx_0;

  wire [3:0]GPIO_0_tri_i;
  wire [3:0]GPIO_0_tri_o;
  wire [3:0]GPIO_0_tri_t;
  wire [0:0]IOBUF_scl;
  wire [0:0]IOBUF_sda;
  wire SPI_0_0_io0_i;
  wire SPI_0_0_io0_o;
  wire SPI_0_0_io0_t;
  wire SPI_0_0_io1_i;
  wire SPI_0_0_io1_o;
  wire SPI_0_0_io1_t;
  wire SPI_0_0_sck_i;
  wire SPI_0_0_sck_o;
  wire SPI_0_0_sck_t;
  wire [0:0]SPI_0_0_ss_i;
  wire [0:0]SPI_0_0_ss_o;
  wire SPI_0_0_ss_t;
  wire [13:0]S_AXI_DATA_1_ARADDR;
  wire [1:0]S_AXI_DATA_1_ARBURST;
  wire [3:0]S_AXI_DATA_1_ARCACHE;
  wire [7:0]S_AXI_DATA_1_ARLEN;
  wire [0:0]S_AXI_DATA_1_ARLOCK;
  wire [2:0]S_AXI_DATA_1_ARPROT;
  wire S_AXI_DATA_1_ARREADY;
  wire [2:0]S_AXI_DATA_1_ARSIZE;
  wire S_AXI_DATA_1_ARVALID;
  wire [13:0]S_AXI_DATA_1_AWADDR;
  wire [1:0]S_AXI_DATA_1_AWBURST;
  wire [3:0]S_AXI_DATA_1_AWCACHE;
  wire [7:0]S_AXI_DATA_1_AWLEN;
  wire [0:0]S_AXI_DATA_1_AWLOCK;
  wire [2:0]S_AXI_DATA_1_AWPROT;
  wire S_AXI_DATA_1_AWREADY;
  wire [2:0]S_AXI_DATA_1_AWSIZE;
  wire S_AXI_DATA_1_AWVALID;
  wire S_AXI_DATA_1_BREADY;
  wire [1:0]S_AXI_DATA_1_BRESP;
  wire S_AXI_DATA_1_BVALID;
  wire [31:0]S_AXI_DATA_1_RDATA;
  wire S_AXI_DATA_1_RLAST;
  wire S_AXI_DATA_1_RREADY;
  wire [1:0]S_AXI_DATA_1_RRESP;
  wire S_AXI_DATA_1_RVALID;
  wire [31:0]S_AXI_DATA_1_WDATA;
  wire S_AXI_DATA_1_WLAST;
  wire S_AXI_DATA_1_WREADY;
  wire [3:0]S_AXI_DATA_1_WSTRB;
  wire S_AXI_DATA_1_WVALID;
  wire [31:0]S_AXI_INST_1_ARADDR;
  wire [1:0]S_AXI_INST_1_ARBURST;
  wire [3:0]S_AXI_INST_1_ARCACHE;
  wire [0:0]S_AXI_INST_1_ARID;
  wire [7:0]S_AXI_INST_1_ARLEN;
  wire [0:0]S_AXI_INST_1_ARLOCK;
  wire [2:0]S_AXI_INST_1_ARPROT;
  wire S_AXI_INST_1_ARREADY;
  wire [2:0]S_AXI_INST_1_ARSIZE;
  wire S_AXI_INST_1_ARVALID;
  wire [31:0]S_AXI_INST_1_RDATA;
  wire [0:0]S_AXI_INST_1_RID;
  wire S_AXI_INST_1_RLAST;
  wire S_AXI_INST_1_RREADY;
  wire [1:0]S_AXI_INST_1_RRESP;
  wire S_AXI_INST_1_RVALID;
  wire [31:0]VexRiscvMcuAxi_0_dBusAxi_ARADDR;
  wire [1:0]VexRiscvMcuAxi_0_dBusAxi_ARBURST;
  wire [3:0]VexRiscvMcuAxi_0_dBusAxi_ARCACHE;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_ARID;
  wire [7:0]VexRiscvMcuAxi_0_dBusAxi_ARLEN;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_ARLOCK;
  wire [2:0]VexRiscvMcuAxi_0_dBusAxi_ARPROT;
  wire [3:0]VexRiscvMcuAxi_0_dBusAxi_ARQOS;
  wire VexRiscvMcuAxi_0_dBusAxi_ARREADY;
  wire [2:0]VexRiscvMcuAxi_0_dBusAxi_ARSIZE;
  wire VexRiscvMcuAxi_0_dBusAxi_ARVALID;
  wire [31:0]VexRiscvMcuAxi_0_dBusAxi_AWADDR;
  wire [1:0]VexRiscvMcuAxi_0_dBusAxi_AWBURST;
  wire [3:0]VexRiscvMcuAxi_0_dBusAxi_AWCACHE;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_AWID;
  wire [7:0]VexRiscvMcuAxi_0_dBusAxi_AWLEN;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_AWLOCK;
  wire [2:0]VexRiscvMcuAxi_0_dBusAxi_AWPROT;
  wire [3:0]VexRiscvMcuAxi_0_dBusAxi_AWQOS;
  wire VexRiscvMcuAxi_0_dBusAxi_AWREADY;
  wire [2:0]VexRiscvMcuAxi_0_dBusAxi_AWSIZE;
  wire VexRiscvMcuAxi_0_dBusAxi_AWVALID;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_BID;
  wire VexRiscvMcuAxi_0_dBusAxi_BREADY;
  wire [1:0]VexRiscvMcuAxi_0_dBusAxi_BRESP;
  wire VexRiscvMcuAxi_0_dBusAxi_BVALID;
  wire [31:0]VexRiscvMcuAxi_0_dBusAxi_RDATA;
  wire [0:0]VexRiscvMcuAxi_0_dBusAxi_RID;
  wire VexRiscvMcuAxi_0_dBusAxi_RLAST;
  wire VexRiscvMcuAxi_0_dBusAxi_RREADY;
  wire [1:0]VexRiscvMcuAxi_0_dBusAxi_RRESP;
  wire VexRiscvMcuAxi_0_dBusAxi_RVALID;
  wire [31:0]VexRiscvMcuAxi_0_dBusAxi_WDATA;
  wire VexRiscvMcuAxi_0_dBusAxi_WLAST;
  wire VexRiscvMcuAxi_0_dBusAxi_WREADY;
  wire [3:0]VexRiscvMcuAxi_0_dBusAxi_WSTRB;
  wire VexRiscvMcuAxi_0_dBusAxi_WVALID;
  wire [31:0]axi_cdma_0_M_AXI_ARADDR;
  wire [1:0]axi_cdma_0_M_AXI_ARBURST;
  wire [3:0]axi_cdma_0_M_AXI_ARCACHE;
  wire [7:0]axi_cdma_0_M_AXI_ARLEN;
  wire [2:0]axi_cdma_0_M_AXI_ARPROT;
  wire axi_cdma_0_M_AXI_ARREADY;
  wire [2:0]axi_cdma_0_M_AXI_ARSIZE;
  wire axi_cdma_0_M_AXI_ARVALID;
  wire [31:0]axi_cdma_0_M_AXI_AWADDR;
  wire [1:0]axi_cdma_0_M_AXI_AWBURST;
  wire [3:0]axi_cdma_0_M_AXI_AWCACHE;
  wire [7:0]axi_cdma_0_M_AXI_AWLEN;
  wire [2:0]axi_cdma_0_M_AXI_AWPROT;
  wire axi_cdma_0_M_AXI_AWREADY;
  wire [2:0]axi_cdma_0_M_AXI_AWSIZE;
  wire axi_cdma_0_M_AXI_AWVALID;
  wire axi_cdma_0_M_AXI_BREADY;
  wire [1:0]axi_cdma_0_M_AXI_BRESP;
  wire axi_cdma_0_M_AXI_BVALID;
  wire [31:0]axi_cdma_0_M_AXI_RDATA;
  wire axi_cdma_0_M_AXI_RLAST;
  wire axi_cdma_0_M_AXI_RREADY;
  wire [1:0]axi_cdma_0_M_AXI_RRESP;
  wire axi_cdma_0_M_AXI_RVALID;
  wire [31:0]axi_cdma_0_M_AXI_WDATA;
  wire axi_cdma_0_M_AXI_WLAST;
  wire axi_cdma_0_M_AXI_WREADY;
  wire [3:0]axi_cdma_0_M_AXI_WSTRB;
  wire axi_cdma_0_M_AXI_WVALID;
  wire cdma_irq_1;
  wire clk_wiz_0_clk_out1;
  wire cpu_reset_controller_c;
  wire cpu_rst;
  wire in_clk;
  wire negation_1_b;
  wire negation_2_b;
  wire npu_axil_wrapper_0_interrupt;
  wire npu_axil_wrapper_0_raw_mem_ready;
  wire peripherals_IRQ;
  wire [13:0]peripherals_bram_addr;
  wire [31:0]peripherals_bram_d;
  wire peripherals_bram_en;
  wire [3:0]peripherals_bram_we;
  wire peripherals_ext_intr;
  wire peripherals_npu_boot_active;
  wire [9:0]peripherals_npu_instr_addr;
  wire [35:0]peripherals_npu_instr_din;
  wire peripherals_npu_instr_we;
  wire [15:0]peripherals_npu_scratchpad_addr;
  wire [31:0]peripherals_npu_scratchpad_din;
  wire peripherals_npu_scratchpad_we;
  wire [15:0]peripherals_npu_weight_addr;
  wire [31:0]peripherals_npu_weight_din;
  wire peripherals_npu_weight_we;
  wire [15:0]smartconnect_0_M01_AXI_ARADDR;
  wire [1:0]smartconnect_0_M01_AXI_ARBURST;
  wire [3:0]smartconnect_0_M01_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M01_AXI_ARLEN;
  wire [0:0]smartconnect_0_M01_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M01_AXI_ARPROT;
  wire smartconnect_0_M01_AXI_ARREADY;
  wire [2:0]smartconnect_0_M01_AXI_ARSIZE;
  wire smartconnect_0_M01_AXI_ARVALID;
  wire [15:0]smartconnect_0_M01_AXI_AWADDR;
  wire [1:0]smartconnect_0_M01_AXI_AWBURST;
  wire [3:0]smartconnect_0_M01_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M01_AXI_AWLEN;
  wire [0:0]smartconnect_0_M01_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M01_AXI_AWPROT;
  wire smartconnect_0_M01_AXI_AWREADY;
  wire [2:0]smartconnect_0_M01_AXI_AWSIZE;
  wire smartconnect_0_M01_AXI_AWVALID;
  wire smartconnect_0_M01_AXI_BREADY;
  wire [1:0]smartconnect_0_M01_AXI_BRESP;
  wire smartconnect_0_M01_AXI_BVALID;
  wire [31:0]smartconnect_0_M01_AXI_RDATA;
  wire smartconnect_0_M01_AXI_RLAST;
  wire smartconnect_0_M01_AXI_RREADY;
  wire [1:0]smartconnect_0_M01_AXI_RRESP;
  wire smartconnect_0_M01_AXI_RVALID;
  wire [31:0]smartconnect_0_M01_AXI_WDATA;
  wire smartconnect_0_M01_AXI_WLAST;
  wire smartconnect_0_M01_AXI_WREADY;
  wire [3:0]smartconnect_0_M01_AXI_WSTRB;
  wire smartconnect_0_M01_AXI_WVALID;
  wire [31:0]smartconnect_0_M02_AXI_ARADDR;
  wire [1:0]smartconnect_0_M02_AXI_ARBURST;
  wire [3:0]smartconnect_0_M02_AXI_ARCACHE;
  wire [1:0]smartconnect_0_M02_AXI_ARID;
  wire [7:0]smartconnect_0_M02_AXI_ARLEN;
  wire [0:0]smartconnect_0_M02_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M02_AXI_ARPROT;
  wire [3:0]smartconnect_0_M02_AXI_ARQOS;
  wire smartconnect_0_M02_AXI_ARREADY;
  wire [2:0]smartconnect_0_M02_AXI_ARSIZE;
  wire [113:0]smartconnect_0_M02_AXI_ARUSER;
  wire smartconnect_0_M02_AXI_ARVALID;
  wire [31:0]smartconnect_0_M02_AXI_AWADDR;
  wire [1:0]smartconnect_0_M02_AXI_AWBURST;
  wire [3:0]smartconnect_0_M02_AXI_AWCACHE;
  wire [1:0]smartconnect_0_M02_AXI_AWID;
  wire [7:0]smartconnect_0_M02_AXI_AWLEN;
  wire [0:0]smartconnect_0_M02_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M02_AXI_AWPROT;
  wire [3:0]smartconnect_0_M02_AXI_AWQOS;
  wire smartconnect_0_M02_AXI_AWREADY;
  wire [2:0]smartconnect_0_M02_AXI_AWSIZE;
  wire [113:0]smartconnect_0_M02_AXI_AWUSER;
  wire smartconnect_0_M02_AXI_AWVALID;
  wire [1:0]smartconnect_0_M02_AXI_BID;
  wire smartconnect_0_M02_AXI_BREADY;
  wire [1:0]smartconnect_0_M02_AXI_BRESP;
  wire smartconnect_0_M02_AXI_BVALID;
  wire [31:0]smartconnect_0_M02_AXI_RDATA;
  wire [1:0]smartconnect_0_M02_AXI_RID;
  wire smartconnect_0_M02_AXI_RLAST;
  wire smartconnect_0_M02_AXI_RREADY;
  wire [1:0]smartconnect_0_M02_AXI_RRESP;
  wire [13:0]smartconnect_0_M02_AXI_RUSER;
  wire smartconnect_0_M02_AXI_RVALID;
  wire [31:0]smartconnect_0_M02_AXI_WDATA;
  wire smartconnect_0_M02_AXI_WLAST;
  wire smartconnect_0_M02_AXI_WREADY;
  wire [3:0]smartconnect_0_M02_AXI_WSTRB;
  wire [13:0]smartconnect_0_M02_AXI_WUSER;
  wire smartconnect_0_M02_AXI_WVALID;
  wire [5:0]smartconnect_0_M03_AXI_ARADDR;
  wire smartconnect_0_M03_AXI_ARREADY;
  wire smartconnect_0_M03_AXI_ARVALID;
  wire [5:0]smartconnect_0_M03_AXI_AWADDR;
  wire smartconnect_0_M03_AXI_AWREADY;
  wire smartconnect_0_M03_AXI_AWVALID;
  wire smartconnect_0_M03_AXI_BREADY;
  wire [1:0]smartconnect_0_M03_AXI_BRESP;
  wire smartconnect_0_M03_AXI_BVALID;
  wire [31:0]smartconnect_0_M03_AXI_RDATA;
  wire smartconnect_0_M03_AXI_RREADY;
  wire [1:0]smartconnect_0_M03_AXI_RRESP;
  wire smartconnect_0_M03_AXI_RVALID;
  wire [31:0]smartconnect_0_M03_AXI_WDATA;
  wire smartconnect_0_M03_AXI_WREADY;
  wire smartconnect_0_M03_AXI_WVALID;
  wire [23:0]smartconnect_0_M04_AXI_ARADDR;
  wire [2:0]smartconnect_0_M04_AXI_ARPROT;
  wire smartconnect_0_M04_AXI_ARREADY;
  wire smartconnect_0_M04_AXI_ARVALID;
  wire [23:0]smartconnect_0_M04_AXI_AWADDR;
  wire [2:0]smartconnect_0_M04_AXI_AWPROT;
  wire smartconnect_0_M04_AXI_AWREADY;
  wire smartconnect_0_M04_AXI_AWVALID;
  wire smartconnect_0_M04_AXI_BREADY;
  wire [1:0]smartconnect_0_M04_AXI_BRESP;
  wire smartconnect_0_M04_AXI_BVALID;
  wire [31:0]smartconnect_0_M04_AXI_RDATA;
  wire smartconnect_0_M04_AXI_RREADY;
  wire [1:0]smartconnect_0_M04_AXI_RRESP;
  wire smartconnect_0_M04_AXI_RVALID;
  wire [31:0]smartconnect_0_M04_AXI_WDATA;
  wire smartconnect_0_M04_AXI_WREADY;
  wire [3:0]smartconnect_0_M04_AXI_WSTRB;
  wire smartconnect_0_M04_AXI_WVALID;
  wire sys_rst;
  wire uart_rx_0;
  wire uart_tx_0;

  design_1_VexRiscvMcuAxi_0_0 VexRiscvMcuAxi_0
       (.clk(clk_wiz_0_clk_out1),
        .dBusAxi_araddr(VexRiscvMcuAxi_0_dBusAxi_ARADDR),
        .dBusAxi_arburst(VexRiscvMcuAxi_0_dBusAxi_ARBURST),
        .dBusAxi_arcache(VexRiscvMcuAxi_0_dBusAxi_ARCACHE),
        .dBusAxi_arid(VexRiscvMcuAxi_0_dBusAxi_ARID),
        .dBusAxi_arlen(VexRiscvMcuAxi_0_dBusAxi_ARLEN),
        .dBusAxi_arlock(VexRiscvMcuAxi_0_dBusAxi_ARLOCK),
        .dBusAxi_arprot(VexRiscvMcuAxi_0_dBusAxi_ARPROT),
        .dBusAxi_arqos(VexRiscvMcuAxi_0_dBusAxi_ARQOS),
        .dBusAxi_arready(VexRiscvMcuAxi_0_dBusAxi_ARREADY),
        .dBusAxi_arsize(VexRiscvMcuAxi_0_dBusAxi_ARSIZE),
        .dBusAxi_arvalid(VexRiscvMcuAxi_0_dBusAxi_ARVALID),
        .dBusAxi_awaddr(VexRiscvMcuAxi_0_dBusAxi_AWADDR),
        .dBusAxi_awburst(VexRiscvMcuAxi_0_dBusAxi_AWBURST),
        .dBusAxi_awcache(VexRiscvMcuAxi_0_dBusAxi_AWCACHE),
        .dBusAxi_awid(VexRiscvMcuAxi_0_dBusAxi_AWID),
        .dBusAxi_awlen(VexRiscvMcuAxi_0_dBusAxi_AWLEN),
        .dBusAxi_awlock(VexRiscvMcuAxi_0_dBusAxi_AWLOCK),
        .dBusAxi_awprot(VexRiscvMcuAxi_0_dBusAxi_AWPROT),
        .dBusAxi_awqos(VexRiscvMcuAxi_0_dBusAxi_AWQOS),
        .dBusAxi_awready(VexRiscvMcuAxi_0_dBusAxi_AWREADY),
        .dBusAxi_awsize(VexRiscvMcuAxi_0_dBusAxi_AWSIZE),
        .dBusAxi_awvalid(VexRiscvMcuAxi_0_dBusAxi_AWVALID),
        .dBusAxi_bid(VexRiscvMcuAxi_0_dBusAxi_BID),
        .dBusAxi_bready(VexRiscvMcuAxi_0_dBusAxi_BREADY),
        .dBusAxi_bresp(VexRiscvMcuAxi_0_dBusAxi_BRESP),
        .dBusAxi_bvalid(VexRiscvMcuAxi_0_dBusAxi_BVALID),
        .dBusAxi_rdata(VexRiscvMcuAxi_0_dBusAxi_RDATA),
        .dBusAxi_rid(VexRiscvMcuAxi_0_dBusAxi_RID),
        .dBusAxi_rlast(VexRiscvMcuAxi_0_dBusAxi_RLAST),
        .dBusAxi_rready(VexRiscvMcuAxi_0_dBusAxi_RREADY),
        .dBusAxi_rresp(VexRiscvMcuAxi_0_dBusAxi_RRESP),
        .dBusAxi_rvalid(VexRiscvMcuAxi_0_dBusAxi_RVALID),
        .dBusAxi_wdata(VexRiscvMcuAxi_0_dBusAxi_WDATA),
        .dBusAxi_wlast(VexRiscvMcuAxi_0_dBusAxi_WLAST),
        .dBusAxi_wready(VexRiscvMcuAxi_0_dBusAxi_WREADY),
        .dBusAxi_wstrb(VexRiscvMcuAxi_0_dBusAxi_WSTRB),
        .dBusAxi_wvalid(VexRiscvMcuAxi_0_dBusAxi_WVALID),
        .externalInterrupt(peripherals_ext_intr),
        .iBusAxi_araddr(S_AXI_INST_1_ARADDR),
        .iBusAxi_arburst(S_AXI_INST_1_ARBURST),
        .iBusAxi_arcache(S_AXI_INST_1_ARCACHE),
        .iBusAxi_arid(S_AXI_INST_1_ARID),
        .iBusAxi_arlen(S_AXI_INST_1_ARLEN),
        .iBusAxi_arlock(S_AXI_INST_1_ARLOCK),
        .iBusAxi_arprot(S_AXI_INST_1_ARPROT),
        .iBusAxi_arready(S_AXI_INST_1_ARREADY),
        .iBusAxi_arsize(S_AXI_INST_1_ARSIZE),
        .iBusAxi_arvalid(S_AXI_INST_1_ARVALID),
        .iBusAxi_rdata(S_AXI_INST_1_RDATA),
        .iBusAxi_rid(S_AXI_INST_1_RID),
        .iBusAxi_rlast(S_AXI_INST_1_RLAST),
        .iBusAxi_rready(S_AXI_INST_1_RREADY),
        .iBusAxi_rresp(S_AXI_INST_1_RRESP),
        .iBusAxi_rvalid(S_AXI_INST_1_RVALID),
        .reset(cpu_reset_controller_c),
        .softwareInterrupt(1'b0),
        .timerInterrupt(peripherals_IRQ));
  design_1_axi_cdma_0_0 axi_cdma_0
       (.cdma_introut(cdma_irq_1),
        .m_axi_aclk(clk_wiz_0_clk_out1),
        .m_axi_araddr(axi_cdma_0_M_AXI_ARADDR),
        .m_axi_arburst(axi_cdma_0_M_AXI_ARBURST),
        .m_axi_arcache(axi_cdma_0_M_AXI_ARCACHE),
        .m_axi_arlen(axi_cdma_0_M_AXI_ARLEN),
        .m_axi_arprot(axi_cdma_0_M_AXI_ARPROT),
        .m_axi_arready(axi_cdma_0_M_AXI_ARREADY),
        .m_axi_arsize(axi_cdma_0_M_AXI_ARSIZE),
        .m_axi_arvalid(axi_cdma_0_M_AXI_ARVALID),
        .m_axi_awaddr(axi_cdma_0_M_AXI_AWADDR),
        .m_axi_awburst(axi_cdma_0_M_AXI_AWBURST),
        .m_axi_awcache(axi_cdma_0_M_AXI_AWCACHE),
        .m_axi_awlen(axi_cdma_0_M_AXI_AWLEN),
        .m_axi_awprot(axi_cdma_0_M_AXI_AWPROT),
        .m_axi_awready(axi_cdma_0_M_AXI_AWREADY),
        .m_axi_awsize(axi_cdma_0_M_AXI_AWSIZE),
        .m_axi_awvalid(axi_cdma_0_M_AXI_AWVALID),
        .m_axi_bready(axi_cdma_0_M_AXI_BREADY),
        .m_axi_bresp(axi_cdma_0_M_AXI_BRESP),
        .m_axi_bvalid(axi_cdma_0_M_AXI_BVALID),
        .m_axi_rdata(axi_cdma_0_M_AXI_RDATA),
        .m_axi_rlast(axi_cdma_0_M_AXI_RLAST),
        .m_axi_rready(axi_cdma_0_M_AXI_RREADY),
        .m_axi_rresp(axi_cdma_0_M_AXI_RRESP),
        .m_axi_rvalid(axi_cdma_0_M_AXI_RVALID),
        .m_axi_wdata(axi_cdma_0_M_AXI_WDATA),
        .m_axi_wlast(axi_cdma_0_M_AXI_WLAST),
        .m_axi_wready(axi_cdma_0_M_AXI_WREADY),
        .m_axi_wstrb(axi_cdma_0_M_AXI_WSTRB),
        .m_axi_wvalid(axi_cdma_0_M_AXI_WVALID),
        .s_axi_lite_aclk(clk_wiz_0_clk_out1),
        .s_axi_lite_araddr(smartconnect_0_M03_AXI_ARADDR),
        .s_axi_lite_aresetn(sys_rst),
        .s_axi_lite_arready(smartconnect_0_M03_AXI_ARREADY),
        .s_axi_lite_arvalid(smartconnect_0_M03_AXI_ARVALID),
        .s_axi_lite_awaddr(smartconnect_0_M03_AXI_AWADDR),
        .s_axi_lite_awready(smartconnect_0_M03_AXI_AWREADY),
        .s_axi_lite_awvalid(smartconnect_0_M03_AXI_AWVALID),
        .s_axi_lite_bready(smartconnect_0_M03_AXI_BREADY),
        .s_axi_lite_bresp(smartconnect_0_M03_AXI_BRESP),
        .s_axi_lite_bvalid(smartconnect_0_M03_AXI_BVALID),
        .s_axi_lite_rdata(smartconnect_0_M03_AXI_RDATA),
        .s_axi_lite_rready(smartconnect_0_M03_AXI_RREADY),
        .s_axi_lite_rresp(smartconnect_0_M03_AXI_RRESP),
        .s_axi_lite_rvalid(smartconnect_0_M03_AXI_RVALID),
        .s_axi_lite_wdata(smartconnect_0_M03_AXI_WDATA),
        .s_axi_lite_wready(smartconnect_0_M03_AXI_WREADY),
        .s_axi_lite_wvalid(smartconnect_0_M03_AXI_WVALID));
  design_1_axi_ram_0_0 axi_ram_0
       (.clk(clk_wiz_0_clk_out1),
        .rst(negation_1_b),
        .s_axi_araddr(smartconnect_0_M01_AXI_ARADDR),
        .s_axi_arburst(smartconnect_0_M01_AXI_ARBURST),
        .s_axi_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen(smartconnect_0_M01_AXI_ARLEN),
        .s_axi_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .s_axi_arprot(smartconnect_0_M01_AXI_ARPROT),
        .s_axi_arready(smartconnect_0_M01_AXI_ARREADY),
        .s_axi_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .s_axi_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .s_axi_awburst(smartconnect_0_M01_AXI_AWBURST),
        .s_axi_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen(smartconnect_0_M01_AXI_AWLEN),
        .s_axi_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .s_axi_awprot(smartconnect_0_M01_AXI_AWPROT),
        .s_axi_awready(smartconnect_0_M01_AXI_AWREADY),
        .s_axi_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .s_axi_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M01_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M01_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M01_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M01_AXI_RDATA),
        .s_axi_rlast(smartconnect_0_M01_AXI_RLAST),
        .s_axi_rready(smartconnect_0_M01_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M01_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M01_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M01_AXI_WDATA),
        .s_axi_wlast(smartconnect_0_M01_AXI_WLAST),
        .s_axi_wready(smartconnect_0_M01_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M01_AXI_WVALID));
  design_1_clk_wiz_0_2 clk_wiz_0
       (.clk_in1(in_clk),
        .clk_out1(clk_wiz_0_clk_out1),
        .reset(negation_1_b));
  cpu_reset_controller_imp_Y312CB cpu_reset_controller
       (.clk(clk_wiz_0_clk_out1),
        .cpu_reset(cpu_rst),
        .reset(cpu_reset_controller_c),
        .sys_reset(sys_rst));
  instr_ram_imp_1811FLP instr_ram
       (.S_AXI_DATA_araddr(S_AXI_DATA_1_ARADDR),
        .S_AXI_DATA_arburst(S_AXI_DATA_1_ARBURST),
        .S_AXI_DATA_arcache(S_AXI_DATA_1_ARCACHE),
        .S_AXI_DATA_arlen(S_AXI_DATA_1_ARLEN),
        .S_AXI_DATA_arlock(S_AXI_DATA_1_ARLOCK),
        .S_AXI_DATA_arprot(S_AXI_DATA_1_ARPROT),
        .S_AXI_DATA_arready(S_AXI_DATA_1_ARREADY),
        .S_AXI_DATA_arsize(S_AXI_DATA_1_ARSIZE),
        .S_AXI_DATA_arvalid(S_AXI_DATA_1_ARVALID),
        .S_AXI_DATA_awaddr(S_AXI_DATA_1_AWADDR),
        .S_AXI_DATA_awburst(S_AXI_DATA_1_AWBURST),
        .S_AXI_DATA_awcache(S_AXI_DATA_1_AWCACHE),
        .S_AXI_DATA_awlen(S_AXI_DATA_1_AWLEN),
        .S_AXI_DATA_awlock(S_AXI_DATA_1_AWLOCK),
        .S_AXI_DATA_awprot(S_AXI_DATA_1_AWPROT),
        .S_AXI_DATA_awready(S_AXI_DATA_1_AWREADY),
        .S_AXI_DATA_awsize(S_AXI_DATA_1_AWSIZE),
        .S_AXI_DATA_awvalid(S_AXI_DATA_1_AWVALID),
        .S_AXI_DATA_bready(S_AXI_DATA_1_BREADY),
        .S_AXI_DATA_bresp(S_AXI_DATA_1_BRESP),
        .S_AXI_DATA_bvalid(S_AXI_DATA_1_BVALID),
        .S_AXI_DATA_rdata(S_AXI_DATA_1_RDATA),
        .S_AXI_DATA_rlast(S_AXI_DATA_1_RLAST),
        .S_AXI_DATA_rready(S_AXI_DATA_1_RREADY),
        .S_AXI_DATA_rresp(S_AXI_DATA_1_RRESP),
        .S_AXI_DATA_rvalid(S_AXI_DATA_1_RVALID),
        .S_AXI_DATA_wdata(S_AXI_DATA_1_WDATA),
        .S_AXI_DATA_wlast(S_AXI_DATA_1_WLAST),
        .S_AXI_DATA_wready(S_AXI_DATA_1_WREADY),
        .S_AXI_DATA_wstrb(S_AXI_DATA_1_WSTRB),
        .S_AXI_DATA_wvalid(S_AXI_DATA_1_WVALID),
        .S_AXI_INST_araddr(S_AXI_INST_1_ARADDR),
        .S_AXI_INST_arburst(S_AXI_INST_1_ARBURST),
        .S_AXI_INST_arcache(S_AXI_INST_1_ARCACHE),
        .S_AXI_INST_arid(S_AXI_INST_1_ARID),
        .S_AXI_INST_arlen(S_AXI_INST_1_ARLEN),
        .S_AXI_INST_arlock(S_AXI_INST_1_ARLOCK),
        .S_AXI_INST_arprot(S_AXI_INST_1_ARPROT),
        .S_AXI_INST_arready(S_AXI_INST_1_ARREADY),
        .S_AXI_INST_arsize(S_AXI_INST_1_ARSIZE),
        .S_AXI_INST_arvalid(S_AXI_INST_1_ARVALID),
        .S_AXI_INST_rdata(S_AXI_INST_1_RDATA),
        .S_AXI_INST_rid(S_AXI_INST_1_RID),
        .S_AXI_INST_rlast(S_AXI_INST_1_RLAST),
        .S_AXI_INST_rready(S_AXI_INST_1_RREADY),
        .S_AXI_INST_rresp(S_AXI_INST_1_RRESP),
        .S_AXI_INST_rvalid(S_AXI_INST_1_RVALID),
        .ram_addr(peripherals_bram_addr),
        .ram_clk(clk_wiz_0_clk_out1),
        .ram_din(peripherals_bram_d),
        .ram_en(peripherals_bram_en),
        .ram_mux_select(negation_2_b),
        .ram_we(peripherals_bram_we),
        .s_axi_aclk(clk_wiz_0_clk_out1),
        .s_axi_aresetn(sys_rst));
  design_1_negation_1_0 negation_1
       (.a(sys_rst),
        .b(negation_1_b),
        .clk(in_clk));
  design_1_negation_1_3 negation_2
       (.a(cpu_rst),
        .b(negation_2_b),
        .clk(clk_wiz_0_clk_out1));
  design_1_npu_axil_wrapper_0_0 npu_axil_wrapper_0
       (.aresetn(sys_rst),
        .boot_mode(peripherals_npu_boot_active),
        .clk(clk_wiz_0_clk_out1),
        .interrupt(npu_axil_wrapper_0_interrupt),
        .raw_instr_addr(peripherals_npu_instr_addr),
        .raw_instr_din(peripherals_npu_instr_din),
        .raw_instr_we(peripherals_npu_instr_we),
        .raw_mem_ready(npu_axil_wrapper_0_raw_mem_ready),
        .raw_scratchpad_addr(peripherals_npu_scratchpad_addr[12:0]),
        .raw_scratchpad_din(peripherals_npu_scratchpad_din),
        .raw_scratchpad_we(peripherals_npu_scratchpad_we),
        .raw_weight_addr(peripherals_npu_weight_addr[12:0]),
        .raw_weight_din(peripherals_npu_weight_din),
        .raw_weight_we(peripherals_npu_weight_we),
        .s_axi_araddr(smartconnect_0_M04_AXI_ARADDR),
        .s_axi_arprot(smartconnect_0_M04_AXI_ARPROT),
        .s_axi_arready(smartconnect_0_M04_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_0_M04_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M04_AXI_AWADDR),
        .s_axi_awprot(smartconnect_0_M04_AXI_AWPROT),
        .s_axi_awready(smartconnect_0_M04_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_0_M04_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M04_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M04_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M04_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M04_AXI_RDATA),
        .s_axi_rready(smartconnect_0_M04_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M04_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M04_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M04_AXI_WDATA),
        .s_axi_wready(smartconnect_0_M04_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M04_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M04_AXI_WVALID));
  peripherals_imp_1BOSXT5 peripherals
       (.GPIO_0_tri_i(GPIO_0_tri_i),
        .GPIO_0_tri_o(GPIO_0_tri_o),
        .GPIO_0_tri_t(GPIO_0_tri_t),
        .IOBUF_scl(IOBUF_scl),
        .IOBUF_sda(IOBUF_sda),
        .S00_AXI_araddr(smartconnect_0_M02_AXI_ARADDR),
        .S00_AXI_arburst(smartconnect_0_M02_AXI_ARBURST),
        .S00_AXI_arcache(smartconnect_0_M02_AXI_ARCACHE),
        .S00_AXI_arid(smartconnect_0_M02_AXI_ARID),
        .S00_AXI_arlen(smartconnect_0_M02_AXI_ARLEN),
        .S00_AXI_arlock(smartconnect_0_M02_AXI_ARLOCK),
        .S00_AXI_arprot(smartconnect_0_M02_AXI_ARPROT),
        .S00_AXI_arqos(smartconnect_0_M02_AXI_ARQOS),
        .S00_AXI_arready(smartconnect_0_M02_AXI_ARREADY),
        .S00_AXI_arsize(smartconnect_0_M02_AXI_ARSIZE),
        .S00_AXI_aruser(smartconnect_0_M02_AXI_ARUSER),
        .S00_AXI_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .S00_AXI_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .S00_AXI_awburst(smartconnect_0_M02_AXI_AWBURST),
        .S00_AXI_awcache(smartconnect_0_M02_AXI_AWCACHE),
        .S00_AXI_awid(smartconnect_0_M02_AXI_AWID),
        .S00_AXI_awlen(smartconnect_0_M02_AXI_AWLEN),
        .S00_AXI_awlock(smartconnect_0_M02_AXI_AWLOCK),
        .S00_AXI_awprot(smartconnect_0_M02_AXI_AWPROT),
        .S00_AXI_awqos(smartconnect_0_M02_AXI_AWQOS),
        .S00_AXI_awready(smartconnect_0_M02_AXI_AWREADY),
        .S00_AXI_awsize(smartconnect_0_M02_AXI_AWSIZE),
        .S00_AXI_awuser(smartconnect_0_M02_AXI_AWUSER),
        .S00_AXI_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .S00_AXI_bid(smartconnect_0_M02_AXI_BID),
        .S00_AXI_bready(smartconnect_0_M02_AXI_BREADY),
        .S00_AXI_bresp(smartconnect_0_M02_AXI_BRESP),
        .S00_AXI_bvalid(smartconnect_0_M02_AXI_BVALID),
        .S00_AXI_rdata(smartconnect_0_M02_AXI_RDATA),
        .S00_AXI_rid(smartconnect_0_M02_AXI_RID),
        .S00_AXI_rlast(smartconnect_0_M02_AXI_RLAST),
        .S00_AXI_rready(smartconnect_0_M02_AXI_RREADY),
        .S00_AXI_rresp(smartconnect_0_M02_AXI_RRESP),
        .S00_AXI_ruser(smartconnect_0_M02_AXI_RUSER),
        .S00_AXI_rvalid(smartconnect_0_M02_AXI_RVALID),
        .S00_AXI_wdata(smartconnect_0_M02_AXI_WDATA),
        .S00_AXI_wlast(smartconnect_0_M02_AXI_WLAST),
        .S00_AXI_wready(smartconnect_0_M02_AXI_WREADY),
        .S00_AXI_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .S00_AXI_wuser(smartconnect_0_M02_AXI_WUSER),
        .S00_AXI_wvalid(smartconnect_0_M02_AXI_WVALID),
        .SPI_0_0_io0_i(SPI_0_0_io0_i),
        .SPI_0_0_io0_o(SPI_0_0_io0_o),
        .SPI_0_0_io0_t(SPI_0_0_io0_t),
        .SPI_0_0_io1_i(SPI_0_0_io1_i),
        .SPI_0_0_io1_o(SPI_0_0_io1_o),
        .SPI_0_0_io1_t(SPI_0_0_io1_t),
        .SPI_0_0_sck_i(SPI_0_0_sck_i),
        .SPI_0_0_sck_o(SPI_0_0_sck_o),
        .SPI_0_0_sck_t(SPI_0_0_sck_t),
        .SPI_0_0_ss_i(SPI_0_0_ss_i),
        .SPI_0_0_ss_o(SPI_0_0_ss_o),
        .SPI_0_0_ss_t(SPI_0_0_ss_t),
        .axi_clk(clk_wiz_0_clk_out1),
        .axi_resetn(sys_rst),
        .boot_mode(negation_2_b),
        .bram_addr(peripherals_bram_addr),
        .bram_d(peripherals_bram_d),
        .bram_en(peripherals_bram_en),
        .bram_we(peripherals_bram_we),
        .cdma_irq(cdma_irq_1),
        .ext_irq(peripherals_ext_intr),
        .npu_boot_active(peripherals_npu_boot_active),
        .npu_instr_addr(peripherals_npu_instr_addr),
        .npu_instr_din(peripherals_npu_instr_din),
        .npu_instr_we(peripherals_npu_instr_we),
        .npu_int(npu_axil_wrapper_0_interrupt),
        .npu_ready(npu_axil_wrapper_0_raw_mem_ready),
        .npu_scratchpad_addr(peripherals_npu_scratchpad_addr),
        .npu_scratchpad_din(peripherals_npu_scratchpad_din),
        .npu_scratchpad_we(peripherals_npu_scratchpad_we),
        .npu_weight_addr(peripherals_npu_weight_addr),
        .npu_weight_din(peripherals_npu_weight_din),
        .npu_weight_we(peripherals_npu_weight_we),
        .timer_clk_in(clk_wiz_0_clk_out1),
        .timer_irq(peripherals_IRQ),
        .uart_rx_0(uart_rx_0),
        .uart_tx_0(uart_tx_0));
  design_1_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(S_AXI_DATA_1_ARADDR),
        .M00_AXI_arburst(S_AXI_DATA_1_ARBURST),
        .M00_AXI_arcache(S_AXI_DATA_1_ARCACHE),
        .M00_AXI_arlen(S_AXI_DATA_1_ARLEN),
        .M00_AXI_arlock(S_AXI_DATA_1_ARLOCK),
        .M00_AXI_arprot(S_AXI_DATA_1_ARPROT),
        .M00_AXI_arready(S_AXI_DATA_1_ARREADY),
        .M00_AXI_arsize(S_AXI_DATA_1_ARSIZE),
        .M00_AXI_arvalid(S_AXI_DATA_1_ARVALID),
        .M00_AXI_awaddr(S_AXI_DATA_1_AWADDR),
        .M00_AXI_awburst(S_AXI_DATA_1_AWBURST),
        .M00_AXI_awcache(S_AXI_DATA_1_AWCACHE),
        .M00_AXI_awlen(S_AXI_DATA_1_AWLEN),
        .M00_AXI_awlock(S_AXI_DATA_1_AWLOCK),
        .M00_AXI_awprot(S_AXI_DATA_1_AWPROT),
        .M00_AXI_awready(S_AXI_DATA_1_AWREADY),
        .M00_AXI_awsize(S_AXI_DATA_1_AWSIZE),
        .M00_AXI_awvalid(S_AXI_DATA_1_AWVALID),
        .M00_AXI_bready(S_AXI_DATA_1_BREADY),
        .M00_AXI_bresp(S_AXI_DATA_1_BRESP),
        .M00_AXI_bvalid(S_AXI_DATA_1_BVALID),
        .M00_AXI_rdata(S_AXI_DATA_1_RDATA),
        .M00_AXI_rlast(S_AXI_DATA_1_RLAST),
        .M00_AXI_rready(S_AXI_DATA_1_RREADY),
        .M00_AXI_rresp(S_AXI_DATA_1_RRESP),
        .M00_AXI_rvalid(S_AXI_DATA_1_RVALID),
        .M00_AXI_wdata(S_AXI_DATA_1_WDATA),
        .M00_AXI_wlast(S_AXI_DATA_1_WLAST),
        .M00_AXI_wready(S_AXI_DATA_1_WREADY),
        .M00_AXI_wstrb(S_AXI_DATA_1_WSTRB),
        .M00_AXI_wvalid(S_AXI_DATA_1_WVALID),
        .M01_AXI_araddr(smartconnect_0_M01_AXI_ARADDR),
        .M01_AXI_arburst(smartconnect_0_M01_AXI_ARBURST),
        .M01_AXI_arcache(smartconnect_0_M01_AXI_ARCACHE),
        .M01_AXI_arlen(smartconnect_0_M01_AXI_ARLEN),
        .M01_AXI_arlock(smartconnect_0_M01_AXI_ARLOCK),
        .M01_AXI_arprot(smartconnect_0_M01_AXI_ARPROT),
        .M01_AXI_arready(smartconnect_0_M01_AXI_ARREADY),
        .M01_AXI_arsize(smartconnect_0_M01_AXI_ARSIZE),
        .M01_AXI_arvalid(smartconnect_0_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_0_M01_AXI_AWADDR),
        .M01_AXI_awburst(smartconnect_0_M01_AXI_AWBURST),
        .M01_AXI_awcache(smartconnect_0_M01_AXI_AWCACHE),
        .M01_AXI_awlen(smartconnect_0_M01_AXI_AWLEN),
        .M01_AXI_awlock(smartconnect_0_M01_AXI_AWLOCK),
        .M01_AXI_awprot(smartconnect_0_M01_AXI_AWPROT),
        .M01_AXI_awready(smartconnect_0_M01_AXI_AWREADY),
        .M01_AXI_awsize(smartconnect_0_M01_AXI_AWSIZE),
        .M01_AXI_awvalid(smartconnect_0_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_0_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_0_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_0_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_0_M01_AXI_RDATA),
        .M01_AXI_rlast(smartconnect_0_M01_AXI_RLAST),
        .M01_AXI_rready(smartconnect_0_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_0_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_0_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_0_M01_AXI_WDATA),
        .M01_AXI_wlast(smartconnect_0_M01_AXI_WLAST),
        .M01_AXI_wready(smartconnect_0_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_0_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_0_M01_AXI_WVALID),
        .M02_AXI_araddr(smartconnect_0_M02_AXI_ARADDR),
        .M02_AXI_arburst(smartconnect_0_M02_AXI_ARBURST),
        .M02_AXI_arcache(smartconnect_0_M02_AXI_ARCACHE),
        .M02_AXI_arid(smartconnect_0_M02_AXI_ARID),
        .M02_AXI_arlen(smartconnect_0_M02_AXI_ARLEN),
        .M02_AXI_arlock(smartconnect_0_M02_AXI_ARLOCK),
        .M02_AXI_arprot(smartconnect_0_M02_AXI_ARPROT),
        .M02_AXI_arqos(smartconnect_0_M02_AXI_ARQOS),
        .M02_AXI_arready(smartconnect_0_M02_AXI_ARREADY),
        .M02_AXI_arsize(smartconnect_0_M02_AXI_ARSIZE),
        .M02_AXI_aruser(smartconnect_0_M02_AXI_ARUSER),
        .M02_AXI_arvalid(smartconnect_0_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_0_M02_AXI_AWADDR),
        .M02_AXI_awburst(smartconnect_0_M02_AXI_AWBURST),
        .M02_AXI_awcache(smartconnect_0_M02_AXI_AWCACHE),
        .M02_AXI_awid(smartconnect_0_M02_AXI_AWID),
        .M02_AXI_awlen(smartconnect_0_M02_AXI_AWLEN),
        .M02_AXI_awlock(smartconnect_0_M02_AXI_AWLOCK),
        .M02_AXI_awprot(smartconnect_0_M02_AXI_AWPROT),
        .M02_AXI_awqos(smartconnect_0_M02_AXI_AWQOS),
        .M02_AXI_awready(smartconnect_0_M02_AXI_AWREADY),
        .M02_AXI_awsize(smartconnect_0_M02_AXI_AWSIZE),
        .M02_AXI_awuser(smartconnect_0_M02_AXI_AWUSER),
        .M02_AXI_awvalid(smartconnect_0_M02_AXI_AWVALID),
        .M02_AXI_bid(smartconnect_0_M02_AXI_BID),
        .M02_AXI_bready(smartconnect_0_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_0_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_0_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_0_M02_AXI_RDATA),
        .M02_AXI_rid(smartconnect_0_M02_AXI_RID),
        .M02_AXI_rlast(smartconnect_0_M02_AXI_RLAST),
        .M02_AXI_rready(smartconnect_0_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_0_M02_AXI_RRESP),
        .M02_AXI_ruser(smartconnect_0_M02_AXI_RUSER),
        .M02_AXI_rvalid(smartconnect_0_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_0_M02_AXI_WDATA),
        .M02_AXI_wlast(smartconnect_0_M02_AXI_WLAST),
        .M02_AXI_wready(smartconnect_0_M02_AXI_WREADY),
        .M02_AXI_wstrb(smartconnect_0_M02_AXI_WSTRB),
        .M02_AXI_wuser(smartconnect_0_M02_AXI_WUSER),
        .M02_AXI_wvalid(smartconnect_0_M02_AXI_WVALID),
        .M03_AXI_araddr(smartconnect_0_M03_AXI_ARADDR),
        .M03_AXI_arready(smartconnect_0_M03_AXI_ARREADY),
        .M03_AXI_arvalid(smartconnect_0_M03_AXI_ARVALID),
        .M03_AXI_awaddr(smartconnect_0_M03_AXI_AWADDR),
        .M03_AXI_awready(smartconnect_0_M03_AXI_AWREADY),
        .M03_AXI_awvalid(smartconnect_0_M03_AXI_AWVALID),
        .M03_AXI_bready(smartconnect_0_M03_AXI_BREADY),
        .M03_AXI_bresp(smartconnect_0_M03_AXI_BRESP),
        .M03_AXI_bvalid(smartconnect_0_M03_AXI_BVALID),
        .M03_AXI_rdata(smartconnect_0_M03_AXI_RDATA),
        .M03_AXI_rready(smartconnect_0_M03_AXI_RREADY),
        .M03_AXI_rresp(smartconnect_0_M03_AXI_RRESP),
        .M03_AXI_rvalid(smartconnect_0_M03_AXI_RVALID),
        .M03_AXI_wdata(smartconnect_0_M03_AXI_WDATA),
        .M03_AXI_wready(smartconnect_0_M03_AXI_WREADY),
        .M03_AXI_wvalid(smartconnect_0_M03_AXI_WVALID),
        .M04_AXI_araddr(smartconnect_0_M04_AXI_ARADDR),
        .M04_AXI_arprot(smartconnect_0_M04_AXI_ARPROT),
        .M04_AXI_arready(smartconnect_0_M04_AXI_ARREADY),
        .M04_AXI_arvalid(smartconnect_0_M04_AXI_ARVALID),
        .M04_AXI_awaddr(smartconnect_0_M04_AXI_AWADDR),
        .M04_AXI_awprot(smartconnect_0_M04_AXI_AWPROT),
        .M04_AXI_awready(smartconnect_0_M04_AXI_AWREADY),
        .M04_AXI_awvalid(smartconnect_0_M04_AXI_AWVALID),
        .M04_AXI_bready(smartconnect_0_M04_AXI_BREADY),
        .M04_AXI_bresp(smartconnect_0_M04_AXI_BRESP),
        .M04_AXI_bvalid(smartconnect_0_M04_AXI_BVALID),
        .M04_AXI_rdata(smartconnect_0_M04_AXI_RDATA),
        .M04_AXI_rready(smartconnect_0_M04_AXI_RREADY),
        .M04_AXI_rresp(smartconnect_0_M04_AXI_RRESP),
        .M04_AXI_rvalid(smartconnect_0_M04_AXI_RVALID),
        .M04_AXI_wdata(smartconnect_0_M04_AXI_WDATA),
        .M04_AXI_wready(smartconnect_0_M04_AXI_WREADY),
        .M04_AXI_wstrb(smartconnect_0_M04_AXI_WSTRB),
        .M04_AXI_wvalid(smartconnect_0_M04_AXI_WVALID),
        .S00_AXI_araddr(VexRiscvMcuAxi_0_dBusAxi_ARADDR),
        .S00_AXI_arburst(VexRiscvMcuAxi_0_dBusAxi_ARBURST),
        .S00_AXI_arcache(VexRiscvMcuAxi_0_dBusAxi_ARCACHE),
        .S00_AXI_arid(VexRiscvMcuAxi_0_dBusAxi_ARID),
        .S00_AXI_arlen(VexRiscvMcuAxi_0_dBusAxi_ARLEN),
        .S00_AXI_arlock(VexRiscvMcuAxi_0_dBusAxi_ARLOCK),
        .S00_AXI_arprot(VexRiscvMcuAxi_0_dBusAxi_ARPROT),
        .S00_AXI_arqos(VexRiscvMcuAxi_0_dBusAxi_ARQOS),
        .S00_AXI_arready(VexRiscvMcuAxi_0_dBusAxi_ARREADY),
        .S00_AXI_arsize(VexRiscvMcuAxi_0_dBusAxi_ARSIZE),
        .S00_AXI_arvalid(VexRiscvMcuAxi_0_dBusAxi_ARVALID),
        .S00_AXI_awaddr(VexRiscvMcuAxi_0_dBusAxi_AWADDR),
        .S00_AXI_awburst(VexRiscvMcuAxi_0_dBusAxi_AWBURST),
        .S00_AXI_awcache(VexRiscvMcuAxi_0_dBusAxi_AWCACHE),
        .S00_AXI_awid(VexRiscvMcuAxi_0_dBusAxi_AWID),
        .S00_AXI_awlen(VexRiscvMcuAxi_0_dBusAxi_AWLEN),
        .S00_AXI_awlock(VexRiscvMcuAxi_0_dBusAxi_AWLOCK),
        .S00_AXI_awprot(VexRiscvMcuAxi_0_dBusAxi_AWPROT),
        .S00_AXI_awqos(VexRiscvMcuAxi_0_dBusAxi_AWQOS),
        .S00_AXI_awready(VexRiscvMcuAxi_0_dBusAxi_AWREADY),
        .S00_AXI_awsize(VexRiscvMcuAxi_0_dBusAxi_AWSIZE),
        .S00_AXI_awvalid(VexRiscvMcuAxi_0_dBusAxi_AWVALID),
        .S00_AXI_bid(VexRiscvMcuAxi_0_dBusAxi_BID),
        .S00_AXI_bready(VexRiscvMcuAxi_0_dBusAxi_BREADY),
        .S00_AXI_bresp(VexRiscvMcuAxi_0_dBusAxi_BRESP),
        .S00_AXI_bvalid(VexRiscvMcuAxi_0_dBusAxi_BVALID),
        .S00_AXI_rdata(VexRiscvMcuAxi_0_dBusAxi_RDATA),
        .S00_AXI_rid(VexRiscvMcuAxi_0_dBusAxi_RID),
        .S00_AXI_rlast(VexRiscvMcuAxi_0_dBusAxi_RLAST),
        .S00_AXI_rready(VexRiscvMcuAxi_0_dBusAxi_RREADY),
        .S00_AXI_rresp(VexRiscvMcuAxi_0_dBusAxi_RRESP),
        .S00_AXI_rvalid(VexRiscvMcuAxi_0_dBusAxi_RVALID),
        .S00_AXI_wdata(VexRiscvMcuAxi_0_dBusAxi_WDATA),
        .S00_AXI_wlast(VexRiscvMcuAxi_0_dBusAxi_WLAST),
        .S00_AXI_wready(VexRiscvMcuAxi_0_dBusAxi_WREADY),
        .S00_AXI_wstrb(VexRiscvMcuAxi_0_dBusAxi_WSTRB),
        .S00_AXI_wvalid(VexRiscvMcuAxi_0_dBusAxi_WVALID),
        .S01_AXI_araddr(axi_cdma_0_M_AXI_ARADDR),
        .S01_AXI_arburst(axi_cdma_0_M_AXI_ARBURST),
        .S01_AXI_arcache(axi_cdma_0_M_AXI_ARCACHE),
        .S01_AXI_arlen(axi_cdma_0_M_AXI_ARLEN),
        .S01_AXI_arlock(1'b0),
        .S01_AXI_arprot(axi_cdma_0_M_AXI_ARPROT),
        .S01_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S01_AXI_arready(axi_cdma_0_M_AXI_ARREADY),
        .S01_AXI_arsize(axi_cdma_0_M_AXI_ARSIZE),
        .S01_AXI_arvalid(axi_cdma_0_M_AXI_ARVALID),
        .S01_AXI_awaddr(axi_cdma_0_M_AXI_AWADDR),
        .S01_AXI_awburst(axi_cdma_0_M_AXI_AWBURST),
        .S01_AXI_awcache(axi_cdma_0_M_AXI_AWCACHE),
        .S01_AXI_awlen(axi_cdma_0_M_AXI_AWLEN),
        .S01_AXI_awlock(1'b0),
        .S01_AXI_awprot(axi_cdma_0_M_AXI_AWPROT),
        .S01_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S01_AXI_awready(axi_cdma_0_M_AXI_AWREADY),
        .S01_AXI_awsize(axi_cdma_0_M_AXI_AWSIZE),
        .S01_AXI_awvalid(axi_cdma_0_M_AXI_AWVALID),
        .S01_AXI_bready(axi_cdma_0_M_AXI_BREADY),
        .S01_AXI_bresp(axi_cdma_0_M_AXI_BRESP),
        .S01_AXI_bvalid(axi_cdma_0_M_AXI_BVALID),
        .S01_AXI_rdata(axi_cdma_0_M_AXI_RDATA),
        .S01_AXI_rlast(axi_cdma_0_M_AXI_RLAST),
        .S01_AXI_rready(axi_cdma_0_M_AXI_RREADY),
        .S01_AXI_rresp(axi_cdma_0_M_AXI_RRESP),
        .S01_AXI_rvalid(axi_cdma_0_M_AXI_RVALID),
        .S01_AXI_wdata(axi_cdma_0_M_AXI_WDATA),
        .S01_AXI_wlast(axi_cdma_0_M_AXI_WLAST),
        .S01_AXI_wready(axi_cdma_0_M_AXI_WREADY),
        .S01_AXI_wstrb(axi_cdma_0_M_AXI_WSTRB),
        .S01_AXI_wvalid(axi_cdma_0_M_AXI_WVALID),
        .aclk(clk_wiz_0_clk_out1),
        .aresetn(sys_rst));
endmodule

module instr_ram_imp_1811FLP
   (S_AXI_DATA_araddr,
    S_AXI_DATA_arburst,
    S_AXI_DATA_arcache,
    S_AXI_DATA_arlen,
    S_AXI_DATA_arlock,
    S_AXI_DATA_arprot,
    S_AXI_DATA_arready,
    S_AXI_DATA_arsize,
    S_AXI_DATA_arvalid,
    S_AXI_DATA_awaddr,
    S_AXI_DATA_awburst,
    S_AXI_DATA_awcache,
    S_AXI_DATA_awlen,
    S_AXI_DATA_awlock,
    S_AXI_DATA_awprot,
    S_AXI_DATA_awready,
    S_AXI_DATA_awsize,
    S_AXI_DATA_awvalid,
    S_AXI_DATA_bready,
    S_AXI_DATA_bresp,
    S_AXI_DATA_bvalid,
    S_AXI_DATA_rdata,
    S_AXI_DATA_rlast,
    S_AXI_DATA_rready,
    S_AXI_DATA_rresp,
    S_AXI_DATA_rvalid,
    S_AXI_DATA_wdata,
    S_AXI_DATA_wlast,
    S_AXI_DATA_wready,
    S_AXI_DATA_wstrb,
    S_AXI_DATA_wvalid,
    S_AXI_INST_araddr,
    S_AXI_INST_arburst,
    S_AXI_INST_arcache,
    S_AXI_INST_arid,
    S_AXI_INST_arlen,
    S_AXI_INST_arlock,
    S_AXI_INST_arprot,
    S_AXI_INST_arready,
    S_AXI_INST_arsize,
    S_AXI_INST_arvalid,
    S_AXI_INST_rdata,
    S_AXI_INST_rid,
    S_AXI_INST_rlast,
    S_AXI_INST_rready,
    S_AXI_INST_rresp,
    S_AXI_INST_rvalid,
    ram_addr,
    ram_clk,
    ram_din,
    ram_dout,
    ram_en,
    ram_mux_select,
    ram_we,
    s_axi_aclk,
    s_axi_aresetn);
  input [13:0]S_AXI_DATA_araddr;
  input [1:0]S_AXI_DATA_arburst;
  input [3:0]S_AXI_DATA_arcache;
  input [7:0]S_AXI_DATA_arlen;
  input S_AXI_DATA_arlock;
  input [2:0]S_AXI_DATA_arprot;
  output S_AXI_DATA_arready;
  input [2:0]S_AXI_DATA_arsize;
  input S_AXI_DATA_arvalid;
  input [13:0]S_AXI_DATA_awaddr;
  input [1:0]S_AXI_DATA_awburst;
  input [3:0]S_AXI_DATA_awcache;
  input [7:0]S_AXI_DATA_awlen;
  input S_AXI_DATA_awlock;
  input [2:0]S_AXI_DATA_awprot;
  output S_AXI_DATA_awready;
  input [2:0]S_AXI_DATA_awsize;
  input S_AXI_DATA_awvalid;
  input S_AXI_DATA_bready;
  output [1:0]S_AXI_DATA_bresp;
  output S_AXI_DATA_bvalid;
  output [31:0]S_AXI_DATA_rdata;
  output S_AXI_DATA_rlast;
  input S_AXI_DATA_rready;
  output [1:0]S_AXI_DATA_rresp;
  output S_AXI_DATA_rvalid;
  input [31:0]S_AXI_DATA_wdata;
  input S_AXI_DATA_wlast;
  output S_AXI_DATA_wready;
  input [3:0]S_AXI_DATA_wstrb;
  input S_AXI_DATA_wvalid;
  input [31:0]S_AXI_INST_araddr;
  input [1:0]S_AXI_INST_arburst;
  input [3:0]S_AXI_INST_arcache;
  input [0:0]S_AXI_INST_arid;
  input [7:0]S_AXI_INST_arlen;
  input S_AXI_INST_arlock;
  input [2:0]S_AXI_INST_arprot;
  output S_AXI_INST_arready;
  input [2:0]S_AXI_INST_arsize;
  input S_AXI_INST_arvalid;
  output [31:0]S_AXI_INST_rdata;
  output [0:0]S_AXI_INST_rid;
  output S_AXI_INST_rlast;
  input S_AXI_INST_rready;
  output [1:0]S_AXI_INST_rresp;
  output S_AXI_INST_rvalid;
  input [13:0]ram_addr;
  input ram_clk;
  input [31:0]ram_din;
  output [31:0]ram_dout;
  input ram_en;
  input ram_mux_select;
  input [3:0]ram_we;
  input s_axi_aclk;
  input s_axi_aresetn;

  wire [13:0]S_AXI_DATA_araddr;
  wire [1:0]S_AXI_DATA_arburst;
  wire [3:0]S_AXI_DATA_arcache;
  wire [7:0]S_AXI_DATA_arlen;
  wire S_AXI_DATA_arlock;
  wire [2:0]S_AXI_DATA_arprot;
  wire S_AXI_DATA_arready;
  wire [2:0]S_AXI_DATA_arsize;
  wire S_AXI_DATA_arvalid;
  wire [13:0]S_AXI_DATA_awaddr;
  wire [1:0]S_AXI_DATA_awburst;
  wire [3:0]S_AXI_DATA_awcache;
  wire [7:0]S_AXI_DATA_awlen;
  wire S_AXI_DATA_awlock;
  wire [2:0]S_AXI_DATA_awprot;
  wire S_AXI_DATA_awready;
  wire [2:0]S_AXI_DATA_awsize;
  wire S_AXI_DATA_awvalid;
  wire S_AXI_DATA_bready;
  wire [1:0]S_AXI_DATA_bresp;
  wire S_AXI_DATA_bvalid;
  wire [31:0]S_AXI_DATA_rdata;
  wire S_AXI_DATA_rlast;
  wire S_AXI_DATA_rready;
  wire [1:0]S_AXI_DATA_rresp;
  wire S_AXI_DATA_rvalid;
  wire [31:0]S_AXI_DATA_wdata;
  wire S_AXI_DATA_wlast;
  wire S_AXI_DATA_wready;
  wire [3:0]S_AXI_DATA_wstrb;
  wire S_AXI_DATA_wvalid;
  wire [31:0]S_AXI_INST_araddr;
  wire [1:0]S_AXI_INST_arburst;
  wire [3:0]S_AXI_INST_arcache;
  wire [0:0]S_AXI_INST_arid;
  wire [7:0]S_AXI_INST_arlen;
  wire S_AXI_INST_arlock;
  wire [2:0]S_AXI_INST_arprot;
  wire S_AXI_INST_arready;
  wire [2:0]S_AXI_INST_arsize;
  wire S_AXI_INST_arvalid;
  wire [31:0]S_AXI_INST_rdata;
  wire [0:0]S_AXI_INST_rid;
  wire S_AXI_INST_rlast;
  wire S_AXI_INST_rready;
  wire [1:0]S_AXI_INST_rresp;
  wire S_AXI_INST_rvalid;
  wire [13:0]axi_bram_ctrl_0_bram_addr_a;
  wire axi_bram_ctrl_0_bram_en_a;
  wire [3:0]axi_bram_ctrl_0_bram_we_a;
  wire [31:0]axi_bram_ctrl_0_bram_wrdata_a;
  wire [13:0]axi_bram_ctrl_1_bram_addr_a;
  wire axi_bram_ctrl_1_bram_en_a;
  wire [3:0]axi_bram_ctrl_1_bram_we_a;
  wire [31:0]axi_bram_ctrl_1_bram_wrdata_a;
  wire [31:0]muxed_dual_port_ram_0_axi_a_dout;
  wire [31:0]muxed_dual_port_ram_0_axi_b_dout;
  wire [13:0]ram_addr;
  wire ram_clk;
  wire [31:0]ram_din;
  wire [31:0]ram_dout;
  wire ram_en;
  wire ram_mux_select;
  wire [3:0]ram_we;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire [11:0]xlslice_0_Dout;
  wire [11:0]xlslice_1_Dout;

  design_1_axi_bram_ctrl_0_1 axi_bram_ctrl_0
       (.bram_addr_a(axi_bram_ctrl_0_bram_addr_a),
        .bram_en_a(axi_bram_ctrl_0_bram_en_a),
        .bram_rddata_a(muxed_dual_port_ram_0_axi_a_dout),
        .bram_we_a(axi_bram_ctrl_0_bram_we_a),
        .bram_wrdata_a(axi_bram_ctrl_0_bram_wrdata_a),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(S_AXI_INST_araddr[13:0]),
        .s_axi_arburst(S_AXI_INST_arburst),
        .s_axi_arcache(S_AXI_INST_arcache),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arid(S_AXI_INST_arid),
        .s_axi_arlen(S_AXI_INST_arlen),
        .s_axi_arlock(S_AXI_INST_arlock),
        .s_axi_arprot(S_AXI_INST_arprot),
        .s_axi_arready(S_AXI_INST_arready),
        .s_axi_arsize(S_AXI_INST_arsize),
        .s_axi_arvalid(S_AXI_INST_arvalid),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b1}),
        .s_axi_awcache({1'b0,1'b0,1'b1,1'b1}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b1,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bready(1'b0),
        .s_axi_rdata(S_AXI_INST_rdata),
        .s_axi_rid(S_AXI_INST_rid),
        .s_axi_rlast(S_AXI_INST_rlast),
        .s_axi_rready(S_AXI_INST_rready),
        .s_axi_rresp(S_AXI_INST_rresp),
        .s_axi_rvalid(S_AXI_INST_rvalid),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wstrb({1'b1,1'b1,1'b1,1'b1}),
        .s_axi_wvalid(1'b0));
  design_1_axi_bram_ctrl_0_2 axi_bram_ctrl_1
       (.bram_addr_a(axi_bram_ctrl_1_bram_addr_a),
        .bram_en_a(axi_bram_ctrl_1_bram_en_a),
        .bram_rddata_a(muxed_dual_port_ram_0_axi_b_dout),
        .bram_we_a(axi_bram_ctrl_1_bram_we_a),
        .bram_wrdata_a(axi_bram_ctrl_1_bram_wrdata_a),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(S_AXI_DATA_araddr),
        .s_axi_arburst(S_AXI_DATA_arburst),
        .s_axi_arcache(S_AXI_DATA_arcache),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arlen(S_AXI_DATA_arlen),
        .s_axi_arlock(S_AXI_DATA_arlock),
        .s_axi_arprot(S_AXI_DATA_arprot),
        .s_axi_arready(S_AXI_DATA_arready),
        .s_axi_arsize(S_AXI_DATA_arsize),
        .s_axi_arvalid(S_AXI_DATA_arvalid),
        .s_axi_awaddr(S_AXI_DATA_awaddr),
        .s_axi_awburst(S_AXI_DATA_awburst),
        .s_axi_awcache(S_AXI_DATA_awcache),
        .s_axi_awlen(S_AXI_DATA_awlen),
        .s_axi_awlock(S_AXI_DATA_awlock),
        .s_axi_awprot(S_AXI_DATA_awprot),
        .s_axi_awready(S_AXI_DATA_awready),
        .s_axi_awsize(S_AXI_DATA_awsize),
        .s_axi_awvalid(S_AXI_DATA_awvalid),
        .s_axi_bready(S_AXI_DATA_bready),
        .s_axi_bresp(S_AXI_DATA_bresp),
        .s_axi_bvalid(S_AXI_DATA_bvalid),
        .s_axi_rdata(S_AXI_DATA_rdata),
        .s_axi_rlast(S_AXI_DATA_rlast),
        .s_axi_rready(S_AXI_DATA_rready),
        .s_axi_rresp(S_AXI_DATA_rresp),
        .s_axi_rvalid(S_AXI_DATA_rvalid),
        .s_axi_wdata(S_AXI_DATA_wdata),
        .s_axi_wlast(S_AXI_DATA_wlast),
        .s_axi_wready(S_AXI_DATA_wready),
        .s_axi_wstrb(S_AXI_DATA_wstrb),
        .s_axi_wvalid(S_AXI_DATA_wvalid));
  design_1_muxed_dual_port_ram_0_0 muxed_dual_port_ram_0
       (.axi_a_addr(xlslice_0_Dout),
        .axi_a_din(axi_bram_ctrl_0_bram_wrdata_a),
        .axi_a_dout(muxed_dual_port_ram_0_axi_a_dout),
        .axi_a_en(axi_bram_ctrl_0_bram_en_a),
        .axi_a_we(axi_bram_ctrl_0_bram_we_a),
        .axi_b_addr(xlslice_1_Dout),
        .axi_b_din(axi_bram_ctrl_1_bram_wrdata_a),
        .axi_b_dout(muxed_dual_port_ram_0_axi_b_dout),
        .axi_b_en(axi_bram_ctrl_1_bram_en_a),
        .axi_b_we(axi_bram_ctrl_1_bram_we_a),
        .clk(ram_clk),
        .mode_pin(ram_mux_select),
        .raw_b_addr(ram_addr[11:0]),
        .raw_b_din(ram_din),
        .raw_b_dout(ram_dout),
        .raw_b_en(ram_en),
        .raw_b_we(ram_we));
  design_1_xlslice_0_0 xlslice_0
       (.Din(axi_bram_ctrl_0_bram_addr_a),
        .Dout(xlslice_0_Dout));
  design_1_xlslice_0_1 xlslice_1
       (.Din(axi_bram_ctrl_1_bram_addr_a),
        .Dout(xlslice_1_Dout));
endmodule

module peripherals_imp_1BOSXT5
   (GPIO_0_tri_i,
    GPIO_0_tri_o,
    GPIO_0_tri_t,
    IOBUF_scl,
    IOBUF_sda,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arsize,
    S00_AXI_aruser,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awsize,
    S00_AXI_awuser,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_ruser,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wuser,
    S00_AXI_wvalid,
    SPI_0_0_io0_i,
    SPI_0_0_io0_o,
    SPI_0_0_io0_t,
    SPI_0_0_io1_i,
    SPI_0_0_io1_o,
    SPI_0_0_io1_t,
    SPI_0_0_sck_i,
    SPI_0_0_sck_o,
    SPI_0_0_sck_t,
    SPI_0_0_ss_i,
    SPI_0_0_ss_o,
    SPI_0_0_ss_t,
    axi_clk,
    axi_resetn,
    boot_mode,
    bram_addr,
    bram_d,
    bram_en,
    bram_we,
    cdma_irq,
    ext_irq,
    npu_boot_active,
    npu_instr_addr,
    npu_instr_din,
    npu_instr_we,
    npu_int,
    npu_ready,
    npu_scratchpad_addr,
    npu_scratchpad_din,
    npu_scratchpad_we,
    npu_weight_addr,
    npu_weight_din,
    npu_weight_we,
    timer_clk_in,
    timer_irq,
    uart_rx_0,
    uart_tx_0);
  input [3:0]GPIO_0_tri_i;
  output [3:0]GPIO_0_tri_o;
  output [3:0]GPIO_0_tri_t;
  inout [0:0]IOBUF_scl;
  inout [0:0]IOBUF_sda;
  input [31:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [1:0]S00_AXI_arid;
  input [7:0]S00_AXI_arlen;
  input [0:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [2:0]S00_AXI_arsize;
  input [113:0]S00_AXI_aruser;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [1:0]S00_AXI_awid;
  input [7:0]S00_AXI_awlen;
  input [0:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [2:0]S00_AXI_awsize;
  input [113:0]S00_AXI_awuser;
  input S00_AXI_awvalid;
  output [1:0]S00_AXI_bid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output [1:0]S00_AXI_rid;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output [13:0]S00_AXI_ruser;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input [13:0]S00_AXI_wuser;
  input S00_AXI_wvalid;
  input SPI_0_0_io0_i;
  output SPI_0_0_io0_o;
  output SPI_0_0_io0_t;
  input SPI_0_0_io1_i;
  output SPI_0_0_io1_o;
  output SPI_0_0_io1_t;
  input SPI_0_0_sck_i;
  output SPI_0_0_sck_o;
  output SPI_0_0_sck_t;
  input [0:0]SPI_0_0_ss_i;
  output [0:0]SPI_0_0_ss_o;
  output SPI_0_0_ss_t;
  input axi_clk;
  input axi_resetn;
  input boot_mode;
  output [13:0]bram_addr;
  output [31:0]bram_d;
  output bram_en;
  output [3:0]bram_we;
  input cdma_irq;
  output ext_irq;
  output npu_boot_active;
  output [9:0]npu_instr_addr;
  output [35:0]npu_instr_din;
  output npu_instr_we;
  input [0:0]npu_int;
  input npu_ready;
  output [15:0]npu_scratchpad_addr;
  output [31:0]npu_scratchpad_din;
  output npu_scratchpad_we;
  output [15:0]npu_weight_addr;
  output [31:0]npu_weight_din;
  output npu_weight_we;
  input timer_clk_in;
  output timer_irq;
  input uart_rx_0;
  output uart_tx_0;

  wire [3:0]GPIO_0_tri_i;
  wire [3:0]GPIO_0_tri_o;
  wire [3:0]GPIO_0_tri_t;
  wire [0:0]IOBUF_scl;
  wire [0:0]IOBUF_sda;
  wire [31:0]S00_AXI_araddr;
  wire [1:0]S00_AXI_arburst;
  wire [3:0]S00_AXI_arcache;
  wire [1:0]S00_AXI_arid;
  wire [7:0]S00_AXI_arlen;
  wire [0:0]S00_AXI_arlock;
  wire [2:0]S00_AXI_arprot;
  wire [3:0]S00_AXI_arqos;
  wire S00_AXI_arready;
  wire [2:0]S00_AXI_arsize;
  wire [113:0]S00_AXI_aruser;
  wire S00_AXI_arvalid;
  wire [31:0]S00_AXI_awaddr;
  wire [1:0]S00_AXI_awburst;
  wire [3:0]S00_AXI_awcache;
  wire [1:0]S00_AXI_awid;
  wire [7:0]S00_AXI_awlen;
  wire [0:0]S00_AXI_awlock;
  wire [2:0]S00_AXI_awprot;
  wire [3:0]S00_AXI_awqos;
  wire S00_AXI_awready;
  wire [2:0]S00_AXI_awsize;
  wire [113:0]S00_AXI_awuser;
  wire S00_AXI_awvalid;
  wire [1:0]S00_AXI_bid;
  wire S00_AXI_bready;
  wire [1:0]S00_AXI_bresp;
  wire S00_AXI_bvalid;
  wire [31:0]S00_AXI_rdata;
  wire [1:0]S00_AXI_rid;
  wire S00_AXI_rlast;
  wire S00_AXI_rready;
  wire [1:0]S00_AXI_rresp;
  wire [13:0]S00_AXI_ruser;
  wire S00_AXI_rvalid;
  wire [31:0]S00_AXI_wdata;
  wire S00_AXI_wlast;
  wire S00_AXI_wready;
  wire [3:0]S00_AXI_wstrb;
  wire [13:0]S00_AXI_wuser;
  wire S00_AXI_wvalid;
  wire SPI_0_0_io0_i;
  wire SPI_0_0_io0_o;
  wire SPI_0_0_io0_t;
  wire SPI_0_0_io1_i;
  wire SPI_0_0_io1_o;
  wire SPI_0_0_io1_t;
  wire SPI_0_0_sck_i;
  wire SPI_0_0_sck_o;
  wire SPI_0_0_sck_t;
  wire [0:0]SPI_0_0_ss_i;
  wire [0:0]SPI_0_0_ss_o;
  wire SPI_0_0_ss_t;
  wire axi_clk;
  wire axi_gpio_0_ip2intc_irpt;
  wire axi_quad_spi_0_ip2intc_irpt;
  wire axi_resetn;
  wire axi_uart_bootloader_1_uart_irq;
  wire boot_mode;
  wire [13:0]bram_addr;
  wire [31:0]bram_d;
  wire bram_en;
  wire [3:0]bram_we;
  wire cdma_irq;
  wire ext_irq;
  wire i2c_master_axil_0_i2c_scl_o;
  wire i2c_master_axil_0_i2c_scl_t;
  wire i2c_master_axil_0_i2c_sda_o;
  wire i2c_master_axil_0_i2c_sda_t;
  wire negation_1_b;
  wire npu_boot_active;
  wire [9:0]npu_instr_addr;
  wire [35:0]npu_instr_din;
  wire npu_instr_we;
  wire [0:0]npu_int;
  wire npu_ready;
  wire [15:0]npu_scratchpad_addr;
  wire [31:0]npu_scratchpad_din;
  wire npu_scratchpad_we;
  wire [15:0]npu_weight_addr;
  wire [31:0]npu_weight_din;
  wire npu_weight_we;
  wire [3:0]smartconnect_1_M00_AXI_ARADDR;
  wire [2:0]smartconnect_1_M00_AXI_ARPROT;
  wire smartconnect_1_M00_AXI_ARREADY;
  wire smartconnect_1_M00_AXI_ARVALID;
  wire [3:0]smartconnect_1_M00_AXI_AWADDR;
  wire [2:0]smartconnect_1_M00_AXI_AWPROT;
  wire smartconnect_1_M00_AXI_AWREADY;
  wire smartconnect_1_M00_AXI_AWVALID;
  wire smartconnect_1_M00_AXI_BREADY;
  wire [1:0]smartconnect_1_M00_AXI_BRESP;
  wire smartconnect_1_M00_AXI_BVALID;
  wire [31:0]smartconnect_1_M00_AXI_RDATA;
  wire smartconnect_1_M00_AXI_RREADY;
  wire [1:0]smartconnect_1_M00_AXI_RRESP;
  wire smartconnect_1_M00_AXI_RVALID;
  wire [31:0]smartconnect_1_M00_AXI_WDATA;
  wire smartconnect_1_M00_AXI_WREADY;
  wire [3:0]smartconnect_1_M00_AXI_WSTRB;
  wire smartconnect_1_M00_AXI_WVALID;
  wire [3:0]smartconnect_1_M01_AXI_ARADDR;
  wire smartconnect_1_M01_AXI_ARREADY;
  wire smartconnect_1_M01_AXI_ARVALID;
  wire [3:0]smartconnect_1_M01_AXI_AWADDR;
  wire smartconnect_1_M01_AXI_AWREADY;
  wire smartconnect_1_M01_AXI_AWVALID;
  wire smartconnect_1_M01_AXI_BREADY;
  wire [1:0]smartconnect_1_M01_AXI_BRESP;
  wire smartconnect_1_M01_AXI_BVALID;
  wire [31:0]smartconnect_1_M01_AXI_RDATA;
  wire smartconnect_1_M01_AXI_RREADY;
  wire [1:0]smartconnect_1_M01_AXI_RRESP;
  wire smartconnect_1_M01_AXI_RVALID;
  wire [31:0]smartconnect_1_M01_AXI_WDATA;
  wire smartconnect_1_M01_AXI_WREADY;
  wire [3:0]smartconnect_1_M01_AXI_WSTRB;
  wire smartconnect_1_M01_AXI_WVALID;
  wire [31:0]smartconnect_1_M02_AXI_ARADDR;
  wire smartconnect_1_M02_AXI_ARREADY;
  wire smartconnect_1_M02_AXI_ARVALID;
  wire [31:0]smartconnect_1_M02_AXI_AWADDR;
  wire smartconnect_1_M02_AXI_AWREADY;
  wire smartconnect_1_M02_AXI_AWVALID;
  wire smartconnect_1_M02_AXI_BREADY;
  wire [1:0]smartconnect_1_M02_AXI_BRESP;
  wire smartconnect_1_M02_AXI_BVALID;
  wire [31:0]smartconnect_1_M02_AXI_RDATA;
  wire smartconnect_1_M02_AXI_RREADY;
  wire [1:0]smartconnect_1_M02_AXI_RRESP;
  wire smartconnect_1_M02_AXI_RVALID;
  wire [31:0]smartconnect_1_M02_AXI_WDATA;
  wire smartconnect_1_M02_AXI_WREADY;
  wire [3:0]smartconnect_1_M02_AXI_WSTRB;
  wire smartconnect_1_M02_AXI_WVALID;
  wire [8:0]smartconnect_1_M03_AXI_ARADDR;
  wire smartconnect_1_M03_AXI_ARREADY;
  wire smartconnect_1_M03_AXI_ARVALID;
  wire [8:0]smartconnect_1_M03_AXI_AWADDR;
  wire smartconnect_1_M03_AXI_AWREADY;
  wire smartconnect_1_M03_AXI_AWVALID;
  wire smartconnect_1_M03_AXI_BREADY;
  wire [1:0]smartconnect_1_M03_AXI_BRESP;
  wire smartconnect_1_M03_AXI_BVALID;
  wire [31:0]smartconnect_1_M03_AXI_RDATA;
  wire smartconnect_1_M03_AXI_RREADY;
  wire [1:0]smartconnect_1_M03_AXI_RRESP;
  wire smartconnect_1_M03_AXI_RVALID;
  wire [31:0]smartconnect_1_M03_AXI_WDATA;
  wire smartconnect_1_M03_AXI_WREADY;
  wire [3:0]smartconnect_1_M03_AXI_WSTRB;
  wire smartconnect_1_M03_AXI_WVALID;
  wire [3:0]smartconnect_1_M04_AXI_ARADDR;
  wire [2:0]smartconnect_1_M04_AXI_ARPROT;
  wire smartconnect_1_M04_AXI_ARREADY;
  wire smartconnect_1_M04_AXI_ARVALID;
  wire [3:0]smartconnect_1_M04_AXI_AWADDR;
  wire [2:0]smartconnect_1_M04_AXI_AWPROT;
  wire smartconnect_1_M04_AXI_AWREADY;
  wire smartconnect_1_M04_AXI_AWVALID;
  wire smartconnect_1_M04_AXI_BREADY;
  wire [1:0]smartconnect_1_M04_AXI_BRESP;
  wire smartconnect_1_M04_AXI_BVALID;
  wire [31:0]smartconnect_1_M04_AXI_RDATA;
  wire smartconnect_1_M04_AXI_RREADY;
  wire [1:0]smartconnect_1_M04_AXI_RRESP;
  wire smartconnect_1_M04_AXI_RVALID;
  wire [31:0]smartconnect_1_M04_AXI_WDATA;
  wire smartconnect_1_M04_AXI_WREADY;
  wire [3:0]smartconnect_1_M04_AXI_WSTRB;
  wire smartconnect_1_M04_AXI_WVALID;
  wire [6:0]smartconnect_1_M05_AXI_ARADDR;
  wire smartconnect_1_M05_AXI_ARREADY;
  wire smartconnect_1_M05_AXI_ARVALID;
  wire [6:0]smartconnect_1_M05_AXI_AWADDR;
  wire smartconnect_1_M05_AXI_AWREADY;
  wire smartconnect_1_M05_AXI_AWVALID;
  wire smartconnect_1_M05_AXI_BREADY;
  wire [1:0]smartconnect_1_M05_AXI_BRESP;
  wire smartconnect_1_M05_AXI_BVALID;
  wire [31:0]smartconnect_1_M05_AXI_RDATA;
  wire smartconnect_1_M05_AXI_RREADY;
  wire [1:0]smartconnect_1_M05_AXI_RRESP;
  wire smartconnect_1_M05_AXI_RVALID;
  wire [31:0]smartconnect_1_M05_AXI_WDATA;
  wire smartconnect_1_M05_AXI_WREADY;
  wire [3:0]smartconnect_1_M05_AXI_WSTRB;
  wire smartconnect_1_M05_AXI_WVALID;
  wire timer_clk_in;
  wire timer_irq;
  wire uart_rx_0;
  wire uart_tx_0;
  wire [0:0]util_ds_buf_0_IOBUF_IO_O;
  wire [0:0]util_ds_buf_1_IOBUF_IO_O;
  wire [7:0]xlconcat_0_dout;

  design_1_axi_gpio_0_0 axi_gpio_0
       (.gpio_io_i(GPIO_0_tri_i),
        .gpio_io_o(GPIO_0_tri_o),
        .gpio_io_t(GPIO_0_tri_t),
        .ip2intc_irpt(axi_gpio_0_ip2intc_irpt),
        .s_axi_aclk(axi_clk),
        .s_axi_araddr(smartconnect_1_M03_AXI_ARADDR),
        .s_axi_aresetn(axi_resetn),
        .s_axi_arready(smartconnect_1_M03_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_1_M03_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_1_M03_AXI_AWADDR),
        .s_axi_awready(smartconnect_1_M03_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_1_M03_AXI_AWVALID),
        .s_axi_bready(smartconnect_1_M03_AXI_BREADY),
        .s_axi_bresp(smartconnect_1_M03_AXI_BRESP),
        .s_axi_bvalid(smartconnect_1_M03_AXI_BVALID),
        .s_axi_rdata(smartconnect_1_M03_AXI_RDATA),
        .s_axi_rready(smartconnect_1_M03_AXI_RREADY),
        .s_axi_rresp(smartconnect_1_M03_AXI_RRESP),
        .s_axi_rvalid(smartconnect_1_M03_AXI_RVALID),
        .s_axi_wdata(smartconnect_1_M03_AXI_WDATA),
        .s_axi_wready(smartconnect_1_M03_AXI_WREADY),
        .s_axi_wstrb(smartconnect_1_M03_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_1_M03_AXI_WVALID));
  design_1_axi_quad_spi_0_0 axi_quad_spi_0
       (.ext_spi_clk(axi_clk),
        .io0_i(SPI_0_0_io0_i),
        .io0_o(SPI_0_0_io0_o),
        .io0_t(SPI_0_0_io0_t),
        .io1_i(SPI_0_0_io1_i),
        .io1_o(SPI_0_0_io1_o),
        .io1_t(SPI_0_0_io1_t),
        .ip2intc_irpt(axi_quad_spi_0_ip2intc_irpt),
        .s_axi_aclk(axi_clk),
        .s_axi_araddr(smartconnect_1_M05_AXI_ARADDR),
        .s_axi_aresetn(axi_resetn),
        .s_axi_arready(smartconnect_1_M05_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_1_M05_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_1_M05_AXI_AWADDR),
        .s_axi_awready(smartconnect_1_M05_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_1_M05_AXI_AWVALID),
        .s_axi_bready(smartconnect_1_M05_AXI_BREADY),
        .s_axi_bresp(smartconnect_1_M05_AXI_BRESP),
        .s_axi_bvalid(smartconnect_1_M05_AXI_BVALID),
        .s_axi_rdata(smartconnect_1_M05_AXI_RDATA),
        .s_axi_rready(smartconnect_1_M05_AXI_RREADY),
        .s_axi_rresp(smartconnect_1_M05_AXI_RRESP),
        .s_axi_rvalid(smartconnect_1_M05_AXI_RVALID),
        .s_axi_wdata(smartconnect_1_M05_AXI_WDATA),
        .s_axi_wready(smartconnect_1_M05_AXI_WREADY),
        .s_axi_wstrb(smartconnect_1_M05_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_1_M05_AXI_WVALID),
        .sck_i(SPI_0_0_sck_i),
        .sck_o(SPI_0_0_sck_o),
        .sck_t(SPI_0_0_sck_t),
        .ss_i(SPI_0_0_ss_i),
        .ss_o(SPI_0_0_ss_o),
        .ss_t(SPI_0_0_ss_t));
  design_1_axi_uart_bootloader_1_0 axi_uart_bootloader_1
       (.boot_mode(boot_mode),
        .bram_addr(bram_addr),
        .bram_din(bram_d),
        .bram_en(bram_en),
        .bram_we(bram_we),
        .npu_boot_active(npu_boot_active),
        .npu_instr_addr(npu_instr_addr),
        .npu_instr_din(npu_instr_din),
        .npu_instr_we(npu_instr_we),
        .npu_ready(npu_ready),
        .npu_scratchpad_addr(npu_scratchpad_addr),
        .npu_scratchpad_din(npu_scratchpad_din),
        .npu_scratchpad_we(npu_scratchpad_we),
        .npu_weight_addr(npu_weight_addr),
        .npu_weight_din(npu_weight_din),
        .npu_weight_we(npu_weight_we),
        .s_axi_aclk(axi_clk),
        .s_axi_araddr(smartconnect_1_M02_AXI_ARADDR),
        .s_axi_aresetn(axi_resetn),
        .s_axi_arready(smartconnect_1_M02_AXI_ARREADY),
        .s_axi_arvalid(smartconnect_1_M02_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_1_M02_AXI_AWADDR),
        .s_axi_awready(smartconnect_1_M02_AXI_AWREADY),
        .s_axi_awvalid(smartconnect_1_M02_AXI_AWVALID),
        .s_axi_bready(smartconnect_1_M02_AXI_BREADY),
        .s_axi_bresp(smartconnect_1_M02_AXI_BRESP),
        .s_axi_bvalid(smartconnect_1_M02_AXI_BVALID),
        .s_axi_rdata(smartconnect_1_M02_AXI_RDATA),
        .s_axi_rready(smartconnect_1_M02_AXI_RREADY),
        .s_axi_rresp(smartconnect_1_M02_AXI_RRESP),
        .s_axi_rvalid(smartconnect_1_M02_AXI_RVALID),
        .s_axi_wdata(smartconnect_1_M02_AXI_WDATA),
        .s_axi_wready(smartconnect_1_M02_AXI_WREADY),
        .s_axi_wstrb(smartconnect_1_M02_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_1_M02_AXI_WVALID),
        .uart_irq(axi_uart_bootloader_1_uart_irq),
        .uart_rx(uart_rx_0),
        .uart_tx(uart_tx_0));
  design_1_axil_timer_64_0_0 axil_timer_64_0
       (.IRQ(timer_irq),
        .S_AXI_ACLK(axi_clk),
        .S_AXI_ARADDR(smartconnect_1_M01_AXI_ARADDR),
        .S_AXI_ARESETN(axi_resetn),
        .S_AXI_ARREADY(smartconnect_1_M01_AXI_ARREADY),
        .S_AXI_ARVALID(smartconnect_1_M01_AXI_ARVALID),
        .S_AXI_AWADDR(smartconnect_1_M01_AXI_AWADDR),
        .S_AXI_AWREADY(smartconnect_1_M01_AXI_AWREADY),
        .S_AXI_AWVALID(smartconnect_1_M01_AXI_AWVALID),
        .S_AXI_BREADY(smartconnect_1_M01_AXI_BREADY),
        .S_AXI_BRESP(smartconnect_1_M01_AXI_BRESP),
        .S_AXI_BVALID(smartconnect_1_M01_AXI_BVALID),
        .S_AXI_RDATA(smartconnect_1_M01_AXI_RDATA),
        .S_AXI_RREADY(smartconnect_1_M01_AXI_RREADY),
        .S_AXI_RRESP(smartconnect_1_M01_AXI_RRESP),
        .S_AXI_RVALID(smartconnect_1_M01_AXI_RVALID),
        .S_AXI_WDATA(smartconnect_1_M01_AXI_WDATA),
        .S_AXI_WREADY(smartconnect_1_M01_AXI_WREADY),
        .S_AXI_WSTRB(smartconnect_1_M01_AXI_WSTRB),
        .S_AXI_WVALID(smartconnect_1_M01_AXI_WVALID));
  design_1_i2c_master_axil_0_0 i2c_master_axil_0
       (.clk(axi_clk),
        .i2c_scl_i(util_ds_buf_1_IOBUF_IO_O),
        .i2c_scl_o(i2c_master_axil_0_i2c_scl_o),
        .i2c_scl_t(i2c_master_axil_0_i2c_scl_t),
        .i2c_sda_i(util_ds_buf_0_IOBUF_IO_O),
        .i2c_sda_o(i2c_master_axil_0_i2c_sda_o),
        .i2c_sda_t(i2c_master_axil_0_i2c_sda_t),
        .rst(negation_1_b),
        .s_axil_araddr(smartconnect_1_M04_AXI_ARADDR),
        .s_axil_arprot(smartconnect_1_M04_AXI_ARPROT),
        .s_axil_arready(smartconnect_1_M04_AXI_ARREADY),
        .s_axil_arvalid(smartconnect_1_M04_AXI_ARVALID),
        .s_axil_awaddr(smartconnect_1_M04_AXI_AWADDR),
        .s_axil_awprot(smartconnect_1_M04_AXI_AWPROT),
        .s_axil_awready(smartconnect_1_M04_AXI_AWREADY),
        .s_axil_awvalid(smartconnect_1_M04_AXI_AWVALID),
        .s_axil_bready(smartconnect_1_M04_AXI_BREADY),
        .s_axil_bresp(smartconnect_1_M04_AXI_BRESP),
        .s_axil_bvalid(smartconnect_1_M04_AXI_BVALID),
        .s_axil_rdata(smartconnect_1_M04_AXI_RDATA),
        .s_axil_rready(smartconnect_1_M04_AXI_RREADY),
        .s_axil_rresp(smartconnect_1_M04_AXI_RRESP),
        .s_axil_rvalid(smartconnect_1_M04_AXI_RVALID),
        .s_axil_wdata(smartconnect_1_M04_AXI_WDATA),
        .s_axil_wready(smartconnect_1_M04_AXI_WREADY),
        .s_axil_wstrb(smartconnect_1_M04_AXI_WSTRB),
        .s_axil_wvalid(smartconnect_1_M04_AXI_WVALID));
  design_1_negation_1_2 negation_1
       (.a(axi_resetn),
        .b(negation_1_b),
        .clk(axi_clk));
  design_1_plic_axil_wrapper_0_0 plic_axil_wrapper_0
       (.S_AXI_ACLK(axi_clk),
        .S_AXI_ARADDR(smartconnect_1_M00_AXI_ARADDR),
        .S_AXI_ARESETN(axi_resetn),
        .S_AXI_ARPROT(smartconnect_1_M00_AXI_ARPROT),
        .S_AXI_ARREADY(smartconnect_1_M00_AXI_ARREADY),
        .S_AXI_ARVALID(smartconnect_1_M00_AXI_ARVALID),
        .S_AXI_AWADDR(smartconnect_1_M00_AXI_AWADDR),
        .S_AXI_AWPROT(smartconnect_1_M00_AXI_AWPROT),
        .S_AXI_AWREADY(smartconnect_1_M00_AXI_AWREADY),
        .S_AXI_AWVALID(smartconnect_1_M00_AXI_AWVALID),
        .S_AXI_BREADY(smartconnect_1_M00_AXI_BREADY),
        .S_AXI_BRESP(smartconnect_1_M00_AXI_BRESP),
        .S_AXI_BVALID(smartconnect_1_M00_AXI_BVALID),
        .S_AXI_RDATA(smartconnect_1_M00_AXI_RDATA),
        .S_AXI_RREADY(smartconnect_1_M00_AXI_RREADY),
        .S_AXI_RRESP(smartconnect_1_M00_AXI_RRESP),
        .S_AXI_RVALID(smartconnect_1_M00_AXI_RVALID),
        .S_AXI_WDATA(smartconnect_1_M00_AXI_WDATA),
        .S_AXI_WREADY(smartconnect_1_M00_AXI_WREADY),
        .S_AXI_WSTRB(smartconnect_1_M00_AXI_WSTRB),
        .S_AXI_WVALID(smartconnect_1_M00_AXI_WVALID),
        .ext_intr(ext_irq),
        .intr_pins(xlconcat_0_dout));
  design_1_smartconnect_1_0 smartconnect_1
       (.M00_AXI_araddr(smartconnect_1_M00_AXI_ARADDR),
        .M00_AXI_arprot(smartconnect_1_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_1_M00_AXI_ARREADY),
        .M00_AXI_arvalid(smartconnect_1_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_1_M00_AXI_AWADDR),
        .M00_AXI_awprot(smartconnect_1_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_1_M00_AXI_AWREADY),
        .M00_AXI_awvalid(smartconnect_1_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_1_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_1_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_1_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_1_M00_AXI_RDATA),
        .M00_AXI_rready(smartconnect_1_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_1_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_1_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_1_M00_AXI_WDATA),
        .M00_AXI_wready(smartconnect_1_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_1_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_1_M00_AXI_WVALID),
        .M01_AXI_araddr(smartconnect_1_M01_AXI_ARADDR),
        .M01_AXI_arready(smartconnect_1_M01_AXI_ARREADY),
        .M01_AXI_arvalid(smartconnect_1_M01_AXI_ARVALID),
        .M01_AXI_awaddr(smartconnect_1_M01_AXI_AWADDR),
        .M01_AXI_awready(smartconnect_1_M01_AXI_AWREADY),
        .M01_AXI_awvalid(smartconnect_1_M01_AXI_AWVALID),
        .M01_AXI_bready(smartconnect_1_M01_AXI_BREADY),
        .M01_AXI_bresp(smartconnect_1_M01_AXI_BRESP),
        .M01_AXI_bvalid(smartconnect_1_M01_AXI_BVALID),
        .M01_AXI_rdata(smartconnect_1_M01_AXI_RDATA),
        .M01_AXI_rready(smartconnect_1_M01_AXI_RREADY),
        .M01_AXI_rresp(smartconnect_1_M01_AXI_RRESP),
        .M01_AXI_rvalid(smartconnect_1_M01_AXI_RVALID),
        .M01_AXI_wdata(smartconnect_1_M01_AXI_WDATA),
        .M01_AXI_wready(smartconnect_1_M01_AXI_WREADY),
        .M01_AXI_wstrb(smartconnect_1_M01_AXI_WSTRB),
        .M01_AXI_wvalid(smartconnect_1_M01_AXI_WVALID),
        .M02_AXI_araddr(smartconnect_1_M02_AXI_ARADDR),
        .M02_AXI_arready(smartconnect_1_M02_AXI_ARREADY),
        .M02_AXI_arvalid(smartconnect_1_M02_AXI_ARVALID),
        .M02_AXI_awaddr(smartconnect_1_M02_AXI_AWADDR),
        .M02_AXI_awready(smartconnect_1_M02_AXI_AWREADY),
        .M02_AXI_awvalid(smartconnect_1_M02_AXI_AWVALID),
        .M02_AXI_bready(smartconnect_1_M02_AXI_BREADY),
        .M02_AXI_bresp(smartconnect_1_M02_AXI_BRESP),
        .M02_AXI_bvalid(smartconnect_1_M02_AXI_BVALID),
        .M02_AXI_rdata(smartconnect_1_M02_AXI_RDATA),
        .M02_AXI_rready(smartconnect_1_M02_AXI_RREADY),
        .M02_AXI_rresp(smartconnect_1_M02_AXI_RRESP),
        .M02_AXI_rvalid(smartconnect_1_M02_AXI_RVALID),
        .M02_AXI_wdata(smartconnect_1_M02_AXI_WDATA),
        .M02_AXI_wready(smartconnect_1_M02_AXI_WREADY),
        .M02_AXI_wstrb(smartconnect_1_M02_AXI_WSTRB),
        .M02_AXI_wvalid(smartconnect_1_M02_AXI_WVALID),
        .M03_AXI_araddr(smartconnect_1_M03_AXI_ARADDR),
        .M03_AXI_arready(smartconnect_1_M03_AXI_ARREADY),
        .M03_AXI_arvalid(smartconnect_1_M03_AXI_ARVALID),
        .M03_AXI_awaddr(smartconnect_1_M03_AXI_AWADDR),
        .M03_AXI_awready(smartconnect_1_M03_AXI_AWREADY),
        .M03_AXI_awvalid(smartconnect_1_M03_AXI_AWVALID),
        .M03_AXI_bready(smartconnect_1_M03_AXI_BREADY),
        .M03_AXI_bresp(smartconnect_1_M03_AXI_BRESP),
        .M03_AXI_bvalid(smartconnect_1_M03_AXI_BVALID),
        .M03_AXI_rdata(smartconnect_1_M03_AXI_RDATA),
        .M03_AXI_rready(smartconnect_1_M03_AXI_RREADY),
        .M03_AXI_rresp(smartconnect_1_M03_AXI_RRESP),
        .M03_AXI_rvalid(smartconnect_1_M03_AXI_RVALID),
        .M03_AXI_wdata(smartconnect_1_M03_AXI_WDATA),
        .M03_AXI_wready(smartconnect_1_M03_AXI_WREADY),
        .M03_AXI_wstrb(smartconnect_1_M03_AXI_WSTRB),
        .M03_AXI_wvalid(smartconnect_1_M03_AXI_WVALID),
        .M04_AXI_araddr(smartconnect_1_M04_AXI_ARADDR),
        .M04_AXI_arprot(smartconnect_1_M04_AXI_ARPROT),
        .M04_AXI_arready(smartconnect_1_M04_AXI_ARREADY),
        .M04_AXI_arvalid(smartconnect_1_M04_AXI_ARVALID),
        .M04_AXI_awaddr(smartconnect_1_M04_AXI_AWADDR),
        .M04_AXI_awprot(smartconnect_1_M04_AXI_AWPROT),
        .M04_AXI_awready(smartconnect_1_M04_AXI_AWREADY),
        .M04_AXI_awvalid(smartconnect_1_M04_AXI_AWVALID),
        .M04_AXI_bready(smartconnect_1_M04_AXI_BREADY),
        .M04_AXI_bresp(smartconnect_1_M04_AXI_BRESP),
        .M04_AXI_bvalid(smartconnect_1_M04_AXI_BVALID),
        .M04_AXI_rdata(smartconnect_1_M04_AXI_RDATA),
        .M04_AXI_rready(smartconnect_1_M04_AXI_RREADY),
        .M04_AXI_rresp(smartconnect_1_M04_AXI_RRESP),
        .M04_AXI_rvalid(smartconnect_1_M04_AXI_RVALID),
        .M04_AXI_wdata(smartconnect_1_M04_AXI_WDATA),
        .M04_AXI_wready(smartconnect_1_M04_AXI_WREADY),
        .M04_AXI_wstrb(smartconnect_1_M04_AXI_WSTRB),
        .M04_AXI_wvalid(smartconnect_1_M04_AXI_WVALID),
        .M05_AXI_araddr(smartconnect_1_M05_AXI_ARADDR),
        .M05_AXI_arready(smartconnect_1_M05_AXI_ARREADY),
        .M05_AXI_arvalid(smartconnect_1_M05_AXI_ARVALID),
        .M05_AXI_awaddr(smartconnect_1_M05_AXI_AWADDR),
        .M05_AXI_awready(smartconnect_1_M05_AXI_AWREADY),
        .M05_AXI_awvalid(smartconnect_1_M05_AXI_AWVALID),
        .M05_AXI_bready(smartconnect_1_M05_AXI_BREADY),
        .M05_AXI_bresp(smartconnect_1_M05_AXI_BRESP),
        .M05_AXI_bvalid(smartconnect_1_M05_AXI_BVALID),
        .M05_AXI_rdata(smartconnect_1_M05_AXI_RDATA),
        .M05_AXI_rready(smartconnect_1_M05_AXI_RREADY),
        .M05_AXI_rresp(smartconnect_1_M05_AXI_RRESP),
        .M05_AXI_rvalid(smartconnect_1_M05_AXI_RVALID),
        .M05_AXI_wdata(smartconnect_1_M05_AXI_WDATA),
        .M05_AXI_wready(smartconnect_1_M05_AXI_WREADY),
        .M05_AXI_wstrb(smartconnect_1_M05_AXI_WSTRB),
        .M05_AXI_wvalid(smartconnect_1_M05_AXI_WVALID),
        .S00_AXI_araddr(S00_AXI_araddr),
        .S00_AXI_arburst(S00_AXI_arburst),
        .S00_AXI_arcache(S00_AXI_arcache),
        .S00_AXI_arid(S00_AXI_arid),
        .S00_AXI_arlen(S00_AXI_arlen),
        .S00_AXI_arlock(S00_AXI_arlock),
        .S00_AXI_arprot(S00_AXI_arprot),
        .S00_AXI_arqos(S00_AXI_arqos),
        .S00_AXI_arready(S00_AXI_arready),
        .S00_AXI_arsize(S00_AXI_arsize),
        .S00_AXI_aruser(S00_AXI_aruser),
        .S00_AXI_arvalid(S00_AXI_arvalid),
        .S00_AXI_awaddr(S00_AXI_awaddr),
        .S00_AXI_awburst(S00_AXI_awburst),
        .S00_AXI_awcache(S00_AXI_awcache),
        .S00_AXI_awid(S00_AXI_awid),
        .S00_AXI_awlen(S00_AXI_awlen),
        .S00_AXI_awlock(S00_AXI_awlock),
        .S00_AXI_awprot(S00_AXI_awprot),
        .S00_AXI_awqos(S00_AXI_awqos),
        .S00_AXI_awready(S00_AXI_awready),
        .S00_AXI_awsize(S00_AXI_awsize),
        .S00_AXI_awuser(S00_AXI_awuser),
        .S00_AXI_awvalid(S00_AXI_awvalid),
        .S00_AXI_bid(S00_AXI_bid),
        .S00_AXI_bready(S00_AXI_bready),
        .S00_AXI_bresp(S00_AXI_bresp),
        .S00_AXI_bvalid(S00_AXI_bvalid),
        .S00_AXI_rdata(S00_AXI_rdata),
        .S00_AXI_rid(S00_AXI_rid),
        .S00_AXI_rlast(S00_AXI_rlast),
        .S00_AXI_rready(S00_AXI_rready),
        .S00_AXI_rresp(S00_AXI_rresp),
        .S00_AXI_ruser(S00_AXI_ruser),
        .S00_AXI_rvalid(S00_AXI_rvalid),
        .S00_AXI_wdata(S00_AXI_wdata),
        .S00_AXI_wlast(S00_AXI_wlast),
        .S00_AXI_wready(S00_AXI_wready),
        .S00_AXI_wstrb(S00_AXI_wstrb),
        .S00_AXI_wuser(S00_AXI_wuser),
        .S00_AXI_wvalid(S00_AXI_wvalid),
        .aclk(axi_clk),
        .aresetn(axi_resetn));
  design_1_util_ds_buf_0_0 util_ds_buf_0
       (.IOBUF_IO_I(i2c_master_axil_0_i2c_sda_o),
        .IOBUF_IO_IO(IOBUF_sda),
        .IOBUF_IO_O(util_ds_buf_0_IOBUF_IO_O),
        .IOBUF_IO_T(i2c_master_axil_0_i2c_sda_t));
  design_1_util_ds_buf_0_1 util_ds_buf_1
       (.IOBUF_IO_I(i2c_master_axil_0_i2c_scl_o),
        .IOBUF_IO_IO(IOBUF_scl),
        .IOBUF_IO_O(util_ds_buf_1_IOBUF_IO_O),
        .IOBUF_IO_T(i2c_master_axil_0_i2c_scl_t));
  design_1_xlconcat_0_0 xlconcat_0
       (.In0(axi_uart_bootloader_1_uart_irq),
        .In1(cdma_irq),
        .In2(axi_gpio_0_ip2intc_irpt),
        .In3(axi_quad_spi_0_ip2intc_irpt),
        .In4(npu_int),
        .In5(1'b0),
        .In6(1'b0),
        .In7(1'b0),
        .dout(xlconcat_0_dout));
endmodule
