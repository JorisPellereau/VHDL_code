# MAX7219_STATIC_04.py
# Use for the generation of the scenario MAX_STATIC_04.txt
#
#
# Aim of test :

import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

import macros_max_static_class

# Create SCN Class
scn       = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class(scn)


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.print_line("//-- STEP 0.1\n")
scn.print_line("//-- Init Inputs to 0")

scn.SET("EN", 0)
scn.SET("LOOP", 0)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.SET("PTR_VAL", 0)


scn.print_line("//-- STEP 1\n")

scn.print_line("//-- STEP 1.1 : Enable Block\n")
scn.SET("EN", 1)
scn.WTFS("CLK")

scn.END_TEST()
