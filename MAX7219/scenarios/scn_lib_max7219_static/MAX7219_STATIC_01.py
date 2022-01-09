# MAX7219_STATIC_01.py
# Use for the generation of the scenario MAX_STATIC_01.txt
#
#
# Aim of test : Test RAM I/F - Write data and read back memory from port A
#

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_static_class

# Create SCN Class
scn       = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class()


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.print_line("//-- STEP 1\n")
scn.print_line("//-- INIT RAM with data")

scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for j in range(0, 256):
    # Init DECODE MODE
    scn.SET("ADDR", j)
    scn.SET("WDATA", j)
    scn.WTFS("CLK")

scn.WTFS("CLK")    
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

scn.print_line("//-- READ BACK RAM and check data")

scn.SET("ME", 1)
scn.SET("WE", 0) # Read access
for j in range(0, 256):
    scn.SET("ADDR", j)
    scn.WTFS("CLK")
    scn.WTFS("CLK") # 2 Clock period before data enable
    scn.CHK("O_RDATA", j, "OK")
    
scn.WTFS("CLK")    
scn.SET("ME", 0)
scn.SET("WE", 0)

scn.WAIT(100, "ns")

scn.END_TEST()
