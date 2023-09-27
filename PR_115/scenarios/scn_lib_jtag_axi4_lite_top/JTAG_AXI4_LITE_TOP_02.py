# JTAG_AXI4_LITE_TOP_02
#
# Test of the UPDATE of single command of LCD following by all display command
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




scn.print_step("Load a Data in the FIFO and Display it to the LCD")

# Initialize data in order to Display :
# Hello, ca marche
# ????!!!!????!!!!
ddram_addr_list = macros_scn.lcd_str_to_ddram_addr("Hello, ca marche????!!!!????!!!!")
print(ddram_addr_list)
for i, data in enumerate(ddram_addr_list):

    scn.print_sub_step("Load the data into the FIFO 0x{0} == {1}".format(i, chr(i)))
    macros_scn.axi4_lite_write(0x1004, ((data << 8) & 0xFFFFFFFF), 0x2, 0)

    
    scn.print_sub_step("Start the update one char LCD DISPLAY Command - Position : {0}".format(i))    
    # Update char position and set the command update one char
    macros_scn.axi4_lite_write(0x1004, (((0x80 << 3*8) | (i << 2*8)) & 0xFFFFFFFF), 0xC, 0)
    scn.WAIT(50, "us")



scn.print_step("Update the entire display")

# Initialize data in order to Display :
# Je pense que oui
# CA MARCHE BIEN !
ddram_addr_list = macros_scn.lcd_str_to_ddram_addr("Je pense que ouiCA MARCHE BIEN !")
print(ddram_addr_list)

scn.print_sub_step("Load all the data for the display")

for i, data in enumerate(ddram_addr_list):   
    macros_scn.axi4_lite_write(0x1004, ((data << 8) & 0xFFFFFFFF), 0x2, 0)
    
scn.print_sub_step("Start the update all LCD DISPLAY Command")
# Update char position and set the command update one char
macros_scn.axi4_lite_write(0x1004, ((0x40 << 3*8) & 0xFFFFFFFF), 0xC, 0)
scn.WAIT(100, "us")

    
    
scn.END_TEST()
