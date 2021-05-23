# MAX_CONTROLLER_034py
# Use for the generation of the scenario MAX_CONTROLLER_04.txt
#
# Load STATIC and SCROLLER RAM with 4 differents pattern over entire memories
# Display Static Pattern and then Scroller Pattern


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

scn = scn_class.scn_class("MAX_CONTROLLER_04.txt")

# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.END_TEST()
