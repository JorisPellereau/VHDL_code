# MAX7219_CONTROLLER_02.py
# Use for the generation of the scenario MAX7219_CONTROLLER_02.txt
#
# Check Static Block : Multiple SPI request tests
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



scn.print_step("Write Data in STATIC RAM and Read it back")


data_list_0 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_1 = [255, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_2 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 255]

data_list_3 = [255, 255, 191, 159, 143, 135, 131, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 195, 231, 255, 231, 195, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 129, 193, 225, 241, 249, 253, 255, 255]

ram_data_list = scn_macros.max7219_models_class.sort_mem_list_static(data_list_0) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_1) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_2) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_3)


scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)


scn.print_step("Wait for the end of Config Init and INIT STATIC Functions")

scn.WTRS("O_CONFIG_DONE", 1, "ms")
scn.SET("I_EN_STATIC", 1)
scn.WAIT(100, "us")



scn.print_step("Send Multiple SPI Request and check it")

scn.SET("DISPLAY_SCREEN_SEL", 1)

for i in range(0, 4):
    ram_start_addr = i*64

    if(i < 3):
        ram_stop_addr  = 64+i*64
    else:
        ram_stop_addr = 0
        
    scn_macros.send_multiple_spi_request_and_check_static(ram_start_addr,
                                                          ram_stop_addr)

    scn.WAIT(100, "us")

scn.print_step("RAZ Memory and send a blank screen")

ram_data_list = scn_macros.max7219_models_class.sort_mem_list_static([0 for i in range(64)])*4

scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)

ram_start_addr = 0x00
ram_stop_addr  = 64
scn_macros.send_multiple_spi_request_and_check_static(ram_start_addr,
                                                      ram_stop_addr)

scn.WAIT(100, "us")


scn.print_step("RAZ Memory and send data with 00 in RAM")

ram_data_list = [0 for i in range(256)]

scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)

ram_start_addr = 0x00
ram_stop_addr  = 64
scn_macros.send_multiple_spi_request_and_check_static(ram_start_addr,
                                                      ram_stop_addr)
scn.WAIT(100, "us")



scn.print_step("RAZ Memory and send Patterns 4 times")

data_list_0 = [128, 64, 32, 16, 8, 4, 2, 1, 2, 4, 8, 16, 32, 64, 128, 64, 32, 16, 8, 4, 2, 1, 2, 4, 8, 16, 32, 64, 128, 64, 32, 16, 8, 4, 2, 1, 2, 4, 8, 16, 32, 64, 128, 64, 32, 16, 8, 4, 2, 1, 2, 4, 8, 16, 32, 64, 128, 64, 32, 16, 8, 4, 2, 1]

data_list_1 = [127, 191, 223, 239, 247, 251, 253, 254, 253, 251, 247, 239, 223, 191, 127, 191, 223, 239, 247, 251, 253, 254, 253, 251, 247, 239, 223, 191, 127, 191, 223, 239, 247, 251, 253, 254, 253, 251, 247, 239, 223, 191, 127, 191, 223, 239, 247, 251, 253, 254, 253, 251, 247, 239, 223, 191, 127, 191, 223, 239, 247, 251, 253, 254]

data_list_2 = [128, 64, 32, 16, 8, 4, 2, 255, 2, 4, 8, 16, 32, 64, 255, 64, 32, 16, 8, 4, 2, 255, 2, 4, 8, 16, 32, 64, 255, 64, 32, 16, 8, 4, 2, 255, 2, 4, 8, 16, 32, 64, 255, 64, 32, 16, 8, 4, 2, 255, 2, 4, 8, 16, 32, 64, 255, 64, 32, 16, 8, 4, 2, 1]

data_list_3 = [127, 191, 223, 239, 247, 251, 253, 0, 253, 251, 247, 239, 223, 191, 0, 191, 223, 239, 247, 251, 253, 0, 253, 251, 247, 239, 223, 191, 0, 191, 223, 239, 247, 251, 253, 0, 253, 251, 247, 239, 223, 191, 0, 191, 223, 239, 247, 251, 253, 0, 253, 251, 247, 239, 223, 191, 0, 191, 223, 239, 247, 251, 253, 254]

ram_data_list = scn_macros.max7219_models_class.sort_mem_list_static(data_list_0) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_1) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_2) + \
    scn_macros.max7219_models_class.sort_mem_list_static(data_list_3)

scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)

nb_patterns    = 4
start_ptr_list = [0, 64, 2*64, 3*64]
stop_ptr_list  = [64, 2*64, 3*64, 0]


# Send different Pulses
for i in range(0, nb_patterns):
    scn.WTFS("CLK")
    scn.SET("I_START_PTR_STATIC", start_ptr_list[i])
    scn.SET("I_LAST_PTR_STATIC", stop_ptr_list[i])
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)


for i in range(0, nb_patterns):
    scn.WTRS("O_PTR_EQUALITY_STATIC", 1, "ms")

scn.WAIT(100, "us")

scn.print_step("Send Patterns 10 times")

nb_patterns = 10
# Send different Pulses
for i in range(0, nb_patterns):
    scn.WTFS("CLK")
    scn.SET("I_START_PTR_STATIC", 0)
    scn.SET("I_LAST_PTR_STATIC", 64)
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)


for i in range(0, nb_patterns):
    scn.WTRS("O_PTR_EQUALITY_STATIC", 1, "ms")

scn.WAIT(100, "us")


scn.print_step("Send Patterns 11 times - 10 Patterns only expected")

nb_patterns = 11
# Send different Pulses
for i in range(0, nb_patterns):
    scn.WTFS("CLK")
    scn.SET("I_START_PTR_STATIC", 2*64)
    scn.SET("I_LAST_PTR_STATIC", 3*64)
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)


for i in range(0, nb_patterns - 1):
    scn.WTRS("O_PTR_EQUALITY_STATIC", 1, "ms")

scn.WAIT(100, "us")


scn.print_step("Send Patterns 20 times - 10 Patterns only expected")

nb_patterns = 20
# Send different Pulses
for i in range(0, nb_patterns):
    scn.WTFS("CLK")
    scn.SET("I_START_PTR_STATIC", 2*64)
    scn.SET("I_LAST_PTR_STATIC", 3*64)
    scn.SET("I_NEW_DISPLAY", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_DISPLAY", 0)


for i in range(0, 10):
    scn.WTRS("O_PTR_EQUALITY_STATIC", 1, "ms")

scn.WAIT(100, "us")

scn.DATA_COLLECTOR_STOP("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
