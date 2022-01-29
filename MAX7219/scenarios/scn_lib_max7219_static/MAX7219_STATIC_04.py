# MAX7219_STATIC_04.py
# Use for the generation of the scenario MAX_STATIC_04.txt
#
#
# Aim of test : Test of WAIT command and WAIT G_CNT command

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

scn.DATA_COLLECTOR_INIT("MAX7219_STATIC_INPUT_COLLECTOR_0", 0, collect_path.format(4))

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


scn.print_line("//-- STEP 1.2 : Load Memory with one data to send through SPI and a wait of 0x1FFF\n")
ram_addr = 0x00
ram_data_list = [0x00BB, 0x3FFF, 0x00CC, 0x3FFF, 0x0DD, 0x3FFF, 0x0EE]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.WAIT(100, "us")

scn.print_line("//-- STEP 1.3 : Load Memory with one data to send through SPI and a wait of 0x001\n")
ram_addr = 0x00
ram_data_list = [0x00BB, 0x2001, 0x00CC, 0x2001, 0x0DD, 0x2001, 0x0EE]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.WAIT(100, "us")

scn.print_line("//-- STEP 1.4 : Load Memory with one data to send through SPI and a wait of 0x000 - Corner case\n")
ram_addr = 0x00
ram_data_list = [0x00B1, 0x2000, 0x00C1, 0x2000, 0x0D1, 0x2000, 0x0E1]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.WAIT(100, "us")

scn.print_line("//-- STEP 2 : Load Memory with one data at @0x00 and a data @0xFF - insert wait_cmd inside 0x01=>0xFE - Corner case\n")
ram_addr = 0x00
ram_data_list = [0x3FFF for i in range(255)]
ram_data_list[0]   = 0x0AA
ram_data_list[254] = 0x55
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")


scn.WAIT(100, "us")

scn.print_line("//-- STEP 3 : Load Memory with one data at @0x00 and a data @0x02 - insert wait_G_MAX_CNT command\n")
ram_addr = 0x00
ram_data_list = [0x0012, 0x4000, 0x0026, 0x0012, 0x4000, 0x0026, 0x0012, 0x4000, 0x0026]
scn_macros.send_multiple_spi_request_and_check(ram_addr, ram_data_list, "OK")

scn.DATA_COLLECTOR_STOP("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
