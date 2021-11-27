# MAX7219_IF_00.py
# Use for the generation of the scenario MAX7219_IF_00.txt
#
# A simple Test of MAX7219 Frame generation
#
# Dut configuration :
# Input Frequency : 50MHz
# G_MAX_HALF_PERIOD == 4 => o_max7219_clk = 6.250MHz
# G_LOAD_DURATION   == 4 => o_max7219_load have a duration of 4*(1/50MHz)

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
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

scn.generic_tb_cmd.CHK("O_MAX7219_LOAD", 0, "OK")
scn.generic_tb_cmd.CHK("O_MAX7219_DATA", 0x0000, "OK")
scn.generic_tb_cmd.CHK("O_MAX7219_CLK", 0, "OK")
scn.generic_tb_cmd.CHK("O_DONE", 0, "OK")
scn.generic_tb_cmd.WAIT(100, "ns")

scn.print_line("//-- STEP 2 - Init Value and send a frame\n")
scn.print_line("\n")

i_data = 0xFFFF
scn.generic_tb_cmd.SET("I_DATA", i_data)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_START", 0)

scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.SET("I_DATA", 0x0000)

scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i_data, "OK")

scn.generic_tb_cmd.WTRS("O_DONE")


scn.generic_tb_cmd.WAIT(100, "ns")


scn.print_line("//-- STEP 3 - Test All Value of data : 0x0000 to 0xFFFF \n")
scn.print_line("\n")

i_data = 0x0000

for i in range(0, 0xFFFF + 1):
    scn.generic_tb_cmd.SET("I_DATA", i)
    scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
    scn.generic_tb_cmd.SET("I_START", 0)

    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 0)
    scn.generic_tb_cmd.SET("I_DATA", 0x0000)

    scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
    scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i, "OK")

    scn.generic_tb_cmd.WTRS("O_DONE")

    scn.generic_tb_cmd.WAIT(10, "ns")

    

scn.END_TEST()
