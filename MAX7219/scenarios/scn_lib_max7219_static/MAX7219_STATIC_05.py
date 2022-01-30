# MAX_STATIC_05.py
# Use for the generation of the scenario MAX7219_STATIC_05.txt
#
# Test of Loop configuration : i_loop enable loop mode
#                               loop mode begin only of a ptr_val is detected and until i_loop return to '0'
#                               A i_loop = '1' without ptr_val shall not start SPI generation
# Test of Discard status

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

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT/MAX7219_STATIC_{:02d}_collect.txt"
 

# Create SCN Macro
scn_macros = macros_max_static_class.macros_max_static_class(scn)


# Start of SCN

scn.print_line("//-- STEP 0\n")
scn.print_line("\n")

scn.DATA_COLLECTOR_INIT("MAX7219_STATIC_INPUT_COLLECTOR_0", 0, collect_path.format(5))

scn.WTR("RST_N")
scn.WAIT(100, "ns")
scn.print_line("\n")

scn.DATA_COLLECTOR_START("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)

scn.SET("EN", 0)
scn.SET("LOOP", 0)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0)
scn.SET("PTR_VAL", 0)
scn.WAIT(100, "ns")

scn.print_line("//-- STEP 1\n")

scn.print_line("//-- STEP 1.1 : Enable Block\n")
scn.SET("EN", 1)
scn.WTFS("CLK")


scn.print_line("//-- STEP 1.2 : Init RAM\n")
ram_addr = 0x00
ram_data = [0xBB, 0xCC]
scn_macros.write_data_to_ram(ram_addr, ram_data)


scn.print_line("//-- STEP 1.3 : Enable LOOP Mode\n")

scn.SET("LOOP", 1)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0x2)
scn.WAIT(10, "us")
scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)

for i in range(0, 10):
    scn.WTRS("SPI_FRAME_RECEIVED", 10, "ms")

scn.print_line("//-- STEP 1.4 : Stop loop Mode\n")

scn.SET("LOOP", 0)

scn.WAIT(10, "us")

scn.print_line("//-- STEP 2.1 : Enable LOOP Mode without ptr_val\n")

scn.SET("LOOP", 1)
scn.SET("START_PTR", 0)
scn.SET("LAST_PTR", 0x2)

scn.WAIT(100, "us")

scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)

scn.WAIT(50, "us")

scn.print_line("//-- STEP 2.2 : PTR_VAL during loop mode\n")

scn.WAIT(50, "us")

scn.SET("LOOP", 0)

scn.WAIT(10, "us")

scn.print_line("//-- STEP 3 : Enable Loop wait and disable loop => nothing append\n")

scn.SET("LOOP", 1)
scn.WAIT(10, "us")
scn.SET("LOOP", 0)
scn.WAIT(10, "us")

scn.print_line("//-- STEP 3 : Enable Loop wait for 2 SPI frames => STOP Loop during a SPI frame\n")

ram_addr = 0x00
ram_data = [0xDD, 0xDE]
scn_macros.write_data_to_ram(ram_addr, ram_data)

scn.SET("LOOP", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 1)
scn.WTFS("CLK")
scn.SET("PTR_VAL", 0)

scn.WAIT(3400, "ns")
scn.SET("LOOP", 0)

scn.WAIT(10, "us")

scn.print_line("//-- STEP 4 : Start PTR_VAL with same value of start and last ptr O_DISCARD expected\n")

for i in range(0, 256):
    scn.SET("START_PTR", i)
    scn.SET("LAST_PTR", i)
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 1)
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 0)
    scn.WTRS("O_DISCARD", 1, "us")

scn.WAIT(1, "us")

for i in range(0, 1):
    scn.SET("START_PTR", i)
    scn.SET("LAST_PTR", i)
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 1)
    scn.WTFS("CLK")
    scn.SET("PTR_VAL", 0)
    scn.WTRS("O_DISCARD", 1, "us")
    
scn.DATA_COLLECTOR_STOP("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("MAX7219_STATIC_INPUT_COLLECTOR_0", 0)
  
scn.END_TEST()
