# JTAG_AXI4_LITE_TOP_00
#
# Test of READ/WRITE Access to Slaves
# 
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
#print(dir(macros_scn.scn))
# FUNCTIONS


scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

scn.WAIT(200, "ns")

scn.print_step("Read Initial Value of each registers of each slaves")

scn.print_sub_step("7 Segments Slaves Read access")
macros_scn.axi4_lite_read(0x0000, 0x0, 0)

scn.print_sub_step("LCD slave Read access")
macros_scn.axi4_lite_read(0x1000, 0x00000000, 0)
macros_scn.axi4_lite_read(0x1004, 0x00000000, 0)
macros_scn.axi4_lite_read(0x1008, 0x00000002, 0)


scn.WAIT(200, "ns")

scn.print_step("Write in registers and read it back")

scn.print_sub_step("Write in 7 Segments slave")
macros_scn.axi4_lite_write(0x0000, 0xCAFEDECA, 0, 0)
macros_scn.axi4_lite_read(0x0000, 0xCAFEDECA, 0)

scn.print_sub_step("Write LCD with no STROBE and read it back - Error expected on Write access")
macros_scn.axi4_lite_write(0x1000, 0x12345678, 0, 0)
macros_scn.axi4_lite_read(0x1000, 0, 0)

# No strobe -> 
macros_scn.axi4_lite_write(0x1004, 0xAABBCCDD, 0, 0)
macros_scn.axi4_lite_read(0x1004, 0, 0)

# Read only register -> error expected
macros_scn.axi4_lite_write(0x1008, 0xDEADBEEF, 0, 2)
macros_scn.axi4_lite_read(0x1008, 0x00000002, 0)


scn.print_step("Write in registers and read it back")

scn.print_sub_step("Write in 7 Segments slave and read it back")
macros_scn.axi4_lite_write(0x0000, 0xCAFEC0C0, 0, 0)
macros_scn.axi4_lite_read(0x0000, 0xCAFEC0C0, 0)

scn.print_sub_step("Write LCD with STROBE and read it back - No Error expected on Write access")
macros_scn.axi4_lite_write(0x1000, 0xFFFFFFFF, 0xF, 0)

# Read only Usefull bits, others bits stay at '0'
macros_scn.axi4_lite_read(0x1000, 0x03070301, 0)


# Write Error because LCD_CMD is written with multiple bits, other field are correctly set
macros_scn.axi4_lite_write(0x1004, 0xFFFFFFFF, 0xF, 2)
macros_scn.axi4_lite_read(0x1004, 0x001FFF07, 0)

# Read only register -> error expected
macros_scn.axi4_lite_write(0x1008, 0xFFFFFFFF, 0, 2)

# FIFO not empty because of previous wr_en_fifo access ( 1 data written so not empty neither full)
macros_scn.axi4_lite_read(0x1008, 0x00000000, 0)




scn.WAIT(200, "ns")

#n.print_comment("TOTO TEST !!!")



scn.END_TEST()
