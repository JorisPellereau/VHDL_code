# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of STATIC Commands


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

scn_txt_path = "/home/linux-jp/SIMULATION_VHDL/UART/scenarios/"

# Import Class
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

from macro_uart_display_ctrl_scn import *



# Create SCN Class
scn = scn_class.scn_class(scn_txt_path + "UART_DISPLAY_CTRL_00.txt")



# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Injection of Correct command and then non correct command\n")
scn.print_line("\n")


scn.print_line("//-- Send : INIT_RAM_STATIC\n")
data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATIC")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("RAM_STATIC_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.CHK("O_CONFIG_DONE", 0, "OK")
scn.END_TEST()

# scn.print_line("//-- Send : INIT_RAM_STATICI\n")
# data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATICI")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("CMD_DISCARD")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(1, "us")


# scn.print_line("//-- STEP 2\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
# scn.print_line("\n")


# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(0x00) # Start @
# for i in range(0, 128):
#     data_to_send.append(0xAA)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




# scn.print_line("//-- STEP 3\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
# scn.print_line("\n")


# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(0x00) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# scn.print_line("//-- STEP 4\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
# scn.print_line("\n")


# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




# scn.print_line("//-- STEP 5\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
# scn.print_line("\n")


# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(2*64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



# scn.print_line("//-- STEP 6\n")
# scn.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
# scn.print_line("\n")


# data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


# data_to_send = []
# data_to_send.append(3*64) # Start @
# for i in range(0, 128):
#     data_to_send.append(i)
    
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



# scn.END_TEST()

