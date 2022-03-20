# MAX7219_CONTROLLER_05.py
# Use for the generation of the scenario MAX7219_CONTROLLER_05.txt
#
# Test the FIFO with CONFIG - STATIC and SCROLLER patterns
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_controller_class
import os

 # Create SCN Class
scn       = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

# Create SCN Macro
scn_macros = macros_max_controller_class.macros_max_controller_class(scn)

# Start of SCN

scn.print_step("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0, collect_path)
scn.DATA_COLLECTOR_START("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)


scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.SET("DISPLAY_SCREEN_SEL", 2) # Display Screen Only 8th LOAD RECEIVED

scn.print_step("//-- Init Scroller RAM and STATIC RAM\n")


data_list_0 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_1 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_2 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_3 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 193, 225, 241, 249, 253, 255, 255]

ram_data_list = data_list_0 + data_list_1 + data_list_2 + data_list_3

scn_macros.write_scroller_data_in_ram(ram_data_list)
scn_macros.read_scroller_data_in_ram(ram_data_list)

ram_data_list = scn_macros.max7219_models_class.sort_mem_list_static(data_list_0) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_1) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_2) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_3)


scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)

scn.WTRS("O_CONFIG_DONE", 10, "ms")

scn.print_step("//-- Init inputs of STATIC and SCROLLER and send patterns\n")

scn.WTFS("CLK")
scn.SET("I_EN_STATIC", 1)

scn.WTFS("CLK")
scn.SET("I_START_PTR_STATIC", 0)
scn.SET("I_LAST_PTR_STATIC", 64)
scn.SET("I_RAM_START_PTR_SCROLLER", 0)
scn.SET("I_MSG_LENGTH_SCROLLER", 3)

scn.WAIT(10, "us")

scn.WTFS("CLK")
scn.SET("I_STATIC_DYN", 1)
scn.SET("I_NEW_DISPLAY", 1)
scn.WTFS("CLK")
scn.SET("I_STATIC_DYN", 0)
scn.SET("I_NEW_DISPLAY", 0)
scn.WTFS("CLK")
scn.SET("I_STATIC_DYN", 0)
scn.SET("I_NEW_DISPLAY", 1)
scn.WTFS("CLK")
scn.SET("I_STATIC_DYN", 0)
scn.SET("I_NEW_DISPLAY", 0)
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 1)
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 0)

scn.WTFS("O_SCROLLER_BUSY", 10, "ms")
scn.WTRS("O_PTR_EQUALITY_STATIC", 10, "ms")
scn.WTRS("O_CONFIG_DONE", 10, "ms")

scn.WAIT(500, "us")

scn.print_step("//-- Send 10 Commands and check it\n")
commandes_list = ["CONFIG"]*3 + ["STATIC"]*3 + ["SCROLLER"]*3 + ["CONFIG"]
scn_macros.send_multile_pattern_and_check(commandes_list)


scn.WAIT(500, "us")

scn.print_step("//-- Send 10 Commands and check it\n")
commandes_list = ["STATIC"] + ["CONFIG"]*2 + ["SCROLLER"] + ["STATIC"] + ["SCROLLER"]*3 + ["STATIC"]*2
scn_macros.send_multile_pattern_and_check(commandes_list)
scn.WAIT(500, "us")



scn.print_step("//-- Send 40 Commands and check it - Only 10 Commands executed\n")
commandes_list = ["STATIC"]*10 + ["CONFIG"]*10 + ["STATIC"]*20
scn_macros.send_multile_pattern_and_check(commandes_list)
scn.WAIT(100, "ns")



scn.print_step("Check STATIC Discard")
scn.WTFS("CLK")
scn.SET("I_START_PTR_STATIC", 0)
scn.SET("I_LAST_PTR_STATIC", 0)
scn.WTFS("CLK")
scn.SET("I_STATIC_DYN", 0)
scn.SET("I_NEW_DISPLAY", 1)
scn.WTFS("CLK")
scn.SET("I_NEW_DISPLAY", 0)

scn.WAIT(1, "us")

scn.DATA_COLLECTOR_STOP("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
