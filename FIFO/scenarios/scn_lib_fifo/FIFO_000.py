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

scn.WAIT(10, "us")

scn.print_step("LOAD RAM until FULL")

for j in range(4):
    for i in range(0, 256):
        scn.WTFS("CLK")
        scn.SET("WR_EN",1)
        scn.SET("WDATA", i)

scn.WTFS("CLK")
scn.SET("WR_EN",0)
scn.SET("WDATA", 0)

scn.CHK("FIFO_FULL", 1, "OK")
scn.CHK("FIFO_EMPTY", 1, "OK")

scn.WAIT(25, "us")

scn.print_step("Read Entire RAM until empty")

scn.SET("WDATA", 0)

for j in range(4):
    for i in range(0, 256):
        scn.WTFS("CLK")
        scn.SET("RD_EN",1)
        

scn.WTFS("CLK")

scn.CHK("FIFO_FULL", 0, "OK")
scn.CHK("FIFO_EMPTY", 1, "OK")

scn.WAIT(25, "us")

scn.END_TEST()
