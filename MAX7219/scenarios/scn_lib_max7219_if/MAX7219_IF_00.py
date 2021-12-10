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
import scn_class

# Create SCN Class
scn = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_IF_{:02d}_collect.txt"

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1 - Check Initial Value of ouputs\n")
scn.print_line("\n")

scn.CHK("O_MAX7219_LOAD", 0, "OK")
scn.CHK("O_MAX7219_DATA", 0x0000, "OK")
scn.CHK("O_MAX7219_CLK", 0, "OK")
scn.CHK("O_DONE", 0, "OK")
scn.WAIT(100, "ns")

scn.print_line("//-- STEP 2 - Init Value and send a frame\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_IF_INPUT_COLLECTOR_0", 0, collect_path.format(0))

i_data = 0xFFFF
scn.SET("I_DATA", i_data)
scn.SET("I_EN_LOAD", 0)
scn.SET("I_START", 0)

scn.WTFS("CLK")

scn.DATA_COLLECTOR_START("MAX7219_IF_INPUT_COLLECTOR_0", 0)

scn.SET("I_START", 1)
scn.WTFS("CLK")
scn.SET("I_START", 0)
scn.SET("I_DATA", 0x0000)

scn.WTRS("S_FRAME_RECEIVED")
scn.CHK("S_DATA_RECEIVED", i_data, "OK")

scn.WTRS("O_DONE")


scn.WAIT(100, "ns")




scn.print_line("//-- STEP 3 - Test All Value of data : 0x0000 to 0xFFFF \n")
scn.print_line("\n")

i_data = 0x0000

if(len(sys.argv) == 1):
    max_data = 0xFFFF    
else:
    max_data = int(sys.argv[1])

max_data += 1

for i in range(0, max_data):
    scn.SET("I_DATA", i)
    scn.SET("I_EN_LOAD", 0)
    scn.SET("I_START", 0)

    scn.WTFS("CLK")
    scn.SET("I_START", 1)
    scn.WTFS("CLK")
    scn.SET("I_START", 0)
    scn.SET("I_DATA", 0x0000)

    scn.WTRS("S_FRAME_RECEIVED")
    scn.CHK("S_DATA_RECEIVED", i, "OK")

    scn.WTRS("O_DONE")

    scn.WAIT(10, "ns")


scn.DATA_COLLECTOR_STOP("MAX7219_IF_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_IF_INPUT_COLLECTOR_0", 0)


scn.END_TEST()
