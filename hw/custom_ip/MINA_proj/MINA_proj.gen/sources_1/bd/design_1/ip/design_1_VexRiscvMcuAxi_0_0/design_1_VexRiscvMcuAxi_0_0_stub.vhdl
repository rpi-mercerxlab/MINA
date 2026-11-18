-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Wed Nov 18 00:26:52 2026
-- Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_VexRiscvMcuAxi_0_0/design_1_VexRiscvMcuAxi_0_0_stub.vhdl
-- Design      : design_1_VexRiscvMcuAxi_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s50csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_VexRiscvMcuAxi_0_0 is
  Port ( 
    timerInterrupt : in STD_LOGIC;
    externalInterrupt : in STD_LOGIC;
    softwareInterrupt : in STD_LOGIC;
    iBusAxi_arvalid : out STD_LOGIC;
    iBusAxi_arready : in STD_LOGIC;
    iBusAxi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    iBusAxi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    iBusAxi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    iBusAxi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    iBusAxi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    iBusAxi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    iBusAxi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    iBusAxi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    iBusAxi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    iBusAxi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    iBusAxi_rvalid : in STD_LOGIC;
    iBusAxi_rready : out STD_LOGIC;
    iBusAxi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    iBusAxi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    iBusAxi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    iBusAxi_rlast : in STD_LOGIC;
    dBusAxi_awvalid : out STD_LOGIC;
    dBusAxi_awready : in STD_LOGIC;
    dBusAxi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dBusAxi_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dBusAxi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    dBusAxi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dBusAxi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    dBusAxi_wvalid : out STD_LOGIC;
    dBusAxi_wready : in STD_LOGIC;
    dBusAxi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dBusAxi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_wlast : out STD_LOGIC;
    dBusAxi_bvalid : in STD_LOGIC;
    dBusAxi_bready : out STD_LOGIC;
    dBusAxi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    dBusAxi_arvalid : out STD_LOGIC;
    dBusAxi_arready : in STD_LOGIC;
    dBusAxi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dBusAxi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dBusAxi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    dBusAxi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    dBusAxi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dBusAxi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    dBusAxi_rvalid : in STD_LOGIC;
    dBusAxi_rready : out STD_LOGIC;
    dBusAxi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dBusAxi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    dBusAxi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    dBusAxi_rlast : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_VexRiscvMcuAxi_0_0 : entity is "design_1_VexRiscvMcuAxi_0_0,VexRiscvMcuAxi,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1_VexRiscvMcuAxi_0_0 : entity is "design_1_VexRiscvMcuAxi_0_0,VexRiscvMcuAxi,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=VexRiscvMcuAxi,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_VexRiscvMcuAxi_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_VexRiscvMcuAxi_0_0 : entity is "module_ref";
end design_1_VexRiscvMcuAxi_0_0;

architecture stub of design_1_VexRiscvMcuAxi_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "timerInterrupt,externalInterrupt,softwareInterrupt,iBusAxi_arvalid,iBusAxi_arready,iBusAxi_araddr[31:0],iBusAxi_arid[0:0],iBusAxi_arregion[3:0],iBusAxi_arlen[7:0],iBusAxi_arsize[2:0],iBusAxi_arburst[1:0],iBusAxi_arlock[0:0],iBusAxi_arcache[3:0],iBusAxi_arqos[3:0],iBusAxi_arprot[2:0],iBusAxi_rvalid,iBusAxi_rready,iBusAxi_rdata[31:0],iBusAxi_rid[0:0],iBusAxi_rresp[1:0],iBusAxi_rlast,dBusAxi_awvalid,dBusAxi_awready,dBusAxi_awaddr[31:0],dBusAxi_awid[0:0],dBusAxi_awregion[3:0],dBusAxi_awlen[7:0],dBusAxi_awsize[2:0],dBusAxi_awburst[1:0],dBusAxi_awlock[0:0],dBusAxi_awcache[3:0],dBusAxi_awqos[3:0],dBusAxi_awprot[2:0],dBusAxi_wvalid,dBusAxi_wready,dBusAxi_wdata[31:0],dBusAxi_wstrb[3:0],dBusAxi_wlast,dBusAxi_bvalid,dBusAxi_bready,dBusAxi_bid[0:0],dBusAxi_bresp[1:0],dBusAxi_arvalid,dBusAxi_arready,dBusAxi_araddr[31:0],dBusAxi_arid[0:0],dBusAxi_arregion[3:0],dBusAxi_arlen[7:0],dBusAxi_arsize[2:0],dBusAxi_arburst[1:0],dBusAxi_arlock[0:0],dBusAxi_arcache[3:0],dBusAxi_arqos[3:0],dBusAxi_arprot[2:0],dBusAxi_rvalid,dBusAxi_rready,dBusAxi_rdata[31:0],dBusAxi_rid[0:0],dBusAxi_rresp[1:0],dBusAxi_rlast,clk,reset";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of iBusAxi_arvalid : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARVALID";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of iBusAxi_arvalid : signal is "master";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of iBusAxi_arvalid : signal is "XIL_INTERFACENAME iBusAxi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 1, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of iBusAxi_arready : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARREADY";
  attribute X_INTERFACE_INFO of iBusAxi_araddr : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARADDR";
  attribute X_INTERFACE_INFO of iBusAxi_arid : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARID";
  attribute X_INTERFACE_INFO of iBusAxi_arregion : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARREGION";
  attribute X_INTERFACE_INFO of iBusAxi_arlen : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARLEN";
  attribute X_INTERFACE_INFO of iBusAxi_arsize : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARSIZE";
  attribute X_INTERFACE_INFO of iBusAxi_arburst : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARBURST";
  attribute X_INTERFACE_INFO of iBusAxi_arlock : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARLOCK";
  attribute X_INTERFACE_INFO of iBusAxi_arcache : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARCACHE";
  attribute X_INTERFACE_INFO of iBusAxi_arqos : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARQOS";
  attribute X_INTERFACE_INFO of iBusAxi_arprot : signal is "xilinx.com:interface:aximm:1.0 iBusAxi ARPROT";
  attribute X_INTERFACE_INFO of iBusAxi_rvalid : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RVALID";
  attribute X_INTERFACE_INFO of iBusAxi_rready : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RREADY";
  attribute X_INTERFACE_INFO of iBusAxi_rdata : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RDATA";
  attribute X_INTERFACE_INFO of iBusAxi_rid : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RID";
  attribute X_INTERFACE_INFO of iBusAxi_rresp : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RRESP";
  attribute X_INTERFACE_INFO of iBusAxi_rlast : signal is "xilinx.com:interface:aximm:1.0 iBusAxi RLAST";
  attribute X_INTERFACE_INFO of dBusAxi_awvalid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWVALID";
  attribute X_INTERFACE_MODE of dBusAxi_awvalid : signal is "master";
  attribute X_INTERFACE_PARAMETER of dBusAxi_awvalid : signal is "XIL_INTERFACENAME dBusAxi, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 1, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of dBusAxi_awready : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWREADY";
  attribute X_INTERFACE_INFO of dBusAxi_awaddr : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWADDR";
  attribute X_INTERFACE_INFO of dBusAxi_awid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWID";
  attribute X_INTERFACE_INFO of dBusAxi_awregion : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWREGION";
  attribute X_INTERFACE_INFO of dBusAxi_awlen : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWLEN";
  attribute X_INTERFACE_INFO of dBusAxi_awsize : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWSIZE";
  attribute X_INTERFACE_INFO of dBusAxi_awburst : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWBURST";
  attribute X_INTERFACE_INFO of dBusAxi_awlock : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWLOCK";
  attribute X_INTERFACE_INFO of dBusAxi_awcache : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWCACHE";
  attribute X_INTERFACE_INFO of dBusAxi_awqos : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWQOS";
  attribute X_INTERFACE_INFO of dBusAxi_awprot : signal is "xilinx.com:interface:aximm:1.0 dBusAxi AWPROT";
  attribute X_INTERFACE_INFO of dBusAxi_wvalid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi WVALID";
  attribute X_INTERFACE_INFO of dBusAxi_wready : signal is "xilinx.com:interface:aximm:1.0 dBusAxi WREADY";
  attribute X_INTERFACE_INFO of dBusAxi_wdata : signal is "xilinx.com:interface:aximm:1.0 dBusAxi WDATA";
  attribute X_INTERFACE_INFO of dBusAxi_wstrb : signal is "xilinx.com:interface:aximm:1.0 dBusAxi WSTRB";
  attribute X_INTERFACE_INFO of dBusAxi_wlast : signal is "xilinx.com:interface:aximm:1.0 dBusAxi WLAST";
  attribute X_INTERFACE_INFO of dBusAxi_bvalid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi BVALID";
  attribute X_INTERFACE_INFO of dBusAxi_bready : signal is "xilinx.com:interface:aximm:1.0 dBusAxi BREADY";
  attribute X_INTERFACE_INFO of dBusAxi_bid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi BID";
  attribute X_INTERFACE_INFO of dBusAxi_bresp : signal is "xilinx.com:interface:aximm:1.0 dBusAxi BRESP";
  attribute X_INTERFACE_INFO of dBusAxi_arvalid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARVALID";
  attribute X_INTERFACE_INFO of dBusAxi_arready : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARREADY";
  attribute X_INTERFACE_INFO of dBusAxi_araddr : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARADDR";
  attribute X_INTERFACE_INFO of dBusAxi_arid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARID";
  attribute X_INTERFACE_INFO of dBusAxi_arregion : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARREGION";
  attribute X_INTERFACE_INFO of dBusAxi_arlen : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARLEN";
  attribute X_INTERFACE_INFO of dBusAxi_arsize : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARSIZE";
  attribute X_INTERFACE_INFO of dBusAxi_arburst : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARBURST";
  attribute X_INTERFACE_INFO of dBusAxi_arlock : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARLOCK";
  attribute X_INTERFACE_INFO of dBusAxi_arcache : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARCACHE";
  attribute X_INTERFACE_INFO of dBusAxi_arqos : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARQOS";
  attribute X_INTERFACE_INFO of dBusAxi_arprot : signal is "xilinx.com:interface:aximm:1.0 dBusAxi ARPROT";
  attribute X_INTERFACE_INFO of dBusAxi_rvalid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RVALID";
  attribute X_INTERFACE_INFO of dBusAxi_rready : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RREADY";
  attribute X_INTERFACE_INFO of dBusAxi_rdata : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RDATA";
  attribute X_INTERFACE_INFO of dBusAxi_rid : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RID";
  attribute X_INTERFACE_INFO of dBusAxi_rresp : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RRESP";
  attribute X_INTERFACE_INFO of dBusAxi_rlast : signal is "xilinx.com:interface:aximm:1.0 dBusAxi RLAST";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF dBusAxi:iBusAxi, ASSOCIATED_RESET reset, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute X_INTERFACE_MODE of reset : signal is "slave";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "VexRiscvMcuAxi,Vivado 2025.2";
begin
end;
