# UART_DISPLAY_CTRL_05.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of Loading on SCROLLER TEMPO

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
scn = scn_class.scn_class("UART_DISPLAY_CTRL_05.txt")


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")

scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Load Tempo Scroller\n")
scn.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_SCROLLER_TEMPO")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")

# Tempo value : 0x11223344
data_to_send = [0x11, 0x22, 0x33, 0x44]
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.print_line("//-- STEP 2\n")
scn.print_line("//-- Load Tempo Scroller several times\n")
scn.print_line("\n")

tempo_scroller_value_list = [ [0x44, 0x44, 0x44, 0x44],
                              [0x55, 0x55, 0x55, 0x55],
                              [0xAA, 0xAA, 0xAA, 0xAA],
                              [0x00, 0x00, 0x00, 0x00],
                              [0x00, 0x00, 0x00, 0x01],
                              [0x10, 0x20, 0x30, 0x40],
                              [0xFF, 0xFF, 0xFF, 0xFF],
                              [0x71, 0x72, 0x73, 0x74],
                              [0x81, 0x82, 0x38, 0x84],
                              [0xDE, 0xAD, 0xBE, 0xEF] ]
nb_loop = 10
for i in range(0, nb_loop):
    data_to_send = str_cmd_2_hex_data_cmd("LOAD_SCROLLER_TEMPO")
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

    data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_RDY")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)
    
    scn.generic_tb_cmd.WAIT(10, "us")

    # Tempo value : 0x11223344
    data_to_send = tempo_scroller_value_list[i]
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_DONE")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)





scn.END_TEST()


