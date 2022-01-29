# MAX7219_STATIC_03.py
# Use for the generation of the scenario MAX_STATIC_03.txt
#
#
# Aim of test : Send Multiple SPI frame with/without LOAD and check SPI frame
# Send Multiple frame with RAM ADDR wrapping
import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_static_class

# Create SCN Class
scn       = scn_class.scn_class()

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_STATIC_{:02d}_collect.txt"


# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class(scn)


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_STATIC_INPUT_COLLECTOR_0", 0, collect_path.format(3))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)

scn.print_line("//-- STEP 0.1\n")
scn.print_line("//-- Init Inputs to 0")

scn.SET("EN", 0)
scn.SET("LOOP", 0)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.SET("PTR_VAL", 0)


scn.print_line("//-- STEP 1\n")

scn.print_line("//-- STEP 1.1 : Enable Block\n")
scn.SET("EN", 1)
scn.WTFS("CLK")


scn.print_line("//-- STEP 1.2 : Load 2 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0x00
ram_data_list = [0x00BB, 0x00DD]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 1.3 : Load 2 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0xFF
ram_data_list = [0x00CA, 0x0055]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 1.2 : Load 2 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0x00
ram_data_list = [0x10BB, 0x10DD]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 1.3 : Load 2 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0xFF
ram_data_list = [0x10CA, 0x1055]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")



scn.print_line("//-- STEP 2.1 : Load 50 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0x00
ram_data_list = [0x00DD for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.2 : Load 50 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0xFF - 50
ram_data_list = [0x00FF for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.3 : Load 50 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0x00
ram_data_list = [0x10DD for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.4 : Load 50 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0xFF - 50
ram_data_list = [0x10FF for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.5 : Load 50 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0xFF - 25
ram_data_list = [0x0099 for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.6 : Load 50 Data in RAM, send it through SPI and check it - NO LOAD\n")
ram_addr = 0xFE
ram_data_list = [0x0098 for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.7 : Load 50 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0xFF - 25
ram_data_list = [0x1099 for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.print_line("//-- STEP 2.8 : Load 50 Data in RAM, send it through SPI and check it - LOAD\n")
ram_addr = 0xFE
ram_data_list = [0x1098 for i in range(50)]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.DATA_COLLECTOR_STOP("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
