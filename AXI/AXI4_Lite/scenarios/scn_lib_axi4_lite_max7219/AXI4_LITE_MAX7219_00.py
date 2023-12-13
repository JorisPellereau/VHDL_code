# AXI4_LITE_MAX7219_00
#
# TEST Interface AXI4 Lite - Read and write to registers
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

scn.WAIT(200, "ns")


scn.print_step("Read Registers")

scn.MASTER_AXI4LITE_READ(alias        = "MASTER_AXI4LITE_0",
                         addr         = 0x00,
                         data         = 0x00,
                         expc         = 0x00000000,
                         timeout      = None,
                         timout_unity = None)


scn.MASTER_AXI4LITE_READ(alias        = "MASTER_AXI4LITE_0",
                         addr         = 0x04,
                         data         = 0x00,
                         expc         = 0,
                         timeout      = None,
                         timout_unity = None)


scn.MASTER_AXI4LITE_READ(alias        = "MASTER_AXI4LITE_0",
                         addr         = 0x08,
                         data         = 0x01,
                         expc         = 0x00000000,
                         timeout      = None,
                         timout_unity = None)

scn.WAIT(200, "ns")

scn.print_step("Write Registers")

scn.MASTER_AXI4LITE_WRITE("MASTER_AXI4LITE_0", 0x04, 0x1, 0x00, 0) # Send NOOP Command


scn.END_TEST()
