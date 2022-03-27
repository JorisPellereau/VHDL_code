# UART_DISPLAY_CTRL_01.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_01.txt
#
# Test of Register configuration and robustness test over this command

import sys
import os

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class
import macros_uart_display_ctrl_class

# Create SCN Class
scn = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_uart_display_ctrl_class.macros_uart_display_ctrl_class(scn)

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

# Start of SCN

scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")


scn.print_step("Wait for the end of SPI Configuration")
scn_macros.check_init_config()


scn.print_step("Injection of Correct command and then non correct command")




scn.print_step("Send : LOAD_MATRIX_CONFIG")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_MATRIX_CONFIG",
                                        main_cmd  = False,
                                        not_rdy   = False)

data_config_list = [0x01, 0xBB, 0xCC, 0xDD, 0xEE]
scn_macros.send_uart_cmd_and_check_resp(uart_data = data_config_list,
                                        main_cmd  = "LOAD_MATRIX_CONFIG",
                                        not_rdy   = False)


scn.print_step("Send : UPDATE_MATRIX_CONFIG")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "UPDATE_MATRIX_CONFIG",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = True)

scn.print_step("Send : UPDATE_MATRIX_CONFII")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "UPDATE_MATRIX_CONFII",
                                        main_cmd  = False,
                                        not_rdy   = False)

scn.print_step("Send : LOAD_MATRIX_CONFIG and UPDATE_MATRIX_CONFIG 10 times")
for i in range(0, 10):
    
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_MATRIX_CONFIG",
                                            main_cmd  = False,
                                            not_rdy   = False)

    data_config_list = [0x01, 0xBB - i, 0xCC - i, 0xDD - i, 0xEE - i]
    scn_macros.send_uart_cmd_and_check_resp(uart_data = data_config_list,
                                            main_cmd  = "LOAD_MATRIX_CONFIG",
                                            not_rdy   = False)

    scn_macros.send_uart_cmd_and_check_resp(uart_data = "UPDATE_MATRIX_CONFIG",
                                            main_cmd  = False,
                                            not_rdy   = False,
                                            check_spi = True)





scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.END_TEST()




# # Start of SCN

# scn.print_line("//-- STEP 0\n")
# scn.print_line("\n")

# scn.generic_tb_cmd.WTR("RST_N")
# scn.generic_tb_cmd.WAIT(100, "ns")
# scn.print_line("\n")


# scn.print_line("//-- STEP 1\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")


# scn.print_line("//-- Send : INIT_RAM_SCROLLER\n")
# data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_SCROLLER")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("RAM_SCROLLER_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")


# scn.print_line("//-- STEP 2\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")


# scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")


# data_to_send = []
# start_addr = 0x00
# stop_addr  = 0x05
# data_to_send.append(start_addr) # Start @
# data_to_send.append(stop_addr) # Stop  @
# for i in range(start_addr, stop_addr+1):
#     data_to_send.append(0xAA)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# scn.print_line("//-- STEP 3\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")

# scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")


# data_to_send = []
# start_addr = 0x00
# stop_addr  = 0xFF
# data_to_send.append(start_addr) # Start @
# data_to_send.append(stop_addr) # Stop  @
# for i in range(start_addr, stop_addr+1):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# scn.print_line("//-- STEP 4\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")

# scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")


# data_to_send = []
# start_addr = 0xF0
# stop_addr  = 0xFF
# data_to_send.append(start_addr) # Start @
# data_to_send.append(stop_addr) # Stop  @
# for i in range(start_addr, stop_addr+1):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



