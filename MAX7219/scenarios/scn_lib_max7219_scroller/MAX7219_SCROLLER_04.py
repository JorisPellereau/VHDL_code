# MAX7219_SCROLLER_01.py
# Use for the generation of the scenario MAX7219_SCROLLER_01.txt
#
# Init All RAM with Random Data - Send a scroll pattern over the entire RAM
# 


import sys
import random

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_scroller_class

 # Create SCN Class
scn       = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_SCROLLER_{:02d}_collect.txt"
 

# Create SCN Macro
scn_macros = macros_max_scroller_class.macros_max_scroller_class(scn)

# Start of SCN

scn.print_step("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(4))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

# == VARIABLES ==
random.seed("MAX7219_SCROLLER_04")
ram_data      = [0x01]*256#random.randint(0, 255) for i in range(256)]
msg_length    = 0x1
ram_addr      = 0
max_tempo_cnt = 0x000000FF


scn.print_step("INIT INPUTS")

scn.SET("RAM_START_PTR",      ram_addr)
scn.SET("MSG_LENGTH",         msg_length)
scn.SET("MAX_TEMPO_CNT",      max_tempo_cnt)
scn.SET("START_SCROLL",       0x0)
scn.SET("DISPLAY_SCREEN_SEL", 1) # Enable SCREEN display from MAX7219 I/F

scn.WTRS("CLK")

scn_macros.send_patterns_and_check(ram_addr, ram_data, msg_length)

scn.DATA_COLLECTOR_STOP("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
