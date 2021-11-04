# MAX7219_IF_00.py
# Use for the generation of the scenario MAX7219_IF_00.txt
#
# A simple Test of MAX7219 Frame generation
# 

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Create SCN Class
scn = scn_class.scn_class("MAX7219_IF_00.txt")

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")

scn.print_line("//-- STEP 1 - Check Initial Value of ouputs\n")
scn.print_line("\n")

scn.generic_tb_cmd.CHK("O_MAX7219_LOAD", 0, "ERROR")
scn.generic_tb_cmd.CHK("O_MAX7219_DATA", 0x0000, "ERROR")
scn.generic_tb_cmd.CHK("O_MAX7219_CLK", 0, "ERROR")
scn.generic_tb_cmd.CHK("O_DONE", 0, "ERROR")
scn.generic_tb_cmd.WAIT(100, "ns")

scn.print_line("//-- STEP 2 - Init Value and send a frame\n")
scn.print_line("\n")

scn.generic_tb_cmd.SET("I_DATA", 0xFFFF)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_START", 0)

scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.SET("I_DATA", 0x0000)

scn.generic_tb_cmd.WTFS("O_DONE")



scn.END_TEST()
