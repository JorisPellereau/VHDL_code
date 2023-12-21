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

scn.MASTER_AXI4LITE_READ("MASTER_AXI4LITE_0", 0x00, 0x00, 0x00000000)
scn.MASTER_AXI4LITE_READ("MASTER_AXI4LITE_0", 0x04, 0x00, 0x00000000)
scn.MASTER_AXI4LITE_READ("MASTER_AXI4LITE_0", 0x08, 0x01, 0x00000000)

scn.WAIT(200, "ns")

scn.print_step("Write Registers")

scn.MASTER_AXI4LITE_WRITE("MASTER_AXI4LITE_0", 0x00, 0x1, 0x00, 0) # Enable the Block
scn.MASTER_AXI4LITE_WRITE("MASTER_AXI4LITE_0", 0x04, 0x1, 0x00, 0) # Send NOOP Command
scn.MASTER_AXI4LITE_WRITE("MASTER_AXI4LITE_0", 0x08, 0xFFFFFFFF, 0x00, 0x2) # Write in status register -> Error expected


scn.END_TEST()
