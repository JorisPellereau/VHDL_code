# JTAG_AXI4_LITE_TOP_01
#
# Test of the UPDATE command on LCD
#

import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class
import JTAG_AXI4_LITE_TOP_class


# Create SCN Class
scn = scn_class.scn_class()
macros_scn = JTAG_AXI4_LITE_TOP_class.JTAG_AXI4_LITE_TOP_class(scn)

# FUNCTIONS


scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

scn.WAIT(200, "ns")

scn.print_step("SET LCD ON on LCD")
macros_scn.axi4_lite_write(0x1000, 1, 0x1, 0)

scn.WAIT(200, "ns")

# Force the counter in order to accelerate the simulation
# 1st Counter
scn.MODELSIM_CMD("force -deposit {0} {1} 0".format(macros_scn.counter_init_path, "0B8530"))
scn.WTRS("S_DURATION_DONE", 10, "ms")
scn.WAIT(1, "us")

# 2nd Counter
scn.MODELSIM_CMD("force -deposit {0} {1} 0".format(macros_scn.counter_init_path, "033440"))
scn.WTRS("S_DURATION_DONE", 10, "ms")
scn.WAIT(120, "us")


scn.print_step("LOAD Data on LCD FIFO DISPLAY")

scn.print_step("Get Status : FIFO Is emplty and not  full")
macros_scn.axi4_lite_read(0x1008, 0x00000002, 0)


scn.print_step("Write a data ant Get Status : not empty and not full")
macros_scn.axi4_lite_write(0x1004, 0x00002600, 0x2, 0)
macros_scn.axi4_lite_read(0x1008, 0x00000000, 0)


scn.WAIT(200, "ns")

scn.print_step("Load 1023 data and check that the FIFO is full")
for i in range(0, 1023):
    if(i == 1022):
        data = 0x0000FF00
    else:
        data = 0x00004100
        
    macros_scn.axi4_lite_write(0x1004, data, 0x2, 0)
    
macros_scn.axi4_lite_read(0x1008, 0x00000000, 0)

scn.WAIT(200, "ns")


scn.print_step("Start the update all LCD DISPLAY Command")
macros_scn.axi4_lite_write(0x1004, 0x40000000, 0x8, 0)
scn.WAIT(100, "us")


scn.print_step("Start the update one char LCD DISPLAY Command")
# Update char position and set the command update one char
# Char position at 0
macros_scn.axi4_lite_write(0x1004, 0x80000000, 0xC, 0)
scn.WAIT(100, "us")



scn.END_TEST()
