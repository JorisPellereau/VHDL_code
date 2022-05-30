# CRC_16_000.py
# Use for the generation of the scenario CRC_16_000.txt
#

# Test of CRC genaration

import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class


crc_class_path = "/home/linux-jp/Documents/GitHub/VHDL_code/CRC/scripts/python"
sys.path.append(crc_class_path)
import crc_class


# Create SCN Class
scn = scn_class.scn_class()
crc = crc_class.crc_class() # Init Class

# Start of SCN


scn.print_step("Wait for Reset")

scn.WTRS("RST_N")
#scn.WAIT(100, "ns")


scn.print_step("Test 256 CRC data (0 to 255)")

crc_data_in = [i for i in range(256)]
last_crc_list,last_crc,crc_out_list     = crc.crc_16(crc_data_in, 0xFFFF)

file_path = "/home/linux-jp/SIMULATION_VHDL/CRC_REF/test.txt"
scn.DATA_CHECKER_INIT("CRC_CHECKER", 0, file_path)
scn.WAIT(1, "us")
scn.DATA_CHECKER_CLOSE("CRC_CHECKER", 0)

# scn.WTFS("CLK")

# for i in range(0, 256):
#     #scn.WTFS("CLK")
#     scn.SET("I_VAL", 1)
#     scn.SET("I_DATA", i)
#     scn.WTRS("CLK")
#     scn.CHK("O_CRC", crc_out_list[i], "OK")
    
# scn.WTFS("CLK")
# scn.SET("I_VAL", 0)

scn.print_step("Reset CRC and perform 256 CRC data")


scn.END_TEST()
