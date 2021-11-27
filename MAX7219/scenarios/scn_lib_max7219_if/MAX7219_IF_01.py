# MAX7219_IF_01.py
# Use for the generation of the scenario MAX7219_IF_01.txt
#
# Test if start request are rejected during a frame generation - No LOAD generated
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
scn = scn_class.scn_class("MAX7219_IF_01.txt")

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1 - Init Value and send a frame - Send that it is MSB first\n")
scn.print_line("\n")

i_data = 0xBABA
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


scn.print_line("//-- STEP 1 - Init Value and send a frame - Start again during the frame generation\n")
scn.print_line("\n")

i_data = 0xBEBE
scn.generic_tb_cmd.SET("I_DATA", i_data)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_START", 0)

for i in range(0, 10*6):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 0)
    i_data_tmp = i + 0x10
    scn.generic_tb_cmd.SET("I_DATA", i_data_tmp)


scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i_data, "OK")

scn.generic_tb_cmd.WTRS("O_DONE")


scn.print_line("//-- STEP 2 - Init Value and send a frame - Stuck Start input to '1' and change i_data\n")
scn.print_line("\n")

i_data = 0xDEAD
scn.generic_tb_cmd.SET("I_DATA", i_data)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)

for i in range(0, 10*6):    
    scn.generic_tb_cmd.WTFS("CLK")
    i_data_tmp = i + 0x10
    scn.generic_tb_cmd.SET("I_DATA", i_data_tmp)


scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i_data, "OK")

scn.generic_tb_cmd.WTRS("O_DONE")


scn.generic_tb_cmd.WAIT(100, "ns")



    

scn.END_TEST()
