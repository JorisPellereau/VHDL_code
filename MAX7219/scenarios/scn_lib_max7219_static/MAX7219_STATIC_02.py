# MAX7219_STATIC_02.py
# Use for the generation of the scenario MAX_STATIC_02.txt
#
#
# Aim of test : Write a single value in each Memory Addr and check the generate of 1 SPI frame
#

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_static_class

# Create SCN Class
scn       = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class(scn)

#print(dir(scn_macros))

# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

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

scn.print_line("//-- STEP 1.2 : Load 1 Data in RAM, send it through SPI and check it - NO LOAD\n")

# Send Normal Command => rdata(15 dowto 13) = "000" - rdata(12) = "0" => NO LOAD

data_list = [0x0000, 0x0FFF, 0x0050, 0x0250]
for addr_i in range(0, 256):
    for data_i in data_list:
        scn_macros.send_one_spi_request_and_check(addr_i, data_i, "OK")

scn.WAIT(100, "ns")


scn.print_line("//-- STEP 1.3 : Load 1 Data in RAM, send it through SPI and check it - LOAD ENABLED\n")

# Send Normal Command => rdata(15 dowto 13) = "000" - rdata(12) = "1"

data_list = [0x1000, 0x1FFF, 0x1050, 0x1250]
for addr_i in range(0, 256):
    for data_i in data_list:
        scn_macros.send_one_spi_request_and_check(addr_i, data_i, "OK")

scn.WAIT(100, "ns")

scn.END_TEST()
