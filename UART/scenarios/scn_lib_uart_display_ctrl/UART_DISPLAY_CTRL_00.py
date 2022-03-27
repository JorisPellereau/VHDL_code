# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_00.txt
#

# Test of Initialization of STATIC and SCROLLER RAM - Robustness test overs theses commands

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


scn.print_step("Send : INIT_RAM_STATIC")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "INIT_RAM_STATIC",
                                        main_cmd  = False,
                                        not_rdy   = False)


scn.print_step("Send : INIT_RAM_STATICI")
scn_macros.send_uart_cmd_and_check_resp("INIT_RAM_STATICI")


scn.print_step("Send : INIT_RAM_STATIC 10 times")
for i in range(0, 10):
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "INIT_RAM_STATIC",
                                            main_cmd  = False,
                                            not_rdy   = False)





scn.print_step("Send : INIT_RAM_SCROLLER")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "INIT_RAM_SCROLLER",
                                        main_cmd  = False,
                                        not_rdy   = False)

scn.print_step("Send : INIT_RAM_SCROLLEY")
scn_macros.send_uart_cmd_and_check_resp(uart_data = "INIT_RAM_SCROLLEY",
                                        main_cmd  = False,
                                        not_rdy   = False)



scn.print_step("Send : INIT_RAM_SCROLLER 10 times")
for i in range(0, 10):
    scn_macros.send_uart_cmd_and_check_resp(uart_data = "INIT_RAM_SCROLLER",
                                            main_cmd  = False,
                                            not_rdy   = False)
    

    
scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.END_TEST()


# scn.print_line("//-- STEP 2\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")



# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(0x00) # Start @
# for i in range(0, 128):
#     data_to_send.append(0xAA)
    
# scn.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)




# scn.print_line("//-- STEP 3\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")



# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(0x00) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# scn.print_line("//-- STEP 4\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")



# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)




# scn.print_line("//-- STEP 5\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")



# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(2*64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)



# scn.print_line("//-- STEP 6\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")



# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(3*64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.RX_WAIT_DATA("UART_RPi", data_to_read)



