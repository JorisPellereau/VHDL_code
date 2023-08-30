# AXI4_LITE_7SEG_000.py
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
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
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

nb_data = 10
data_list = [i for i in range(nb_data)]
for i in data_list:
    # PErform a Write Access
    scn.WTFS("CLK")
    scn.SET("START", 1)
    scn.SET("MASTER_WDATA", i)
    scn.SET("RNW", 0)
    scn.WTFS("CLK")
    scn.SET("START", 0)

    scn.WAIT(200, "ns")

    # Perform a Read Access
    scn.WTFS("CLK")
    scn.SET("START", 1)
    scn.SET("MASTER_WDATA", i)
    scn.SET("RNW", 1)
    scn.WTFS("CLK")
    scn.SET("START", 0)
    
    scn.WAIT(300, "ns")

scn.END_TEST()
