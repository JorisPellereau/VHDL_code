# UART_DISPLAY_CTRL_01.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of SCROLLER Commands

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
scn = scn_class.scn_class(scn_txt_path + "UART_DISPLAY_CTRL_01.txt")


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Injection of Correct command\n")
scn.print_line("\n")


scn.print_line("//-- Send : INIT_RAM_SCROLLER\n")
data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_SCROLLER")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("RAM_SCROLLER_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


scn.print_line("//-- STEP 2\n")
scn.print_line("//-- Injection of Correct command\n")
scn.print_line("\n")


scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


data_to_send = []
start_addr = 0x00
stop_addr  = 0x05
data_to_send.append(start_addr) # Start @
data_to_send.append(stop_addr) # Stop  @
for i in range(start_addr, stop_addr+1):
    data_to_send.append(0xAA)
    
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


scn.print_line("//-- STEP 3\n")
scn.print_line("//-- Injection of Correct command\n")
scn.print_line("\n")

scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


data_to_send = []
start_addr = 0x00
stop_addr  = 0xFF
data_to_send.append(start_addr) # Start @
data_to_send.append(stop_addr) # Stop  @
for i in range(start_addr, stop_addr+1):
    data_to_send.append(i)
    
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


scn.print_line("//-- STEP 4\n")
scn.print_line("//-- Injection of Correct command\n")
scn.print_line("\n")

scn.print_line("//-- Send : LOAD_PATTERN_SCROLL\n")
data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


data_to_send = []
start_addr = 0xF0
stop_addr  = 0xFF
data_to_send.append(start_addr) # Start @
data_to_send.append(stop_addr) # Stop  @
for i in range(start_addr, stop_addr+1):
    data_to_send.append(i)
    
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)





scn.END_TEST()
