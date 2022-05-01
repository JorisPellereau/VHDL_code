# UART_DISPLAY_CTRL_04.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_04.txt
#
# Test of generation of STATIC PATTERN

import sys
import os
import random

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

scn_txt_path = "/home/linux-jp/SIMULATION_VHDL/UART/scenarios/"


# Import Class
import scn_class
import macros_uart_display_ctrl_class


# Create SCN Class
scn = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_uart_display_ctrl_class.macros_uart_display_ctrl_class(scn)

# == Collect Path ==
collect_path     = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])
memory_dump_path = "/home/linux-jp/SIMULATION_VHDL/MEMORY_DUMP/"

# Start of SCN

scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")

scn.print_step("Wait for the end of SPI Configuration")
scn_macros.check_init_config()

scn.print_step("Enable Matrix Screen in transcript")
scn.SET("DISPLAY_SCREEN_SEL", 1)

scn.print_step("Check initial value of STATIC RAM")
memory_rtl_path = "/tb_top/i_dut/i_max7219_display_controller_0/max7219_cmd_decod_inst_0/tdpram_inst_0/v_ram"
memory_to_check = ["X"*4 for i in range(256)]
# Check that memory is filled with XX
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 4)


pattern_1 = [129, 195, 118, 24, 24, 118, 195, 129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 66, 46, 17, 17, 46, 66, 128, 0, 0, 0, 0, 0, 0, 0, 0, 1, 66, 116, 136, 136, 116, 66, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 129, 66, 36, 24, 24, 24, 24, 24, 36, 66, 129]

pattern_2 = [126, 60, 137, 231, 231, 137, 60, 126, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 127, 189, 209, 238, 238, 209, 189, 127, 255, 255, 255, 255, 255, 255, 255, 255, 254, 189, 139, 119, 119, 139, 189, 254, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 126, 189, 219, 231, 231, 231, 231, 231, 219, 189, 126]

pattern_3 = [129, 195, 118, 24, 24, 118, 195, 129, 66, 66, 66, 126, 24, 24, 126, 66, 66, 66, 128, 66, 46, 17, 17, 46, 66, 128, 0, 0, 255, 0, 0, 0, 0, 0, 1, 66, 116, 136, 136, 116, 66, 1, 0, 129, 129, 129, 129, 255, 0, 0, 0, 0, 0, 129, 66, 36, 24, 24, 24, 24, 24, 36, 66, 129]

pattern_4 = [126, 60, 137, 231, 231, 137, 60, 126, 189, 189, 189, 129, 231, 231, 129, 189, 189, 189, 127, 189, 209, 238, 238, 209, 189, 127, 255, 255, 0, 255, 255, 255, 255, 255, 254, 189, 139, 119, 119, 139, 189, 254, 255, 126, 126, 126, 126, 0, 255, 255, 255, 255, 255, 126, 189, 219, 231, 231, 231, 231, 231, 219, 189, 126]


patterns_list = [pattern_1, pattern_2, pattern_3, pattern_4]


pattern_static_list = [129, 195, 118, 24, 24, 118, 195, 129, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 66, 46, 17, 17, 46, 66, 128, 0, 0, 0, 0, 0, 0, 0, 0, 1, 66, 116, 136, 136, 116, 66, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 129, 66, 36, 24, 24, 24, 24, 24, 36, 66, 129]




scn.print_step("LOAD 4 Pattern in STATIC RAM")

wr_ptr_list = [0, 64, 2*64, 3*64]
for i in range(0, 4):
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_STATIC",
                                            main_cmd  = False,
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)
    
    uart_data_list = scn_macros.pattern_to_uart_static_data_list(pattern_list = patterns_list[i])
    uart_data_list = [wr_ptr_list[i]] + uart_data_list
    scn_macros.send_uart_cmd_and_check_resp(uart_data = uart_data_list,
                                            main_cmd  = "LOAD_PATTERN_STATIC",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)



scn.print_step("Run 4 pattern - wait 1 us between each pattern")

start_ptr_static_list = [0, 64, 2*64, 3*64]
last_ptr_static_list  = [64, 2*64, 3*64, 0]
for i in range(0, 4):
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "RUN_PATTERN_STATIC",
                                            main_cmd  = False,
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)

    uart_data_list = [start_ptr_static_list[i], last_ptr_static_list[i]]
    scn_macros.send_uart_cmd_and_check_resp(uart_data = uart_data_list,
                                            main_cmd  = "RUN_PATTERN_STATIC",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)

    scn.WAIT(1, "us")

scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

scn.END_TEST()
