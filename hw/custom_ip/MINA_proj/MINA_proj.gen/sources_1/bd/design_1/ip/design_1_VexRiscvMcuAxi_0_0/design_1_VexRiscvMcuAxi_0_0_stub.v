// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
// Date        : Wed Nov 18 00:26:52 2026
// Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
// Command     : write_verilog -force -mode synth_stub
//               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_VexRiscvMcuAxi_0_0/design_1_VexRiscvMcuAxi_0_0_stub.v
// Design      : design_1_VexRiscvMcuAxi_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_VexRiscvMcuAxi_0_0,VexRiscvMcuAxi,{}" *) (* CORE_GENERATION_INFO = "design_1_VexRiscvMcuAxi_0_0,VexRiscvMcuAxi,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=VexRiscvMcuAxi,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "VexRiscvMcuAxi,Vivado 2025.2" *) 
module design_1_VexRiscvMcuAxi_0_0(timerInterrupt, externalInterrupt, 
  softwareInterrupt, iBusAxi_arvalid, iBusAxi_arready, iBusAxi_araddr, iBusAxi_arid, 
  iBusAxi_arregion, iBusAxi_arlen, iBusAxi_arsize, iBusAxi_arburst, iBusAxi_arlock, 
  iBusAxi_arcache, iBusAxi_arqos, iBusAxi_arprot, iBusAxi_rvalid, iBusAxi_rready, 
  iBusAxi_rdata, iBusAxi_rid, iBusAxi_rresp, iBusAxi_rlast, dBusAxi_awvalid, dBusAxi_awready, 
  dBusAxi_awaddr, dBusAxi_awid, dBusAxi_awregion, dBusAxi_awlen, dBusAxi_awsize, 
  dBusAxi_awburst, dBusAxi_awlock, dBusAxi_awcache, dBusAxi_awqos, dBusAxi_awprot, 
  dBusAxi_wvalid, dBusAxi_wready, dBusAxi_wdata, dBusAxi_wstrb, dBusAxi_wlast, 
  dBusAxi_bvalid, dBusAxi_bready, dBusAxi_bid, dBusAxi_bresp, dBusAxi_arvalid, 
  dBusAxi_arready, dBusAxi_araddr, dBusAxi_arid, dBusAxi_arregion, dBusAxi_arlen, 
  dBusAxi_arsize, dBusAxi_arburst, dBusAxi_arlock, dBusAxi_arcache, dBusAxi_arqos, 
  dBusAxi_arprot, dBusAxi_rvalid, dBusAxi_rready, dBusAxi_rdata, dBusAxi_rid, dBusAxi_rresp, 
  dBusAxi_rlast, clk, reset)
/* synthesis syn_black_box black_box_pad_pin="timerInterrupt,externalInterrupt,softwareInterrupt,iBusAxi_arvalid,iBusAxi_arready,iBusAxi_araddr[31:0],iBusAxi_arid[0:0],iBusAxi_arregion[3:0],iBusAxi_arlen[7:0],iBusAxi_arsize[2:0],iBusAxi_arburst[1:0],iBusAxi_arlock[0:0],iBusAxi_arcache[3:0],iBusAxi_arqos[3:0],iBusAxi_arprot[2:0],iBusAxi_rvalid,iBusAxi_rready,iBusAxi_rdata[31:0],iBusAxi_rid[0:0],iBusAxi_rresp[1:0],iBusAxi_rlast,dBusAxi_awvalid,dBusAxi_awready,dBusAxi_awaddr[31:0],dBusAxi_awid[0:0],dBusAxi_awregion[3:0],dBusAxi_awlen[7:0],dBusAxi_awsize[2:0],dBusAxi_awburst[1:0],dBusAxi_awlock[0:0],dBusAxi_awcache[3:0],dBusAxi_awqos[3:0],dBusAxi_awprot[2:0],dBusAxi_wvalid,dBusAxi_wready,dBusAxi_wdata[31:0],dBusAxi_wstrb[3:0],dBusAxi_wlast,dBusAxi_bvalid,dBusAxi_bready,dBusAxi_bid[0:0],dBusAxi_bresp[1:0],dBusAxi_arvalid,dBusAxi_arready,dBusAxi_araddr[31:0],dBusAxi_arid[0:0],dBusAxi_arregion[3:0],dBusAxi_arlen[7:0],dBusAxi_arsize[2:0],dBusAxi_arburst[1:0],dBusAxi_arlock[0:0],dBusAxi_arcache[3:0],dBusAxi_arqos[3:0],dBusAxi_arprot[2:0],dBusAxi_rvalid,dBusAxi_rready,dBusAxi_rdata[31:0],dBusAxi_rid[0:0],dBusAxi_rresp[1:0],dBusAxi_rlast,reset" */
/* synthesis syn_force_seq_prim="clk" */;
  input timerInterrupt;
  input externalInterrupt;
  input softwareInterrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARVALID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME iBusAxi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 1, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output iBusAxi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARREADY" *) input iBusAxi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARADDR" *) output [31:0]iBusAxi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARID" *) output [0:0]iBusAxi_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARREGION" *) output [3:0]iBusAxi_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARLEN" *) output [7:0]iBusAxi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARSIZE" *) output [2:0]iBusAxi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARBURST" *) output [1:0]iBusAxi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARLOCK" *) output [0:0]iBusAxi_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARCACHE" *) output [3:0]iBusAxi_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARQOS" *) output [3:0]iBusAxi_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi ARPROT" *) output [2:0]iBusAxi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RVALID" *) input iBusAxi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RREADY" *) output iBusAxi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RDATA" *) input [31:0]iBusAxi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RID" *) input [0:0]iBusAxi_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RRESP" *) input [1:0]iBusAxi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 iBusAxi RLAST" *) input iBusAxi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWVALID" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dBusAxi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 1, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output dBusAxi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWREADY" *) input dBusAxi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWADDR" *) output [31:0]dBusAxi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWID" *) output [0:0]dBusAxi_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWREGION" *) output [3:0]dBusAxi_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWLEN" *) output [7:0]dBusAxi_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWSIZE" *) output [2:0]dBusAxi_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWBURST" *) output [1:0]dBusAxi_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWLOCK" *) output [0:0]dBusAxi_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWCACHE" *) output [3:0]dBusAxi_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWQOS" *) output [3:0]dBusAxi_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi AWPROT" *) output [2:0]dBusAxi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi WVALID" *) output dBusAxi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi WREADY" *) input dBusAxi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi WDATA" *) output [31:0]dBusAxi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi WSTRB" *) output [3:0]dBusAxi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi WLAST" *) output dBusAxi_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi BVALID" *) input dBusAxi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi BREADY" *) output dBusAxi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi BID" *) input [0:0]dBusAxi_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi BRESP" *) input [1:0]dBusAxi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARVALID" *) output dBusAxi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARREADY" *) input dBusAxi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARADDR" *) output [31:0]dBusAxi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARID" *) output [0:0]dBusAxi_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARREGION" *) output [3:0]dBusAxi_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARLEN" *) output [7:0]dBusAxi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARSIZE" *) output [2:0]dBusAxi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARBURST" *) output [1:0]dBusAxi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARLOCK" *) output [0:0]dBusAxi_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARCACHE" *) output [3:0]dBusAxi_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARQOS" *) output [3:0]dBusAxi_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi ARPROT" *) output [2:0]dBusAxi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RVALID" *) input dBusAxi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RREADY" *) output dBusAxi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RDATA" *) input [31:0]dBusAxi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RID" *) input [0:0]dBusAxi_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RRESP" *) input [1:0]dBusAxi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dBusAxi RLAST" *) input dBusAxi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF dBusAxi:iBusAxi, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset;
endmodule
