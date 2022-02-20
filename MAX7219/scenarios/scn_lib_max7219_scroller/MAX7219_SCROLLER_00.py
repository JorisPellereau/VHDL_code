# MAX7219_SCROLLER_00.py
# Use for the generation of the scenario MAX7219_SCROLLER_00.txt
#
# Write in memory and read back
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_scroller_class

 # Create SCN Class
scn       = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_SCROLLER_{:02d}_collect.txt"
 

# Create SCN Macro
scn_macros = macros_max_scroller_class.macros_max_scroller_class(scn)

# Start of SCN

scn.print_step("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(0))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

scn.print_step("INIT RAM")

ram_addr = 0
ram_data = [i for i in range(256)]
scn_macros.write_data_in_ram(ram_addr, ram_data)

scn.print_step("READ RAM")

scn.WTFS("CLK")
for i in range(0, 256):
    scn.SET("ME", 1)
    scn.SET("WE", 0)
    scn.SET("ADDR", i)
    scn.WTFS("CLK")
    scn.WTFS("CLK")
    scn.CHK("O_RDATA", ram_data[i], "OK")
#    scn.WTFS("CLK")


scn.DATA_COLLECTOR_STOP("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
