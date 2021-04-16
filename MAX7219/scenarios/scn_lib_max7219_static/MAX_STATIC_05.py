# MAX_STATIC_05.py
# Use for the generation of the scenario MAX_STATIC_05.txt
#
# Corner Tests
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

from MAX_STATIC_macros import INIT_STATIC_RAM, LOAD_PATTERN_I_STATIC


pattern_0 = ['0x18', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x18']

pattern_1 = ['0x18', '0x3c', '0x0', '0x81', '0x81', '0x42', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0x81', '0x24', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x24', '0x81', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x42', '0x81', '0x81', '0x0', '0x3c', '0x18']


pattern_2 = ['0x18', '0x3c', '0x0', '0x81', '0xff', '0x5a', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0xdb', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0xc3', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0xc3', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0xdb', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x5a', '0xff', '0x81', '0x0', '0x3c', '0x18']


pattern_3 = ['0xff', '0x3c', '0x3c', '0x81', '0xff', '0x5a', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xc3', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0xc3', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x5a', '0xff', '0x81', '0x3c', '0x3c', '0xff']


# Create SCN Class
scn_max_static_05 = scn_class.scn_class("MAX_STATIC_05.txt")


# Start of SCN

scn_max_static_05.print_line("//-- STEP 0\n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTR("RST_N")
scn_max_static_05.generic_tb_cmd.WAIT(100, "ns")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 0\n")
scn_max_static_05.print_line("//-- INIT STATIC\n")
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.SET("EN", 1)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.SET("SEL", 1) # SELECTION for display screen matrix

scn_max_static_05 = INIT_STATIC_RAM(scn_max_static_05)

scn_max_static_05.generic_tb_cmd.WAIT(1, "ns")

pattern_i  = pattern_0
start_addr = 0
scn_max_static_05 = LOAD_PATTERN_I_STATIC(scn_max_static_05, pattern_i, start_addr)

pattern_i  = pattern_1
start_addr = start_addr + 64
scn_max_static_05 = LOAD_PATTERN_I_STATIC(scn_max_static_05, pattern_i, start_addr)

pattern_i  = pattern_2
start_addr = start_addr + 64
scn_max_static_05 = LOAD_PATTERN_I_STATIC(scn_max_static_05, pattern_i, start_addr)

pattern_i  = pattern_3
start_addr = start_addr + 64
scn_max_static_05 = LOAD_PATTERN_I_STATIC(scn_max_static_05, pattern_i, start_addr)


scn_max_static_05.generic_tb_cmd.WAIT(1, "us")


scn_max_static_05.print_line("//-- STEP 1\n")
scn_max_static_05.print_line("//-- Start a Transation with start ptr = Last_ptr = 0\n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 0)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(1, "us")


#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WAIT(1, "us")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 2\n")
scn_max_static_05.print_line("//-- Start a correct Transation \n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 64)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTRS("PTR_EQUALITY", 20, "ms")
scn_max_static_05.print_line("\n")


#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(10, "us")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 3\n")
scn_max_static_05.print_line("//-- Start with LAST PTR > 63 \n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 128)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTRS("PTR_EQUALITY", 20, "ms")
scn_max_static_05.print_line("\n")


#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(10, "us")
scn_max_static_05.print_line("\n")


scn_max_static_05.print_line("//-- STEP 4\n")
scn_max_static_05.print_line("//-- Start with LAST PTR > 63 \n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 255)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTRS("PTR_EQUALITY", 20, "ms")
scn_max_static_05.print_line("\n")


#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(10, "us")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 5\n")
scn_max_static_05.print_line("//-- Start with LAST PTR > 63 \n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 128)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 127)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WTRS("PTR_EQUALITY", 20, "ms")
scn_max_static_05.print_line("\n")


#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
#scn_max_static_05.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(10, "us")
scn_max_static_05.print_line("\n")



scn_max_static_05.print_line("//-- STEP 6\n")
scn_max_static_05.print_line("//-- Start a Transation with start ptr = Last_ptr = 0\n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 0)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 0)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTRS("O_DISCARD", 1, "ms")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.WAIT(1, "us")




scn_max_static_05.print_line("//-- STEP 7\n")
scn_max_static_05.print_line("//-- Start a Transation with start ptr = Last_ptr = 255\n")
scn_max_static_05.print_line("\n")


scn_max_static_05.generic_tb_cmd.SET("START_PTR", 255)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 255)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")

scn_max_static_05.generic_tb_cmd.WTRS("O_DISCARD", 1, "ms")
scn_max_static_05.print_line("\n")

    
scn_max_static_05.generic_tb_cmd.WAIT(1, "us")
    
    
scn_max_static_05.print_line("//-- STEP 8\n")
scn_max_static_05.print_line("//-- Start a Transation with start ptr = Last_ptr = 37\n")
scn_max_static_05.print_line("\n")

    
scn_max_static_05.generic_tb_cmd.SET("START_PTR", 37)
scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", 37)
scn_max_static_05.print_line("\n")
    
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
scn_max_static_05.generic_tb_cmd.WTFS("CLK")
scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
scn_max_static_05.print_line("\n")
    
scn_max_static_05.generic_tb_cmd.WTRS("O_DISCARD", 1, "ms")
scn_max_static_05.print_line("\n")
    
    
scn_max_static_05.generic_tb_cmd.WAIT(1, "us")
    
    
scn_max_static_05.print_line("//-- STEP 9\n")
scn_max_static_05.print_line("//-- Start a Transation with start ptr = Last_ptr = 0:255\n")
scn_max_static_05.print_line("\n")
    
    
for i in range(0, 256):
    scn_max_static_05.generic_tb_cmd.SET("START_PTR", i)
    scn_max_static_05.generic_tb_cmd.SET("LAST_PTR", i)
    scn_max_static_05.print_line("\n")
    
    scn_max_static_05.generic_tb_cmd.WTFS("CLK")
    scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 1)
    scn_max_static_05.generic_tb_cmd.WTFS("CLK")
    scn_max_static_05.generic_tb_cmd.SET("PTR_VAL", 0)
    scn_max_static_05.print_line("\n")
    
    scn_max_static_05.generic_tb_cmd.WTRS("O_DISCARD", 1, "ms")
    scn_max_static_05.print_line("\n")
    
    
    scn_max_static_05.generic_tb_cmd.WAIT(1, "us")
    
    
    
scn_max_static_05.END_TEST()
