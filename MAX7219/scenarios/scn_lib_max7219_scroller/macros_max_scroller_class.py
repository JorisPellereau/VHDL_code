import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

sys.path.append("/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/scenarios/scn_lib_max7219_static")
# Import class
import macros_max_static_class


class macros_max_scroller_class:

    # == CONSTANTES ==
    

    def __init__(self, scn):
        self.scn = scn
        self.macros_max_static_class = macros_max_static_class.macros_max_static_class(scn)


    def write_data_in_ram(self, ram_addr, ram_data):
        self.macros_max_static_class.write_data_to_ram(ram_addr, ram_data)
