# SCENARIO For I2C Master block
#
#
#
#


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class


scn = scn_class.scn_class("I2C_MASTER_00.txt")


# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")




scn.END_TEST()
