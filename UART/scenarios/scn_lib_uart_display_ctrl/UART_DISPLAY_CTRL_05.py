# UART_DISPLAY_CTRL_05.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of Loading on SCROLLER TEMPO

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


scn.print_step("Send Scroller Tempo and check it")

scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_SCROLLER_TEMPO",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

scroller_tempo_data = 0xAABBCCDD

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


scn.print_step("Send Scroller Multiple Tempo and check it")

nb_loop = 10
for i in range(0, nb_loop):
    random.seed(i)
    scroller_tempo_data = random.randrange(0, 0xFFFFFFFF)

    # MSB First Send
    scroller_tempo_data_list = [(scroller_tempo_data & 0xFF000000) >> 24,
                                (scroller_tempo_data & 0x00FF0000) >> 16,
                                (scroller_tempo_data & 0x0000FF00) >> 8,
                                (scroller_tempo_data & 0x000000FF) >> 0,]

    # Send UART Command
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_SCROLLER_TEMPO",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)
    # Send UART Data
    scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_tempo_data_list,
                                            main_cmd  = "LOAD_SCROLLER_TEMPO",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)

    scn.CHK(scn_macros.s_max_tempo_cnt_scroller_alias, scroller_tempo_data, "OK")
    scn.WAIT(10, "ns")
    



scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

scn.END_TEST()


