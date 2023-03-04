# AXI4_LITE_000.py
# Test of AXI4 Lite
# 
# 
# 
# 
# 
# 
# 

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import scn_class

# Create SCN Class
scn = scn_class.scn_class()


# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")



scn.END_TEST()
