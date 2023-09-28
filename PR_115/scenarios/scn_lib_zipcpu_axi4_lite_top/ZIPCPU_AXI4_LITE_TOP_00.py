# ZIPCPU_AXI4_LITE_TOP_00
#
# DEBUG TEST
# 
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

scn.WTRS("RST_N")

scn.WAIT(20, "us")



scn.END_TEST()
