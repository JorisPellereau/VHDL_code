# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_00.txt
#

# Test of Initialization of STATIC and SCROLLER RAM - Robustness test overs theses commands

import sys
import os
import random
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

sys.path.append("/home/linux-jp/Documents/GitHub/VHDL_code/LCD/LCD_CFAH1602BTMCJP/scripts/python_scripts/")
import macros_tb_unit_lcd_cfah_top

# Create SCN Class
scn       = scn_class.scn_class()
macros_tb = macros_tb_unit_lcd_cfah_top.macros_tb_unit_lcd_cfah_top(scn)

# == Collect Path ==
#collect_path = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

# Start of SCN

#scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
#scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

# == VARIABLES CONFIGURATION ==
lines_data_list = [[None for i in range(16)] for j in range(2)]

lines_data_list[0][0] = 0xAA
wait_duration = 1

# Static configuration :
dl_n_f = 0b111 # 8bits - 2 Lines - 5*11 dots
# =============================


# == BEGINNING of SCENARIO ==
scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")

# ==============================================
scn.print_step("Set configuration of LCD Emulation Block")
# ==============================================
scn.SET("S_BUSY_FLAG_DURATION", wait_duration)

# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")


# ==============================================
scn.print_step("Set Data in Line buffer")
# ==============================================
lines_data_list = [[0xE5 for i in range(16)], [0xE5 for i in range(16)]]
macros_tb.lcd_load_lines_buffer(lines_data_list = lines_data_list)
scn.WAIT(1, "us")


if(os.environ.get('DEBUG') != "ON"):
    # ==============================================
    scn.print_step("Enable LCD power and wait for the end of command")
    # ==============================================
    macros_tb.lcd_start_cmd(lcd_on = 1)
    scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Set Display ON")
# ==============================================
macros_tb.lcd_start_cmd(display_ctrl_cmd = 1, dcb = 0b100)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Set Display OFF - Cursor ON")
# ==============================================
macros_tb.lcd_start_cmd(display_ctrl_cmd = 1, dcb = 0b010)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Set Display OFF - CURSOR OFF - CURSOR_BLINK ON")
# ==============================================
macros_tb.lcd_start_cmd(display_ctrl_cmd = 1, dcb = 0b001)
scn.WTRS("O_CONTROL_DONE", 40, "ms")


# ==============================================
scn.print_step("Clear Display Command")
# ==============================================
macros_tb.lcd_start_cmd(clear_display_cmd = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Clear Display Command")
# ==============================================
macros_tb.lcd_start_cmd(clear_display_cmd = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Clear Display Command")
# ==============================================
macros_tb.lcd_start_cmd(clear_display_cmd = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Update ONE CHAR")
# ==============================================
macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 0, lcd_line_sel = 0, lcd_char_position = 15)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")

# ==============================================
scn.print_step("Update ONE CHAR")
# ==============================================
macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 0, lcd_line_sel = 1, lcd_char_position = 15)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")


# ==============================================
scn.print_step("Update ALL LCD")
# ==============================================
macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 1, lcd_line_sel = 0, lcd_char_position = 0)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Update ONCE CHAR - Dor it several time")
# ==============================================
for char_i in range(0, 16):
    macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 0, lcd_line_sel = 0, lcd_char_position = char_i)
    scn.WTRS("O_CONTROL_DONE", 40, "ms")
    scn.WAIT(1, "us")

scn.WAIT(5, "us")

# ==============================================
scn.print_step("Update ONCE CHAR - Dor it several time")
# ==============================================
for char_i in range(0, 16):
    macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 0, lcd_line_sel = 1, lcd_char_position = char_i)
    scn.WTRS("O_CONTROL_DONE", 40, "ms")
    scn.WAIT(1, "us")
scn.WAIT(5, "us")



# ==============================================
scn.print_step("Start an LCD INIT comma,d")
# ==============================================
macros_tb.lcd_start_cmd(lcd_init = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")


scn.END_TEST()
