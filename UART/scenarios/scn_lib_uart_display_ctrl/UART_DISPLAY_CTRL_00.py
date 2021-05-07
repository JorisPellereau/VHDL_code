# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of Pulse Commands


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
scn_uart_display_ctrl_00 = scn_class.scn_class("UART_DISPLAY_CTRL_00.txt")



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


def tmp():

    scn_uart_display_ctrl_00.print_line("//-- Send : INIT_RAM_STATI\n")
    data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATI")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.print_line("//-- Send : INIT_RAM_SCROLLER\n")
    data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_SCROLLER")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    scn_uart_display_ctrl_00.print_line("//-- Send : INIT_RAM_SCROLL\n")
    data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_SCROLL")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    
    data_to_send = str_cmd_2_hex_data_cmd("UPDATE_MATRIX_CONFIG")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("UPDATE_MATRIX_CONFI")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("LOAD")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    
    data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCR")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    
    data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_STATIC")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("TOTO")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    
    data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_SCROLLER")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    data_to_send = str_cmd_2_hex_data_cmd("TOT")
    scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
    
    
    scn_uart_display_ctrl_00.print_line("//-- STEP 2\n")
    scn_uart_display_ctrl_00.print_line("//-- Injection of Correct command one by one\n")
    scn_uart_display_ctrl_00.print_line("\n")
    
    for i in range(0, 8):
        data_to_send = str_cmd_2_hex_data_cmd(uart_cmd_list[i])
        scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
        
        scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
        
        
        scn_uart_display_ctrl_00.print_line("//-- STEP 3\n")
        scn_uart_display_ctrl_00.print_line("//-- TBD\n")
        scn_uart_display_ctrl_00.print_line("\n")
        
#data_to_read = [0x35]
#scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_READ("UART_RPi", data_to_read)


scn_uart_display_ctrl_00.END_TEST()

