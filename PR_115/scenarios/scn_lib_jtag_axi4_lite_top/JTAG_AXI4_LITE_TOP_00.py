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

#f_path = "/home/linux-jp/SIMULATION_VHDL"
#f_instruction = f_path + "/instructions.mem"


scn.WTRS("RST_N")

scn.WAIT(200, "ns")


scn.print_step("1st Write - NO ERROR EXPECTED")
macros_scn.axi4_lite_write(0x0, 0xCAFEDECA, 0, 0)

scn.WAIT(200, "ns")

scn.print_step("2nd Write - ERROR EXPECTED")
macros_scn.axi4_lite_write(0x4, 0xCAFEDECA, 0, 2)

scn.print_step("Write 7SEGS and read it back")
macros_scn.axi4_lite_write(0x0, 0x12345678, 0, 0)
macros_scn.axi4_lite_read(0x0, 0x12345678, 0)

scn.WAIT(200, "ns")


scn.print_step("SET LCD ON on LCD")
macros_scn.axi4_lite_write(0x1000, 1, 0x1, 0)
scn.WAIT(30, "ms")

scn.END_TEST()
