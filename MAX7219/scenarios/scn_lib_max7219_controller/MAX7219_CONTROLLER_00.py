# MAX7219_CONTROLLER_00.py
# Use for the generation of the scenario MAX7219_CONTROLLER_00.txt
#
# Check initial config. generation - Send several Configuration and check it
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

scn.DATA_COLLECTOR_INIT("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0, collect_path.format(0))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)


scn.print_step("Check initial configuration")

scn_macros.check_init_config()
scn.WAIT(50, "us")

scn.print_step("Set a New Config and check it")

decode_mode_data  = 0
intensity_data    = 1
scan_limit_data   = 2
shutdown_data     = 3
display_test_data = 1

scn_macros.set_new_config_and_check(decode_mode_data,
                                    intensity_data,
                                    scan_limit_data,
                                    shutdown_data,
                                    display_test_data)

scn.print_step("Set Several New Config and check it")

scn.WAIT(100, "us")

nb_loop = 10
decode_mode_data_list  = [i for i in range(nb_loop)]
intensity_data_list    = [i*2 for i in range(nb_loop)]
scan_limit_data_list   = [i*3 for i in range(nb_loop)]
shutdown_data_list     = [i*4 for i in range(nb_loop)]
display_test_data_list = [1 for i in range(nb_loop)]


for i in range(0, nb_loop):
    scn_macros.set_new_config_and_check(decode_mode_data_list[i],
                                        intensity_data_list[i],
                                        scan_limit_data_list[i],
                                        shutdown_data_list[i],
                                        display_test_data_list[i])
    scn.WAIT(10, "us")

    
scn.print_step("Set a new Config and Keep i_new_config_val at 1 until end of Config")
scn.WAIT(40, "us")

scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 1)
scn.WTFS("CLK")
scn.WTFS("O_CONFIG_DONE", 10, "ms")
scn.WTRS("O_CONFIG_DONE", 10, "ms")

scn.WAIT(10, "us")
scn.SET("I_NEW_CONFIG_VAL", 0)

scn.print_step("Set a new Config and send a new config during configuration => 2 Config expected")

scn.WTFS("CLK")
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 1)
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 0)
scn.WTFS("O_CONFIG_DONE", 10, "ms")

scn.WAIT(500, "ns")
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 1)
scn.WTFS("CLK")
scn.SET("I_NEW_CONFIG_VAL", 0)
scn.WTRS("O_CONFIG_DONE", 10, "ms") # 1st config
scn.WTRS("O_CONFIG_DONE", 10, "ms") # 2nd Config



scn.print_step("Send 10 Pulses on config Val and check that 10 Config are generated - 10 Config with same Data")

nb_config = 10
for i in range(0, nb_config):
    scn.WTFS("CLK")
    scn.SET("I_NEW_CONFIG_VAL", 1)
    scn.WTFS("CLK")
    scn.SET("I_NEW_CONFIG_VAL", 0)


for i in range(0, nb_config):
    scn.WTRS("O_CONFIG_DONE", 10, "ms")

    
# scn.print_step("Send 10 Pulses on config Val and check that 10 Config are generated - 10 Config with differents Data")

# scn.WAIT(100, "us")

# nb_config = 10

# decode_mode_data_list  = [i*5 for i in range(nb_config)]
# intensity_data_list    = [i*6 for i in range(nb_config)]
# scan_limit_data_list   = [i*7 for i in range(nb_config)]
# shutdown_data_list     = [i*8 for i in range(nb_config)]
# display_test_data_list = [1 for i in range(nb_config)]

# # Set config in a 1st time
# for i in range(0, nb_config):
#     scn.WTFS("CLK")
#     scn.SET("I_NEW_CONFIG_VAL", 1)
#     scn.SET(scn_macros.i_decode_mode_alias,  decode_mode_data_list[i])
#     scn.SET(scn_macros.i_intensity_alias,    intensity_data_list[i])
#     scn.SET(scn_macros.i_scan_limit_alias,   scan_limit_data_list[i])
#     scn.SET(scn_macros.i_shutdown_alias,     shutdown_data_list[i])
#     scn.SET(scn_macros.i_display_test_alias, display_test_data_list[i])
#     scn.WTFS("CLK")
#     scn.SET("I_NEW_CONFIG_VAL", 0)
#     scn.SET(scn_macros.i_decode_mode_alias,  0)
#     scn.SET(scn_macros.i_intensity_alias,    0)
#     scn.SET(scn_macros.i_scan_limit_alias,   0)
#     scn.SET(scn_macros.i_shutdown_alias,     0)
#     scn.SET(scn_macros.i_display_test_alias, 0)

# # Check Config
# for i in range(0, nb_config):
#     scn_macros.check_config(decode_mode_data_list[i],
#                             intensity_data_list[i],
#                             scan_limit_data_list[i],
#                             shutdown_data_list[i],
#                             display_test_data_list[i])
    
scn.DATA_COLLECTOR_STOP("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_CONTROLLER_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
