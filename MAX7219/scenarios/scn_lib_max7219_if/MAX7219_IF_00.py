# MAX7219_IF_00.py
# Use for the generation of the scenario MAX7219_IF_00.txt
#
# A simple Test of MAX7219 Frame generation
# 

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Create SCN Class
scn = scn_class.scn_class("MAX7219_IF_00.txt")

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")


scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.END_TEST()
