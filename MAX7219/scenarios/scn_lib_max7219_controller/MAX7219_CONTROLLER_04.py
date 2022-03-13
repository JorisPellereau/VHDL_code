# MAX7219_CONTROLLER_04.py
# Use for the generation of the scenario MAX7219_CONTROLLER_04.txt
#
# 
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

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.SET("DISPLAY_SCREEN_SEL", 2) # Display Screen Only 8th LOAD RECEIVED

scn.DATA_COLLECTOR_START("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.print_step("Write Data in SCROLLER RAM and Read it back")


data_list_0 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_1 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_2 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_3 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 193, 225, 241, 249, 253, 255, 255]

ram_data_list = data_list_0 + data_list_1 + data_list_2 + data_list_3


scn_macros.write_scroller_data_in_ram(ram_data_list)
scn_macros.read_scroller_data_in_ram(ram_data_list)



scn.print_step("Wait for the end of Config INI and INIT INPUTS")

scn.WTRS("O_CONFIG_DONE", 1, "ms")

scn.WTFS("CLK")
scn.SET("I_MAX_TEMPO_CNT_SCROLLER", 0x00000000)
scn.SET("I_STATIC_DYN", 1)
scn.WTFS("CLK")


scn.print_step("Set Multiple Scroller Pattern")

nb_scroller_patterns = 2
ram_start_ptr_scroller_list = [i for i in range(nb_scroller_patterns)]
msg_length_list = [1 for i in range(nb_scroller_patterns)]
for i in range(0, nb_scroller_patterns):
    
    scn.SET("I_RAM_START_PTR_SCROLLER", ram_start_ptr_scroller_list[i])
    scn.SET("I_MSG_LENGTH_SCROLLER", msg_length_list[i])
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)
    scn.WTFS("CLK")

# Wait for Number of Sccroller patterns
for i in range(0, nb_scroller_patterns):
    scn.WTFS("O_SCROLLER_BUSY", 10, "ms")
    
scn.WAIT(10, "us")

scn.print_step("Set Multiple Scroller Pattern")
scn.WTFS("CLK")

nb_scroller_patterns = 10
ram_start_ptr_scroller_list = [i for i in range(nb_scroller_patterns)]
msg_length_list = [1 for i in range(nb_scroller_patterns)]
for i in range(0, nb_scroller_patterns):
    
    scn.SET("I_RAM_START_PTR_SCROLLER", ram_start_ptr_scroller_list[i])
    scn.SET("I_MSG_LENGTH_SCROLLER", msg_length_list[i])
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)
    scn.WTFS("CLK")

# Wait for Number of Sccroller patterns
for i in range(0, nb_scroller_patterns):
    scn.WTFS("O_SCROLLER_BUSY", 10, "ms")


scn.print_step("Set Multiple Scroller Pattern")

nb_scroller_patterns = 12
ram_start_ptr_scroller_list = [i for i in range(nb_scroller_patterns)]
msg_length_list = [1 for i in range(nb_scroller_patterns)]
for i in range(0, nb_scroller_patterns):
    
    scn.SET("I_RAM_START_PTR_SCROLLER", ram_start_ptr_scroller_list[i])
    scn.SET("I_MSG_LENGTH_SCROLLER", msg_length_list[i])
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)
    scn.WTFS("CLK")

# Wait for Number of Sccroller patterns
for i in range(0, 10):
    scn.WTFS("O_SCROLLER_BUSY", 10, "ms")

    
scn.DATA_COLLECTOR_STOP("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
