# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of STATIC Commands


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

scn_txt_path = "/home/linux-jp/SIMULATION_VHDL/UART/scenarios"

# Import Class
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

from macro_uart_display_ctrl_scn import *



# Create SCN Class
scn_uart_display_ctrl_00 = scn_class.scn_class(scn_txt_path + "UART_DISPLAY_CTRL_00.txt")



# Start of SCN

scn_uart_display_ctrl_00.print_line("//-- STEP 0\n")
scn_uart_display_ctrl_00.print_line("\n")

scn_uart_display_ctrl_00.generic_tb_cmd.WTR("RST_N")
scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
scn_uart_display_ctrl_00.print_line("\n")


scn_uart_display_ctrl_00.print_line("//-- STEP 1\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of Correct command and then non correct command\n")
scn_uart_display_ctrl_00.print_line("\n")


scn_uart_display_ctrl_00.print_line("//-- Send : INIT_RAM_STATIC\n")
data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("RAM_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


scn_uart_display_ctrl_00.print_line("//-- Send : INIT_RAM_STATICI\n")
data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATICI")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("CMD_DISCARD")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(1, "us")


scn_uart_display_ctrl_00.print_line("//-- STEP 2\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
scn_uart_display_ctrl_00.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(0x00) # Start @
for i in range(0, 128):
    data_to_send.append(0xAA)
    
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




scn_uart_display_ctrl_00.print_line("//-- STEP 3\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
scn_uart_display_ctrl_00.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(0x00) # Start @
for i in range(0, 128):
    data_to_send.append(i)
    
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


scn_uart_display_ctrl_00.print_line("//-- STEP 4\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
scn_uart_display_ctrl_00.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(64) # Start @
for i in range(0, 128):
    data_to_send.append(i)
    
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




scn_uart_display_ctrl_00.print_line("//-- STEP 5\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
scn_uart_display_ctrl_00.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(2*64) # Start @
for i in range(0, 128):
    data_to_send.append(i)
    
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



scn_uart_display_ctrl_00.print_line("//-- STEP 6\n")
scn_uart_display_ctrl_00.print_line("//-- Injection of LOAD_PATTERN_STATIC and check\n")
scn_uart_display_ctrl_00.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(3*64) # Start @
for i in range(0, 128):
    data_to_send.append(i)
    
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



scn_uart_display_ctrl_00.END_TEST()

