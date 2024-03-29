# MAX7219_SCROLLER_01.py
# Use for the generation of the scenario MAX7219_SCROLLER_01.txt
#
# Init RAM With a Pattern - Start Transaction
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

scn.DATA_COLLECTOR_INIT("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(2))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

# == VARIABLES ==
random.seed("MAX7219_SCROLLER_02")
ram_data      = [random.randint(0, 255) for i in range(256)]
msg_length    = 64
ram_addr      = 0
max_tempo_cnt = 0x00000000

ram_data = scn_macros.patterns_matrix[0]*4

scn.print_step("INIT INPUTS")

scn.SET("RAM_START_PTR",      ram_addr)
scn.SET("MSG_LENGTH",         msg_length)
scn.SET("MAX_TEMPO_CNT",      max_tempo_cnt)
scn.SET("START_SCROLL",       0x0)
scn.SET("DISPLAY_SCREEN_SEL", 1) # Enable SCREEN display from MAX7219 I/F

scn.WTRS("CLK")

scn_macros.send_patterns_and_check(ram_addr, ram_data, msg_length, check_disable = True)

scn.DATA_COLLECTOR_STOP("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_SCROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
