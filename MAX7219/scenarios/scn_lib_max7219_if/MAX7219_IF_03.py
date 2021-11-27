# MAX7219_IF_02.py
# Use for the generation of the scenario MAX7219_IF_03.txt
#
# Test the generation of o_max7219_load - Change the length of G_LOAD_DURATION
#
# Dut configuration :
# Input Frequency : 50MHz
# G_MAX_HALF_PERIOD == 4 => o_max7219_clk = 6.250MHz
# G_LOAD_DURATION   == 40 => o_max7219_load have a duration of 40*(1/50MHz)

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Create SCN Class
scn = scn_class.scn_class("MAX7219_IF_03.txt")

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1 - Init Value and send a frame - Enable LOAD for this frame\n")
scn.print_line("\n")

i_data = 0xBABA
scn.generic_tb_cmd.SET("I_DATA", i_data)
scn.generic_tb_cmd.SET("I_EN_LOAD", 1)
scn.generic_tb_cmd.SET("I_START", 0)

scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_DATA", 0x0000)

scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i_data, "OK")

# LOAD Flag must me rised before o_done
scn.generic_tb_cmd.WTRS("O_MAX7219_LOAD")
scn.generic_tb_cmd.WTRS("O_DONE")


scn.generic_tb_cmd.WAIT(100, "ns")

scn.print_line("//-- STEP 1 - Init Value and send a frame - Enable LOAD after start pulse - No LOAD must be generated\n")
scn.print_line("\n")

i_data = 0xBEAF
scn.generic_tb_cmd.SET("I_DATA", i_data)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_START", 0)

scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
scn.generic_tb_cmd.SET("I_DATA", 0x0000)
for i in range(0, 10):
    scn.generic_tb_cmd.WTFS("CLK")

scn.generic_tb_cmd.SET("I_EN_LOAD", 1)


scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i_data, "OK")

# # No LOAD must be generated
scn.generic_tb_cmd.WTRS("O_DONE")

scn.generic_tb_cmd.WAIT(100, "ns")


scn.print_line("//-- STEP 2 - Init Value and send a frame - Enable LOAD for 10 frames\n")
scn.print_line("\n")


for i in range(0, 10):
    scn.generic_tb_cmd.SET("I_DATA", i)
    scn.generic_tb_cmd.SET("I_EN_LOAD", 1)
    scn.generic_tb_cmd.SET("I_START", 0)

    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 0)
    scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
    scn.generic_tb_cmd.SET("I_DATA", 0x0000)

    scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
    scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i, "OK")

    # LOAD Flag must me rised before o_done
    scn.generic_tb_cmd.WTRS("O_MAX7219_LOAD")
    scn.generic_tb_cmd.WTRS("O_DONE")


scn.generic_tb_cmd.WAIT(100, "ns")

scn.print_line("//-- STEP 3 - Init Value and send a frame - Enable LOAD for Even frames\n")
scn.print_line("\n")

scn.generic_tb_cmd.WAIT(300, "ns")

for i in range(0, 6):
    scn.generic_tb_cmd.SET("I_DATA", i)
    if(i & 0x1 == 0):
        scn.generic_tb_cmd.SET("I_EN_LOAD", 1)
    else:
        scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
    scn.generic_tb_cmd.SET("I_START", 0)

    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_START", 0)
    scn.generic_tb_cmd.SET("I_EN_LOAD", 0)
    scn.generic_tb_cmd.SET("I_DATA", 0x0000)

    scn.generic_tb_cmd.WTRS("S_FRAME_RECEIVED")
    scn.generic_tb_cmd.CHK("S_DATA_RECEIVED", i, "OK")

    # LOAD Flag must me rised before o_done
    if(i & 0x1 == 0):
        scn.generic_tb_cmd.WTRS("O_MAX7219_LOAD")
    scn.generic_tb_cmd.WTRS("O_DONE")


scn.generic_tb_cmd.WAIT(100, "ns")

    

scn.END_TEST()
