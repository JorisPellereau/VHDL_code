# UART_DISPLAY_CTRL_02.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of Config. Matrix Commands

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

from macro_uart_display_ctrl_scn import *



# Create SCN Class
scn = scn_class.scn_class("UART_DISPLAY_CTRL_02.txt")


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Injection of Correct command\n")
scn.print_line("\n")


scn.print_line("//-- Send : LOAD_MATRIX_CONFIG\n")
data_to_send = str_cmd_2_hex_data_cmd("LOAD_MATRIX_CONFIG")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_MATRIX_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


scn.print_line("//-- Send : Data for config Matrix\n")
# Display Test
# Decod Mode
# Intensity
# Scan Limit
# Shutdown
data_to_send = [0x01, 0x02, 0x03, 0x04, 0x05]
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("UPDATE_MATRIX_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")


scn.END_TEST()
