set_property SRC_FILE_INFO {cfile:e:/Project/E203_P1_Zynq7015_copy/E203_P1_Zynq7015_copy.gen/sources_1/ip/PLL/PLL.xdc rfile:../../../E203_P1_Zynq7015_copy.gen/sources_1/ip/PLL/PLL.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports CLK_I_50M]] 0.200
