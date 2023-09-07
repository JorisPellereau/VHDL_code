#
import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class


# Create SCN Class
scn = scn_class.scn_class()

scn.print_step("Wait for Reset")

f_path = "/home/linux-jp/SIMULATION_VHDL"
f_instruction = f_path + "/instructions.mem"


scn.WTRS("RST_N")

scn.WAIT(5, "ms")



scn.END_TEST()
