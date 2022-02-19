import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import scn_class

class macros_max_scroller_class:

    # == CONSTANTES ==
    

    def __init__(self, scn):
        self.scn = scn
        
