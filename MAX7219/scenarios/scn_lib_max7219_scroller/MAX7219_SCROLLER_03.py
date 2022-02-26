# MAX7219_SCROLLER_03.py
# Use for the generation of the scenario MAX7219_SCROLLER_03.txt
#
# Init All RAM with Random Data - Send a scroll pattern with a length of 2 at @ 0xFF to 0x00 - Send a second PATTERN
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

scn.DATA_COLLECTOR_INIT("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(3))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

# == VARIABLES ==
random.seed("MAX7219_SCROLLER_03")
ram_data      = [0 for i in range(256)]
ram_data[255] = 0xFF
ram_data[0]   = 0xBB
msg_length    = 0x2
ram_addr      = 0xFF
max_tempo_cnt = 0x00000000


scn.print_step("INIT INPUTS")

scn.SET("RAM_START_PTR",      ram_addr)
scn.SET("MSG_LENGTH",         msg_length)
scn.SET("MAX_TEMPO_CNT",      max_tempo_cnt)
scn.SET("START_SCROLL",       0x0)
scn.SET("DISPLAY_SCREEN_SEL", 1) # Enable SCREEN display from MAX7219 I/F

scn.WTRS("CLK")

scn.print_step("SEND a 1st PATTERN")

scn_macros.send_patterns_and_check(ram_addr, ram_data, msg_length)


scn.print_step("SEND a 2nd ATTERN")

ram_data = scn_macros.patterns_matrix[1] + scn_macros.patterns_matrix[2] + scn_macros.patterns_matrix[1] + scn_macros.patterns_matrix[2]

msg_length    = 0xFF
ram_addr      = 0x00
scn.SET("RAM_START_PTR",      ram_addr)
scn.SET("MSG_LENGTH",         msg_length)
scn.SET("MAX_TEMPO_CNT",      max_tempo_cnt)
scn.SET("START_SCROLL",       0x0)

scn_macros.send_patterns_and_check(ram_addr, ram_data, msg_length)


scn.print_step("SEND a 2nd ATTERN")

msg_length    = 64
ram_addr      = 32
scn.SET("RAM_START_PTR",      ram_addr)
scn.SET("MSG_LENGTH",         msg_length)
scn.SET("MAX_TEMPO_CNT",      max_tempo_cnt)
scn.SET("START_SCROLL",       0x0)

scn_macros.send_patterns_and_check(ram_addr, ram_data, msg_length)



scn.DATA_COLLECTOR_STOP("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
