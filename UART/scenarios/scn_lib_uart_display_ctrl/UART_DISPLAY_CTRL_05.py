# UART_DISPLAY_CTRL_05.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#

# Test of Loading on SCROLLER TEMPO

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
scn = scn_class.scn_class(scn_txt_path + "UART_DISPLAY_CTRL_05.txt")


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTR("RST_N")
scn.generic_tb_cmd.WAIT(100, "ns")
scn.print_line("\n")


check_spi_config_after_reset(scn, 0, 0, 0x07, 0x01, 0)

# Display reception of screen matrix
scn.generic_tb_cmd.SET("DISPLAY_SCREEN_SEL", 1)

scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Load Tempo Scroller - and Start a SCROLLER PATTERN\n")
scn.print_line("\n")


data_to_send = str_cmd_2_hex_data_cmd("LOAD_SCROLLER_TEMPO")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

scn.generic_tb_cmd.WAIT(10, "us")

# Tempo value : 0x000000FF
data_to_send = [0x00, 0x01, 0xFF, 0xFF]
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_TEMPO_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = str_cmd_2_hex_data_cmd("INIT_RAM_SCROLLER")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("RAM_SCROLLER_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)



data_to_send = str_cmd_2_hex_data_cmd("LOAD_PATTERN_SCROLL")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


scn.generic_tb_cmd.WAIT(10, "us")

data_to_send = []
start_addr = 0x00
stop_addr  = 0x40
data_to_send.append(start_addr) # Start @
data_to_send.append(stop_addr) # Message length

data_to_check = []
for i in range(start_addr, stop_addr+1):
    if(i == 0):
        data_to_send.append(0xFF)
        data_to_check.append(0xFF)
    else:
        data_to_send.append(0xFF)
        data_to_check.append(0xFF)
        
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("LOAD_SCROLL_DONE")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = str_cmd_2_hex_data_cmd("RUN_PATTERN_SCROLLER")
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

data_to_read = str_cmd_2_hex_data_cmd("SCROLL_PTRN_RDY")
scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


data_to_send = []
data_to_send.append(start_addr) # Start PTR
data_to_send.append(stop_addr) # Message length
scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)

# Scroll En cours 
#data_to_read = str_cmd_2_hex_data_cmd("SCROLL_PTRN_DONE")
#scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)


#scn.generic_tb_cmd.WTR("SPI_FRAME_RECEIVED", 1, "ms")
#scn.generic_tb_cmd.CHK("O_SPI_DATA_RECEIVED", 0x0000, 'OK')

#data_to_check = 
check_spi_scroller(scn, data_to_check)

def toto(self):
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


