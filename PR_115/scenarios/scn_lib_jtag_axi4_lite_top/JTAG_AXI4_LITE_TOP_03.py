# JTAG_AXI4_LITE_TOP_03
#
# Test of single command of LCD
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



scn.print_step("Run command Clear Display")
macros_scn.axi4_lite_write(0x1004, 0x01000000, 0x8, 0)

scn.WAIT(200, "ns")



scn.print_step("Run return_gome_command")
macros_scn.axi4_lite_write(0x1004, 0x02000000, 0x8, 0)

scn.WAIT(200, "ns")



scn.print_step("Set entry Mode set configuration and set up command")

scn.print_sub_step("Set entry set configuration")
macros_scn.axi4_lite_write(0x1000, 0x00000300, 0x2, 0)

scn.print_sub_step("Set entry set command")
macros_scn.axi4_lite_write(0x1004, 0x04000000, 0x8, 0)

scn.WAIT(200, "ns")




scn.print_step("Set display_on_off configuration and set up command")

scn.print_sub_step("Set display_on_off configuration")
macros_scn.axi4_lite_write(0x1000, 0x00070000, 0x4, 0)

scn.print_sub_step("Set display_on_off command")
macros_scn.axi4_lite_write(0x1004, 0x08000000, 0x8, 0)

scn.WAIT(200, "ns")




scn.print_step("Set cursor_shift configuration and set up command")

scn.print_sub_step("Set cursor_shift configuration")
macros_scn.axi4_lite_write(0x1000, 0x03000000, 0x8, 0)

scn.print_sub_step("Set cursor_shift command")
macros_scn.axi4_lite_write(0x1004, 0x10000000, 0x8, 0)

scn.WAIT(200, "ns")




scn.print_step("Set function_set configuration and set up command")

scn.print_sub_step("Set function_set configuration")
macros_scn.axi4_lite_write(0x1004, 0x00000007, 0x1, 0)

scn.print_sub_step("Set function_set command")
macros_scn.axi4_lite_write(0x1004, 0x20000000, 0x8, 0)

scn.WAIT(200, "ns")






    
scn.END_TEST()
