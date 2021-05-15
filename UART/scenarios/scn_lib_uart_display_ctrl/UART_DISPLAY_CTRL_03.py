# UART_DISPLAY_CTRL_03.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of generation of a Static Pattern

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
scn = scn_class.scn_class("UART_DISPLAY_CTRL_03.txt")



# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Init RAM STATIC\n")
scn.print_line("\n")



scn.print_line("//-- Send : INIT_RAM_STATIC\n")
data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_STATIC")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("RAM_STATIC_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




scn.print_line("//-- STEP 2\n")
scn.print_line("//-- LOAD RAM STATIC @0 => @63\n")
scn.print_line("\n")

data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_STATIC")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(0) # Start @
for i in range(0, 128):
    data_to_send.append(0x01)
    
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_STATIC_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)




scn.print_line("//-- STEP 3\n")

nb_loop = 2
for i in range(0, nb_loop):
    scn.print_line("//-- RUN PATTERN STATIC - Pattern RDY\n")
    scn.print_line("\n")

    data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_STATIC")
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("STATIC_PTRN_RDY")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)
    
    
    data_to_send = []
    data_to_send.append(0) # Start PTR
    data_to_send.append(64)
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("STATIC_PTRN_DONE")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


    
scn.print_line("//-- STEP 4\n")
scn.print_line("//-- RUN PATTERN STATIC - Pattern NOT RDY\n")
scn.print_line("\n")

scn.MODELSIM_CMD("force -freeze sim:/tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_run_pattern_mngt_0/i_static_busy 1 0")

for j in range(0, 5):
    data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_STATIC")
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("STATIC_PTRN_NOT_RDY")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



scn.print_line("//-- STEP 5\n")
scn.print_line("//-- RUN PATTERN STATIC - Pattern RDY\n")
scn.print_line("\n")
    
scn.MODELSIM_CMD("noforce sim:/tb_top/i_dut/i_max7219_display_controller_0/o_static_busy")

nb_loop = 2
for i in range(0, nb_loop):
    scn.print_line("//-- RUN PATTERN STATIC - Pattern RDY\n")
    scn.print_line("\n")

    data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_STATIC")
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("STATIC_PTRN_RDY")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)
    
    
    data_to_send = []
    data_to_send.append(0) # Start PTR
    data_to_send.append(64)
    scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)
    
    data_to_read = str_cmd_2_hex_data_cmd("STATIC_PTRN_DONE")
    scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)
    

scn.END_TEST()
