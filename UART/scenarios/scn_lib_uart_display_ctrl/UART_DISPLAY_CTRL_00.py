# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#



import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

# Create SCN Class
scn_uart_display_ctrl_00 = scn_class.scn_class("UART_DISPLAY_CTRL_00.txt")


# Start of SCN

scn_uart_display_ctrl_00.print_line("//-- STEP 0\n")
scn_uart_display_ctrl_00.print_line("\n")

scn_uart_display_ctrl_00.generic_tb_cmd.WTR("RST_N")
scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")
scn_uart_display_ctrl_00.print_line("\n")

data_to_send = [0x30]
scn_uart_display_ctrl_00.generic_tb_uart_cmd.TX_START("UART_0", data_to_send)

scn_uart_display_ctrl_00.generic_tb_cmd.WAIT(100, "ns")


data_to_read = [0x35]
scn_uart_display_ctrl_00.generic_tb_uart_cmd.RX_READ("UART_0", data_to_read)


scn_uart_display_ctrl_00.END_TEST()
