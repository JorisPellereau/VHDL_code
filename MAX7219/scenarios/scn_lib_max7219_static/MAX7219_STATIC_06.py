# MAX7219_STATIC_06.py
# Use for the generation of the scenario MAX7219_STATIC_06.txt
#
# Auto Test 1 : Write 
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

#from MAX_STATIC_macros import INIT_STATIC_RAM, LOAD_PATTERN_I_STATIC
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

scn.DATA_COLLECTOR_INIT("MAX7219_STATIC_INPUT_COLLECTOR_0", 0, collect_path.format(6))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)


scn.print_line("//-- STEP 0.1\n")
scn.SET("EN", 0)
scn.SET("LOOP", 0)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.SET("PTR_VAL", 0)
scn.WAIT(100, "ns")

scn.print_line("//-- STEP 1\n")

scn.print_line("//-- STEP 1.1 : Enable Block\n")
scn.SET("EN", 1)
scn.WTFS("CLK")


scn.print_line("//-- STEP 1.2 : Init RAM - Set Configuration Register of MAX7219\n")
ram_addr = 0x00

# == Decode Register : Value 0x00 => No decode For digit 7-0
decode_reg_data_list = [0x900 for i in range(8)]
decode_reg_data_list[7] = decode_reg_data_list[7] + 0x1000 # Add Load Enable cmd

# == Intensity Register : Value 0x00 => Min intensity for all digits
intensity_reg_data_list = [0xA00 for i in range(8)]
intensity_reg_data_list[7] = intensity_reg_data_list + 0x1000 # Add Load Enable cmd

# == Scan Limit  Register : All Digits Displayed => Value 0x7
scan_limit_reg_data_list = [0xB07 for i in range(8)]
scan_limit_reg_data_list[7] = scan_limit_reg_data_list[7] + 0x1000 # Add Load Enable cmd

# == Shutdown Register : Normal Operation
shutdown_mode_reg_data_list = [0xC01 for i in range(8)]
shutdown_mode_reg_data_list[7] = shutdown_mode_reg_data_list[7] + 0x1000 # Add Load enable cmd

# == Display Test register : Normal Operation ==
display_test_reg_data_list = [0xF00 for i in range(8)]
display_test_reg_data_list[7] = display_test_reg_data_list[7] + 0x1000 # Add Load enable cmd

ram_data_config_list = decode_reg_data_list + intensity_reg_data_list + scan_limit_reg_data_list + shutdown_reg_data_list + display_test_reg_data_list


# Ordre des data :
# DIGIT_X_M7
#...
# DIGIT_X_M0 + LOAD

tmp_list = [192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192, 96, 48, 24, 12, 6, 3, 192]


ram_addr = 0x00
scn_macros.write_data_to_ram(ram_addr, ram_data_config_list)






scn.DATA_COLLECTOR_STOP("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)

  
scn.END_TEST()
