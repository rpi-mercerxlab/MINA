-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (lin64) Build 6299465 Fri Nov 14 12:34:56 MST 2025
-- Date        : Mon Nov 16 09:45:32 2026
-- Host        : ryan-21k8s14n00 running 64-bit EndeavourOS Linux
-- Command     : write_vhdl -force -mode funcsim
--               /home/ryanb/Documents/MINA/hw/custom_ip/MINA_proj/MINA_proj.gen/sources_1/bd/design_1/ip/design_1_axil_timer_64_0_0/design_1_axil_timer_64_0_0_sim_netlist.vhdl
-- Design      : design_1_axil_timer_64_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s50csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axil_timer_64_0_0_axil_timer_64 is
  port (
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rvalid_int_reg_0 : out STD_LOGIC;
    IRQ : out STD_LOGIC;
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_ARESETN : in STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_axil_timer_64_0_0_axil_timer_64 : entity is "axil_timer_64";
end design_1_axil_timer_64_0_0_axil_timer_64;

architecture STRUCTURE of design_1_axil_timer_64_0_0_axil_timer_64 is
  signal \IRQ0_carry__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__0_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__0_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__0_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__1_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__1_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__1_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__2_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__2_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__2_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__3_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__3_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__3_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__4_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__4_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__4_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry__5_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__5_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__5_n_3\ : STD_LOGIC;
  signal \IRQ0_carry__6_n_1\ : STD_LOGIC;
  signal \IRQ0_carry__6_n_2\ : STD_LOGIC;
  signal \IRQ0_carry__6_n_3\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_1__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_1_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_2__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_2__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_2_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_3__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_3__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_3_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_4__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_4__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_4_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_5__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_5__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_5_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_6__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_6__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_6_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_7__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_7__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_7_n_0 : STD_LOGIC;
  signal \IRQ0_carry_i_8__0_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__1_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__2_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__3_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__4_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__5_n_0\ : STD_LOGIC;
  signal \IRQ0_carry_i_8__6_n_0\ : STD_LOGIC;
  signal IRQ0_carry_i_8_n_0 : STD_LOGIC;
  signal IRQ0_carry_n_0 : STD_LOGIC;
  signal IRQ0_carry_n_1 : STD_LOGIC;
  signal IRQ0_carry_n_2 : STD_LOGIC;
  signal IRQ0_carry_n_3 : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  signal arready_int0 : STD_LOGIC;
  signal awready_int0 : STD_LOGIC;
  signal bvalid_int_i_1_n_0 : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal \clock_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[32]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[36]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[40]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[44]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[48]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[52]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[56]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[60]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \clock_reg_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[10]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[11]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[12]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[13]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[14]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[15]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[16]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[17]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[18]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[19]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[20]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[21]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[22]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[23]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[24]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[25]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[26]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[27]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[28]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[29]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[30]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[31]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[4]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[5]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[6]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[7]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[8]\ : STD_LOGIC;
  signal \clock_reg_reg_n_0_[9]\ : STD_LOGIC;
  signal clock_snap_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal clock_snap_reg_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal compare_reg : STD_LOGIC_VECTOR ( 63 downto 31 );
  signal \compare_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[10]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[11]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[12]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[13]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[14]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[15]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[16]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[17]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[18]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[19]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[20]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[21]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[22]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[23]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[24]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[25]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[26]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[27]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[28]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[29]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[30]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[31]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[32]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[33]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[34]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[35]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[36]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[37]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[38]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[39]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[40]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[41]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[42]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[43]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[44]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[45]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[46]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[47]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[48]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[49]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[4]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[50]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[51]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[52]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[53]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[54]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[55]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[56]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[57]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[58]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[59]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[5]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[60]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[61]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[62]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[63]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[6]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[7]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[8]\ : STD_LOGIC;
  signal \compare_reg_reg_n_0_[9]\ : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \rdata_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[10]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[11]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[12]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[13]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[14]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[15]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[16]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[17]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[18]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[19]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[1]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[20]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[21]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[22]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[23]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[24]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[25]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[26]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[27]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[28]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[29]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[2]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[30]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[31]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[3]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[4]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[5]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[6]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[7]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[8]_i_1_n_0\ : STD_LOGIC;
  signal \rdata_int[9]_i_1_n_0\ : STD_LOGIC;
  signal \rvalid_int00_out__0\ : STD_LOGIC;
  signal rvalid_int_i_1_n_0 : STD_LOGIC;
  signal \^rvalid_int_reg_0\ : STD_LOGIC;
  signal wready_int0 : STD_LOGIC;
  signal NLW_IRQ0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_IRQ0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_clock_reg_reg[60]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of IRQ0_carry : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__0\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__1\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__2\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__3\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__4\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__5\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \IRQ0_carry__6\ : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of arready_int_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of awready_int_i_2 : label is "soft_lutpair1";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \clock_reg_reg[0]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[12]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[16]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[20]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[24]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[28]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[32]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[36]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[40]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[44]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[48]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[4]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[52]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[56]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[60]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \clock_reg_reg[8]_i_1\ : label is 35;
  attribute SOFT_HLUTNM of rvalid_int_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of wready_int_i_1 : label is "soft_lutpair1";
begin
  S_AXI_ARREADY <= \^s_axi_arready\;
  S_AXI_AWREADY <= \^s_axi_awready\;
  S_AXI_BVALID <= \^s_axi_bvalid\;
  S_AXI_WREADY <= \^s_axi_wready\;
  rvalid_int_reg_0 <= \^rvalid_int_reg_0\;
IRQ0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => IRQ0_carry_n_0,
      CO(2) => IRQ0_carry_n_1,
      CO(1) => IRQ0_carry_n_2,
      CO(0) => IRQ0_carry_n_3,
      CYINIT => '0',
      DI(3) => IRQ0_carry_i_1_n_0,
      DI(2) => IRQ0_carry_i_2_n_0,
      DI(1) => IRQ0_carry_i_3_n_0,
      DI(0) => IRQ0_carry_i_4_n_0,
      O(3 downto 0) => NLW_IRQ0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => IRQ0_carry_i_5_n_0,
      S(2) => IRQ0_carry_i_6_n_0,
      S(1) => IRQ0_carry_i_7_n_0,
      S(0) => IRQ0_carry_i_8_n_0
    );
\IRQ0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => IRQ0_carry_n_0,
      CO(3) => \IRQ0_carry__0_n_0\,
      CO(2) => \IRQ0_carry__0_n_1\,
      CO(1) => \IRQ0_carry__0_n_2\,
      CO(0) => \IRQ0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__0_n_0\,
      DI(2) => \IRQ0_carry_i_2__0_n_0\,
      DI(1) => \IRQ0_carry_i_3__0_n_0\,
      DI(0) => \IRQ0_carry_i_4__0_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__0_n_0\,
      S(2) => \IRQ0_carry_i_6__0_n_0\,
      S(1) => \IRQ0_carry_i_7__0_n_0\,
      S(0) => \IRQ0_carry_i_8__0_n_0\
    );
\IRQ0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__0_n_0\,
      CO(3) => \IRQ0_carry__1_n_0\,
      CO(2) => \IRQ0_carry__1_n_1\,
      CO(1) => \IRQ0_carry__1_n_2\,
      CO(0) => \IRQ0_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__1_n_0\,
      DI(2) => \IRQ0_carry_i_2__1_n_0\,
      DI(1) => \IRQ0_carry_i_3__1_n_0\,
      DI(0) => \IRQ0_carry_i_4__1_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__1_n_0\,
      S(2) => \IRQ0_carry_i_6__1_n_0\,
      S(1) => \IRQ0_carry_i_7__1_n_0\,
      S(0) => \IRQ0_carry_i_8__1_n_0\
    );
\IRQ0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__1_n_0\,
      CO(3) => \IRQ0_carry__2_n_0\,
      CO(2) => \IRQ0_carry__2_n_1\,
      CO(1) => \IRQ0_carry__2_n_2\,
      CO(0) => \IRQ0_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__2_n_0\,
      DI(2) => \IRQ0_carry_i_2__2_n_0\,
      DI(1) => \IRQ0_carry_i_3__2_n_0\,
      DI(0) => \IRQ0_carry_i_4__2_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__2_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__2_n_0\,
      S(2) => \IRQ0_carry_i_6__2_n_0\,
      S(1) => \IRQ0_carry_i_7__2_n_0\,
      S(0) => \IRQ0_carry_i_8__2_n_0\
    );
\IRQ0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__2_n_0\,
      CO(3) => \IRQ0_carry__3_n_0\,
      CO(2) => \IRQ0_carry__3_n_1\,
      CO(1) => \IRQ0_carry__3_n_2\,
      CO(0) => \IRQ0_carry__3_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__3_n_0\,
      DI(2) => \IRQ0_carry_i_2__3_n_0\,
      DI(1) => \IRQ0_carry_i_3__3_n_0\,
      DI(0) => \IRQ0_carry_i_4__3_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__3_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__3_n_0\,
      S(2) => \IRQ0_carry_i_6__3_n_0\,
      S(1) => \IRQ0_carry_i_7__3_n_0\,
      S(0) => \IRQ0_carry_i_8__3_n_0\
    );
\IRQ0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__3_n_0\,
      CO(3) => \IRQ0_carry__4_n_0\,
      CO(2) => \IRQ0_carry__4_n_1\,
      CO(1) => \IRQ0_carry__4_n_2\,
      CO(0) => \IRQ0_carry__4_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__4_n_0\,
      DI(2) => \IRQ0_carry_i_2__4_n_0\,
      DI(1) => \IRQ0_carry_i_3__4_n_0\,
      DI(0) => \IRQ0_carry_i_4__4_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__4_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__4_n_0\,
      S(2) => \IRQ0_carry_i_6__4_n_0\,
      S(1) => \IRQ0_carry_i_7__4_n_0\,
      S(0) => \IRQ0_carry_i_8__4_n_0\
    );
\IRQ0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__4_n_0\,
      CO(3) => \IRQ0_carry__5_n_0\,
      CO(2) => \IRQ0_carry__5_n_1\,
      CO(1) => \IRQ0_carry__5_n_2\,
      CO(0) => \IRQ0_carry__5_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__5_n_0\,
      DI(2) => \IRQ0_carry_i_2__5_n_0\,
      DI(1) => \IRQ0_carry_i_3__5_n_0\,
      DI(0) => \IRQ0_carry_i_4__5_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__5_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__5_n_0\,
      S(2) => \IRQ0_carry_i_6__5_n_0\,
      S(1) => \IRQ0_carry_i_7__5_n_0\,
      S(0) => \IRQ0_carry_i_8__5_n_0\
    );
\IRQ0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \IRQ0_carry__5_n_0\,
      CO(3) => IRQ,
      CO(2) => \IRQ0_carry__6_n_1\,
      CO(1) => \IRQ0_carry__6_n_2\,
      CO(0) => \IRQ0_carry__6_n_3\,
      CYINIT => '0',
      DI(3) => \IRQ0_carry_i_1__6_n_0\,
      DI(2) => \IRQ0_carry_i_2__6_n_0\,
      DI(1) => \IRQ0_carry_i_3__6_n_0\,
      DI(0) => \IRQ0_carry_i_4__6_n_0\,
      O(3 downto 0) => \NLW_IRQ0_carry__6_O_UNCONNECTED\(3 downto 0),
      S(3) => \IRQ0_carry_i_5__6_n_0\,
      S(2) => \IRQ0_carry_i_6__6_n_0\,
      S(1) => \IRQ0_carry_i_7__6_n_0\,
      S(0) => \IRQ0_carry_i_8__6_n_0\
    );
IRQ0_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[6]\,
      I1 => \compare_reg_reg_n_0_[6]\,
      I2 => \compare_reg_reg_n_0_[7]\,
      I3 => \clock_reg_reg_n_0_[7]\,
      O => IRQ0_carry_i_1_n_0
    );
\IRQ0_carry_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[14]\,
      I1 => \compare_reg_reg_n_0_[14]\,
      I2 => \compare_reg_reg_n_0_[15]\,
      I3 => \clock_reg_reg_n_0_[15]\,
      O => \IRQ0_carry_i_1__0_n_0\
    );
\IRQ0_carry_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[22]\,
      I1 => \compare_reg_reg_n_0_[22]\,
      I2 => \compare_reg_reg_n_0_[23]\,
      I3 => \clock_reg_reg_n_0_[23]\,
      O => \IRQ0_carry_i_1__1_n_0\
    );
\IRQ0_carry_i_1__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[30]\,
      I1 => \compare_reg_reg_n_0_[30]\,
      I2 => \compare_reg_reg_n_0_[31]\,
      I3 => \clock_reg_reg_n_0_[31]\,
      O => \IRQ0_carry_i_1__2_n_0\
    );
\IRQ0_carry_i_1__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(6),
      I1 => \compare_reg_reg_n_0_[38]\,
      I2 => \compare_reg_reg_n_0_[39]\,
      I3 => p_1_in(7),
      O => \IRQ0_carry_i_1__3_n_0\
    );
\IRQ0_carry_i_1__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(14),
      I1 => \compare_reg_reg_n_0_[46]\,
      I2 => \compare_reg_reg_n_0_[47]\,
      I3 => p_1_in(15),
      O => \IRQ0_carry_i_1__4_n_0\
    );
\IRQ0_carry_i_1__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(22),
      I1 => \compare_reg_reg_n_0_[54]\,
      I2 => \compare_reg_reg_n_0_[55]\,
      I3 => p_1_in(23),
      O => \IRQ0_carry_i_1__5_n_0\
    );
\IRQ0_carry_i_1__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(30),
      I1 => \compare_reg_reg_n_0_[62]\,
      I2 => \compare_reg_reg_n_0_[63]\,
      I3 => p_1_in(31),
      O => \IRQ0_carry_i_1__6_n_0\
    );
IRQ0_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[4]\,
      I1 => \compare_reg_reg_n_0_[4]\,
      I2 => \compare_reg_reg_n_0_[5]\,
      I3 => \clock_reg_reg_n_0_[5]\,
      O => IRQ0_carry_i_2_n_0
    );
\IRQ0_carry_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[12]\,
      I1 => \compare_reg_reg_n_0_[12]\,
      I2 => \compare_reg_reg_n_0_[13]\,
      I3 => \clock_reg_reg_n_0_[13]\,
      O => \IRQ0_carry_i_2__0_n_0\
    );
\IRQ0_carry_i_2__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[20]\,
      I1 => \compare_reg_reg_n_0_[20]\,
      I2 => \compare_reg_reg_n_0_[21]\,
      I3 => \clock_reg_reg_n_0_[21]\,
      O => \IRQ0_carry_i_2__1_n_0\
    );
\IRQ0_carry_i_2__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[28]\,
      I1 => \compare_reg_reg_n_0_[28]\,
      I2 => \compare_reg_reg_n_0_[29]\,
      I3 => \clock_reg_reg_n_0_[29]\,
      O => \IRQ0_carry_i_2__2_n_0\
    );
\IRQ0_carry_i_2__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(4),
      I1 => \compare_reg_reg_n_0_[36]\,
      I2 => \compare_reg_reg_n_0_[37]\,
      I3 => p_1_in(5),
      O => \IRQ0_carry_i_2__3_n_0\
    );
\IRQ0_carry_i_2__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(12),
      I1 => \compare_reg_reg_n_0_[44]\,
      I2 => \compare_reg_reg_n_0_[45]\,
      I3 => p_1_in(13),
      O => \IRQ0_carry_i_2__4_n_0\
    );
\IRQ0_carry_i_2__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(20),
      I1 => \compare_reg_reg_n_0_[52]\,
      I2 => \compare_reg_reg_n_0_[53]\,
      I3 => p_1_in(21),
      O => \IRQ0_carry_i_2__5_n_0\
    );
\IRQ0_carry_i_2__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(28),
      I1 => \compare_reg_reg_n_0_[60]\,
      I2 => \compare_reg_reg_n_0_[61]\,
      I3 => p_1_in(29),
      O => \IRQ0_carry_i_2__6_n_0\
    );
IRQ0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[2]\,
      I1 => \compare_reg_reg_n_0_[2]\,
      I2 => \compare_reg_reg_n_0_[3]\,
      I3 => \clock_reg_reg_n_0_[3]\,
      O => IRQ0_carry_i_3_n_0
    );
\IRQ0_carry_i_3__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[10]\,
      I1 => \compare_reg_reg_n_0_[10]\,
      I2 => \compare_reg_reg_n_0_[11]\,
      I3 => \clock_reg_reg_n_0_[11]\,
      O => \IRQ0_carry_i_3__0_n_0\
    );
\IRQ0_carry_i_3__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[18]\,
      I1 => \compare_reg_reg_n_0_[18]\,
      I2 => \compare_reg_reg_n_0_[19]\,
      I3 => \clock_reg_reg_n_0_[19]\,
      O => \IRQ0_carry_i_3__1_n_0\
    );
\IRQ0_carry_i_3__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[26]\,
      I1 => \compare_reg_reg_n_0_[26]\,
      I2 => \compare_reg_reg_n_0_[27]\,
      I3 => \clock_reg_reg_n_0_[27]\,
      O => \IRQ0_carry_i_3__2_n_0\
    );
\IRQ0_carry_i_3__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(2),
      I1 => \compare_reg_reg_n_0_[34]\,
      I2 => \compare_reg_reg_n_0_[35]\,
      I3 => p_1_in(3),
      O => \IRQ0_carry_i_3__3_n_0\
    );
\IRQ0_carry_i_3__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(10),
      I1 => \compare_reg_reg_n_0_[42]\,
      I2 => \compare_reg_reg_n_0_[43]\,
      I3 => p_1_in(11),
      O => \IRQ0_carry_i_3__4_n_0\
    );
\IRQ0_carry_i_3__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(18),
      I1 => \compare_reg_reg_n_0_[50]\,
      I2 => \compare_reg_reg_n_0_[51]\,
      I3 => p_1_in(19),
      O => \IRQ0_carry_i_3__5_n_0\
    );
\IRQ0_carry_i_3__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(26),
      I1 => \compare_reg_reg_n_0_[58]\,
      I2 => \compare_reg_reg_n_0_[59]\,
      I3 => p_1_in(27),
      O => \IRQ0_carry_i_3__6_n_0\
    );
IRQ0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[0]\,
      I1 => \compare_reg_reg_n_0_[0]\,
      I2 => \compare_reg_reg_n_0_[1]\,
      I3 => \clock_reg_reg_n_0_[1]\,
      O => IRQ0_carry_i_4_n_0
    );
\IRQ0_carry_i_4__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[8]\,
      I1 => \compare_reg_reg_n_0_[8]\,
      I2 => \compare_reg_reg_n_0_[9]\,
      I3 => \clock_reg_reg_n_0_[9]\,
      O => \IRQ0_carry_i_4__0_n_0\
    );
\IRQ0_carry_i_4__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[16]\,
      I1 => \compare_reg_reg_n_0_[16]\,
      I2 => \compare_reg_reg_n_0_[17]\,
      I3 => \clock_reg_reg_n_0_[17]\,
      O => \IRQ0_carry_i_4__1_n_0\
    );
\IRQ0_carry_i_4__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[24]\,
      I1 => \compare_reg_reg_n_0_[24]\,
      I2 => \compare_reg_reg_n_0_[25]\,
      I3 => \clock_reg_reg_n_0_[25]\,
      O => \IRQ0_carry_i_4__2_n_0\
    );
\IRQ0_carry_i_4__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(0),
      I1 => \compare_reg_reg_n_0_[32]\,
      I2 => \compare_reg_reg_n_0_[33]\,
      I3 => p_1_in(1),
      O => \IRQ0_carry_i_4__3_n_0\
    );
\IRQ0_carry_i_4__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(8),
      I1 => \compare_reg_reg_n_0_[40]\,
      I2 => \compare_reg_reg_n_0_[41]\,
      I3 => p_1_in(9),
      O => \IRQ0_carry_i_4__4_n_0\
    );
\IRQ0_carry_i_4__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(16),
      I1 => \compare_reg_reg_n_0_[48]\,
      I2 => \compare_reg_reg_n_0_[49]\,
      I3 => p_1_in(17),
      O => \IRQ0_carry_i_4__5_n_0\
    );
\IRQ0_carry_i_4__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F02"
    )
        port map (
      I0 => p_1_in(24),
      I1 => \compare_reg_reg_n_0_[56]\,
      I2 => \compare_reg_reg_n_0_[57]\,
      I3 => p_1_in(25),
      O => \IRQ0_carry_i_4__6_n_0\
    );
IRQ0_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[6]\,
      I1 => \compare_reg_reg_n_0_[6]\,
      I2 => \clock_reg_reg_n_0_[7]\,
      I3 => \compare_reg_reg_n_0_[7]\,
      O => IRQ0_carry_i_5_n_0
    );
\IRQ0_carry_i_5__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[14]\,
      I1 => \compare_reg_reg_n_0_[14]\,
      I2 => \clock_reg_reg_n_0_[15]\,
      I3 => \compare_reg_reg_n_0_[15]\,
      O => \IRQ0_carry_i_5__0_n_0\
    );
\IRQ0_carry_i_5__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[22]\,
      I1 => \compare_reg_reg_n_0_[22]\,
      I2 => \clock_reg_reg_n_0_[23]\,
      I3 => \compare_reg_reg_n_0_[23]\,
      O => \IRQ0_carry_i_5__1_n_0\
    );
\IRQ0_carry_i_5__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[30]\,
      I1 => \compare_reg_reg_n_0_[30]\,
      I2 => \clock_reg_reg_n_0_[31]\,
      I3 => \compare_reg_reg_n_0_[31]\,
      O => \IRQ0_carry_i_5__2_n_0\
    );
\IRQ0_carry_i_5__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(6),
      I1 => \compare_reg_reg_n_0_[38]\,
      I2 => p_1_in(7),
      I3 => \compare_reg_reg_n_0_[39]\,
      O => \IRQ0_carry_i_5__3_n_0\
    );
\IRQ0_carry_i_5__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(14),
      I1 => \compare_reg_reg_n_0_[46]\,
      I2 => p_1_in(15),
      I3 => \compare_reg_reg_n_0_[47]\,
      O => \IRQ0_carry_i_5__4_n_0\
    );
\IRQ0_carry_i_5__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(22),
      I1 => \compare_reg_reg_n_0_[54]\,
      I2 => p_1_in(23),
      I3 => \compare_reg_reg_n_0_[55]\,
      O => \IRQ0_carry_i_5__5_n_0\
    );
\IRQ0_carry_i_5__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(30),
      I1 => \compare_reg_reg_n_0_[62]\,
      I2 => p_1_in(31),
      I3 => \compare_reg_reg_n_0_[63]\,
      O => \IRQ0_carry_i_5__6_n_0\
    );
IRQ0_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[4]\,
      I1 => \compare_reg_reg_n_0_[4]\,
      I2 => \clock_reg_reg_n_0_[5]\,
      I3 => \compare_reg_reg_n_0_[5]\,
      O => IRQ0_carry_i_6_n_0
    );
\IRQ0_carry_i_6__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[12]\,
      I1 => \compare_reg_reg_n_0_[12]\,
      I2 => \clock_reg_reg_n_0_[13]\,
      I3 => \compare_reg_reg_n_0_[13]\,
      O => \IRQ0_carry_i_6__0_n_0\
    );
\IRQ0_carry_i_6__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[20]\,
      I1 => \compare_reg_reg_n_0_[20]\,
      I2 => \clock_reg_reg_n_0_[21]\,
      I3 => \compare_reg_reg_n_0_[21]\,
      O => \IRQ0_carry_i_6__1_n_0\
    );
\IRQ0_carry_i_6__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[28]\,
      I1 => \compare_reg_reg_n_0_[28]\,
      I2 => \clock_reg_reg_n_0_[29]\,
      I3 => \compare_reg_reg_n_0_[29]\,
      O => \IRQ0_carry_i_6__2_n_0\
    );
\IRQ0_carry_i_6__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(4),
      I1 => \compare_reg_reg_n_0_[36]\,
      I2 => p_1_in(5),
      I3 => \compare_reg_reg_n_0_[37]\,
      O => \IRQ0_carry_i_6__3_n_0\
    );
\IRQ0_carry_i_6__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(12),
      I1 => \compare_reg_reg_n_0_[44]\,
      I2 => p_1_in(13),
      I3 => \compare_reg_reg_n_0_[45]\,
      O => \IRQ0_carry_i_6__4_n_0\
    );
\IRQ0_carry_i_6__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(20),
      I1 => \compare_reg_reg_n_0_[52]\,
      I2 => p_1_in(21),
      I3 => \compare_reg_reg_n_0_[53]\,
      O => \IRQ0_carry_i_6__5_n_0\
    );
\IRQ0_carry_i_6__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(28),
      I1 => \compare_reg_reg_n_0_[60]\,
      I2 => p_1_in(29),
      I3 => \compare_reg_reg_n_0_[61]\,
      O => \IRQ0_carry_i_6__6_n_0\
    );
IRQ0_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[2]\,
      I1 => \compare_reg_reg_n_0_[2]\,
      I2 => \clock_reg_reg_n_0_[3]\,
      I3 => \compare_reg_reg_n_0_[3]\,
      O => IRQ0_carry_i_7_n_0
    );
\IRQ0_carry_i_7__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[10]\,
      I1 => \compare_reg_reg_n_0_[10]\,
      I2 => \clock_reg_reg_n_0_[11]\,
      I3 => \compare_reg_reg_n_0_[11]\,
      O => \IRQ0_carry_i_7__0_n_0\
    );
\IRQ0_carry_i_7__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[18]\,
      I1 => \compare_reg_reg_n_0_[18]\,
      I2 => \clock_reg_reg_n_0_[19]\,
      I3 => \compare_reg_reg_n_0_[19]\,
      O => \IRQ0_carry_i_7__1_n_0\
    );
\IRQ0_carry_i_7__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[26]\,
      I1 => \compare_reg_reg_n_0_[26]\,
      I2 => \clock_reg_reg_n_0_[27]\,
      I3 => \compare_reg_reg_n_0_[27]\,
      O => \IRQ0_carry_i_7__2_n_0\
    );
\IRQ0_carry_i_7__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(2),
      I1 => \compare_reg_reg_n_0_[34]\,
      I2 => p_1_in(3),
      I3 => \compare_reg_reg_n_0_[35]\,
      O => \IRQ0_carry_i_7__3_n_0\
    );
\IRQ0_carry_i_7__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(10),
      I1 => \compare_reg_reg_n_0_[42]\,
      I2 => p_1_in(11),
      I3 => \compare_reg_reg_n_0_[43]\,
      O => \IRQ0_carry_i_7__4_n_0\
    );
\IRQ0_carry_i_7__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(18),
      I1 => \compare_reg_reg_n_0_[50]\,
      I2 => p_1_in(19),
      I3 => \compare_reg_reg_n_0_[51]\,
      O => \IRQ0_carry_i_7__5_n_0\
    );
\IRQ0_carry_i_7__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(26),
      I1 => \compare_reg_reg_n_0_[58]\,
      I2 => p_1_in(27),
      I3 => \compare_reg_reg_n_0_[59]\,
      O => \IRQ0_carry_i_7__6_n_0\
    );
IRQ0_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[0]\,
      I1 => \compare_reg_reg_n_0_[0]\,
      I2 => \clock_reg_reg_n_0_[1]\,
      I3 => \compare_reg_reg_n_0_[1]\,
      O => IRQ0_carry_i_8_n_0
    );
\IRQ0_carry_i_8__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[8]\,
      I1 => \compare_reg_reg_n_0_[8]\,
      I2 => \clock_reg_reg_n_0_[9]\,
      I3 => \compare_reg_reg_n_0_[9]\,
      O => \IRQ0_carry_i_8__0_n_0\
    );
\IRQ0_carry_i_8__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[16]\,
      I1 => \compare_reg_reg_n_0_[16]\,
      I2 => \clock_reg_reg_n_0_[17]\,
      I3 => \compare_reg_reg_n_0_[17]\,
      O => \IRQ0_carry_i_8__1_n_0\
    );
\IRQ0_carry_i_8__2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[24]\,
      I1 => \compare_reg_reg_n_0_[24]\,
      I2 => \clock_reg_reg_n_0_[25]\,
      I3 => \compare_reg_reg_n_0_[25]\,
      O => \IRQ0_carry_i_8__2_n_0\
    );
\IRQ0_carry_i_8__3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(0),
      I1 => \compare_reg_reg_n_0_[32]\,
      I2 => p_1_in(1),
      I3 => \compare_reg_reg_n_0_[33]\,
      O => \IRQ0_carry_i_8__3_n_0\
    );
\IRQ0_carry_i_8__4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(8),
      I1 => \compare_reg_reg_n_0_[40]\,
      I2 => p_1_in(9),
      I3 => \compare_reg_reg_n_0_[41]\,
      O => \IRQ0_carry_i_8__4_n_0\
    );
\IRQ0_carry_i_8__5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(16),
      I1 => \compare_reg_reg_n_0_[48]\,
      I2 => p_1_in(17),
      I3 => \compare_reg_reg_n_0_[49]\,
      O => \IRQ0_carry_i_8__5_n_0\
    );
\IRQ0_carry_i_8__6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => p_1_in(24),
      I1 => \compare_reg_reg_n_0_[56]\,
      I2 => p_1_in(25),
      I3 => \compare_reg_reg_n_0_[57]\,
      O => \IRQ0_carry_i_8__6_n_0\
    );
arready_int_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S_AXI_ARVALID,
      I1 => \^s_axi_arready\,
      O => arready_int0
    );
arready_int_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => arready_int0,
      Q => \^s_axi_arready\,
      R => clear
    );
awready_int_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => S_AXI_ARESETN,
      O => clear
    );
awready_int_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => S_AXI_WVALID,
      I1 => S_AXI_AWVALID,
      I2 => \^s_axi_awready\,
      O => awready_int0
    );
awready_int_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => awready_int0,
      Q => \^s_axi_awready\,
      R => clear
    );
bvalid_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF80008000"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => \^s_axi_awready\,
      I2 => S_AXI_WVALID,
      I3 => S_AXI_AWVALID,
      I4 => S_AXI_BREADY,
      I5 => \^s_axi_bvalid\,
      O => bvalid_int_i_1_n_0
    );
bvalid_int_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => bvalid_int_i_1_n_0,
      Q => \^s_axi_bvalid\,
      R => clear
    );
\clock_reg[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \clock_reg_reg_n_0_[0]\,
      O => \clock_reg[0]_i_2_n_0\
    );
\clock_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[0]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[0]\,
      R => clear
    );
\clock_reg_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \clock_reg_reg[0]_i_1_n_0\,
      CO(2) => \clock_reg_reg[0]_i_1_n_1\,
      CO(1) => \clock_reg_reg[0]_i_1_n_2\,
      CO(0) => \clock_reg_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \clock_reg_reg[0]_i_1_n_4\,
      O(2) => \clock_reg_reg[0]_i_1_n_5\,
      O(1) => \clock_reg_reg[0]_i_1_n_6\,
      O(0) => \clock_reg_reg[0]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[3]\,
      S(2) => \clock_reg_reg_n_0_[2]\,
      S(1) => \clock_reg_reg_n_0_[1]\,
      S(0) => \clock_reg[0]_i_2_n_0\
    );
\clock_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[8]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[10]\,
      R => clear
    );
\clock_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[8]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[11]\,
      R => clear
    );
\clock_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[12]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[12]\,
      R => clear
    );
\clock_reg_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[8]_i_1_n_0\,
      CO(3) => \clock_reg_reg[12]_i_1_n_0\,
      CO(2) => \clock_reg_reg[12]_i_1_n_1\,
      CO(1) => \clock_reg_reg[12]_i_1_n_2\,
      CO(0) => \clock_reg_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[12]_i_1_n_4\,
      O(2) => \clock_reg_reg[12]_i_1_n_5\,
      O(1) => \clock_reg_reg[12]_i_1_n_6\,
      O(0) => \clock_reg_reg[12]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[15]\,
      S(2) => \clock_reg_reg_n_0_[14]\,
      S(1) => \clock_reg_reg_n_0_[13]\,
      S(0) => \clock_reg_reg_n_0_[12]\
    );
\clock_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[12]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[13]\,
      R => clear
    );
\clock_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[12]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[14]\,
      R => clear
    );
\clock_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[12]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[15]\,
      R => clear
    );
\clock_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[16]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[16]\,
      R => clear
    );
\clock_reg_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[12]_i_1_n_0\,
      CO(3) => \clock_reg_reg[16]_i_1_n_0\,
      CO(2) => \clock_reg_reg[16]_i_1_n_1\,
      CO(1) => \clock_reg_reg[16]_i_1_n_2\,
      CO(0) => \clock_reg_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[16]_i_1_n_4\,
      O(2) => \clock_reg_reg[16]_i_1_n_5\,
      O(1) => \clock_reg_reg[16]_i_1_n_6\,
      O(0) => \clock_reg_reg[16]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[19]\,
      S(2) => \clock_reg_reg_n_0_[18]\,
      S(1) => \clock_reg_reg_n_0_[17]\,
      S(0) => \clock_reg_reg_n_0_[16]\
    );
\clock_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[16]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[17]\,
      R => clear
    );
\clock_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[16]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[18]\,
      R => clear
    );
\clock_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[16]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[19]\,
      R => clear
    );
\clock_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[0]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[1]\,
      R => clear
    );
\clock_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[20]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[20]\,
      R => clear
    );
\clock_reg_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[16]_i_1_n_0\,
      CO(3) => \clock_reg_reg[20]_i_1_n_0\,
      CO(2) => \clock_reg_reg[20]_i_1_n_1\,
      CO(1) => \clock_reg_reg[20]_i_1_n_2\,
      CO(0) => \clock_reg_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[20]_i_1_n_4\,
      O(2) => \clock_reg_reg[20]_i_1_n_5\,
      O(1) => \clock_reg_reg[20]_i_1_n_6\,
      O(0) => \clock_reg_reg[20]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[23]\,
      S(2) => \clock_reg_reg_n_0_[22]\,
      S(1) => \clock_reg_reg_n_0_[21]\,
      S(0) => \clock_reg_reg_n_0_[20]\
    );
\clock_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[20]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[21]\,
      R => clear
    );
\clock_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[20]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[22]\,
      R => clear
    );
\clock_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[20]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[23]\,
      R => clear
    );
\clock_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[24]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[24]\,
      R => clear
    );
\clock_reg_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[20]_i_1_n_0\,
      CO(3) => \clock_reg_reg[24]_i_1_n_0\,
      CO(2) => \clock_reg_reg[24]_i_1_n_1\,
      CO(1) => \clock_reg_reg[24]_i_1_n_2\,
      CO(0) => \clock_reg_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[24]_i_1_n_4\,
      O(2) => \clock_reg_reg[24]_i_1_n_5\,
      O(1) => \clock_reg_reg[24]_i_1_n_6\,
      O(0) => \clock_reg_reg[24]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[27]\,
      S(2) => \clock_reg_reg_n_0_[26]\,
      S(1) => \clock_reg_reg_n_0_[25]\,
      S(0) => \clock_reg_reg_n_0_[24]\
    );
\clock_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[24]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[25]\,
      R => clear
    );
\clock_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[24]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[26]\,
      R => clear
    );
\clock_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[24]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[27]\,
      R => clear
    );
\clock_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[28]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[28]\,
      R => clear
    );
\clock_reg_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[24]_i_1_n_0\,
      CO(3) => \clock_reg_reg[28]_i_1_n_0\,
      CO(2) => \clock_reg_reg[28]_i_1_n_1\,
      CO(1) => \clock_reg_reg[28]_i_1_n_2\,
      CO(0) => \clock_reg_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[28]_i_1_n_4\,
      O(2) => \clock_reg_reg[28]_i_1_n_5\,
      O(1) => \clock_reg_reg[28]_i_1_n_6\,
      O(0) => \clock_reg_reg[28]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[31]\,
      S(2) => \clock_reg_reg_n_0_[30]\,
      S(1) => \clock_reg_reg_n_0_[29]\,
      S(0) => \clock_reg_reg_n_0_[28]\
    );
\clock_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[28]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[29]\,
      R => clear
    );
\clock_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[0]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[2]\,
      R => clear
    );
\clock_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[28]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[30]\,
      R => clear
    );
\clock_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[28]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[31]\,
      R => clear
    );
\clock_reg_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[32]_i_1_n_7\,
      Q => p_1_in(0),
      R => clear
    );
\clock_reg_reg[32]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[28]_i_1_n_0\,
      CO(3) => \clock_reg_reg[32]_i_1_n_0\,
      CO(2) => \clock_reg_reg[32]_i_1_n_1\,
      CO(1) => \clock_reg_reg[32]_i_1_n_2\,
      CO(0) => \clock_reg_reg[32]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[32]_i_1_n_4\,
      O(2) => \clock_reg_reg[32]_i_1_n_5\,
      O(1) => \clock_reg_reg[32]_i_1_n_6\,
      O(0) => \clock_reg_reg[32]_i_1_n_7\,
      S(3 downto 0) => p_1_in(3 downto 0)
    );
\clock_reg_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[32]_i_1_n_6\,
      Q => p_1_in(1),
      R => clear
    );
\clock_reg_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[32]_i_1_n_5\,
      Q => p_1_in(2),
      R => clear
    );
\clock_reg_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[32]_i_1_n_4\,
      Q => p_1_in(3),
      R => clear
    );
\clock_reg_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[36]_i_1_n_7\,
      Q => p_1_in(4),
      R => clear
    );
\clock_reg_reg[36]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[32]_i_1_n_0\,
      CO(3) => \clock_reg_reg[36]_i_1_n_0\,
      CO(2) => \clock_reg_reg[36]_i_1_n_1\,
      CO(1) => \clock_reg_reg[36]_i_1_n_2\,
      CO(0) => \clock_reg_reg[36]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[36]_i_1_n_4\,
      O(2) => \clock_reg_reg[36]_i_1_n_5\,
      O(1) => \clock_reg_reg[36]_i_1_n_6\,
      O(0) => \clock_reg_reg[36]_i_1_n_7\,
      S(3 downto 0) => p_1_in(7 downto 4)
    );
\clock_reg_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[36]_i_1_n_6\,
      Q => p_1_in(5),
      R => clear
    );
\clock_reg_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[36]_i_1_n_5\,
      Q => p_1_in(6),
      R => clear
    );
\clock_reg_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[36]_i_1_n_4\,
      Q => p_1_in(7),
      R => clear
    );
\clock_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[0]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[3]\,
      R => clear
    );
\clock_reg_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[40]_i_1_n_7\,
      Q => p_1_in(8),
      R => clear
    );
\clock_reg_reg[40]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[36]_i_1_n_0\,
      CO(3) => \clock_reg_reg[40]_i_1_n_0\,
      CO(2) => \clock_reg_reg[40]_i_1_n_1\,
      CO(1) => \clock_reg_reg[40]_i_1_n_2\,
      CO(0) => \clock_reg_reg[40]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[40]_i_1_n_4\,
      O(2) => \clock_reg_reg[40]_i_1_n_5\,
      O(1) => \clock_reg_reg[40]_i_1_n_6\,
      O(0) => \clock_reg_reg[40]_i_1_n_7\,
      S(3 downto 0) => p_1_in(11 downto 8)
    );
\clock_reg_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[40]_i_1_n_6\,
      Q => p_1_in(9),
      R => clear
    );
\clock_reg_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[40]_i_1_n_5\,
      Q => p_1_in(10),
      R => clear
    );
\clock_reg_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[40]_i_1_n_4\,
      Q => p_1_in(11),
      R => clear
    );
\clock_reg_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[44]_i_1_n_7\,
      Q => p_1_in(12),
      R => clear
    );
\clock_reg_reg[44]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[40]_i_1_n_0\,
      CO(3) => \clock_reg_reg[44]_i_1_n_0\,
      CO(2) => \clock_reg_reg[44]_i_1_n_1\,
      CO(1) => \clock_reg_reg[44]_i_1_n_2\,
      CO(0) => \clock_reg_reg[44]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[44]_i_1_n_4\,
      O(2) => \clock_reg_reg[44]_i_1_n_5\,
      O(1) => \clock_reg_reg[44]_i_1_n_6\,
      O(0) => \clock_reg_reg[44]_i_1_n_7\,
      S(3 downto 0) => p_1_in(15 downto 12)
    );
\clock_reg_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[44]_i_1_n_6\,
      Q => p_1_in(13),
      R => clear
    );
\clock_reg_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[44]_i_1_n_5\,
      Q => p_1_in(14),
      R => clear
    );
\clock_reg_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[44]_i_1_n_4\,
      Q => p_1_in(15),
      R => clear
    );
\clock_reg_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[48]_i_1_n_7\,
      Q => p_1_in(16),
      R => clear
    );
\clock_reg_reg[48]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[44]_i_1_n_0\,
      CO(3) => \clock_reg_reg[48]_i_1_n_0\,
      CO(2) => \clock_reg_reg[48]_i_1_n_1\,
      CO(1) => \clock_reg_reg[48]_i_1_n_2\,
      CO(0) => \clock_reg_reg[48]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[48]_i_1_n_4\,
      O(2) => \clock_reg_reg[48]_i_1_n_5\,
      O(1) => \clock_reg_reg[48]_i_1_n_6\,
      O(0) => \clock_reg_reg[48]_i_1_n_7\,
      S(3 downto 0) => p_1_in(19 downto 16)
    );
\clock_reg_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[48]_i_1_n_6\,
      Q => p_1_in(17),
      R => clear
    );
\clock_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[4]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[4]\,
      R => clear
    );
\clock_reg_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[0]_i_1_n_0\,
      CO(3) => \clock_reg_reg[4]_i_1_n_0\,
      CO(2) => \clock_reg_reg[4]_i_1_n_1\,
      CO(1) => \clock_reg_reg[4]_i_1_n_2\,
      CO(0) => \clock_reg_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[4]_i_1_n_4\,
      O(2) => \clock_reg_reg[4]_i_1_n_5\,
      O(1) => \clock_reg_reg[4]_i_1_n_6\,
      O(0) => \clock_reg_reg[4]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[7]\,
      S(2) => \clock_reg_reg_n_0_[6]\,
      S(1) => \clock_reg_reg_n_0_[5]\,
      S(0) => \clock_reg_reg_n_0_[4]\
    );
\clock_reg_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[48]_i_1_n_5\,
      Q => p_1_in(18),
      R => clear
    );
\clock_reg_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[48]_i_1_n_4\,
      Q => p_1_in(19),
      R => clear
    );
\clock_reg_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[52]_i_1_n_7\,
      Q => p_1_in(20),
      R => clear
    );
\clock_reg_reg[52]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[48]_i_1_n_0\,
      CO(3) => \clock_reg_reg[52]_i_1_n_0\,
      CO(2) => \clock_reg_reg[52]_i_1_n_1\,
      CO(1) => \clock_reg_reg[52]_i_1_n_2\,
      CO(0) => \clock_reg_reg[52]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[52]_i_1_n_4\,
      O(2) => \clock_reg_reg[52]_i_1_n_5\,
      O(1) => \clock_reg_reg[52]_i_1_n_6\,
      O(0) => \clock_reg_reg[52]_i_1_n_7\,
      S(3 downto 0) => p_1_in(23 downto 20)
    );
\clock_reg_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[52]_i_1_n_6\,
      Q => p_1_in(21),
      R => clear
    );
\clock_reg_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[52]_i_1_n_5\,
      Q => p_1_in(22),
      R => clear
    );
\clock_reg_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[52]_i_1_n_4\,
      Q => p_1_in(23),
      R => clear
    );
\clock_reg_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[56]_i_1_n_7\,
      Q => p_1_in(24),
      R => clear
    );
\clock_reg_reg[56]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[52]_i_1_n_0\,
      CO(3) => \clock_reg_reg[56]_i_1_n_0\,
      CO(2) => \clock_reg_reg[56]_i_1_n_1\,
      CO(1) => \clock_reg_reg[56]_i_1_n_2\,
      CO(0) => \clock_reg_reg[56]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[56]_i_1_n_4\,
      O(2) => \clock_reg_reg[56]_i_1_n_5\,
      O(1) => \clock_reg_reg[56]_i_1_n_6\,
      O(0) => \clock_reg_reg[56]_i_1_n_7\,
      S(3 downto 0) => p_1_in(27 downto 24)
    );
\clock_reg_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[56]_i_1_n_6\,
      Q => p_1_in(25),
      R => clear
    );
\clock_reg_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[56]_i_1_n_5\,
      Q => p_1_in(26),
      R => clear
    );
\clock_reg_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[56]_i_1_n_4\,
      Q => p_1_in(27),
      R => clear
    );
\clock_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[4]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[5]\,
      R => clear
    );
\clock_reg_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[60]_i_1_n_7\,
      Q => p_1_in(28),
      R => clear
    );
\clock_reg_reg[60]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[56]_i_1_n_0\,
      CO(3) => \NLW_clock_reg_reg[60]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \clock_reg_reg[60]_i_1_n_1\,
      CO(1) => \clock_reg_reg[60]_i_1_n_2\,
      CO(0) => \clock_reg_reg[60]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[60]_i_1_n_4\,
      O(2) => \clock_reg_reg[60]_i_1_n_5\,
      O(1) => \clock_reg_reg[60]_i_1_n_6\,
      O(0) => \clock_reg_reg[60]_i_1_n_7\,
      S(3 downto 0) => p_1_in(31 downto 28)
    );
\clock_reg_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[60]_i_1_n_6\,
      Q => p_1_in(29),
      R => clear
    );
\clock_reg_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[60]_i_1_n_5\,
      Q => p_1_in(30),
      R => clear
    );
\clock_reg_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[60]_i_1_n_4\,
      Q => p_1_in(31),
      R => clear
    );
\clock_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[4]_i_1_n_5\,
      Q => \clock_reg_reg_n_0_[6]\,
      R => clear
    );
\clock_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[4]_i_1_n_4\,
      Q => \clock_reg_reg_n_0_[7]\,
      R => clear
    );
\clock_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[8]_i_1_n_7\,
      Q => \clock_reg_reg_n_0_[8]\,
      R => clear
    );
\clock_reg_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg_reg[4]_i_1_n_0\,
      CO(3) => \clock_reg_reg[8]_i_1_n_0\,
      CO(2) => \clock_reg_reg[8]_i_1_n_1\,
      CO(1) => \clock_reg_reg[8]_i_1_n_2\,
      CO(0) => \clock_reg_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clock_reg_reg[8]_i_1_n_4\,
      O(2) => \clock_reg_reg[8]_i_1_n_5\,
      O(1) => \clock_reg_reg[8]_i_1_n_6\,
      O(0) => \clock_reg_reg[8]_i_1_n_7\,
      S(3) => \clock_reg_reg_n_0_[11]\,
      S(2) => \clock_reg_reg_n_0_[10]\,
      S(1) => \clock_reg_reg_n_0_[9]\,
      S(0) => \clock_reg_reg_n_0_[8]\
    );
\clock_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => \clock_reg_reg[8]_i_1_n_6\,
      Q => \clock_reg_reg_n_0_[9]\,
      R => clear
    );
\clock_snap_reg[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000040"
    )
        port map (
      I0 => \^rvalid_int_reg_0\,
      I1 => \^s_axi_arready\,
      I2 => S_AXI_ARVALID,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      O => clock_snap_reg_0(0)
    );
\clock_snap_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(0),
      Q => clock_snap_reg(0),
      R => clear
    );
\clock_snap_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(10),
      Q => clock_snap_reg(10),
      R => clear
    );
\clock_snap_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(11),
      Q => clock_snap_reg(11),
      R => clear
    );
\clock_snap_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(12),
      Q => clock_snap_reg(12),
      R => clear
    );
\clock_snap_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(13),
      Q => clock_snap_reg(13),
      R => clear
    );
\clock_snap_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(14),
      Q => clock_snap_reg(14),
      R => clear
    );
\clock_snap_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(15),
      Q => clock_snap_reg(15),
      R => clear
    );
\clock_snap_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(16),
      Q => clock_snap_reg(16),
      R => clear
    );
\clock_snap_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(17),
      Q => clock_snap_reg(17),
      R => clear
    );
\clock_snap_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(18),
      Q => clock_snap_reg(18),
      R => clear
    );
\clock_snap_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(19),
      Q => clock_snap_reg(19),
      R => clear
    );
\clock_snap_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(1),
      Q => clock_snap_reg(1),
      R => clear
    );
\clock_snap_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(20),
      Q => clock_snap_reg(20),
      R => clear
    );
\clock_snap_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(21),
      Q => clock_snap_reg(21),
      R => clear
    );
\clock_snap_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(22),
      Q => clock_snap_reg(22),
      R => clear
    );
\clock_snap_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(23),
      Q => clock_snap_reg(23),
      R => clear
    );
\clock_snap_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(24),
      Q => clock_snap_reg(24),
      R => clear
    );
\clock_snap_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(25),
      Q => clock_snap_reg(25),
      R => clear
    );
\clock_snap_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(26),
      Q => clock_snap_reg(26),
      R => clear
    );
\clock_snap_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(27),
      Q => clock_snap_reg(27),
      R => clear
    );
\clock_snap_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(28),
      Q => clock_snap_reg(28),
      R => clear
    );
\clock_snap_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(29),
      Q => clock_snap_reg(29),
      R => clear
    );
\clock_snap_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(2),
      Q => clock_snap_reg(2),
      R => clear
    );
\clock_snap_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(30),
      Q => clock_snap_reg(30),
      R => clear
    );
\clock_snap_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(31),
      Q => clock_snap_reg(31),
      R => clear
    );
\clock_snap_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(3),
      Q => clock_snap_reg(3),
      R => clear
    );
\clock_snap_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(4),
      Q => clock_snap_reg(4),
      R => clear
    );
\clock_snap_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(5),
      Q => clock_snap_reg(5),
      R => clear
    );
\clock_snap_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(6),
      Q => clock_snap_reg(6),
      R => clear
    );
\clock_snap_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(7),
      Q => clock_snap_reg(7),
      R => clear
    );
\clock_snap_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(8),
      Q => clock_snap_reg(8),
      R => clear
    );
\clock_snap_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => clock_snap_reg_0(0),
      D => p_1_in(9),
      Q => clock_snap_reg(9),
      R => clear
    );
\compare_reg[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000080"
    )
        port map (
      I0 => S_AXI_AWADDR(1),
      I1 => S_AXI_WVALID,
      I2 => S_AXI_AWVALID,
      I3 => \^s_axi_wready\,
      I4 => S_AXI_AWADDR(0),
      O => compare_reg(31)
    );
\compare_reg[63]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
        port map (
      I0 => S_AXI_AWADDR(1),
      I1 => S_AXI_WVALID,
      I2 => S_AXI_AWVALID,
      I3 => \^s_axi_wready\,
      I4 => S_AXI_AWADDR(0),
      O => compare_reg(63)
    );
\compare_reg_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(0),
      Q => \compare_reg_reg_n_0_[0]\,
      S => clear
    );
\compare_reg_reg[10]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(10),
      Q => \compare_reg_reg_n_0_[10]\,
      S => clear
    );
\compare_reg_reg[11]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(11),
      Q => \compare_reg_reg_n_0_[11]\,
      S => clear
    );
\compare_reg_reg[12]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(12),
      Q => \compare_reg_reg_n_0_[12]\,
      S => clear
    );
\compare_reg_reg[13]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(13),
      Q => \compare_reg_reg_n_0_[13]\,
      S => clear
    );
\compare_reg_reg[14]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(14),
      Q => \compare_reg_reg_n_0_[14]\,
      S => clear
    );
\compare_reg_reg[15]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(15),
      Q => \compare_reg_reg_n_0_[15]\,
      S => clear
    );
\compare_reg_reg[16]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(16),
      Q => \compare_reg_reg_n_0_[16]\,
      S => clear
    );
\compare_reg_reg[17]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(17),
      Q => \compare_reg_reg_n_0_[17]\,
      S => clear
    );
\compare_reg_reg[18]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(18),
      Q => \compare_reg_reg_n_0_[18]\,
      S => clear
    );
\compare_reg_reg[19]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(19),
      Q => \compare_reg_reg_n_0_[19]\,
      S => clear
    );
\compare_reg_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(1),
      Q => \compare_reg_reg_n_0_[1]\,
      S => clear
    );
\compare_reg_reg[20]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(20),
      Q => \compare_reg_reg_n_0_[20]\,
      S => clear
    );
\compare_reg_reg[21]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(21),
      Q => \compare_reg_reg_n_0_[21]\,
      S => clear
    );
\compare_reg_reg[22]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(22),
      Q => \compare_reg_reg_n_0_[22]\,
      S => clear
    );
\compare_reg_reg[23]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(23),
      Q => \compare_reg_reg_n_0_[23]\,
      S => clear
    );
\compare_reg_reg[24]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(24),
      Q => \compare_reg_reg_n_0_[24]\,
      S => clear
    );
\compare_reg_reg[25]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(25),
      Q => \compare_reg_reg_n_0_[25]\,
      S => clear
    );
\compare_reg_reg[26]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(26),
      Q => \compare_reg_reg_n_0_[26]\,
      S => clear
    );
\compare_reg_reg[27]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(27),
      Q => \compare_reg_reg_n_0_[27]\,
      S => clear
    );
\compare_reg_reg[28]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(28),
      Q => \compare_reg_reg_n_0_[28]\,
      S => clear
    );
\compare_reg_reg[29]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(29),
      Q => \compare_reg_reg_n_0_[29]\,
      S => clear
    );
\compare_reg_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(2),
      Q => \compare_reg_reg_n_0_[2]\,
      S => clear
    );
\compare_reg_reg[30]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(30),
      Q => \compare_reg_reg_n_0_[30]\,
      S => clear
    );
\compare_reg_reg[31]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(31),
      Q => \compare_reg_reg_n_0_[31]\,
      S => clear
    );
\compare_reg_reg[32]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(0),
      Q => \compare_reg_reg_n_0_[32]\,
      S => clear
    );
\compare_reg_reg[33]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(1),
      Q => \compare_reg_reg_n_0_[33]\,
      S => clear
    );
\compare_reg_reg[34]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(2),
      Q => \compare_reg_reg_n_0_[34]\,
      S => clear
    );
\compare_reg_reg[35]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(3),
      Q => \compare_reg_reg_n_0_[35]\,
      S => clear
    );
\compare_reg_reg[36]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(4),
      Q => \compare_reg_reg_n_0_[36]\,
      S => clear
    );
\compare_reg_reg[37]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(5),
      Q => \compare_reg_reg_n_0_[37]\,
      S => clear
    );
\compare_reg_reg[38]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(6),
      Q => \compare_reg_reg_n_0_[38]\,
      S => clear
    );
\compare_reg_reg[39]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(7),
      Q => \compare_reg_reg_n_0_[39]\,
      S => clear
    );
\compare_reg_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(3),
      Q => \compare_reg_reg_n_0_[3]\,
      S => clear
    );
\compare_reg_reg[40]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(8),
      Q => \compare_reg_reg_n_0_[40]\,
      S => clear
    );
\compare_reg_reg[41]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(9),
      Q => \compare_reg_reg_n_0_[41]\,
      S => clear
    );
\compare_reg_reg[42]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(10),
      Q => \compare_reg_reg_n_0_[42]\,
      S => clear
    );
\compare_reg_reg[43]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(11),
      Q => \compare_reg_reg_n_0_[43]\,
      S => clear
    );
\compare_reg_reg[44]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(12),
      Q => \compare_reg_reg_n_0_[44]\,
      S => clear
    );
\compare_reg_reg[45]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(13),
      Q => \compare_reg_reg_n_0_[45]\,
      S => clear
    );
\compare_reg_reg[46]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(14),
      Q => \compare_reg_reg_n_0_[46]\,
      S => clear
    );
\compare_reg_reg[47]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(15),
      Q => \compare_reg_reg_n_0_[47]\,
      S => clear
    );
\compare_reg_reg[48]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(16),
      Q => \compare_reg_reg_n_0_[48]\,
      S => clear
    );
\compare_reg_reg[49]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(17),
      Q => \compare_reg_reg_n_0_[49]\,
      S => clear
    );
\compare_reg_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(4),
      Q => \compare_reg_reg_n_0_[4]\,
      S => clear
    );
\compare_reg_reg[50]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(18),
      Q => \compare_reg_reg_n_0_[50]\,
      S => clear
    );
\compare_reg_reg[51]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(19),
      Q => \compare_reg_reg_n_0_[51]\,
      S => clear
    );
\compare_reg_reg[52]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(20),
      Q => \compare_reg_reg_n_0_[52]\,
      S => clear
    );
\compare_reg_reg[53]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(21),
      Q => \compare_reg_reg_n_0_[53]\,
      S => clear
    );
\compare_reg_reg[54]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(22),
      Q => \compare_reg_reg_n_0_[54]\,
      S => clear
    );
\compare_reg_reg[55]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(23),
      Q => \compare_reg_reg_n_0_[55]\,
      S => clear
    );
\compare_reg_reg[56]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(24),
      Q => \compare_reg_reg_n_0_[56]\,
      S => clear
    );
\compare_reg_reg[57]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(25),
      Q => \compare_reg_reg_n_0_[57]\,
      S => clear
    );
\compare_reg_reg[58]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(26),
      Q => \compare_reg_reg_n_0_[58]\,
      S => clear
    );
\compare_reg_reg[59]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(27),
      Q => \compare_reg_reg_n_0_[59]\,
      S => clear
    );
\compare_reg_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(5),
      Q => \compare_reg_reg_n_0_[5]\,
      S => clear
    );
\compare_reg_reg[60]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(28),
      Q => \compare_reg_reg_n_0_[60]\,
      S => clear
    );
\compare_reg_reg[61]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(29),
      Q => \compare_reg_reg_n_0_[61]\,
      S => clear
    );
\compare_reg_reg[62]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(30),
      Q => \compare_reg_reg_n_0_[62]\,
      S => clear
    );
\compare_reg_reg[63]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(63),
      D => S_AXI_WDATA(31),
      Q => \compare_reg_reg_n_0_[63]\,
      S => clear
    );
\compare_reg_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(6),
      Q => \compare_reg_reg_n_0_[6]\,
      S => clear
    );
\compare_reg_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(7),
      Q => \compare_reg_reg_n_0_[7]\,
      S => clear
    );
\compare_reg_reg[8]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(8),
      Q => \compare_reg_reg_n_0_[8]\,
      S => clear
    );
\compare_reg_reg[9]\: unisim.vcomponents.FDSE
     port map (
      C => S_AXI_ACLK,
      CE => compare_reg(31),
      D => S_AXI_WDATA(9),
      Q => \compare_reg_reg_n_0_[9]\,
      S => clear
    );
\rdata_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(0),
      I1 => \clock_reg_reg_n_0_[0]\,
      I2 => \compare_reg_reg_n_0_[32]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[0]\,
      O => \rdata_int[0]_i_1_n_0\
    );
\rdata_int[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(10),
      I1 => \clock_reg_reg_n_0_[10]\,
      I2 => \compare_reg_reg_n_0_[42]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[10]\,
      O => \rdata_int[10]_i_1_n_0\
    );
\rdata_int[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(11),
      I1 => \clock_reg_reg_n_0_[11]\,
      I2 => \compare_reg_reg_n_0_[43]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[11]\,
      O => \rdata_int[11]_i_1_n_0\
    );
\rdata_int[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(12),
      I1 => \clock_reg_reg_n_0_[12]\,
      I2 => \compare_reg_reg_n_0_[44]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[12]\,
      O => \rdata_int[12]_i_1_n_0\
    );
\rdata_int[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(13),
      I1 => \clock_reg_reg_n_0_[13]\,
      I2 => \compare_reg_reg_n_0_[45]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[13]\,
      O => \rdata_int[13]_i_1_n_0\
    );
\rdata_int[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(14),
      I1 => \clock_reg_reg_n_0_[14]\,
      I2 => \compare_reg_reg_n_0_[46]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[14]\,
      O => \rdata_int[14]_i_1_n_0\
    );
\rdata_int[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(15),
      I1 => \clock_reg_reg_n_0_[15]\,
      I2 => \compare_reg_reg_n_0_[47]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[15]\,
      O => \rdata_int[15]_i_1_n_0\
    );
\rdata_int[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(16),
      I1 => \clock_reg_reg_n_0_[16]\,
      I2 => \compare_reg_reg_n_0_[48]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[16]\,
      O => \rdata_int[16]_i_1_n_0\
    );
\rdata_int[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(17),
      I1 => \clock_reg_reg_n_0_[17]\,
      I2 => \compare_reg_reg_n_0_[49]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[17]\,
      O => \rdata_int[17]_i_1_n_0\
    );
\rdata_int[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(18),
      I1 => \clock_reg_reg_n_0_[18]\,
      I2 => \compare_reg_reg_n_0_[50]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[18]\,
      O => \rdata_int[18]_i_1_n_0\
    );
\rdata_int[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(19),
      I1 => \clock_reg_reg_n_0_[19]\,
      I2 => \compare_reg_reg_n_0_[51]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[19]\,
      O => \rdata_int[19]_i_1_n_0\
    );
\rdata_int[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(1),
      I1 => \clock_reg_reg_n_0_[1]\,
      I2 => \compare_reg_reg_n_0_[33]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[1]\,
      O => \rdata_int[1]_i_1_n_0\
    );
\rdata_int[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(20),
      I1 => \clock_reg_reg_n_0_[20]\,
      I2 => \compare_reg_reg_n_0_[52]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[20]\,
      O => \rdata_int[20]_i_1_n_0\
    );
\rdata_int[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(21),
      I1 => \clock_reg_reg_n_0_[21]\,
      I2 => \compare_reg_reg_n_0_[53]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[21]\,
      O => \rdata_int[21]_i_1_n_0\
    );
\rdata_int[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(22),
      I1 => \clock_reg_reg_n_0_[22]\,
      I2 => \compare_reg_reg_n_0_[54]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[22]\,
      O => \rdata_int[22]_i_1_n_0\
    );
\rdata_int[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(23),
      I1 => \clock_reg_reg_n_0_[23]\,
      I2 => \compare_reg_reg_n_0_[55]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[23]\,
      O => \rdata_int[23]_i_1_n_0\
    );
\rdata_int[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(24),
      I1 => \clock_reg_reg_n_0_[24]\,
      I2 => \compare_reg_reg_n_0_[56]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[24]\,
      O => \rdata_int[24]_i_1_n_0\
    );
\rdata_int[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(25),
      I1 => \clock_reg_reg_n_0_[25]\,
      I2 => \compare_reg_reg_n_0_[57]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[25]\,
      O => \rdata_int[25]_i_1_n_0\
    );
\rdata_int[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(26),
      I1 => \clock_reg_reg_n_0_[26]\,
      I2 => \compare_reg_reg_n_0_[58]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[26]\,
      O => \rdata_int[26]_i_1_n_0\
    );
\rdata_int[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(27),
      I1 => \clock_reg_reg_n_0_[27]\,
      I2 => \compare_reg_reg_n_0_[59]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[27]\,
      O => \rdata_int[27]_i_1_n_0\
    );
\rdata_int[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(28),
      I1 => \clock_reg_reg_n_0_[28]\,
      I2 => \compare_reg_reg_n_0_[60]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[28]\,
      O => \rdata_int[28]_i_1_n_0\
    );
\rdata_int[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(29),
      I1 => \clock_reg_reg_n_0_[29]\,
      I2 => \compare_reg_reg_n_0_[61]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[29]\,
      O => \rdata_int[29]_i_1_n_0\
    );
\rdata_int[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(2),
      I1 => \clock_reg_reg_n_0_[2]\,
      I2 => \compare_reg_reg_n_0_[34]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[2]\,
      O => \rdata_int[2]_i_1_n_0\
    );
\rdata_int[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(30),
      I1 => \clock_reg_reg_n_0_[30]\,
      I2 => \compare_reg_reg_n_0_[62]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[30]\,
      O => \rdata_int[30]_i_1_n_0\
    );
\rdata_int[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(31),
      I1 => \clock_reg_reg_n_0_[31]\,
      I2 => \compare_reg_reg_n_0_[63]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[31]\,
      O => \rdata_int[31]_i_1_n_0\
    );
\rdata_int[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(3),
      I1 => \clock_reg_reg_n_0_[3]\,
      I2 => \compare_reg_reg_n_0_[35]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[3]\,
      O => \rdata_int[3]_i_1_n_0\
    );
\rdata_int[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(4),
      I1 => \clock_reg_reg_n_0_[4]\,
      I2 => \compare_reg_reg_n_0_[36]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[4]\,
      O => \rdata_int[4]_i_1_n_0\
    );
\rdata_int[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(5),
      I1 => \clock_reg_reg_n_0_[5]\,
      I2 => \compare_reg_reg_n_0_[37]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[5]\,
      O => \rdata_int[5]_i_1_n_0\
    );
\rdata_int[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(6),
      I1 => \clock_reg_reg_n_0_[6]\,
      I2 => \compare_reg_reg_n_0_[38]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[6]\,
      O => \rdata_int[6]_i_1_n_0\
    );
\rdata_int[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(7),
      I1 => \clock_reg_reg_n_0_[7]\,
      I2 => \compare_reg_reg_n_0_[39]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[7]\,
      O => \rdata_int[7]_i_1_n_0\
    );
\rdata_int[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(8),
      I1 => \clock_reg_reg_n_0_[8]\,
      I2 => \compare_reg_reg_n_0_[40]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[8]\,
      O => \rdata_int[8]_i_1_n_0\
    );
\rdata_int[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0AAFFCCF0AA00CC"
    )
        port map (
      I0 => clock_snap_reg(9),
      I1 => \clock_reg_reg_n_0_[9]\,
      I2 => \compare_reg_reg_n_0_[41]\,
      I3 => S_AXI_ARADDR(1),
      I4 => S_AXI_ARADDR(0),
      I5 => \compare_reg_reg_n_0_[9]\,
      O => \rdata_int[9]_i_1_n_0\
    );
\rdata_int_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[0]_i_1_n_0\,
      Q => S_AXI_RDATA(0),
      R => clear
    );
\rdata_int_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[10]_i_1_n_0\,
      Q => S_AXI_RDATA(10),
      R => clear
    );
\rdata_int_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[11]_i_1_n_0\,
      Q => S_AXI_RDATA(11),
      R => clear
    );
\rdata_int_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[12]_i_1_n_0\,
      Q => S_AXI_RDATA(12),
      R => clear
    );
\rdata_int_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[13]_i_1_n_0\,
      Q => S_AXI_RDATA(13),
      R => clear
    );
\rdata_int_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[14]_i_1_n_0\,
      Q => S_AXI_RDATA(14),
      R => clear
    );
\rdata_int_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[15]_i_1_n_0\,
      Q => S_AXI_RDATA(15),
      R => clear
    );
\rdata_int_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[16]_i_1_n_0\,
      Q => S_AXI_RDATA(16),
      R => clear
    );
\rdata_int_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[17]_i_1_n_0\,
      Q => S_AXI_RDATA(17),
      R => clear
    );
\rdata_int_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[18]_i_1_n_0\,
      Q => S_AXI_RDATA(18),
      R => clear
    );
\rdata_int_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[19]_i_1_n_0\,
      Q => S_AXI_RDATA(19),
      R => clear
    );
\rdata_int_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[1]_i_1_n_0\,
      Q => S_AXI_RDATA(1),
      R => clear
    );
\rdata_int_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[20]_i_1_n_0\,
      Q => S_AXI_RDATA(20),
      R => clear
    );
\rdata_int_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[21]_i_1_n_0\,
      Q => S_AXI_RDATA(21),
      R => clear
    );
\rdata_int_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[22]_i_1_n_0\,
      Q => S_AXI_RDATA(22),
      R => clear
    );
\rdata_int_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[23]_i_1_n_0\,
      Q => S_AXI_RDATA(23),
      R => clear
    );
\rdata_int_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[24]_i_1_n_0\,
      Q => S_AXI_RDATA(24),
      R => clear
    );
\rdata_int_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[25]_i_1_n_0\,
      Q => S_AXI_RDATA(25),
      R => clear
    );
\rdata_int_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[26]_i_1_n_0\,
      Q => S_AXI_RDATA(26),
      R => clear
    );
\rdata_int_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[27]_i_1_n_0\,
      Q => S_AXI_RDATA(27),
      R => clear
    );
\rdata_int_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[28]_i_1_n_0\,
      Q => S_AXI_RDATA(28),
      R => clear
    );
\rdata_int_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[29]_i_1_n_0\,
      Q => S_AXI_RDATA(29),
      R => clear
    );
\rdata_int_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[2]_i_1_n_0\,
      Q => S_AXI_RDATA(2),
      R => clear
    );
\rdata_int_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[30]_i_1_n_0\,
      Q => S_AXI_RDATA(30),
      R => clear
    );
\rdata_int_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[31]_i_1_n_0\,
      Q => S_AXI_RDATA(31),
      R => clear
    );
\rdata_int_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[3]_i_1_n_0\,
      Q => S_AXI_RDATA(3),
      R => clear
    );
\rdata_int_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[4]_i_1_n_0\,
      Q => S_AXI_RDATA(4),
      R => clear
    );
\rdata_int_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[5]_i_1_n_0\,
      Q => S_AXI_RDATA(5),
      R => clear
    );
\rdata_int_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[6]_i_1_n_0\,
      Q => S_AXI_RDATA(6),
      R => clear
    );
\rdata_int_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[7]_i_1_n_0\,
      Q => S_AXI_RDATA(7),
      R => clear
    );
\rdata_int_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[8]_i_1_n_0\,
      Q => S_AXI_RDATA(8),
      R => clear
    );
\rdata_int_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => \rvalid_int00_out__0\,
      D => \rdata_int[9]_i_1_n_0\,
      Q => S_AXI_RDATA(9),
      R => clear
    );
rvalid_int00_out: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => S_AXI_ARVALID,
      I1 => \^s_axi_arready\,
      I2 => \^rvalid_int_reg_0\,
      O => \rvalid_int00_out__0\
    );
rvalid_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => \^s_axi_arready\,
      I1 => S_AXI_ARVALID,
      I2 => \^rvalid_int_reg_0\,
      I3 => S_AXI_RREADY,
      O => rvalid_int_i_1_n_0
    );
rvalid_int_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => rvalid_int_i_1_n_0,
      Q => \^rvalid_int_reg_0\,
      R => clear
    );
wready_int_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => S_AXI_WVALID,
      I1 => S_AXI_AWVALID,
      I2 => \^s_axi_wready\,
      O => wready_int0
    );
wready_int_reg: unisim.vcomponents.FDRE
     port map (
      C => S_AXI_ACLK,
      CE => '1',
      D => wready_int0,
      Q => \^s_axi_wready\,
      R => clear
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axil_timer_64_0_0 is
  port (
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_ARESETN : in STD_LOGIC;
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_RVALID : out STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC;
    IRQ : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_axil_timer_64_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_axil_timer_64_0_0 : entity is "design_1_axil_timer_64_0_0,axil_timer_64,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_axil_timer_64_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_axil_timer_64_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_axil_timer_64_0_0 : entity is "axil_timer_64,Vivado 2025.2";
end design_1_axil_timer_64_0_0;

architecture STRUCTURE of design_1_axil_timer_64_0_0 is
  signal \<const0>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of IRQ : signal is "xilinx.com:signal:interrupt:1.0 IRQ INTERRUPT";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of IRQ : signal is "master";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of IRQ : signal is "XIL_INTERFACENAME IRQ, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of S_AXI_ACLK : signal is "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK";
  attribute X_INTERFACE_MODE of S_AXI_ACLK : signal is "slave";
  attribute X_INTERFACE_PARAMETER of S_AXI_ACLK : signal is "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET S_AXI_ARESETN, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_ARESETN : signal is "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST";
  attribute X_INTERFACE_MODE of S_AXI_ARESETN : signal is "slave";
  attribute X_INTERFACE_PARAMETER of S_AXI_ARESETN : signal is "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_ARREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  attribute X_INTERFACE_INFO of S_AXI_ARVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  attribute X_INTERFACE_INFO of S_AXI_AWREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWREADY";
  attribute X_INTERFACE_INFO of S_AXI_AWVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWVALID";
  attribute X_INTERFACE_INFO of S_AXI_BREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI BREADY";
  attribute X_INTERFACE_INFO of S_AXI_BVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI BVALID";
  attribute X_INTERFACE_INFO of S_AXI_RREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  attribute X_INTERFACE_INFO of S_AXI_RVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
  attribute X_INTERFACE_INFO of S_AXI_WREADY : signal is "xilinx.com:interface:aximm:1.0 S_AXI WREADY";
  attribute X_INTERFACE_INFO of S_AXI_WVALID : signal is "xilinx.com:interface:aximm:1.0 S_AXI WVALID";
  attribute X_INTERFACE_INFO of S_AXI_ARADDR : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  attribute X_INTERFACE_INFO of S_AXI_AWADDR : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWADDR";
  attribute X_INTERFACE_MODE of S_AXI_AWADDR : signal is "slave";
  attribute X_INTERFACE_PARAMETER of S_AXI_AWADDR : signal is "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of S_AXI_BRESP : signal is "xilinx.com:interface:aximm:1.0 S_AXI BRESP";
  attribute X_INTERFACE_INFO of S_AXI_RDATA : signal is "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  attribute X_INTERFACE_INFO of S_AXI_RRESP : signal is "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
  attribute X_INTERFACE_INFO of S_AXI_WDATA : signal is "xilinx.com:interface:aximm:1.0 S_AXI WDATA";
  attribute X_INTERFACE_INFO of S_AXI_WSTRB : signal is "xilinx.com:interface:aximm:1.0 S_AXI WSTRB";
begin
  S_AXI_BRESP(1) <= \<const0>\;
  S_AXI_BRESP(0) <= \<const0>\;
  S_AXI_RRESP(1) <= \<const0>\;
  S_AXI_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_1_axil_timer_64_0_0_axil_timer_64
     port map (
      IRQ => IRQ,
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARADDR(1 downto 0) => S_AXI_ARADDR(3 downto 2),
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_AWADDR(1 downto 0) => S_AXI_AWADDR(3 downto 2),
      S_AXI_AWREADY => S_AXI_AWREADY,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_BREADY => S_AXI_BREADY,
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_RDATA(31 downto 0) => S_AXI_RDATA(31 downto 0),
      S_AXI_RREADY => S_AXI_RREADY,
      S_AXI_WDATA(31 downto 0) => S_AXI_WDATA(31 downto 0),
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_WVALID => S_AXI_WVALID,
      rvalid_int_reg_0 => S_AXI_RVALID
    );
end STRUCTURE;
