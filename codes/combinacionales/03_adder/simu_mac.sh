#!/bin/bash

TIMEFORMAT='It took %R seconds.'

if [ $# -eq 0 ]; then
    echo "ERROR: Enter the the name of the verilog testbench with no extension"
    read -p "Press enter to continue"
    exit 1
else
    var=$1
fi

v=".v"
vvp=".vvp"
vcd=".vcd"

v_file="${var}${v}"
vvp_file="${var}${vvp}"
vcd_file="${var}${vcd}"

time {
echo "1. Compiling verilog code..."
iverilog -o $vvp_file $v_file
echo "2. Runing simulation..."
vvp $vvp_file
echo "3. Opening wave viewer.."
open -a gtkwave $vcd_file
}
