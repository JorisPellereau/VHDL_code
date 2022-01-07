# MAX_STATIC_00.py
# Use for the generation of the scenario MAX_STATIC_00.txt
#
#
# Aim of test : Configure All eight Matrix and turn on entire screen (All digit register to 0xFF value)
#

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

#from MAX_STATIC_macros import INIT_STATIC_RAM, LOAD_PATTERN_I_STATIC
import macros_max_static_class

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

scn.print_line("//-- STEP 1\n")
# == Init Memory with MAX7219 Configuration for 8 Matrix ==
scn.print_line("//-- INIT STATIC\n")
scn.print_line("\n")

scn.SET("EN", 1)

# Init DECODE MODE
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

for i in range(0, 7):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x0900)
    scn.WTFS("CLK")

scn.SET("ADDR", 0x007)
scn.SET("WDATA", 0x1900)
scn.WTFS("CLK")    

scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT INTENSITY MODE
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

for i in range(8, 0xF):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x0A01)
    scn.WTFS("CLK")

scn.SET("ADDR", 0xF)
scn.SET("WDATA", 0x1A01)
scn.WTFS("CLK")

scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT SCAN_LIMIT MODE
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

for i in range(0x10, 0x17):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x0B07)
    scn.WTFS("CLK")

scn.SET("ADDR", 0x17)
scn.SET("WDATA", 0x1B07)
scn.WTFS("CLK")

scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT SHUTDOWN MODE
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

for i in range(0x18, 0x1F):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x0C01)
    scn.WTFS("CLK")

scn.SET("ADDR", 0x1F)
scn.SET("WDATA", 0x1C01)
scn.WTFS("CLK")

scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")


# INIT DISPLAY_TEST MODE
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

for i in range(0x20, 0x27):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x0F00)
    scn.WTFS("CLK")

scn.SET("ADDR", 0x27)
scn.SET("WDATA", 0x1F00)
scn.WTFS("CLK")

scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")


# SET START PTR and STOP PTR

scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0x28)

scn.WTRS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTRS("CLK")
scn.SET("PTR_VAL", 0)

# == Wait for the end of the transfert and Display registers
scn.WTR("PTR_EQUALITY", 1, "ms")
scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
scn.WAIT(1, "us")
scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WAIT(1, "us")

# => Check Registers and screen in transcript

scn.SET("DISPLAY_REG_MATRIX_N", 0x00)
scn.WAIT(1, "us")

scn.SET("DISPLAY_SCREEN_MATRIX", 0)
scn.WAIT(1, "us")

# Set DIGIT of ALL Matrix
scn.WTFS("CLK")

scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")

# INIT DIGIT 0
for i in range(0x29, 0x30):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x01FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x30)
scn.SET("WDATA", 0x11FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 1
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x31, 0x38):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x02FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x38)
scn.SET("WDATA", 0x12FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 2
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x39, 0x40):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x03FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x40)
scn.SET("WDATA", 0x13FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 3
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x40, 0x48):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x04FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x48)
scn.SET("WDATA", 0x14FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 4
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x49, 0x50):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x05FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x50)
scn.SET("WDATA", 0x15FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 5
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x51, 0x58):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x06FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x58)
scn.SET("WDATA", 0x16FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 6
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x59, 0x60):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x07FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x60)
scn.SET("WDATA", 0x17FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")

# INIT DIGIT 7
scn.SET("ME", 1)
scn.SET("WE", 1)
scn.WTFS("CLK")
for i in range(0x61, 0x68):
    scn.SET("ADDR", i)
    scn.SET("WDATA", 0x08FF)
    scn.WTFS("CLK")
    
scn.SET("ADDR", 0x68)
scn.SET("WDATA", 0x18FF)
scn.WTFS("CLK")
scn.SET("ME", 0)
scn.SET("WE", 0)
scn.WTFS("CLK")


# SET START and STOP PTR

scn.SET("START_PTR", 0x29)
scn.SET("LAST_PTR", 0x69)

scn.WTRS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTRS("CLK")
scn.SET("PTR_VAL", 0)

# == Wait for the end of the transfert and Display registers

scn.SET("DISPLAY_REG_MATRIX_N", 0xFF)
scn.WAIT(1, "us")
scn.SET("DISPLAY_SCREEN_MATRIX", 1)
scn.WAIT(1, "us")

scn.END_TEST()
