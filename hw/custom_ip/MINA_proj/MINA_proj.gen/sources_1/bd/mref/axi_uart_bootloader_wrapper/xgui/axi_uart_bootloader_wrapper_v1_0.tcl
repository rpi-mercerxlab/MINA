# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BAUD_RATE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BRAM_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLK_FREQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NPU_HOST_ADDR_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to update AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to validate AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.BAUD_RATE { PARAM_VALUE.BAUD_RATE } {
	# Procedure called to update BAUD_RATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BAUD_RATE { PARAM_VALUE.BAUD_RATE } {
	# Procedure called to validate BAUD_RATE
	return true
}

proc update_PARAM_VALUE.BRAM_ADDR_WIDTH { PARAM_VALUE.BRAM_ADDR_WIDTH } {
	# Procedure called to update BRAM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BRAM_ADDR_WIDTH { PARAM_VALUE.BRAM_ADDR_WIDTH } {
	# Procedure called to validate BRAM_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.CLK_FREQ { PARAM_VALUE.CLK_FREQ } {
	# Procedure called to update CLK_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_FREQ { PARAM_VALUE.CLK_FREQ } {
	# Procedure called to validate CLK_FREQ
	return true
}

proc update_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to update FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to validate FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.NPU_HOST_ADDR_WIDTH { PARAM_VALUE.NPU_HOST_ADDR_WIDTH } {
	# Procedure called to update NPU_HOST_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NPU_HOST_ADDR_WIDTH { PARAM_VALUE.NPU_HOST_ADDR_WIDTH } {
	# Procedure called to validate NPU_HOST_ADDR_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.CLK_FREQ { MODELPARAM_VALUE.CLK_FREQ PARAM_VALUE.CLK_FREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_FREQ}] ${MODELPARAM_VALUE.CLK_FREQ}
}

proc update_MODELPARAM_VALUE.BAUD_RATE { MODELPARAM_VALUE.BAUD_RATE PARAM_VALUE.BAUD_RATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BAUD_RATE}] ${MODELPARAM_VALUE.BAUD_RATE}
}

proc update_MODELPARAM_VALUE.AXI_ADDR_WIDTH { MODELPARAM_VALUE.AXI_ADDR_WIDTH PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.FIFO_DEPTH { MODELPARAM_VALUE.FIFO_DEPTH PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_DEPTH}] ${MODELPARAM_VALUE.FIFO_DEPTH}
}

proc update_MODELPARAM_VALUE.BRAM_ADDR_WIDTH { MODELPARAM_VALUE.BRAM_ADDR_WIDTH PARAM_VALUE.BRAM_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BRAM_ADDR_WIDTH}] ${MODELPARAM_VALUE.BRAM_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.NPU_HOST_ADDR_WIDTH { MODELPARAM_VALUE.NPU_HOST_ADDR_WIDTH PARAM_VALUE.NPU_HOST_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NPU_HOST_ADDR_WIDTH}] ${MODELPARAM_VALUE.NPU_HOST_ADDR_WIDTH}
}

