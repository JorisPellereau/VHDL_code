# MAX_STATIC_05.py
# Use for the generation of the scenario MAX_STATIC_05.txt
#
# Corner Tests
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

#from MAX_STATIC_macros import INIT_STATIC_RAM, LOAD_PATTERN_I_STATIC
import macros_max_static_class

pattern_0 = ['0x18', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x0', '0x0', '0x0', '0x0', '0x3c', '0x18']

pattern_1 = ['0x18', '0x3c', '0x0', '0x81', '0x81', '0x42', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0x81', '0x24', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0x81', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0x81', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x24', '0x81', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x42', '0x81', '0x81', '0x0', '0x3c', '0x18']


pattern_2 = ['0x18', '0x3c', '0x0', '0x81', '0xff', '0x5a', '0x18', '0x3c', '0x3c', '0x3c', '0x0', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0x7e', '0x3c', '0x0', '0x81', '0xdb', '0x18', '0x3c', '0x3c', '0xff', '0x3c', '0x0', '0x81', '0xc3', '0x18', '0x3c', '0x3c', '0x3c', '0x3c', '0x18', '0xc3', '0x81', '0x0', '0x3c', '0xff', '0x3c', '0x3c', '0x18', '0xdb', '0x81', '0x0', '0x3c', '0x7e', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x0', '0x3c', '0x3c', '0x3c', '0x18', '0x5a', '0xff', '0x81', '0x0', '0x3c', '0x18']


pattern_3 = ['0xff', '0x3c', '0x3c', '0x81', '0xff', '0x5a', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xdb', '0x3c', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x81', '0xc3', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0x3c', '0xc3', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x3c', '0xdb', '0x81', '0x3c', '0x3c', '0xff', '0x3c', '0x3c', '0x5a', '0xff', '0x81', '0x3c', '0x3c', '0xff']


# Create SCN Class
scn       = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class()

# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")


scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")



scn.print_line("//-- STEP 0\n")
scn.print_line("//-- INIT STATIC\n")
scn.print_line("\n")

scn.SET("EN", 1)
scn.print_line("\n")

scn.SET("SEL", 1) # SELECTION for display screen matrix

#scn =
scn_macros.INIT_STATIC_RAM()

scn.WAIT(1, "ns")

pattern_i  = pattern_0
start_addr = 0
scn_macros.LOAD_PATTERN_I_STATIC(pattern_i, start_addr)

pattern_i  = pattern_1
start_addr = start_addr + 64
scn_macros.LOAD_PATTERN_I_STATIC(pattern_i, start_addr)

pattern_i  = pattern_2
start_addr = start_addr + 64
scn_macros.LOAD_PATTERN_I_STATIC(pattern_i, start_addr)

pattern_i  = pattern_3
start_addr = start_addr + 64
scn_macros.LOAD_PATTERN_I_STATIC(pattern_i, start_addr)


scn.WAIT(1, "us")


scn.print_line("//-- STEP 1\n")
scn.print_line("//-- Start a Transation with start ptr = Last_ptr = 0\n")
scn.print_line("\n")


scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.print_line("\n")

scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")


scn.WAIT(1, "us")


#scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WTFS("CLK")
#scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.print_line("\n")

scn.WAIT(1, "us")
scn.print_line("\n")



scn.print_line("//-- STEP 2\n")
scn.print_line("//-- Start a correct Transation \n")
scn.print_line("\n")


scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 64)
scn.print_line("\n")


scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")


scn.WTRS("PTR_EQUALITY", 20, "ms")
scn.print_line("\n")


#scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WTFS("CLK")
#scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.print_line("\n")


scn.WAIT(10, "us")
scn.print_line("\n")



scn.print_line("//-- STEP 3\n")
scn.print_line("//-- Start with LAST PTR > 63 \n")
scn.print_line("\n")


scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 128)
scn.print_line("\n")


scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")


scn.WTRS("PTR_EQUALITY", 20, "ms")
scn.print_line("\n")


#scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WTFS("CLK")
#scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.print_line("\n")


scn.WAIT(10, "us")
scn.print_line("\n")


scn.print_line("//-- STEP 4\n")
scn.print_line("//-- Start with LAST PTR > 63 \n")
scn.print_line("\n")


scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 255)
scn.print_line("\n")


scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")


scn.WTRS("PTR_EQUALITY", 20, "ms")
scn.print_line("\n")


#scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WTFS("CLK")
#scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.print_line("\n")


scn.WAIT(10, "us")
scn.print_line("\n")



scn.print_line("//-- STEP 5\n")
scn.print_line("//-- Start with LAST PTR > 63 \n")
scn.print_line("\n")


scn.SET("START_PTR", 128)
scn.SET("LAST_PTR", 127)
scn.print_line("\n")


scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")


scn.WTRS("PTR_EQUALITY", 20, "ms")
scn.print_line("\n")


#scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
#scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WTFS("CLK")
#scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.print_line("\n")


scn.WAIT(10, "us")
scn.print_line("\n")



scn.print_line("//-- STEP 6\n")
scn.print_line("//-- Start a Transation with start ptr = Last_ptr = 0\n")
scn.print_line("\n")


scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.print_line("\n")

scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")

scn.WTRS("O_DISCARD", 1, "ms")
scn.print_line("\n")


scn.WAIT(1, "us")




scn.print_line("//-- STEP 7\n")
scn.print_line("//-- Start a Transation with start ptr = Last_ptr = 255\n")
scn.print_line("\n")


scn.SET("START_PTR", 255)
scn.SET("LAST_PTR", 255)
scn.print_line("\n")

scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")

scn.WTRS("O_DISCARD", 1, "ms")
scn.print_line("\n")

    
scn.WAIT(1, "us")
    
    
scn.print_line("//-- STEP 8\n")
scn.print_line("//-- Start a Transation with start ptr = Last_ptr = 37\n")
scn.print_line("\n")

    
scn.SET("START_PTR", 37)
scn.SET("LAST_PTR", 37)
scn.print_line("\n")
    
scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)
scn.print_line("\n")
    
scn.WTRS("O_DISCARD", 1, "ms")
scn.print_line("\n")
    
    
scn.WAIT(1, "us")
    
    
scn.print_line("//-- STEP 9\n")
scn.print_line("//-- Start a Transation with start ptr = Last_ptr = 0:255\n")
scn.print_line("\n")
    
    
for i in range(0, 256):
    scn.SET("START_PTR", i)
    scn.SET("LAST_PTR", i)
    scn.print_line("\n")
    
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 1)
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 0)
    scn.print_line("\n")
    
    scn.WTRS("O_DISCARD", 1, "ms")
    scn.print_line("\n")
    
    
    scn.WAIT(1, "us")
    
    
    
scn.END_TEST()
