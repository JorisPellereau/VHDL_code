# MAX_CONTROLLER_02.py
# Use for the generation of the scenario MAX_CONTROLLER_02.txt
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


# Create SCN Class
generic_cmd_scn_max_controller_02 = scn_class.scn_class("MAX_CONTROLLER_02.txt")


# Start of SCN

generic_cmd_scn_max_controller_02.print_line("-- STEP 0\n")
generic_cmd_scn_max_controller_02.print_line("\n")

generic_cmd_scn_max_controller_02.generic_tb_cmd.WTR("RST_N")
generic_cmd_scn_max_controller_02.generic_tb_cmd.WAIT(100, "ns")
generic_cmd_scn_max_controller_02.print_line("\n")


generic_cmd_scn_max_controller_02.print_line("-- STEP 1\n")
generic_cmd_scn_max_controller_02.print_line("-- Init RAMs with 0\n")
generic_cmd_scn_max_controller_02.print_line("\n")

generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ME_SCROLLER", 1)
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WE_SCROLLER", 1)
generic_cmd_scn_max_controller_02.print_line("\n")

for i in range(0, 256):
    generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")
    generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ADDR_SCROLLER", i)
    generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WDATA_SCROLLER", 0)
    generic_cmd_scn_max_controller_02.print_line("\n")

generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")    
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ME_SCROLLER", 0)
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WE_SCROLLER", 0)
generic_cmd_scn_max_controller_02.print_line("\n")





generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ME_STATIC", 1)
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WE_STATIC", 1)
generic_cmd_scn_max_controller_02.print_line("\n")

for i in range(0, 256):
    generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")
    generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ADDR_STATIC", i)
    generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WDATA_STATIC", 0)
    generic_cmd_scn_max_controller_02.print_line("\n")

generic_cmd_scn_max_controller_02.generic_tb_cmd.WTFS("CLK")    
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_ME_STATIC", 0)
generic_cmd_scn_max_controller_02.generic_tb_cmd.SET("I_WE_STATIC", 0)
generic_cmd_scn_max_controller_02.print_line("\n")



generic_cmd_scn_max_controller_02.generic_tb_cmd.WAIT(100, "us")   
generic_cmd_scn_max_controller_02.END_TEST()


