# MAX_STATIC_05.py
# Use for the generation of the scenario MAX_STATIC_05.txt
#
# Corner Tests
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class


# Create SCN Class
scn_max_static_05 = scn_class.scn_class("MAX_STATIC_05.txt")


# Start of SCN

scn_max_static_05.print_line("//-- STEP 0\n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTR("RST_N")
scn_max_static_05.generic_tb_cmd.WAIT(100, "ns")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 0\n")
scn_max_static_05.print_line("//-- INIT STATIC\n")
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.SET("EN", 1)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 2)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")




scn_max_scroller_04.END_TEST()
