# UART_DISPLAY_CTRL_05.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_07.txt
#

# Test of Loading on SCROLLER PATTERN and RUN Pattern

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

scn.print_step("Send Scroller Tempo and check it")

scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_SCROLLER_TEMPO",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

scroller_tempo_data = 0x00000010

# MSB First Send
scroller_tempo_data_list = [(scroller_tempo_data & 0xFF000000) >> 24,
                            (scroller_tempo_data & 0x00FF0000) >> 16,
                            (scroller_tempo_data & 0x0000FF00) >> 8,
                            (scroller_tempo_data & 0x000000FF) >> 0,]

scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_tempo_data_list,
                                        main_cmd  = "LOAD_SCROLLER_TEMPO",
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

scn.CHK(scn_macros.s_max_tempo_cnt_scroller_alias, scroller_tempo_data, "OK")
scn.WAIT(100, "ns")




memory_rtl_path = "/tb_top/i_dut/i_max7219_display_controller_0/max7219_scroller_ctrl_inst_0/tdpram_inst_0/v_ram"
memory_to_check = ["X"*2 for i in range(256)]
# Check that memory is filled with XX
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 2)



scn.print_step("Set SCROLLER PATTERN and check it")

scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_SCROLL",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

scroller_start_ptr = 0x00
scroller_stop_ptr  = 0xFF
memory_scroller_data = [i for i in range (256)]
scroller_data_list = [scroller_start_ptr, scroller_stop_ptr] + memory_scroller_data
scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_data_list,
                                        main_cmd  = "LOAD_PATTERN_SCROLL",
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

memory_to_check = memory_scroller_data
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 2)

scn.print_step("Run SCROLLER Pattern")

scn_macros.send_uart_cmd_and_check_resp(uart_data = "RUN_PATTERN_SCROLLER",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

scroller_start_ptr   = 0x00
scroller_msg_length  = 0x5
scroller_data_list = [scroller_start_ptr, scroller_msg_length]
scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_data_list,
                                        main_cmd  = "RUN_PATTERN_SCROLLER",
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)


scn.WAIT(11, "ms") # Wait end of SCROLLER Pattern

scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

scn.END_TEST()


