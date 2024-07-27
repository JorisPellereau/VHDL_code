# TOP_WATCH_00
#
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

scn.WAIT(100, "ns")

scn.END_TEST()
