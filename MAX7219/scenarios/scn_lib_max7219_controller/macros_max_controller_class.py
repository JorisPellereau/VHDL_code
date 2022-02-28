import sys
import numpy as np


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

sys.path.append("/home/linux-jp/Documents/GitHub/Python/Tools/yattag_debug")
import html_blocs_class

class macros_max_scroller_class:        

    def __init__(self, scn):
        self.scn = scn
