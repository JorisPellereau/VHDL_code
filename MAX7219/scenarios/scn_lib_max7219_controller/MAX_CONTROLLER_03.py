# MAX_CONTROLLER_03.py
# Use for the generation of the scenario MAX_CONTROLLER_03.txt
#
# Load STATIC and SCROLLER RAM with 4 differents pattern over entire memories
# Display Static Pattern and then Scroller Pattern


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Import Macros
from MAX_CONTROLLER_macros import INIT_STATIC_RAM, INIT_SCROLLER_RAM, LOAD_PATTERN_I_SCROLLER, LOAD_PATTERN_I_STATIC, DISPLAY_MATRIX

pattern_0 = ['0x18', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x18']

pattern_1 = ['0x18', '0x3c', '0x0', '0x81', '0x81', '0x42', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0x81', '0x24', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x24', '0x81', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x42', '0x81', '0x81', '0x0', '0x3c', '0x18']


pattern_2 = ['0x18', '0x3c', '0x0', '0x81', '0xff', '0x5a', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0xdb', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0xc3', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0xc3', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0xdb', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x5a', '0xff', '0x81', '0x0', '0x3c', '0x18']


pattern_3 = ['0xff', '0x3c', '0x3c', '0x81', '0xff', '0x5a', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xc3', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0xc3', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x5a', '0xff', '0x81', '0x3c', '0x3c', '0xff']



pattern_0_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x18', '0x3c', '0x7e', '0xff']

pattern_1_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x3c', '0x7e', '0xff']


pattern_2_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x3c', '0x7e', '0xff']

pattern_3_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0xff', '0x99', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0x99', '0xff', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x3c', '0x7e', '0xff']

# Create SCN Class
scn_max_controller_03 = scn_class.scn_class("MAX_CONTROLLER_03.txt")


# Start of SCN

scn_max_controller_03.print_line("-- STEP 0\n")
scn_max_controller_03.print_line("\n")

scn_max_controller_03.generic_tb_cmd.WTR("RST_N")
scn_max_controller_03.generic_tb_cmd.WAIT(100, "ns")
scn_max_controller_03.print_line("\n")


#// Display SCREEN Matrix on load
#SET DISPLAY_SCREEN_SEL 1
scn_max_controller_03.generic_tb_cmd.SET("DISPLAY_SCREEN_SEL", 0)

scn_max_controller_03.print_line("-- STEP 1\n")
scn_max_controller_03.print_line("-- Init RAMs with 0\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03 = INIT_STATIC_RAM(scn_max_controller_03)
scn_max_controller_03 = INIT_SCROLLER_RAM(scn_max_controller_03)


scn_max_controller_03.print_line("-- STEP 2\n")
scn_max_controller_03.print_line("-- LOAD Scroller Patterns\n")
scn_max_controller_03.print_line("\n")


start_addr = 0
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_0_scroller, start_addr)


start_addr = 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_1_scroller, start_addr)


start_addr = 64 + 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_2_scroller, start_addr)


start_addr = 64 + 64 + 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_3_scroller, start_addr)


scn_max_controller_03.print_line("-- STEP 3\n")
scn_max_controller_03.print_line("-- LOAD Static Patterns\n")
scn_max_controller_03.print_line("\n")


start_addr = 0
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_3, start_addr)

start_addr = 64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_2, start_addr)

start_addr = 2*64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_1, start_addr)

start_addr = 3*64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_0, start_addr)

scn_max_controller_03.generic_tb_cmd.WTR("O_CONFIG_DONE")
scn_max_controller_03.generic_tb_cmd.WAIT(100, "ns")
scn_max_controller_03.print_line("\n")



scn_max_controller_03.print_line("-- STEP 4\n")
scn_max_controller_03.print_line("-- Display Pattern STATIC\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03.generic_tb_cmd.SET("I_EN_STATIC", 1)


scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 0x000)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)



scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 2*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)

scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 2*64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 3*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)

scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 3*64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 4*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)




scn_max_controller_03.print_line("-- STEP 5\n")
scn_max_controller_03.print_line("-- Display Pattern SCROLLER\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03.generic_tb_cmd.SET("DISPLAY_SCREEN_SEL", 1) # Display on Load

scn_max_controller_03.generic_tb_cmd.SET("I_MAX_TEMPO_CNT_SCROLLER", 1)

scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_RAM_START_PTR_SCROLLER", 0)
scn_max_controller_03.generic_tb_cmd.SET("I_MSG_LENGTH_SCROLLER", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 0)
scn_max_controller_03.generic_tb_cmd.WTF("O_SCROLLER_BUSY")




scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_RAM_START_PTR_SCROLLER", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_MSG_LENGTH_SCROLLER", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 0)
scn_max_controller_03.generic_tb_cmd.WTF("O_SCROLLER_BUSY")



scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_RAM_START_PTR_SCROLLER", 2*64)
scn_max_controller_03.generic_tb_cmd.SET("I_MSG_LENGTH_SCROLLER", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 0)
scn_max_controller_03.generic_tb_cmd.WTF("O_SCROLLER_BUSY")



scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_RAM_START_PTR_SCROLLER", 3*64)
scn_max_controller_03.generic_tb_cmd.SET("I_MSG_LENGTH_SCROLLER", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.SET("I_STATIC_DYN", 0)
scn_max_controller_03.generic_tb_cmd.WTF("O_SCROLLER_BUSY")



scn_max_controller_03.print_line("-- STEP 6\n")
scn_max_controller_03.print_line("-- Display Pattern STATIC - Part of pattern\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 0x000)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 64/2)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC", 1, "ms")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)



scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 2*64/2)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC", 1, "ms")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)


scn_max_controller_03.END_TEST()

#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 2*64)
#scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 3*64/2)
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
#scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC", 1, "ms")
#scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)

#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 3*64)
#scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 4*64/2)
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
#scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC", 1, "ms")
#scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)


#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 2*64 + 32)
#scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 64)
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
#scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
#scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
#scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC", 1, "ms")
#scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)


#scn_max_controller_03.generic_tb_cmd.WAIT(100, "us")   
#scn_max_controller_03.END_TEST()


