// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Mon Nov 16 09:45:32 2026
// Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
// Command     : write_verilog -force -mode funcsim
//               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_axil_timer_64_0_0/design_1_axil_timer_64_0_0_sim_netlist.v
// Design      : design_1_axil_timer_64_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axil_timer_64_0_0,axil_timer_64,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axil_timer_64,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_axil_timer_64_0_0
   (S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    IRQ);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input S_AXI_ACLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input S_AXI_ARESETN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [3:0]S_AXI_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input S_AXI_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output S_AXI_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]S_AXI_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]S_AXI_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input S_AXI_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output S_AXI_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]S_AXI_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output S_AXI_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input S_AXI_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [3:0]S_AXI_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input S_AXI_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output S_AXI_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]S_AXI_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]S_AXI_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output S_AXI_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input S_AXI_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME IRQ, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output IRQ;

  wire \<const0> ;
  wire IRQ;
  wire S_AXI_ACLK;
  wire [3:0]S_AXI_ARADDR;
  wire S_AXI_ARESETN;
  wire S_AXI_ARREADY;
  wire S_AXI_ARVALID;
  wire [3:0]S_AXI_AWADDR;
  wire S_AXI_AWREADY;
  wire S_AXI_AWVALID;
  wire S_AXI_BREADY;
  wire S_AXI_BVALID;
  wire [31:0]S_AXI_RDATA;
  wire S_AXI_RREADY;
  wire S_AXI_RVALID;
  wire [31:0]S_AXI_WDATA;
  wire S_AXI_WREADY;
  wire S_AXI_WVALID;

  assign S_AXI_BRESP[1] = \<const0> ;
  assign S_AXI_BRESP[0] = \<const0> ;
  assign S_AXI_RRESP[1] = \<const0> ;
  assign S_AXI_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  design_1_axil_timer_64_0_0_axil_timer_64 inst
       (.IRQ(IRQ),
        .S_AXI_ACLK(S_AXI_ACLK),
        .S_AXI_ARADDR(S_AXI_ARADDR[3:2]),
        .S_AXI_ARESETN(S_AXI_ARESETN),
        .S_AXI_ARREADY(S_AXI_ARREADY),
        .S_AXI_ARVALID(S_AXI_ARVALID),
        .S_AXI_AWADDR(S_AXI_AWADDR[3:2]),
        .S_AXI_AWREADY(S_AXI_AWREADY),
        .S_AXI_AWVALID(S_AXI_AWVALID),
        .S_AXI_BREADY(S_AXI_BREADY),
        .S_AXI_BVALID(S_AXI_BVALID),
        .S_AXI_RDATA(S_AXI_RDATA),
        .S_AXI_RREADY(S_AXI_RREADY),
        .S_AXI_WDATA(S_AXI_WDATA),
        .S_AXI_WREADY(S_AXI_WREADY),
        .S_AXI_WVALID(S_AXI_WVALID),
        .rvalid_int_reg_0(S_AXI_RVALID));
endmodule

(* ORIG_REF_NAME = "axil_timer_64" *) 
module design_1_axil_timer_64_0_0_axil_timer_64
   (S_AXI_AWREADY,
    S_AXI_WREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    rvalid_int_reg_0,
    IRQ,
    S_AXI_BVALID,
    S_AXI_ACLK,
    S_AXI_WDATA,
    S_AXI_AWADDR,
    S_AXI_WVALID,
    S_AXI_AWVALID,
    S_AXI_ARVALID,
    S_AXI_ARADDR,
    S_AXI_ARESETN,
    S_AXI_BREADY,
    S_AXI_RREADY);
  output S_AXI_AWREADY;
  output S_AXI_WREADY;
  output S_AXI_ARREADY;
  output [31:0]S_AXI_RDATA;
  output rvalid_int_reg_0;
  output IRQ;
  output S_AXI_BVALID;
  input S_AXI_ACLK;
  input [31:0]S_AXI_WDATA;
  input [1:0]S_AXI_AWADDR;
  input S_AXI_WVALID;
  input S_AXI_AWVALID;
  input S_AXI_ARVALID;
  input [1:0]S_AXI_ARADDR;
  input S_AXI_ARESETN;
  input S_AXI_BREADY;
  input S_AXI_RREADY;

  wire IRQ;
  wire IRQ0_carry__0_n_0;
  wire IRQ0_carry__0_n_1;
  wire IRQ0_carry__0_n_2;
  wire IRQ0_carry__0_n_3;
  wire IRQ0_carry__1_n_0;
  wire IRQ0_carry__1_n_1;
  wire IRQ0_carry__1_n_2;
  wire IRQ0_carry__1_n_3;
  wire IRQ0_carry__2_n_0;
  wire IRQ0_carry__2_n_1;
  wire IRQ0_carry__2_n_2;
  wire IRQ0_carry__2_n_3;
  wire IRQ0_carry__3_n_0;
  wire IRQ0_carry__3_n_1;
  wire IRQ0_carry__3_n_2;
  wire IRQ0_carry__3_n_3;
  wire IRQ0_carry__4_n_0;
  wire IRQ0_carry__4_n_1;
  wire IRQ0_carry__4_n_2;
  wire IRQ0_carry__4_n_3;
  wire IRQ0_carry__5_n_0;
  wire IRQ0_carry__5_n_1;
  wire IRQ0_carry__5_n_2;
  wire IRQ0_carry__5_n_3;
  wire IRQ0_carry__6_n_1;
  wire IRQ0_carry__6_n_2;
  wire IRQ0_carry__6_n_3;
  wire IRQ0_carry_i_1__0_n_0;
  wire IRQ0_carry_i_1__1_n_0;
  wire IRQ0_carry_i_1__2_n_0;
  wire IRQ0_carry_i_1__3_n_0;
  wire IRQ0_carry_i_1__4_n_0;
  wire IRQ0_carry_i_1__5_n_0;
  wire IRQ0_carry_i_1__6_n_0;
  wire IRQ0_carry_i_1_n_0;
  wire IRQ0_carry_i_2__0_n_0;
  wire IRQ0_carry_i_2__1_n_0;
  wire IRQ0_carry_i_2__2_n_0;
  wire IRQ0_carry_i_2__3_n_0;
  wire IRQ0_carry_i_2__4_n_0;
  wire IRQ0_carry_i_2__5_n_0;
  wire IRQ0_carry_i_2__6_n_0;
  wire IRQ0_carry_i_2_n_0;
  wire IRQ0_carry_i_3__0_n_0;
  wire IRQ0_carry_i_3__1_n_0;
  wire IRQ0_carry_i_3__2_n_0;
  wire IRQ0_carry_i_3__3_n_0;
  wire IRQ0_carry_i_3__4_n_0;
  wire IRQ0_carry_i_3__5_n_0;
  wire IRQ0_carry_i_3__6_n_0;
  wire IRQ0_carry_i_3_n_0;
  wire IRQ0_carry_i_4__0_n_0;
  wire IRQ0_carry_i_4__1_n_0;
  wire IRQ0_carry_i_4__2_n_0;
  wire IRQ0_carry_i_4__3_n_0;
  wire IRQ0_carry_i_4__4_n_0;
  wire IRQ0_carry_i_4__5_n_0;
  wire IRQ0_carry_i_4__6_n_0;
  wire IRQ0_carry_i_4_n_0;
  wire IRQ0_carry_i_5__0_n_0;
  wire IRQ0_carry_i_5__1_n_0;
  wire IRQ0_carry_i_5__2_n_0;
  wire IRQ0_carry_i_5__3_n_0;
  wire IRQ0_carry_i_5__4_n_0;
  wire IRQ0_carry_i_5__5_n_0;
  wire IRQ0_carry_i_5__6_n_0;
  wire IRQ0_carry_i_5_n_0;
  wire IRQ0_carry_i_6__0_n_0;
  wire IRQ0_carry_i_6__1_n_0;
  wire IRQ0_carry_i_6__2_n_0;
  wire IRQ0_carry_i_6__3_n_0;
  wire IRQ0_carry_i_6__4_n_0;
  wire IRQ0_carry_i_6__5_n_0;
  wire IRQ0_carry_i_6__6_n_0;
  wire IRQ0_carry_i_6_n_0;
  wire IRQ0_carry_i_7__0_n_0;
  wire IRQ0_carry_i_7__1_n_0;
  wire IRQ0_carry_i_7__2_n_0;
  wire IRQ0_carry_i_7__3_n_0;
  wire IRQ0_carry_i_7__4_n_0;
  wire IRQ0_carry_i_7__5_n_0;
  wire IRQ0_carry_i_7__6_n_0;
  wire IRQ0_carry_i_7_n_0;
  wire IRQ0_carry_i_8__0_n_0;
  wire IRQ0_carry_i_8__1_n_0;
  wire IRQ0_carry_i_8__2_n_0;
  wire IRQ0_carry_i_8__3_n_0;
  wire IRQ0_carry_i_8__4_n_0;
  wire IRQ0_carry_i_8__5_n_0;
  wire IRQ0_carry_i_8__6_n_0;
  wire IRQ0_carry_i_8_n_0;
  wire IRQ0_carry_n_0;
  wire IRQ0_carry_n_1;
  wire IRQ0_carry_n_2;
  wire IRQ0_carry_n_3;
  wire S_AXI_ACLK;
  wire [1:0]S_AXI_ARADDR;
  wire S_AXI_ARESETN;
  wire S_AXI_ARREADY;
  wire S_AXI_ARVALID;
  wire [1:0]S_AXI_AWADDR;
  wire S_AXI_AWREADY;
  wire S_AXI_AWVALID;
  wire S_AXI_BREADY;
  wire S_AXI_BVALID;
  wire [31:0]S_AXI_RDATA;
  wire S_AXI_RREADY;
  wire [31:0]S_AXI_WDATA;
  wire S_AXI_WREADY;
  wire S_AXI_WVALID;
  wire arready_int0;
  wire awready_int0;
  wire bvalid_int_i_1_n_0;
  wire clear;
  wire \clock_reg[0]_i_2_n_0 ;
  wire \clock_reg_reg[0]_i_1_n_0 ;
  wire \clock_reg_reg[0]_i_1_n_1 ;
  wire \clock_reg_reg[0]_i_1_n_2 ;
  wire \clock_reg_reg[0]_i_1_n_3 ;
  wire \clock_reg_reg[0]_i_1_n_4 ;
  wire \clock_reg_reg[0]_i_1_n_5 ;
  wire \clock_reg_reg[0]_i_1_n_6 ;
  wire \clock_reg_reg[0]_i_1_n_7 ;
  wire \clock_reg_reg[12]_i_1_n_0 ;
  wire \clock_reg_reg[12]_i_1_n_1 ;
  wire \clock_reg_reg[12]_i_1_n_2 ;
  wire \clock_reg_reg[12]_i_1_n_3 ;
  wire \clock_reg_reg[12]_i_1_n_4 ;
  wire \clock_reg_reg[12]_i_1_n_5 ;
  wire \clock_reg_reg[12]_i_1_n_6 ;
  wire \clock_reg_reg[12]_i_1_n_7 ;
  wire \clock_reg_reg[16]_i_1_n_0 ;
  wire \clock_reg_reg[16]_i_1_n_1 ;
  wire \clock_reg_reg[16]_i_1_n_2 ;
  wire \clock_reg_reg[16]_i_1_n_3 ;
  wire \clock_reg_reg[16]_i_1_n_4 ;
  wire \clock_reg_reg[16]_i_1_n_5 ;
  wire \clock_reg_reg[16]_i_1_n_6 ;
  wire \clock_reg_reg[16]_i_1_n_7 ;
  wire \clock_reg_reg[20]_i_1_n_0 ;
  wire \clock_reg_reg[20]_i_1_n_1 ;
  wire \clock_reg_reg[20]_i_1_n_2 ;
  wire \clock_reg_reg[20]_i_1_n_3 ;
  wire \clock_reg_reg[20]_i_1_n_4 ;
  wire \clock_reg_reg[20]_i_1_n_5 ;
  wire \clock_reg_reg[20]_i_1_n_6 ;
  wire \clock_reg_reg[20]_i_1_n_7 ;
  wire \clock_reg_reg[24]_i_1_n_0 ;
  wire \clock_reg_reg[24]_i_1_n_1 ;
  wire \clock_reg_reg[24]_i_1_n_2 ;
  wire \clock_reg_reg[24]_i_1_n_3 ;
  wire \clock_reg_reg[24]_i_1_n_4 ;
  wire \clock_reg_reg[24]_i_1_n_5 ;
  wire \clock_reg_reg[24]_i_1_n_6 ;
  wire \clock_reg_reg[24]_i_1_n_7 ;
  wire \clock_reg_reg[28]_i_1_n_0 ;
  wire \clock_reg_reg[28]_i_1_n_1 ;
  wire \clock_reg_reg[28]_i_1_n_2 ;
  wire \clock_reg_reg[28]_i_1_n_3 ;
  wire \clock_reg_reg[28]_i_1_n_4 ;
  wire \clock_reg_reg[28]_i_1_n_5 ;
  wire \clock_reg_reg[28]_i_1_n_6 ;
  wire \clock_reg_reg[28]_i_1_n_7 ;
  wire \clock_reg_reg[32]_i_1_n_0 ;
  wire \clock_reg_reg[32]_i_1_n_1 ;
  wire \clock_reg_reg[32]_i_1_n_2 ;
  wire \clock_reg_reg[32]_i_1_n_3 ;
  wire \clock_reg_reg[32]_i_1_n_4 ;
  wire \clock_reg_reg[32]_i_1_n_5 ;
  wire \clock_reg_reg[32]_i_1_n_6 ;
  wire \clock_reg_reg[32]_i_1_n_7 ;
  wire \clock_reg_reg[36]_i_1_n_0 ;
  wire \clock_reg_reg[36]_i_1_n_1 ;
  wire \clock_reg_reg[36]_i_1_n_2 ;
  wire \clock_reg_reg[36]_i_1_n_3 ;
  wire \clock_reg_reg[36]_i_1_n_4 ;
  wire \clock_reg_reg[36]_i_1_n_5 ;
  wire \clock_reg_reg[36]_i_1_n_6 ;
  wire \clock_reg_reg[36]_i_1_n_7 ;
  wire \clock_reg_reg[40]_i_1_n_0 ;
  wire \clock_reg_reg[40]_i_1_n_1 ;
  wire \clock_reg_reg[40]_i_1_n_2 ;
  wire \clock_reg_reg[40]_i_1_n_3 ;
  wire \clock_reg_reg[40]_i_1_n_4 ;
  wire \clock_reg_reg[40]_i_1_n_5 ;
  wire \clock_reg_reg[40]_i_1_n_6 ;
  wire \clock_reg_reg[40]_i_1_n_7 ;
  wire \clock_reg_reg[44]_i_1_n_0 ;
  wire \clock_reg_reg[44]_i_1_n_1 ;
  wire \clock_reg_reg[44]_i_1_n_2 ;
  wire \clock_reg_reg[44]_i_1_n_3 ;
  wire \clock_reg_reg[44]_i_1_n_4 ;
  wire \clock_reg_reg[44]_i_1_n_5 ;
  wire \clock_reg_reg[44]_i_1_n_6 ;
  wire \clock_reg_reg[44]_i_1_n_7 ;
  wire \clock_reg_reg[48]_i_1_n_0 ;
  wire \clock_reg_reg[48]_i_1_n_1 ;
  wire \clock_reg_reg[48]_i_1_n_2 ;
  wire \clock_reg_reg[48]_i_1_n_3 ;
  wire \clock_reg_reg[48]_i_1_n_4 ;
  wire \clock_reg_reg[48]_i_1_n_5 ;
  wire \clock_reg_reg[48]_i_1_n_6 ;
  wire \clock_reg_reg[48]_i_1_n_7 ;
  wire \clock_reg_reg[4]_i_1_n_0 ;
  wire \clock_reg_reg[4]_i_1_n_1 ;
  wire \clock_reg_reg[4]_i_1_n_2 ;
  wire \clock_reg_reg[4]_i_1_n_3 ;
  wire \clock_reg_reg[4]_i_1_n_4 ;
  wire \clock_reg_reg[4]_i_1_n_5 ;
  wire \clock_reg_reg[4]_i_1_n_6 ;
  wire \clock_reg_reg[4]_i_1_n_7 ;
  wire \clock_reg_reg[52]_i_1_n_0 ;
  wire \clock_reg_reg[52]_i_1_n_1 ;
  wire \clock_reg_reg[52]_i_1_n_2 ;
  wire \clock_reg_reg[52]_i_1_n_3 ;
  wire \clock_reg_reg[52]_i_1_n_4 ;
  wire \clock_reg_reg[52]_i_1_n_5 ;
  wire \clock_reg_reg[52]_i_1_n_6 ;
  wire \clock_reg_reg[52]_i_1_n_7 ;
  wire \clock_reg_reg[56]_i_1_n_0 ;
  wire \clock_reg_reg[56]_i_1_n_1 ;
  wire \clock_reg_reg[56]_i_1_n_2 ;
  wire \clock_reg_reg[56]_i_1_n_3 ;
  wire \clock_reg_reg[56]_i_1_n_4 ;
  wire \clock_reg_reg[56]_i_1_n_5 ;
  wire \clock_reg_reg[56]_i_1_n_6 ;
  wire \clock_reg_reg[56]_i_1_n_7 ;
  wire \clock_reg_reg[60]_i_1_n_1 ;
  wire \clock_reg_reg[60]_i_1_n_2 ;
  wire \clock_reg_reg[60]_i_1_n_3 ;
  wire \clock_reg_reg[60]_i_1_n_4 ;
  wire \clock_reg_reg[60]_i_1_n_5 ;
  wire \clock_reg_reg[60]_i_1_n_6 ;
  wire \clock_reg_reg[60]_i_1_n_7 ;
  wire \clock_reg_reg[8]_i_1_n_0 ;
  wire \clock_reg_reg[8]_i_1_n_1 ;
  wire \clock_reg_reg[8]_i_1_n_2 ;
  wire \clock_reg_reg[8]_i_1_n_3 ;
  wire \clock_reg_reg[8]_i_1_n_4 ;
  wire \clock_reg_reg[8]_i_1_n_5 ;
  wire \clock_reg_reg[8]_i_1_n_6 ;
  wire \clock_reg_reg[8]_i_1_n_7 ;
  wire \clock_reg_reg_n_0_[0] ;
  wire \clock_reg_reg_n_0_[10] ;
  wire \clock_reg_reg_n_0_[11] ;
  wire \clock_reg_reg_n_0_[12] ;
  wire \clock_reg_reg_n_0_[13] ;
  wire \clock_reg_reg_n_0_[14] ;
  wire \clock_reg_reg_n_0_[15] ;
  wire \clock_reg_reg_n_0_[16] ;
  wire \clock_reg_reg_n_0_[17] ;
  wire \clock_reg_reg_n_0_[18] ;
  wire \clock_reg_reg_n_0_[19] ;
  wire \clock_reg_reg_n_0_[1] ;
  wire \clock_reg_reg_n_0_[20] ;
  wire \clock_reg_reg_n_0_[21] ;
  wire \clock_reg_reg_n_0_[22] ;
  wire \clock_reg_reg_n_0_[23] ;
  wire \clock_reg_reg_n_0_[24] ;
  wire \clock_reg_reg_n_0_[25] ;
  wire \clock_reg_reg_n_0_[26] ;
  wire \clock_reg_reg_n_0_[27] ;
  wire \clock_reg_reg_n_0_[28] ;
  wire \clock_reg_reg_n_0_[29] ;
  wire \clock_reg_reg_n_0_[2] ;
  wire \clock_reg_reg_n_0_[30] ;
  wire \clock_reg_reg_n_0_[31] ;
  wire \clock_reg_reg_n_0_[3] ;
  wire \clock_reg_reg_n_0_[4] ;
  wire \clock_reg_reg_n_0_[5] ;
  wire \clock_reg_reg_n_0_[6] ;
  wire \clock_reg_reg_n_0_[7] ;
  wire \clock_reg_reg_n_0_[8] ;
  wire \clock_reg_reg_n_0_[9] ;
  wire [31:0]clock_snap_reg;
  wire [0:0]clock_snap_reg_0;
  wire [63:31]compare_reg;
  wire \compare_reg_reg_n_0_[0] ;
  wire \compare_reg_reg_n_0_[10] ;
  wire \compare_reg_reg_n_0_[11] ;
  wire \compare_reg_reg_n_0_[12] ;
  wire \compare_reg_reg_n_0_[13] ;
  wire \compare_reg_reg_n_0_[14] ;
  wire \compare_reg_reg_n_0_[15] ;
  wire \compare_reg_reg_n_0_[16] ;
  wire \compare_reg_reg_n_0_[17] ;
  wire \compare_reg_reg_n_0_[18] ;
  wire \compare_reg_reg_n_0_[19] ;
  wire \compare_reg_reg_n_0_[1] ;
  wire \compare_reg_reg_n_0_[20] ;
  wire \compare_reg_reg_n_0_[21] ;
  wire \compare_reg_reg_n_0_[22] ;
  wire \compare_reg_reg_n_0_[23] ;
  wire \compare_reg_reg_n_0_[24] ;
  wire \compare_reg_reg_n_0_[25] ;
  wire \compare_reg_reg_n_0_[26] ;
  wire \compare_reg_reg_n_0_[27] ;
  wire \compare_reg_reg_n_0_[28] ;
  wire \compare_reg_reg_n_0_[29] ;
  wire \compare_reg_reg_n_0_[2] ;
  wire \compare_reg_reg_n_0_[30] ;
  wire \compare_reg_reg_n_0_[31] ;
  wire \compare_reg_reg_n_0_[32] ;
  wire \compare_reg_reg_n_0_[33] ;
  wire \compare_reg_reg_n_0_[34] ;
  wire \compare_reg_reg_n_0_[35] ;
  wire \compare_reg_reg_n_0_[36] ;
  wire \compare_reg_reg_n_0_[37] ;
  wire \compare_reg_reg_n_0_[38] ;
  wire \compare_reg_reg_n_0_[39] ;
  wire \compare_reg_reg_n_0_[3] ;
  wire \compare_reg_reg_n_0_[40] ;
  wire \compare_reg_reg_n_0_[41] ;
  wire \compare_reg_reg_n_0_[42] ;
  wire \compare_reg_reg_n_0_[43] ;
  wire \compare_reg_reg_n_0_[44] ;
  wire \compare_reg_reg_n_0_[45] ;
  wire \compare_reg_reg_n_0_[46] ;
  wire \compare_reg_reg_n_0_[47] ;
  wire \compare_reg_reg_n_0_[48] ;
  wire \compare_reg_reg_n_0_[49] ;
  wire \compare_reg_reg_n_0_[4] ;
  wire \compare_reg_reg_n_0_[50] ;
  wire \compare_reg_reg_n_0_[51] ;
  wire \compare_reg_reg_n_0_[52] ;
  wire \compare_reg_reg_n_0_[53] ;
  wire \compare_reg_reg_n_0_[54] ;
  wire \compare_reg_reg_n_0_[55] ;
  wire \compare_reg_reg_n_0_[56] ;
  wire \compare_reg_reg_n_0_[57] ;
  wire \compare_reg_reg_n_0_[58] ;
  wire \compare_reg_reg_n_0_[59] ;
  wire \compare_reg_reg_n_0_[5] ;
  wire \compare_reg_reg_n_0_[60] ;
  wire \compare_reg_reg_n_0_[61] ;
  wire \compare_reg_reg_n_0_[62] ;
  wire \compare_reg_reg_n_0_[63] ;
  wire \compare_reg_reg_n_0_[6] ;
  wire \compare_reg_reg_n_0_[7] ;
  wire \compare_reg_reg_n_0_[8] ;
  wire \compare_reg_reg_n_0_[9] ;
  wire [31:0]p_1_in;
  wire \rdata_int[0]_i_1_n_0 ;
  wire \rdata_int[10]_i_1_n_0 ;
  wire \rdata_int[11]_i_1_n_0 ;
  wire \rdata_int[12]_i_1_n_0 ;
  wire \rdata_int[13]_i_1_n_0 ;
  wire \rdata_int[14]_i_1_n_0 ;
  wire \rdata_int[15]_i_1_n_0 ;
  wire \rdata_int[16]_i_1_n_0 ;
  wire \rdata_int[17]_i_1_n_0 ;
  wire \rdata_int[18]_i_1_n_0 ;
  wire \rdata_int[19]_i_1_n_0 ;
  wire \rdata_int[1]_i_1_n_0 ;
  wire \rdata_int[20]_i_1_n_0 ;
  wire \rdata_int[21]_i_1_n_0 ;
  wire \rdata_int[22]_i_1_n_0 ;
  wire \rdata_int[23]_i_1_n_0 ;
  wire \rdata_int[24]_i_1_n_0 ;
  wire \rdata_int[25]_i_1_n_0 ;
  wire \rdata_int[26]_i_1_n_0 ;
  wire \rdata_int[27]_i_1_n_0 ;
  wire \rdata_int[28]_i_1_n_0 ;
  wire \rdata_int[29]_i_1_n_0 ;
  wire \rdata_int[2]_i_1_n_0 ;
  wire \rdata_int[30]_i_1_n_0 ;
  wire \rdata_int[31]_i_1_n_0 ;
  wire \rdata_int[3]_i_1_n_0 ;
  wire \rdata_int[4]_i_1_n_0 ;
  wire \rdata_int[5]_i_1_n_0 ;
  wire \rdata_int[6]_i_1_n_0 ;
  wire \rdata_int[7]_i_1_n_0 ;
  wire \rdata_int[8]_i_1_n_0 ;
  wire \rdata_int[9]_i_1_n_0 ;
  wire rvalid_int00_out__0;
  wire rvalid_int_i_1_n_0;
  wire rvalid_int_reg_0;
  wire wready_int0;
  wire [3:0]NLW_IRQ0_carry_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__2_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__3_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__4_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__5_O_UNCONNECTED;
  wire [3:0]NLW_IRQ0_carry__6_O_UNCONNECTED;
  wire [3:3]\NLW_clock_reg_reg[60]_i_1_CO_UNCONNECTED ;

  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry
       (.CI(1'b0),
        .CO({IRQ0_carry_n_0,IRQ0_carry_n_1,IRQ0_carry_n_2,IRQ0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1_n_0,IRQ0_carry_i_2_n_0,IRQ0_carry_i_3_n_0,IRQ0_carry_i_4_n_0}),
        .O(NLW_IRQ0_carry_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5_n_0,IRQ0_carry_i_6_n_0,IRQ0_carry_i_7_n_0,IRQ0_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__0
       (.CI(IRQ0_carry_n_0),
        .CO({IRQ0_carry__0_n_0,IRQ0_carry__0_n_1,IRQ0_carry__0_n_2,IRQ0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__0_n_0,IRQ0_carry_i_2__0_n_0,IRQ0_carry_i_3__0_n_0,IRQ0_carry_i_4__0_n_0}),
        .O(NLW_IRQ0_carry__0_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__0_n_0,IRQ0_carry_i_6__0_n_0,IRQ0_carry_i_7__0_n_0,IRQ0_carry_i_8__0_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__1
       (.CI(IRQ0_carry__0_n_0),
        .CO({IRQ0_carry__1_n_0,IRQ0_carry__1_n_1,IRQ0_carry__1_n_2,IRQ0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__1_n_0,IRQ0_carry_i_2__1_n_0,IRQ0_carry_i_3__1_n_0,IRQ0_carry_i_4__1_n_0}),
        .O(NLW_IRQ0_carry__1_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__1_n_0,IRQ0_carry_i_6__1_n_0,IRQ0_carry_i_7__1_n_0,IRQ0_carry_i_8__1_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__2
       (.CI(IRQ0_carry__1_n_0),
        .CO({IRQ0_carry__2_n_0,IRQ0_carry__2_n_1,IRQ0_carry__2_n_2,IRQ0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__2_n_0,IRQ0_carry_i_2__2_n_0,IRQ0_carry_i_3__2_n_0,IRQ0_carry_i_4__2_n_0}),
        .O(NLW_IRQ0_carry__2_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__2_n_0,IRQ0_carry_i_6__2_n_0,IRQ0_carry_i_7__2_n_0,IRQ0_carry_i_8__2_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__3
       (.CI(IRQ0_carry__2_n_0),
        .CO({IRQ0_carry__3_n_0,IRQ0_carry__3_n_1,IRQ0_carry__3_n_2,IRQ0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__3_n_0,IRQ0_carry_i_2__3_n_0,IRQ0_carry_i_3__3_n_0,IRQ0_carry_i_4__3_n_0}),
        .O(NLW_IRQ0_carry__3_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__3_n_0,IRQ0_carry_i_6__3_n_0,IRQ0_carry_i_7__3_n_0,IRQ0_carry_i_8__3_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__4
       (.CI(IRQ0_carry__3_n_0),
        .CO({IRQ0_carry__4_n_0,IRQ0_carry__4_n_1,IRQ0_carry__4_n_2,IRQ0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__4_n_0,IRQ0_carry_i_2__4_n_0,IRQ0_carry_i_3__4_n_0,IRQ0_carry_i_4__4_n_0}),
        .O(NLW_IRQ0_carry__4_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__4_n_0,IRQ0_carry_i_6__4_n_0,IRQ0_carry_i_7__4_n_0,IRQ0_carry_i_8__4_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__5
       (.CI(IRQ0_carry__4_n_0),
        .CO({IRQ0_carry__5_n_0,IRQ0_carry__5_n_1,IRQ0_carry__5_n_2,IRQ0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__5_n_0,IRQ0_carry_i_2__5_n_0,IRQ0_carry_i_3__5_n_0,IRQ0_carry_i_4__5_n_0}),
        .O(NLW_IRQ0_carry__5_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__5_n_0,IRQ0_carry_i_6__5_n_0,IRQ0_carry_i_7__5_n_0,IRQ0_carry_i_8__5_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 IRQ0_carry__6
       (.CI(IRQ0_carry__5_n_0),
        .CO({IRQ,IRQ0_carry__6_n_1,IRQ0_carry__6_n_2,IRQ0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({IRQ0_carry_i_1__6_n_0,IRQ0_carry_i_2__6_n_0,IRQ0_carry_i_3__6_n_0,IRQ0_carry_i_4__6_n_0}),
        .O(NLW_IRQ0_carry__6_O_UNCONNECTED[3:0]),
        .S({IRQ0_carry_i_5__6_n_0,IRQ0_carry_i_6__6_n_0,IRQ0_carry_i_7__6_n_0,IRQ0_carry_i_8__6_n_0}));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1
       (.I0(\clock_reg_reg_n_0_[6] ),
        .I1(\compare_reg_reg_n_0_[6] ),
        .I2(\compare_reg_reg_n_0_[7] ),
        .I3(\clock_reg_reg_n_0_[7] ),
        .O(IRQ0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__0
       (.I0(\clock_reg_reg_n_0_[14] ),
        .I1(\compare_reg_reg_n_0_[14] ),
        .I2(\compare_reg_reg_n_0_[15] ),
        .I3(\clock_reg_reg_n_0_[15] ),
        .O(IRQ0_carry_i_1__0_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__1
       (.I0(\clock_reg_reg_n_0_[22] ),
        .I1(\compare_reg_reg_n_0_[22] ),
        .I2(\compare_reg_reg_n_0_[23] ),
        .I3(\clock_reg_reg_n_0_[23] ),
        .O(IRQ0_carry_i_1__1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__2
       (.I0(\clock_reg_reg_n_0_[30] ),
        .I1(\compare_reg_reg_n_0_[30] ),
        .I2(\compare_reg_reg_n_0_[31] ),
        .I3(\clock_reg_reg_n_0_[31] ),
        .O(IRQ0_carry_i_1__2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__3
       (.I0(p_1_in[6]),
        .I1(\compare_reg_reg_n_0_[38] ),
        .I2(\compare_reg_reg_n_0_[39] ),
        .I3(p_1_in[7]),
        .O(IRQ0_carry_i_1__3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__4
       (.I0(p_1_in[14]),
        .I1(\compare_reg_reg_n_0_[46] ),
        .I2(\compare_reg_reg_n_0_[47] ),
        .I3(p_1_in[15]),
        .O(IRQ0_carry_i_1__4_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__5
       (.I0(p_1_in[22]),
        .I1(\compare_reg_reg_n_0_[54] ),
        .I2(\compare_reg_reg_n_0_[55] ),
        .I3(p_1_in[23]),
        .O(IRQ0_carry_i_1__5_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_1__6
       (.I0(p_1_in[30]),
        .I1(\compare_reg_reg_n_0_[62] ),
        .I2(\compare_reg_reg_n_0_[63] ),
        .I3(p_1_in[31]),
        .O(IRQ0_carry_i_1__6_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2
       (.I0(\clock_reg_reg_n_0_[4] ),
        .I1(\compare_reg_reg_n_0_[4] ),
        .I2(\compare_reg_reg_n_0_[5] ),
        .I3(\clock_reg_reg_n_0_[5] ),
        .O(IRQ0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__0
       (.I0(\clock_reg_reg_n_0_[12] ),
        .I1(\compare_reg_reg_n_0_[12] ),
        .I2(\compare_reg_reg_n_0_[13] ),
        .I3(\clock_reg_reg_n_0_[13] ),
        .O(IRQ0_carry_i_2__0_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__1
       (.I0(\clock_reg_reg_n_0_[20] ),
        .I1(\compare_reg_reg_n_0_[20] ),
        .I2(\compare_reg_reg_n_0_[21] ),
        .I3(\clock_reg_reg_n_0_[21] ),
        .O(IRQ0_carry_i_2__1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__2
       (.I0(\clock_reg_reg_n_0_[28] ),
        .I1(\compare_reg_reg_n_0_[28] ),
        .I2(\compare_reg_reg_n_0_[29] ),
        .I3(\clock_reg_reg_n_0_[29] ),
        .O(IRQ0_carry_i_2__2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__3
       (.I0(p_1_in[4]),
        .I1(\compare_reg_reg_n_0_[36] ),
        .I2(\compare_reg_reg_n_0_[37] ),
        .I3(p_1_in[5]),
        .O(IRQ0_carry_i_2__3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__4
       (.I0(p_1_in[12]),
        .I1(\compare_reg_reg_n_0_[44] ),
        .I2(\compare_reg_reg_n_0_[45] ),
        .I3(p_1_in[13]),
        .O(IRQ0_carry_i_2__4_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__5
       (.I0(p_1_in[20]),
        .I1(\compare_reg_reg_n_0_[52] ),
        .I2(\compare_reg_reg_n_0_[53] ),
        .I3(p_1_in[21]),
        .O(IRQ0_carry_i_2__5_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_2__6
       (.I0(p_1_in[28]),
        .I1(\compare_reg_reg_n_0_[60] ),
        .I2(\compare_reg_reg_n_0_[61] ),
        .I3(p_1_in[29]),
        .O(IRQ0_carry_i_2__6_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3
       (.I0(\clock_reg_reg_n_0_[2] ),
        .I1(\compare_reg_reg_n_0_[2] ),
        .I2(\compare_reg_reg_n_0_[3] ),
        .I3(\clock_reg_reg_n_0_[3] ),
        .O(IRQ0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__0
       (.I0(\clock_reg_reg_n_0_[10] ),
        .I1(\compare_reg_reg_n_0_[10] ),
        .I2(\compare_reg_reg_n_0_[11] ),
        .I3(\clock_reg_reg_n_0_[11] ),
        .O(IRQ0_carry_i_3__0_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__1
       (.I0(\clock_reg_reg_n_0_[18] ),
        .I1(\compare_reg_reg_n_0_[18] ),
        .I2(\compare_reg_reg_n_0_[19] ),
        .I3(\clock_reg_reg_n_0_[19] ),
        .O(IRQ0_carry_i_3__1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__2
       (.I0(\clock_reg_reg_n_0_[26] ),
        .I1(\compare_reg_reg_n_0_[26] ),
        .I2(\compare_reg_reg_n_0_[27] ),
        .I3(\clock_reg_reg_n_0_[27] ),
        .O(IRQ0_carry_i_3__2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__3
       (.I0(p_1_in[2]),
        .I1(\compare_reg_reg_n_0_[34] ),
        .I2(\compare_reg_reg_n_0_[35] ),
        .I3(p_1_in[3]),
        .O(IRQ0_carry_i_3__3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__4
       (.I0(p_1_in[10]),
        .I1(\compare_reg_reg_n_0_[42] ),
        .I2(\compare_reg_reg_n_0_[43] ),
        .I3(p_1_in[11]),
        .O(IRQ0_carry_i_3__4_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__5
       (.I0(p_1_in[18]),
        .I1(\compare_reg_reg_n_0_[50] ),
        .I2(\compare_reg_reg_n_0_[51] ),
        .I3(p_1_in[19]),
        .O(IRQ0_carry_i_3__5_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_3__6
       (.I0(p_1_in[26]),
        .I1(\compare_reg_reg_n_0_[58] ),
        .I2(\compare_reg_reg_n_0_[59] ),
        .I3(p_1_in[27]),
        .O(IRQ0_carry_i_3__6_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4
       (.I0(\clock_reg_reg_n_0_[0] ),
        .I1(\compare_reg_reg_n_0_[0] ),
        .I2(\compare_reg_reg_n_0_[1] ),
        .I3(\clock_reg_reg_n_0_[1] ),
        .O(IRQ0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__0
       (.I0(\clock_reg_reg_n_0_[8] ),
        .I1(\compare_reg_reg_n_0_[8] ),
        .I2(\compare_reg_reg_n_0_[9] ),
        .I3(\clock_reg_reg_n_0_[9] ),
        .O(IRQ0_carry_i_4__0_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__1
       (.I0(\clock_reg_reg_n_0_[16] ),
        .I1(\compare_reg_reg_n_0_[16] ),
        .I2(\compare_reg_reg_n_0_[17] ),
        .I3(\clock_reg_reg_n_0_[17] ),
        .O(IRQ0_carry_i_4__1_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__2
       (.I0(\clock_reg_reg_n_0_[24] ),
        .I1(\compare_reg_reg_n_0_[24] ),
        .I2(\compare_reg_reg_n_0_[25] ),
        .I3(\clock_reg_reg_n_0_[25] ),
        .O(IRQ0_carry_i_4__2_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__3
       (.I0(p_1_in[0]),
        .I1(\compare_reg_reg_n_0_[32] ),
        .I2(\compare_reg_reg_n_0_[33] ),
        .I3(p_1_in[1]),
        .O(IRQ0_carry_i_4__3_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__4
       (.I0(p_1_in[8]),
        .I1(\compare_reg_reg_n_0_[40] ),
        .I2(\compare_reg_reg_n_0_[41] ),
        .I3(p_1_in[9]),
        .O(IRQ0_carry_i_4__4_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__5
       (.I0(p_1_in[16]),
        .I1(\compare_reg_reg_n_0_[48] ),
        .I2(\compare_reg_reg_n_0_[49] ),
        .I3(p_1_in[17]),
        .O(IRQ0_carry_i_4__5_n_0));
  LUT4 #(
    .INIT(16'h2F02)) 
    IRQ0_carry_i_4__6
       (.I0(p_1_in[24]),
        .I1(\compare_reg_reg_n_0_[56] ),
        .I2(\compare_reg_reg_n_0_[57] ),
        .I3(p_1_in[25]),
        .O(IRQ0_carry_i_4__6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5
       (.I0(\clock_reg_reg_n_0_[6] ),
        .I1(\compare_reg_reg_n_0_[6] ),
        .I2(\clock_reg_reg_n_0_[7] ),
        .I3(\compare_reg_reg_n_0_[7] ),
        .O(IRQ0_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__0
       (.I0(\clock_reg_reg_n_0_[14] ),
        .I1(\compare_reg_reg_n_0_[14] ),
        .I2(\clock_reg_reg_n_0_[15] ),
        .I3(\compare_reg_reg_n_0_[15] ),
        .O(IRQ0_carry_i_5__0_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__1
       (.I0(\clock_reg_reg_n_0_[22] ),
        .I1(\compare_reg_reg_n_0_[22] ),
        .I2(\clock_reg_reg_n_0_[23] ),
        .I3(\compare_reg_reg_n_0_[23] ),
        .O(IRQ0_carry_i_5__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__2
       (.I0(\clock_reg_reg_n_0_[30] ),
        .I1(\compare_reg_reg_n_0_[30] ),
        .I2(\clock_reg_reg_n_0_[31] ),
        .I3(\compare_reg_reg_n_0_[31] ),
        .O(IRQ0_carry_i_5__2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__3
       (.I0(p_1_in[6]),
        .I1(\compare_reg_reg_n_0_[38] ),
        .I2(p_1_in[7]),
        .I3(\compare_reg_reg_n_0_[39] ),
        .O(IRQ0_carry_i_5__3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__4
       (.I0(p_1_in[14]),
        .I1(\compare_reg_reg_n_0_[46] ),
        .I2(p_1_in[15]),
        .I3(\compare_reg_reg_n_0_[47] ),
        .O(IRQ0_carry_i_5__4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__5
       (.I0(p_1_in[22]),
        .I1(\compare_reg_reg_n_0_[54] ),
        .I2(p_1_in[23]),
        .I3(\compare_reg_reg_n_0_[55] ),
        .O(IRQ0_carry_i_5__5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_5__6
       (.I0(p_1_in[30]),
        .I1(\compare_reg_reg_n_0_[62] ),
        .I2(p_1_in[31]),
        .I3(\compare_reg_reg_n_0_[63] ),
        .O(IRQ0_carry_i_5__6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6
       (.I0(\clock_reg_reg_n_0_[4] ),
        .I1(\compare_reg_reg_n_0_[4] ),
        .I2(\clock_reg_reg_n_0_[5] ),
        .I3(\compare_reg_reg_n_0_[5] ),
        .O(IRQ0_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__0
       (.I0(\clock_reg_reg_n_0_[12] ),
        .I1(\compare_reg_reg_n_0_[12] ),
        .I2(\clock_reg_reg_n_0_[13] ),
        .I3(\compare_reg_reg_n_0_[13] ),
        .O(IRQ0_carry_i_6__0_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__1
       (.I0(\clock_reg_reg_n_0_[20] ),
        .I1(\compare_reg_reg_n_0_[20] ),
        .I2(\clock_reg_reg_n_0_[21] ),
        .I3(\compare_reg_reg_n_0_[21] ),
        .O(IRQ0_carry_i_6__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__2
       (.I0(\clock_reg_reg_n_0_[28] ),
        .I1(\compare_reg_reg_n_0_[28] ),
        .I2(\clock_reg_reg_n_0_[29] ),
        .I3(\compare_reg_reg_n_0_[29] ),
        .O(IRQ0_carry_i_6__2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__3
       (.I0(p_1_in[4]),
        .I1(\compare_reg_reg_n_0_[36] ),
        .I2(p_1_in[5]),
        .I3(\compare_reg_reg_n_0_[37] ),
        .O(IRQ0_carry_i_6__3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__4
       (.I0(p_1_in[12]),
        .I1(\compare_reg_reg_n_0_[44] ),
        .I2(p_1_in[13]),
        .I3(\compare_reg_reg_n_0_[45] ),
        .O(IRQ0_carry_i_6__4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__5
       (.I0(p_1_in[20]),
        .I1(\compare_reg_reg_n_0_[52] ),
        .I2(p_1_in[21]),
        .I3(\compare_reg_reg_n_0_[53] ),
        .O(IRQ0_carry_i_6__5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_6__6
       (.I0(p_1_in[28]),
        .I1(\compare_reg_reg_n_0_[60] ),
        .I2(p_1_in[29]),
        .I3(\compare_reg_reg_n_0_[61] ),
        .O(IRQ0_carry_i_6__6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7
       (.I0(\clock_reg_reg_n_0_[2] ),
        .I1(\compare_reg_reg_n_0_[2] ),
        .I2(\clock_reg_reg_n_0_[3] ),
        .I3(\compare_reg_reg_n_0_[3] ),
        .O(IRQ0_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__0
       (.I0(\clock_reg_reg_n_0_[10] ),
        .I1(\compare_reg_reg_n_0_[10] ),
        .I2(\clock_reg_reg_n_0_[11] ),
        .I3(\compare_reg_reg_n_0_[11] ),
        .O(IRQ0_carry_i_7__0_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__1
       (.I0(\clock_reg_reg_n_0_[18] ),
        .I1(\compare_reg_reg_n_0_[18] ),
        .I2(\clock_reg_reg_n_0_[19] ),
        .I3(\compare_reg_reg_n_0_[19] ),
        .O(IRQ0_carry_i_7__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__2
       (.I0(\clock_reg_reg_n_0_[26] ),
        .I1(\compare_reg_reg_n_0_[26] ),
        .I2(\clock_reg_reg_n_0_[27] ),
        .I3(\compare_reg_reg_n_0_[27] ),
        .O(IRQ0_carry_i_7__2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__3
       (.I0(p_1_in[2]),
        .I1(\compare_reg_reg_n_0_[34] ),
        .I2(p_1_in[3]),
        .I3(\compare_reg_reg_n_0_[35] ),
        .O(IRQ0_carry_i_7__3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__4
       (.I0(p_1_in[10]),
        .I1(\compare_reg_reg_n_0_[42] ),
        .I2(p_1_in[11]),
        .I3(\compare_reg_reg_n_0_[43] ),
        .O(IRQ0_carry_i_7__4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__5
       (.I0(p_1_in[18]),
        .I1(\compare_reg_reg_n_0_[50] ),
        .I2(p_1_in[19]),
        .I3(\compare_reg_reg_n_0_[51] ),
        .O(IRQ0_carry_i_7__5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_7__6
       (.I0(p_1_in[26]),
        .I1(\compare_reg_reg_n_0_[58] ),
        .I2(p_1_in[27]),
        .I3(\compare_reg_reg_n_0_[59] ),
        .O(IRQ0_carry_i_7__6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8
       (.I0(\clock_reg_reg_n_0_[0] ),
        .I1(\compare_reg_reg_n_0_[0] ),
        .I2(\clock_reg_reg_n_0_[1] ),
        .I3(\compare_reg_reg_n_0_[1] ),
        .O(IRQ0_carry_i_8_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__0
       (.I0(\clock_reg_reg_n_0_[8] ),
        .I1(\compare_reg_reg_n_0_[8] ),
        .I2(\clock_reg_reg_n_0_[9] ),
        .I3(\compare_reg_reg_n_0_[9] ),
        .O(IRQ0_carry_i_8__0_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__1
       (.I0(\clock_reg_reg_n_0_[16] ),
        .I1(\compare_reg_reg_n_0_[16] ),
        .I2(\clock_reg_reg_n_0_[17] ),
        .I3(\compare_reg_reg_n_0_[17] ),
        .O(IRQ0_carry_i_8__1_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__2
       (.I0(\clock_reg_reg_n_0_[24] ),
        .I1(\compare_reg_reg_n_0_[24] ),
        .I2(\clock_reg_reg_n_0_[25] ),
        .I3(\compare_reg_reg_n_0_[25] ),
        .O(IRQ0_carry_i_8__2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__3
       (.I0(p_1_in[0]),
        .I1(\compare_reg_reg_n_0_[32] ),
        .I2(p_1_in[1]),
        .I3(\compare_reg_reg_n_0_[33] ),
        .O(IRQ0_carry_i_8__3_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__4
       (.I0(p_1_in[8]),
        .I1(\compare_reg_reg_n_0_[40] ),
        .I2(p_1_in[9]),
        .I3(\compare_reg_reg_n_0_[41] ),
        .O(IRQ0_carry_i_8__4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__5
       (.I0(p_1_in[16]),
        .I1(\compare_reg_reg_n_0_[48] ),
        .I2(p_1_in[17]),
        .I3(\compare_reg_reg_n_0_[49] ),
        .O(IRQ0_carry_i_8__5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    IRQ0_carry_i_8__6
       (.I0(p_1_in[24]),
        .I1(\compare_reg_reg_n_0_[56] ),
        .I2(p_1_in[25]),
        .I3(\compare_reg_reg_n_0_[57] ),
        .O(IRQ0_carry_i_8__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    arready_int_i_1
       (.I0(S_AXI_ARVALID),
        .I1(S_AXI_ARREADY),
        .O(arready_int0));
  FDRE arready_int_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(arready_int0),
        .Q(S_AXI_ARREADY),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    awready_int_i_1
       (.I0(S_AXI_ARESETN),
        .O(clear));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h08)) 
    awready_int_i_2
       (.I0(S_AXI_WVALID),
        .I1(S_AXI_AWVALID),
        .I2(S_AXI_AWREADY),
        .O(awready_int0));
  FDRE awready_int_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(awready_int0),
        .Q(S_AXI_AWREADY),
        .R(clear));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    bvalid_int_i_1
       (.I0(S_AXI_WREADY),
        .I1(S_AXI_AWREADY),
        .I2(S_AXI_WVALID),
        .I3(S_AXI_AWVALID),
        .I4(S_AXI_BREADY),
        .I5(S_AXI_BVALID),
        .O(bvalid_int_i_1_n_0));
  FDRE bvalid_int_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(bvalid_int_i_1_n_0),
        .Q(S_AXI_BVALID),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \clock_reg[0]_i_2 
       (.I0(\clock_reg_reg_n_0_[0] ),
        .O(\clock_reg[0]_i_2_n_0 ));
  FDRE \clock_reg_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[0]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[0] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\clock_reg_reg[0]_i_1_n_0 ,\clock_reg_reg[0]_i_1_n_1 ,\clock_reg_reg[0]_i_1_n_2 ,\clock_reg_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\clock_reg_reg[0]_i_1_n_4 ,\clock_reg_reg[0]_i_1_n_5 ,\clock_reg_reg[0]_i_1_n_6 ,\clock_reg_reg[0]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[3] ,\clock_reg_reg_n_0_[2] ,\clock_reg_reg_n_0_[1] ,\clock_reg[0]_i_2_n_0 }));
  FDRE \clock_reg_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[8]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[10] ),
        .R(clear));
  FDRE \clock_reg_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[8]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[11] ),
        .R(clear));
  FDRE \clock_reg_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[12]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[12] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[12]_i_1 
       (.CI(\clock_reg_reg[8]_i_1_n_0 ),
        .CO({\clock_reg_reg[12]_i_1_n_0 ,\clock_reg_reg[12]_i_1_n_1 ,\clock_reg_reg[12]_i_1_n_2 ,\clock_reg_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[12]_i_1_n_4 ,\clock_reg_reg[12]_i_1_n_5 ,\clock_reg_reg[12]_i_1_n_6 ,\clock_reg_reg[12]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[15] ,\clock_reg_reg_n_0_[14] ,\clock_reg_reg_n_0_[13] ,\clock_reg_reg_n_0_[12] }));
  FDRE \clock_reg_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[12]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[13] ),
        .R(clear));
  FDRE \clock_reg_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[12]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[14] ),
        .R(clear));
  FDRE \clock_reg_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[12]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[15] ),
        .R(clear));
  FDRE \clock_reg_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[16]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[16] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[16]_i_1 
       (.CI(\clock_reg_reg[12]_i_1_n_0 ),
        .CO({\clock_reg_reg[16]_i_1_n_0 ,\clock_reg_reg[16]_i_1_n_1 ,\clock_reg_reg[16]_i_1_n_2 ,\clock_reg_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[16]_i_1_n_4 ,\clock_reg_reg[16]_i_1_n_5 ,\clock_reg_reg[16]_i_1_n_6 ,\clock_reg_reg[16]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[19] ,\clock_reg_reg_n_0_[18] ,\clock_reg_reg_n_0_[17] ,\clock_reg_reg_n_0_[16] }));
  FDRE \clock_reg_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[16]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[17] ),
        .R(clear));
  FDRE \clock_reg_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[16]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[18] ),
        .R(clear));
  FDRE \clock_reg_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[16]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[19] ),
        .R(clear));
  FDRE \clock_reg_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[0]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[1] ),
        .R(clear));
  FDRE \clock_reg_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[20]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[20] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[20]_i_1 
       (.CI(\clock_reg_reg[16]_i_1_n_0 ),
        .CO({\clock_reg_reg[20]_i_1_n_0 ,\clock_reg_reg[20]_i_1_n_1 ,\clock_reg_reg[20]_i_1_n_2 ,\clock_reg_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[20]_i_1_n_4 ,\clock_reg_reg[20]_i_1_n_5 ,\clock_reg_reg[20]_i_1_n_6 ,\clock_reg_reg[20]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[23] ,\clock_reg_reg_n_0_[22] ,\clock_reg_reg_n_0_[21] ,\clock_reg_reg_n_0_[20] }));
  FDRE \clock_reg_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[20]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[21] ),
        .R(clear));
  FDRE \clock_reg_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[20]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[22] ),
        .R(clear));
  FDRE \clock_reg_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[20]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[23] ),
        .R(clear));
  FDRE \clock_reg_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[24]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[24] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[24]_i_1 
       (.CI(\clock_reg_reg[20]_i_1_n_0 ),
        .CO({\clock_reg_reg[24]_i_1_n_0 ,\clock_reg_reg[24]_i_1_n_1 ,\clock_reg_reg[24]_i_1_n_2 ,\clock_reg_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[24]_i_1_n_4 ,\clock_reg_reg[24]_i_1_n_5 ,\clock_reg_reg[24]_i_1_n_6 ,\clock_reg_reg[24]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[27] ,\clock_reg_reg_n_0_[26] ,\clock_reg_reg_n_0_[25] ,\clock_reg_reg_n_0_[24] }));
  FDRE \clock_reg_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[24]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[25] ),
        .R(clear));
  FDRE \clock_reg_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[24]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[26] ),
        .R(clear));
  FDRE \clock_reg_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[24]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[27] ),
        .R(clear));
  FDRE \clock_reg_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[28]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[28] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[28]_i_1 
       (.CI(\clock_reg_reg[24]_i_1_n_0 ),
        .CO({\clock_reg_reg[28]_i_1_n_0 ,\clock_reg_reg[28]_i_1_n_1 ,\clock_reg_reg[28]_i_1_n_2 ,\clock_reg_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[28]_i_1_n_4 ,\clock_reg_reg[28]_i_1_n_5 ,\clock_reg_reg[28]_i_1_n_6 ,\clock_reg_reg[28]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[31] ,\clock_reg_reg_n_0_[30] ,\clock_reg_reg_n_0_[29] ,\clock_reg_reg_n_0_[28] }));
  FDRE \clock_reg_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[28]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[29] ),
        .R(clear));
  FDRE \clock_reg_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[0]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[2] ),
        .R(clear));
  FDRE \clock_reg_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[28]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[30] ),
        .R(clear));
  FDRE \clock_reg_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[28]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[31] ),
        .R(clear));
  FDRE \clock_reg_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[32]_i_1_n_7 ),
        .Q(p_1_in[0]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[32]_i_1 
       (.CI(\clock_reg_reg[28]_i_1_n_0 ),
        .CO({\clock_reg_reg[32]_i_1_n_0 ,\clock_reg_reg[32]_i_1_n_1 ,\clock_reg_reg[32]_i_1_n_2 ,\clock_reg_reg[32]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[32]_i_1_n_4 ,\clock_reg_reg[32]_i_1_n_5 ,\clock_reg_reg[32]_i_1_n_6 ,\clock_reg_reg[32]_i_1_n_7 }),
        .S(p_1_in[3:0]));
  FDRE \clock_reg_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[32]_i_1_n_6 ),
        .Q(p_1_in[1]),
        .R(clear));
  FDRE \clock_reg_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[32]_i_1_n_5 ),
        .Q(p_1_in[2]),
        .R(clear));
  FDRE \clock_reg_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[32]_i_1_n_4 ),
        .Q(p_1_in[3]),
        .R(clear));
  FDRE \clock_reg_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[36]_i_1_n_7 ),
        .Q(p_1_in[4]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[36]_i_1 
       (.CI(\clock_reg_reg[32]_i_1_n_0 ),
        .CO({\clock_reg_reg[36]_i_1_n_0 ,\clock_reg_reg[36]_i_1_n_1 ,\clock_reg_reg[36]_i_1_n_2 ,\clock_reg_reg[36]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[36]_i_1_n_4 ,\clock_reg_reg[36]_i_1_n_5 ,\clock_reg_reg[36]_i_1_n_6 ,\clock_reg_reg[36]_i_1_n_7 }),
        .S(p_1_in[7:4]));
  FDRE \clock_reg_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[36]_i_1_n_6 ),
        .Q(p_1_in[5]),
        .R(clear));
  FDRE \clock_reg_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[36]_i_1_n_5 ),
        .Q(p_1_in[6]),
        .R(clear));
  FDRE \clock_reg_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[36]_i_1_n_4 ),
        .Q(p_1_in[7]),
        .R(clear));
  FDRE \clock_reg_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[0]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[3] ),
        .R(clear));
  FDRE \clock_reg_reg[40] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[40]_i_1_n_7 ),
        .Q(p_1_in[8]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[40]_i_1 
       (.CI(\clock_reg_reg[36]_i_1_n_0 ),
        .CO({\clock_reg_reg[40]_i_1_n_0 ,\clock_reg_reg[40]_i_1_n_1 ,\clock_reg_reg[40]_i_1_n_2 ,\clock_reg_reg[40]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[40]_i_1_n_4 ,\clock_reg_reg[40]_i_1_n_5 ,\clock_reg_reg[40]_i_1_n_6 ,\clock_reg_reg[40]_i_1_n_7 }),
        .S(p_1_in[11:8]));
  FDRE \clock_reg_reg[41] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[40]_i_1_n_6 ),
        .Q(p_1_in[9]),
        .R(clear));
  FDRE \clock_reg_reg[42] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[40]_i_1_n_5 ),
        .Q(p_1_in[10]),
        .R(clear));
  FDRE \clock_reg_reg[43] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[40]_i_1_n_4 ),
        .Q(p_1_in[11]),
        .R(clear));
  FDRE \clock_reg_reg[44] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[44]_i_1_n_7 ),
        .Q(p_1_in[12]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[44]_i_1 
       (.CI(\clock_reg_reg[40]_i_1_n_0 ),
        .CO({\clock_reg_reg[44]_i_1_n_0 ,\clock_reg_reg[44]_i_1_n_1 ,\clock_reg_reg[44]_i_1_n_2 ,\clock_reg_reg[44]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[44]_i_1_n_4 ,\clock_reg_reg[44]_i_1_n_5 ,\clock_reg_reg[44]_i_1_n_6 ,\clock_reg_reg[44]_i_1_n_7 }),
        .S(p_1_in[15:12]));
  FDRE \clock_reg_reg[45] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[44]_i_1_n_6 ),
        .Q(p_1_in[13]),
        .R(clear));
  FDRE \clock_reg_reg[46] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[44]_i_1_n_5 ),
        .Q(p_1_in[14]),
        .R(clear));
  FDRE \clock_reg_reg[47] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[44]_i_1_n_4 ),
        .Q(p_1_in[15]),
        .R(clear));
  FDRE \clock_reg_reg[48] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[48]_i_1_n_7 ),
        .Q(p_1_in[16]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[48]_i_1 
       (.CI(\clock_reg_reg[44]_i_1_n_0 ),
        .CO({\clock_reg_reg[48]_i_1_n_0 ,\clock_reg_reg[48]_i_1_n_1 ,\clock_reg_reg[48]_i_1_n_2 ,\clock_reg_reg[48]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[48]_i_1_n_4 ,\clock_reg_reg[48]_i_1_n_5 ,\clock_reg_reg[48]_i_1_n_6 ,\clock_reg_reg[48]_i_1_n_7 }),
        .S(p_1_in[19:16]));
  FDRE \clock_reg_reg[49] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[48]_i_1_n_6 ),
        .Q(p_1_in[17]),
        .R(clear));
  FDRE \clock_reg_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[4]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[4] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[4]_i_1 
       (.CI(\clock_reg_reg[0]_i_1_n_0 ),
        .CO({\clock_reg_reg[4]_i_1_n_0 ,\clock_reg_reg[4]_i_1_n_1 ,\clock_reg_reg[4]_i_1_n_2 ,\clock_reg_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[4]_i_1_n_4 ,\clock_reg_reg[4]_i_1_n_5 ,\clock_reg_reg[4]_i_1_n_6 ,\clock_reg_reg[4]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[7] ,\clock_reg_reg_n_0_[6] ,\clock_reg_reg_n_0_[5] ,\clock_reg_reg_n_0_[4] }));
  FDRE \clock_reg_reg[50] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[48]_i_1_n_5 ),
        .Q(p_1_in[18]),
        .R(clear));
  FDRE \clock_reg_reg[51] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[48]_i_1_n_4 ),
        .Q(p_1_in[19]),
        .R(clear));
  FDRE \clock_reg_reg[52] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[52]_i_1_n_7 ),
        .Q(p_1_in[20]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[52]_i_1 
       (.CI(\clock_reg_reg[48]_i_1_n_0 ),
        .CO({\clock_reg_reg[52]_i_1_n_0 ,\clock_reg_reg[52]_i_1_n_1 ,\clock_reg_reg[52]_i_1_n_2 ,\clock_reg_reg[52]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[52]_i_1_n_4 ,\clock_reg_reg[52]_i_1_n_5 ,\clock_reg_reg[52]_i_1_n_6 ,\clock_reg_reg[52]_i_1_n_7 }),
        .S(p_1_in[23:20]));
  FDRE \clock_reg_reg[53] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[52]_i_1_n_6 ),
        .Q(p_1_in[21]),
        .R(clear));
  FDRE \clock_reg_reg[54] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[52]_i_1_n_5 ),
        .Q(p_1_in[22]),
        .R(clear));
  FDRE \clock_reg_reg[55] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[52]_i_1_n_4 ),
        .Q(p_1_in[23]),
        .R(clear));
  FDRE \clock_reg_reg[56] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[56]_i_1_n_7 ),
        .Q(p_1_in[24]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[56]_i_1 
       (.CI(\clock_reg_reg[52]_i_1_n_0 ),
        .CO({\clock_reg_reg[56]_i_1_n_0 ,\clock_reg_reg[56]_i_1_n_1 ,\clock_reg_reg[56]_i_1_n_2 ,\clock_reg_reg[56]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[56]_i_1_n_4 ,\clock_reg_reg[56]_i_1_n_5 ,\clock_reg_reg[56]_i_1_n_6 ,\clock_reg_reg[56]_i_1_n_7 }),
        .S(p_1_in[27:24]));
  FDRE \clock_reg_reg[57] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[56]_i_1_n_6 ),
        .Q(p_1_in[25]),
        .R(clear));
  FDRE \clock_reg_reg[58] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[56]_i_1_n_5 ),
        .Q(p_1_in[26]),
        .R(clear));
  FDRE \clock_reg_reg[59] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[56]_i_1_n_4 ),
        .Q(p_1_in[27]),
        .R(clear));
  FDRE \clock_reg_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[4]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[5] ),
        .R(clear));
  FDRE \clock_reg_reg[60] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[60]_i_1_n_7 ),
        .Q(p_1_in[28]),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[60]_i_1 
       (.CI(\clock_reg_reg[56]_i_1_n_0 ),
        .CO({\NLW_clock_reg_reg[60]_i_1_CO_UNCONNECTED [3],\clock_reg_reg[60]_i_1_n_1 ,\clock_reg_reg[60]_i_1_n_2 ,\clock_reg_reg[60]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[60]_i_1_n_4 ,\clock_reg_reg[60]_i_1_n_5 ,\clock_reg_reg[60]_i_1_n_6 ,\clock_reg_reg[60]_i_1_n_7 }),
        .S(p_1_in[31:28]));
  FDRE \clock_reg_reg[61] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[60]_i_1_n_6 ),
        .Q(p_1_in[29]),
        .R(clear));
  FDRE \clock_reg_reg[62] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[60]_i_1_n_5 ),
        .Q(p_1_in[30]),
        .R(clear));
  FDRE \clock_reg_reg[63] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[60]_i_1_n_4 ),
        .Q(p_1_in[31]),
        .R(clear));
  FDRE \clock_reg_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[4]_i_1_n_5 ),
        .Q(\clock_reg_reg_n_0_[6] ),
        .R(clear));
  FDRE \clock_reg_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[4]_i_1_n_4 ),
        .Q(\clock_reg_reg_n_0_[7] ),
        .R(clear));
  FDRE \clock_reg_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[8]_i_1_n_7 ),
        .Q(\clock_reg_reg_n_0_[8] ),
        .R(clear));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \clock_reg_reg[8]_i_1 
       (.CI(\clock_reg_reg[4]_i_1_n_0 ),
        .CO({\clock_reg_reg[8]_i_1_n_0 ,\clock_reg_reg[8]_i_1_n_1 ,\clock_reg_reg[8]_i_1_n_2 ,\clock_reg_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clock_reg_reg[8]_i_1_n_4 ,\clock_reg_reg[8]_i_1_n_5 ,\clock_reg_reg[8]_i_1_n_6 ,\clock_reg_reg[8]_i_1_n_7 }),
        .S({\clock_reg_reg_n_0_[11] ,\clock_reg_reg_n_0_[10] ,\clock_reg_reg_n_0_[9] ,\clock_reg_reg_n_0_[8] }));
  FDRE \clock_reg_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(\clock_reg_reg[8]_i_1_n_6 ),
        .Q(\clock_reg_reg_n_0_[9] ),
        .R(clear));
  LUT5 #(
    .INIT(32'h00000040)) 
    \clock_snap_reg[31]_i_1 
       (.I0(rvalid_int_reg_0),
        .I1(S_AXI_ARREADY),
        .I2(S_AXI_ARVALID),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .O(clock_snap_reg_0));
  FDRE \clock_snap_reg_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[0]),
        .Q(clock_snap_reg[0]),
        .R(clear));
  FDRE \clock_snap_reg_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[10]),
        .Q(clock_snap_reg[10]),
        .R(clear));
  FDRE \clock_snap_reg_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[11]),
        .Q(clock_snap_reg[11]),
        .R(clear));
  FDRE \clock_snap_reg_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[12]),
        .Q(clock_snap_reg[12]),
        .R(clear));
  FDRE \clock_snap_reg_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[13]),
        .Q(clock_snap_reg[13]),
        .R(clear));
  FDRE \clock_snap_reg_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[14]),
        .Q(clock_snap_reg[14]),
        .R(clear));
  FDRE \clock_snap_reg_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[15]),
        .Q(clock_snap_reg[15]),
        .R(clear));
  FDRE \clock_snap_reg_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[16]),
        .Q(clock_snap_reg[16]),
        .R(clear));
  FDRE \clock_snap_reg_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[17]),
        .Q(clock_snap_reg[17]),
        .R(clear));
  FDRE \clock_snap_reg_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[18]),
        .Q(clock_snap_reg[18]),
        .R(clear));
  FDRE \clock_snap_reg_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[19]),
        .Q(clock_snap_reg[19]),
        .R(clear));
  FDRE \clock_snap_reg_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[1]),
        .Q(clock_snap_reg[1]),
        .R(clear));
  FDRE \clock_snap_reg_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[20]),
        .Q(clock_snap_reg[20]),
        .R(clear));
  FDRE \clock_snap_reg_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[21]),
        .Q(clock_snap_reg[21]),
        .R(clear));
  FDRE \clock_snap_reg_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[22]),
        .Q(clock_snap_reg[22]),
        .R(clear));
  FDRE \clock_snap_reg_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[23]),
        .Q(clock_snap_reg[23]),
        .R(clear));
  FDRE \clock_snap_reg_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[24]),
        .Q(clock_snap_reg[24]),
        .R(clear));
  FDRE \clock_snap_reg_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[25]),
        .Q(clock_snap_reg[25]),
        .R(clear));
  FDRE \clock_snap_reg_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[26]),
        .Q(clock_snap_reg[26]),
        .R(clear));
  FDRE \clock_snap_reg_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[27]),
        .Q(clock_snap_reg[27]),
        .R(clear));
  FDRE \clock_snap_reg_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[28]),
        .Q(clock_snap_reg[28]),
        .R(clear));
  FDRE \clock_snap_reg_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[29]),
        .Q(clock_snap_reg[29]),
        .R(clear));
  FDRE \clock_snap_reg_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[2]),
        .Q(clock_snap_reg[2]),
        .R(clear));
  FDRE \clock_snap_reg_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[30]),
        .Q(clock_snap_reg[30]),
        .R(clear));
  FDRE \clock_snap_reg_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[31]),
        .Q(clock_snap_reg[31]),
        .R(clear));
  FDRE \clock_snap_reg_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[3]),
        .Q(clock_snap_reg[3]),
        .R(clear));
  FDRE \clock_snap_reg_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[4]),
        .Q(clock_snap_reg[4]),
        .R(clear));
  FDRE \clock_snap_reg_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[5]),
        .Q(clock_snap_reg[5]),
        .R(clear));
  FDRE \clock_snap_reg_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[6]),
        .Q(clock_snap_reg[6]),
        .R(clear));
  FDRE \clock_snap_reg_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[7]),
        .Q(clock_snap_reg[7]),
        .R(clear));
  FDRE \clock_snap_reg_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[8]),
        .Q(clock_snap_reg[8]),
        .R(clear));
  FDRE \clock_snap_reg_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(clock_snap_reg_0),
        .D(p_1_in[9]),
        .Q(clock_snap_reg[9]),
        .R(clear));
  LUT5 #(
    .INIT(32'h00000080)) 
    \compare_reg[31]_i_1 
       (.I0(S_AXI_AWADDR[1]),
        .I1(S_AXI_WVALID),
        .I2(S_AXI_AWVALID),
        .I3(S_AXI_WREADY),
        .I4(S_AXI_AWADDR[0]),
        .O(compare_reg[31]));
  LUT5 #(
    .INIT(32'h00800000)) 
    \compare_reg[63]_i_1 
       (.I0(S_AXI_AWADDR[1]),
        .I1(S_AXI_WVALID),
        .I2(S_AXI_AWVALID),
        .I3(S_AXI_WREADY),
        .I4(S_AXI_AWADDR[0]),
        .O(compare_reg[63]));
  FDSE \compare_reg_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[0]),
        .Q(\compare_reg_reg_n_0_[0] ),
        .S(clear));
  FDSE \compare_reg_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[10]),
        .Q(\compare_reg_reg_n_0_[10] ),
        .S(clear));
  FDSE \compare_reg_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[11]),
        .Q(\compare_reg_reg_n_0_[11] ),
        .S(clear));
  FDSE \compare_reg_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[12]),
        .Q(\compare_reg_reg_n_0_[12] ),
        .S(clear));
  FDSE \compare_reg_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[13]),
        .Q(\compare_reg_reg_n_0_[13] ),
        .S(clear));
  FDSE \compare_reg_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[14]),
        .Q(\compare_reg_reg_n_0_[14] ),
        .S(clear));
  FDSE \compare_reg_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[15]),
        .Q(\compare_reg_reg_n_0_[15] ),
        .S(clear));
  FDSE \compare_reg_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[16]),
        .Q(\compare_reg_reg_n_0_[16] ),
        .S(clear));
  FDSE \compare_reg_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[17]),
        .Q(\compare_reg_reg_n_0_[17] ),
        .S(clear));
  FDSE \compare_reg_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[18]),
        .Q(\compare_reg_reg_n_0_[18] ),
        .S(clear));
  FDSE \compare_reg_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[19]),
        .Q(\compare_reg_reg_n_0_[19] ),
        .S(clear));
  FDSE \compare_reg_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[1]),
        .Q(\compare_reg_reg_n_0_[1] ),
        .S(clear));
  FDSE \compare_reg_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[20]),
        .Q(\compare_reg_reg_n_0_[20] ),
        .S(clear));
  FDSE \compare_reg_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[21]),
        .Q(\compare_reg_reg_n_0_[21] ),
        .S(clear));
  FDSE \compare_reg_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[22]),
        .Q(\compare_reg_reg_n_0_[22] ),
        .S(clear));
  FDSE \compare_reg_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[23]),
        .Q(\compare_reg_reg_n_0_[23] ),
        .S(clear));
  FDSE \compare_reg_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[24]),
        .Q(\compare_reg_reg_n_0_[24] ),
        .S(clear));
  FDSE \compare_reg_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[25]),
        .Q(\compare_reg_reg_n_0_[25] ),
        .S(clear));
  FDSE \compare_reg_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[26]),
        .Q(\compare_reg_reg_n_0_[26] ),
        .S(clear));
  FDSE \compare_reg_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[27]),
        .Q(\compare_reg_reg_n_0_[27] ),
        .S(clear));
  FDSE \compare_reg_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[28]),
        .Q(\compare_reg_reg_n_0_[28] ),
        .S(clear));
  FDSE \compare_reg_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[29]),
        .Q(\compare_reg_reg_n_0_[29] ),
        .S(clear));
  FDSE \compare_reg_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[2]),
        .Q(\compare_reg_reg_n_0_[2] ),
        .S(clear));
  FDSE \compare_reg_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[30]),
        .Q(\compare_reg_reg_n_0_[30] ),
        .S(clear));
  FDSE \compare_reg_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[31]),
        .Q(\compare_reg_reg_n_0_[31] ),
        .S(clear));
  FDSE \compare_reg_reg[32] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[0]),
        .Q(\compare_reg_reg_n_0_[32] ),
        .S(clear));
  FDSE \compare_reg_reg[33] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[1]),
        .Q(\compare_reg_reg_n_0_[33] ),
        .S(clear));
  FDSE \compare_reg_reg[34] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[2]),
        .Q(\compare_reg_reg_n_0_[34] ),
        .S(clear));
  FDSE \compare_reg_reg[35] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[3]),
        .Q(\compare_reg_reg_n_0_[35] ),
        .S(clear));
  FDSE \compare_reg_reg[36] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[4]),
        .Q(\compare_reg_reg_n_0_[36] ),
        .S(clear));
  FDSE \compare_reg_reg[37] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[5]),
        .Q(\compare_reg_reg_n_0_[37] ),
        .S(clear));
  FDSE \compare_reg_reg[38] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[6]),
        .Q(\compare_reg_reg_n_0_[38] ),
        .S(clear));
  FDSE \compare_reg_reg[39] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[7]),
        .Q(\compare_reg_reg_n_0_[39] ),
        .S(clear));
  FDSE \compare_reg_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[3]),
        .Q(\compare_reg_reg_n_0_[3] ),
        .S(clear));
  FDSE \compare_reg_reg[40] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[8]),
        .Q(\compare_reg_reg_n_0_[40] ),
        .S(clear));
  FDSE \compare_reg_reg[41] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[9]),
        .Q(\compare_reg_reg_n_0_[41] ),
        .S(clear));
  FDSE \compare_reg_reg[42] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[10]),
        .Q(\compare_reg_reg_n_0_[42] ),
        .S(clear));
  FDSE \compare_reg_reg[43] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[11]),
        .Q(\compare_reg_reg_n_0_[43] ),
        .S(clear));
  FDSE \compare_reg_reg[44] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[12]),
        .Q(\compare_reg_reg_n_0_[44] ),
        .S(clear));
  FDSE \compare_reg_reg[45] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[13]),
        .Q(\compare_reg_reg_n_0_[45] ),
        .S(clear));
  FDSE \compare_reg_reg[46] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[14]),
        .Q(\compare_reg_reg_n_0_[46] ),
        .S(clear));
  FDSE \compare_reg_reg[47] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[15]),
        .Q(\compare_reg_reg_n_0_[47] ),
        .S(clear));
  FDSE \compare_reg_reg[48] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[16]),
        .Q(\compare_reg_reg_n_0_[48] ),
        .S(clear));
  FDSE \compare_reg_reg[49] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[17]),
        .Q(\compare_reg_reg_n_0_[49] ),
        .S(clear));
  FDSE \compare_reg_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[4]),
        .Q(\compare_reg_reg_n_0_[4] ),
        .S(clear));
  FDSE \compare_reg_reg[50] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[18]),
        .Q(\compare_reg_reg_n_0_[50] ),
        .S(clear));
  FDSE \compare_reg_reg[51] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[19]),
        .Q(\compare_reg_reg_n_0_[51] ),
        .S(clear));
  FDSE \compare_reg_reg[52] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[20]),
        .Q(\compare_reg_reg_n_0_[52] ),
        .S(clear));
  FDSE \compare_reg_reg[53] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[21]),
        .Q(\compare_reg_reg_n_0_[53] ),
        .S(clear));
  FDSE \compare_reg_reg[54] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[22]),
        .Q(\compare_reg_reg_n_0_[54] ),
        .S(clear));
  FDSE \compare_reg_reg[55] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[23]),
        .Q(\compare_reg_reg_n_0_[55] ),
        .S(clear));
  FDSE \compare_reg_reg[56] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[24]),
        .Q(\compare_reg_reg_n_0_[56] ),
        .S(clear));
  FDSE \compare_reg_reg[57] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[25]),
        .Q(\compare_reg_reg_n_0_[57] ),
        .S(clear));
  FDSE \compare_reg_reg[58] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[26]),
        .Q(\compare_reg_reg_n_0_[58] ),
        .S(clear));
  FDSE \compare_reg_reg[59] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[27]),
        .Q(\compare_reg_reg_n_0_[59] ),
        .S(clear));
  FDSE \compare_reg_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[5]),
        .Q(\compare_reg_reg_n_0_[5] ),
        .S(clear));
  FDSE \compare_reg_reg[60] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[28]),
        .Q(\compare_reg_reg_n_0_[60] ),
        .S(clear));
  FDSE \compare_reg_reg[61] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[29]),
        .Q(\compare_reg_reg_n_0_[61] ),
        .S(clear));
  FDSE \compare_reg_reg[62] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[30]),
        .Q(\compare_reg_reg_n_0_[62] ),
        .S(clear));
  FDSE \compare_reg_reg[63] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[63]),
        .D(S_AXI_WDATA[31]),
        .Q(\compare_reg_reg_n_0_[63] ),
        .S(clear));
  FDSE \compare_reg_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[6]),
        .Q(\compare_reg_reg_n_0_[6] ),
        .S(clear));
  FDSE \compare_reg_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[7]),
        .Q(\compare_reg_reg_n_0_[7] ),
        .S(clear));
  FDSE \compare_reg_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[8]),
        .Q(\compare_reg_reg_n_0_[8] ),
        .S(clear));
  FDSE \compare_reg_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(compare_reg[31]),
        .D(S_AXI_WDATA[9]),
        .Q(\compare_reg_reg_n_0_[9] ),
        .S(clear));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[0]_i_1 
       (.I0(clock_snap_reg[0]),
        .I1(\clock_reg_reg_n_0_[0] ),
        .I2(\compare_reg_reg_n_0_[32] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[0] ),
        .O(\rdata_int[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[10]_i_1 
       (.I0(clock_snap_reg[10]),
        .I1(\clock_reg_reg_n_0_[10] ),
        .I2(\compare_reg_reg_n_0_[42] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[10] ),
        .O(\rdata_int[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[11]_i_1 
       (.I0(clock_snap_reg[11]),
        .I1(\clock_reg_reg_n_0_[11] ),
        .I2(\compare_reg_reg_n_0_[43] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[11] ),
        .O(\rdata_int[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[12]_i_1 
       (.I0(clock_snap_reg[12]),
        .I1(\clock_reg_reg_n_0_[12] ),
        .I2(\compare_reg_reg_n_0_[44] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[12] ),
        .O(\rdata_int[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[13]_i_1 
       (.I0(clock_snap_reg[13]),
        .I1(\clock_reg_reg_n_0_[13] ),
        .I2(\compare_reg_reg_n_0_[45] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[13] ),
        .O(\rdata_int[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[14]_i_1 
       (.I0(clock_snap_reg[14]),
        .I1(\clock_reg_reg_n_0_[14] ),
        .I2(\compare_reg_reg_n_0_[46] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[14] ),
        .O(\rdata_int[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[15]_i_1 
       (.I0(clock_snap_reg[15]),
        .I1(\clock_reg_reg_n_0_[15] ),
        .I2(\compare_reg_reg_n_0_[47] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[15] ),
        .O(\rdata_int[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[16]_i_1 
       (.I0(clock_snap_reg[16]),
        .I1(\clock_reg_reg_n_0_[16] ),
        .I2(\compare_reg_reg_n_0_[48] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[16] ),
        .O(\rdata_int[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[17]_i_1 
       (.I0(clock_snap_reg[17]),
        .I1(\clock_reg_reg_n_0_[17] ),
        .I2(\compare_reg_reg_n_0_[49] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[17] ),
        .O(\rdata_int[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[18]_i_1 
       (.I0(clock_snap_reg[18]),
        .I1(\clock_reg_reg_n_0_[18] ),
        .I2(\compare_reg_reg_n_0_[50] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[18] ),
        .O(\rdata_int[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[19]_i_1 
       (.I0(clock_snap_reg[19]),
        .I1(\clock_reg_reg_n_0_[19] ),
        .I2(\compare_reg_reg_n_0_[51] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[19] ),
        .O(\rdata_int[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[1]_i_1 
       (.I0(clock_snap_reg[1]),
        .I1(\clock_reg_reg_n_0_[1] ),
        .I2(\compare_reg_reg_n_0_[33] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[1] ),
        .O(\rdata_int[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[20]_i_1 
       (.I0(clock_snap_reg[20]),
        .I1(\clock_reg_reg_n_0_[20] ),
        .I2(\compare_reg_reg_n_0_[52] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[20] ),
        .O(\rdata_int[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[21]_i_1 
       (.I0(clock_snap_reg[21]),
        .I1(\clock_reg_reg_n_0_[21] ),
        .I2(\compare_reg_reg_n_0_[53] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[21] ),
        .O(\rdata_int[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[22]_i_1 
       (.I0(clock_snap_reg[22]),
        .I1(\clock_reg_reg_n_0_[22] ),
        .I2(\compare_reg_reg_n_0_[54] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[22] ),
        .O(\rdata_int[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[23]_i_1 
       (.I0(clock_snap_reg[23]),
        .I1(\clock_reg_reg_n_0_[23] ),
        .I2(\compare_reg_reg_n_0_[55] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[23] ),
        .O(\rdata_int[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[24]_i_1 
       (.I0(clock_snap_reg[24]),
        .I1(\clock_reg_reg_n_0_[24] ),
        .I2(\compare_reg_reg_n_0_[56] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[24] ),
        .O(\rdata_int[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[25]_i_1 
       (.I0(clock_snap_reg[25]),
        .I1(\clock_reg_reg_n_0_[25] ),
        .I2(\compare_reg_reg_n_0_[57] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[25] ),
        .O(\rdata_int[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[26]_i_1 
       (.I0(clock_snap_reg[26]),
        .I1(\clock_reg_reg_n_0_[26] ),
        .I2(\compare_reg_reg_n_0_[58] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[26] ),
        .O(\rdata_int[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[27]_i_1 
       (.I0(clock_snap_reg[27]),
        .I1(\clock_reg_reg_n_0_[27] ),
        .I2(\compare_reg_reg_n_0_[59] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[27] ),
        .O(\rdata_int[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[28]_i_1 
       (.I0(clock_snap_reg[28]),
        .I1(\clock_reg_reg_n_0_[28] ),
        .I2(\compare_reg_reg_n_0_[60] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[28] ),
        .O(\rdata_int[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[29]_i_1 
       (.I0(clock_snap_reg[29]),
        .I1(\clock_reg_reg_n_0_[29] ),
        .I2(\compare_reg_reg_n_0_[61] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[29] ),
        .O(\rdata_int[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[2]_i_1 
       (.I0(clock_snap_reg[2]),
        .I1(\clock_reg_reg_n_0_[2] ),
        .I2(\compare_reg_reg_n_0_[34] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[2] ),
        .O(\rdata_int[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[30]_i_1 
       (.I0(clock_snap_reg[30]),
        .I1(\clock_reg_reg_n_0_[30] ),
        .I2(\compare_reg_reg_n_0_[62] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[30] ),
        .O(\rdata_int[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[31]_i_1 
       (.I0(clock_snap_reg[31]),
        .I1(\clock_reg_reg_n_0_[31] ),
        .I2(\compare_reg_reg_n_0_[63] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[31] ),
        .O(\rdata_int[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[3]_i_1 
       (.I0(clock_snap_reg[3]),
        .I1(\clock_reg_reg_n_0_[3] ),
        .I2(\compare_reg_reg_n_0_[35] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[3] ),
        .O(\rdata_int[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[4]_i_1 
       (.I0(clock_snap_reg[4]),
        .I1(\clock_reg_reg_n_0_[4] ),
        .I2(\compare_reg_reg_n_0_[36] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[4] ),
        .O(\rdata_int[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[5]_i_1 
       (.I0(clock_snap_reg[5]),
        .I1(\clock_reg_reg_n_0_[5] ),
        .I2(\compare_reg_reg_n_0_[37] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[5] ),
        .O(\rdata_int[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[6]_i_1 
       (.I0(clock_snap_reg[6]),
        .I1(\clock_reg_reg_n_0_[6] ),
        .I2(\compare_reg_reg_n_0_[38] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[6] ),
        .O(\rdata_int[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[7]_i_1 
       (.I0(clock_snap_reg[7]),
        .I1(\clock_reg_reg_n_0_[7] ),
        .I2(\compare_reg_reg_n_0_[39] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[7] ),
        .O(\rdata_int[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[8]_i_1 
       (.I0(clock_snap_reg[8]),
        .I1(\clock_reg_reg_n_0_[8] ),
        .I2(\compare_reg_reg_n_0_[40] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[8] ),
        .O(\rdata_int[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF0AAFFCCF0AA00CC)) 
    \rdata_int[9]_i_1 
       (.I0(clock_snap_reg[9]),
        .I1(\clock_reg_reg_n_0_[9] ),
        .I2(\compare_reg_reg_n_0_[41] ),
        .I3(S_AXI_ARADDR[1]),
        .I4(S_AXI_ARADDR[0]),
        .I5(\compare_reg_reg_n_0_[9] ),
        .O(\rdata_int[9]_i_1_n_0 ));
  FDRE \rdata_int_reg[0] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[0]_i_1_n_0 ),
        .Q(S_AXI_RDATA[0]),
        .R(clear));
  FDRE \rdata_int_reg[10] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[10]_i_1_n_0 ),
        .Q(S_AXI_RDATA[10]),
        .R(clear));
  FDRE \rdata_int_reg[11] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[11]_i_1_n_0 ),
        .Q(S_AXI_RDATA[11]),
        .R(clear));
  FDRE \rdata_int_reg[12] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[12]_i_1_n_0 ),
        .Q(S_AXI_RDATA[12]),
        .R(clear));
  FDRE \rdata_int_reg[13] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[13]_i_1_n_0 ),
        .Q(S_AXI_RDATA[13]),
        .R(clear));
  FDRE \rdata_int_reg[14] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[14]_i_1_n_0 ),
        .Q(S_AXI_RDATA[14]),
        .R(clear));
  FDRE \rdata_int_reg[15] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[15]_i_1_n_0 ),
        .Q(S_AXI_RDATA[15]),
        .R(clear));
  FDRE \rdata_int_reg[16] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[16]_i_1_n_0 ),
        .Q(S_AXI_RDATA[16]),
        .R(clear));
  FDRE \rdata_int_reg[17] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[17]_i_1_n_0 ),
        .Q(S_AXI_RDATA[17]),
        .R(clear));
  FDRE \rdata_int_reg[18] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[18]_i_1_n_0 ),
        .Q(S_AXI_RDATA[18]),
        .R(clear));
  FDRE \rdata_int_reg[19] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[19]_i_1_n_0 ),
        .Q(S_AXI_RDATA[19]),
        .R(clear));
  FDRE \rdata_int_reg[1] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[1]_i_1_n_0 ),
        .Q(S_AXI_RDATA[1]),
        .R(clear));
  FDRE \rdata_int_reg[20] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[20]_i_1_n_0 ),
        .Q(S_AXI_RDATA[20]),
        .R(clear));
  FDRE \rdata_int_reg[21] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[21]_i_1_n_0 ),
        .Q(S_AXI_RDATA[21]),
        .R(clear));
  FDRE \rdata_int_reg[22] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[22]_i_1_n_0 ),
        .Q(S_AXI_RDATA[22]),
        .R(clear));
  FDRE \rdata_int_reg[23] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[23]_i_1_n_0 ),
        .Q(S_AXI_RDATA[23]),
        .R(clear));
  FDRE \rdata_int_reg[24] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[24]_i_1_n_0 ),
        .Q(S_AXI_RDATA[24]),
        .R(clear));
  FDRE \rdata_int_reg[25] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[25]_i_1_n_0 ),
        .Q(S_AXI_RDATA[25]),
        .R(clear));
  FDRE \rdata_int_reg[26] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[26]_i_1_n_0 ),
        .Q(S_AXI_RDATA[26]),
        .R(clear));
  FDRE \rdata_int_reg[27] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[27]_i_1_n_0 ),
        .Q(S_AXI_RDATA[27]),
        .R(clear));
  FDRE \rdata_int_reg[28] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[28]_i_1_n_0 ),
        .Q(S_AXI_RDATA[28]),
        .R(clear));
  FDRE \rdata_int_reg[29] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[29]_i_1_n_0 ),
        .Q(S_AXI_RDATA[29]),
        .R(clear));
  FDRE \rdata_int_reg[2] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[2]_i_1_n_0 ),
        .Q(S_AXI_RDATA[2]),
        .R(clear));
  FDRE \rdata_int_reg[30] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[30]_i_1_n_0 ),
        .Q(S_AXI_RDATA[30]),
        .R(clear));
  FDRE \rdata_int_reg[31] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[31]_i_1_n_0 ),
        .Q(S_AXI_RDATA[31]),
        .R(clear));
  FDRE \rdata_int_reg[3] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[3]_i_1_n_0 ),
        .Q(S_AXI_RDATA[3]),
        .R(clear));
  FDRE \rdata_int_reg[4] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[4]_i_1_n_0 ),
        .Q(S_AXI_RDATA[4]),
        .R(clear));
  FDRE \rdata_int_reg[5] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[5]_i_1_n_0 ),
        .Q(S_AXI_RDATA[5]),
        .R(clear));
  FDRE \rdata_int_reg[6] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[6]_i_1_n_0 ),
        .Q(S_AXI_RDATA[6]),
        .R(clear));
  FDRE \rdata_int_reg[7] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[7]_i_1_n_0 ),
        .Q(S_AXI_RDATA[7]),
        .R(clear));
  FDRE \rdata_int_reg[8] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[8]_i_1_n_0 ),
        .Q(S_AXI_RDATA[8]),
        .R(clear));
  FDRE \rdata_int_reg[9] 
       (.C(S_AXI_ACLK),
        .CE(rvalid_int00_out__0),
        .D(\rdata_int[9]_i_1_n_0 ),
        .Q(S_AXI_RDATA[9]),
        .R(clear));
  LUT3 #(
    .INIT(8'h08)) 
    rvalid_int00_out
       (.I0(S_AXI_ARVALID),
        .I1(S_AXI_ARREADY),
        .I2(rvalid_int_reg_0),
        .O(rvalid_int00_out__0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h08F8)) 
    rvalid_int_i_1
       (.I0(S_AXI_ARREADY),
        .I1(S_AXI_ARVALID),
        .I2(rvalid_int_reg_0),
        .I3(S_AXI_RREADY),
        .O(rvalid_int_i_1_n_0));
  FDRE rvalid_int_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(rvalid_int_i_1_n_0),
        .Q(rvalid_int_reg_0),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h08)) 
    wready_int_i_1
       (.I0(S_AXI_WVALID),
        .I1(S_AXI_AWVALID),
        .I2(S_AXI_WREADY),
        .O(wready_int0));
  FDRE wready_int_reg
       (.C(S_AXI_ACLK),
        .CE(1'b1),
        .D(wready_int0),
        .Q(S_AXI_WREADY),
        .R(clear));
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
