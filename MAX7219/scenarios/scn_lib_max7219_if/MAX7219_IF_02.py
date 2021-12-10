# MAX7219_IF_02.py
# Use for the generation of the scenario MAX7219_IF_02.txt
#
# Test the generation of o_max7219_load
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

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX721_COLLECT/MAX7219_IF_{:02d}_collect.txt"

# Create SCN Class
scn = scn_class.scn_class()

# Start of SCN
scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_IF_INPUT_COLLECTOR_0", 0, collect_path.format(2))
scn.DATA_COLLECTOR_START("MAX7219_IF_INPUT_COLLECTOR_0", 0)


scn.print_line("//-- STEP 1 - Init Value and send a frame - Enable LOAD for this frame\n")
scn.print_line("\n")

i_data = 0xBABA
scn.SET("I_DATA", i_data)
scn.SET("I_EN_LOAD", 1)
scn.SET("I_START", 0)

scn.WTFS("CLK")
scn.SET("I_START", 1)
scn.WTFS("CLK")
scn.SET("I_START", 0)
scn.SET("I_EN_LOAD", 0)
scn.SET("I_DATA", 0x0000)

scn.WTRS("S_FRAME_RECEIVED")
scn.CHK("S_DATA_RECEIVED", i_data, "OK")

# LOAD Flag must me rised before o_done
scn.WTRS("O_MAX7219_LOAD")
scn.WTRS("O_DONE")


scn.WAIT(100, "ns")

scn.print_line("//-- STEP 1 - Init Value and send a frame - Enable LOAD after start pulse - No LOAD must be generated\n")
scn.print_line("\n")

i_data = 0xBEAF
scn.SET("I_DATA", i_data)
scn.SET("I_EN_LOAD", 0)
scn.SET("I_START", 0)

scn.WTFS("CLK")
scn.SET("I_START", 1)
scn.WTFS("CLK")
scn.SET("I_START", 0)
scn.SET("I_EN_LOAD", 0)
scn.SET("I_DATA", 0x0000)
for i in range(0, 10):
    scn.WTFS("CLK")

scn.SET("I_EN_LOAD", 1)


scn.WTRS("S_FRAME_RECEIVED")
scn.CHK("S_DATA_RECEIVED", i_data, "OK")

# No LOAD must be generated
scn.WTRS("O_DONE")

scn.WAIT(100, "ns")


scn.print_line("//-- STEP 2 - Init Value and send a frame - Enable LOAD for all frame\n")
scn.print_line("\n")


for i in range(0, 0xFFFF + 1):
    scn.SET("I_DATA", i)
    scn.SET("I_EN_LOAD", 1)
    scn.SET("I_START", 0)

    scn.WTFS("CLK")
    scn.SET("I_START", 1)
    scn.WTFS("CLK")
    scn.SET("I_START", 0)
    scn.SET("I_EN_LOAD", 0)
    scn.SET("I_DATA", 0x0000)

    scn.WTRS("S_FRAME_RECEIVED")
    scn.CHK("S_DATA_RECEIVED", i, "OK")

    # LOAD Flag must me rised before o_done
    scn.WTRS("O_MAX7219_LOAD")
    scn.WTRS("O_DONE")


scn.WAIT(100, "ns")

    
scn.DATA_COLLECTOR_STOP("MAX7219_IF_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_IF_INPUT_COLLECTOR_0", 0)


scn.END_TEST()
