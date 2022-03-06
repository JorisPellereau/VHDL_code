# MAX7219_CONTROLLER_01.py
# Use for the generation of the scenario MAX7219_CONTROLLER_01.txt
#
# Check Static Block
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_controller_class

 # Create SCN Class
scn       = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_CONTROLLER_{:02d}_collect.txt"
 

# Create SCN Macro
scn_macros = macros_max_controller_class.macros_max_controller_class(scn)

# Start of SCN

scn.print_step("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(1))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.print_step("Write Data in STATIC RAM and Read it back")

ram_data_list = [i for i in range(256)]
scn_macros.write_static_data_in_ram(ram_data_list)
scn_macros.read_static_data_in_ram(ram_data_list)


scn.print_step("Wait for the end of Cnfig Init and INIT STATIC Functions")

scn.WTRS("O_CONFIG_DONE", 1, "ms")
scn.SET("I_EN_STATIC", 1)
scn.WAIT(1, "us")


scn.print_step("Send One SPI Request and check it")
ram_addr = 0
ram_data = ram_data_list[ram_addr]
scn_macros.send_one_spi_request_and_check_static(ram_addr, ram_data)


scn.WAIT(10, "us")


scn.print_step("Send Multiple One SPI Request and check it")

for i in range(0, 256):
    ram_addr = i
    ram_data = ram_data_list[ram_addr]
    scn_macros.send_one_spi_request_and_check_static(ram_addr, ram_data)
    scn.WAIT(10, "us")


scn.WAIT(100, "us")


scn.print_step("Send Multiple  SPI Request and check it")

ram_addr = 0

scn_macros.send_multiple_spi_request_and_check_static(ram_addr,
                                                      ram_data_list[0:2])


scn.DATA_COLLECTOR_STOP("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
