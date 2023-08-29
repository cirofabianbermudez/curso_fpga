set_property IOSTANDARD LVCMOS33 [get_ports btn]
set_property IOSTANDARD LVCMOS33 [get_ports button_out1]
set_property IOSTANDARD LVCMOS33 [get_ports button_out2]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports dbsig]
set_property IOSTANDARD LVCMOS33 [get_ports LED]
set_property PACKAGE_PIN W19 [get_ports btn]
set_property PACKAGE_PIN K17 [get_ports button_out1]
set_property PACKAGE_PIN M18 [get_ports button_out2]
set_property PACKAGE_PIN W5 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]
set_property PACKAGE_PIN N17 [get_ports dbsig]
set_property PACKAGE_PIN U16 [get_ports LED]



