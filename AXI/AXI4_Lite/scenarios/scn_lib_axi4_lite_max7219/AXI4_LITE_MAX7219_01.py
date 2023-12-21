# AXI4_LITE_MAX7219_01
#
# TEST Interface AXI4 Lite - Write in FIFO - No data send
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

import axi4_lite_max7219_class

axi4_lite_max7219 = axi4_lite_max7219_class.axi4_lite_max7219_class(scn)

scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

scn.WAIT(200, "ns")


scn.print_step("Write NOOP Command for each Matrix")

for i in range(0, axi4_lite_max7219.G_NB_MATRIX):
    axi4_lite_max7219.write_commands(cmd        = "NOOP",
                                     data       = 0x0A,
                                     matrix_idx = i)
    scn.WAIT(200, "ns")


scn.END_TEST()
