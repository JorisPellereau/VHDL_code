import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

class i2c_master_tb_macro_class:        

    # Init
    def __init__(self, scn):
        self.scn = scn

    # Load I2C Master TX FIFO
    def load_i2c_master_tx_fifo(self, data_list):
       self.scn.LOAD_BUS("WR_EN_FIFO_TX", "WDATA_FIFO_TX", "CLK", data_list, timeout = 'none',unity = 'none')


    # Start a read of write I2C Master Access
    def start_i2c_master(self, chip_addr, rnw, nb_data):
        
        self.scn.WTFS("CLK")                 # Wait of CLK falling edge for synchronization
        self.scn.SET("START", 1)             # Set START Input to '1'
        self.scn.SET("RW", 1 if rnw == "READ" else 0)              # Set Read not Write (1 : Read - 0 : Write)
        self.scn.SET("CHIP_ADDR", chip_addr) # Set chip addr
        self.scn.SET("NB_DATA", nb_data)     # Set Number of Data of the I2C Access

        self.scn.WTFS("CLK")         # Wait of CLK falling edge for synchronization
        self.scn.SET("START",     0) # Set START Input to '0'
        self.scn.SET("RW",        0) # Reset to 0
        self.scn.SET("CHIP_ADDR", 0) # Reset to 0
        self.scn.SET("NB_DATA",   0) # Reset to 0

    def rd_fifo_rx_and_check(self, data_list):
        if(type(data_list) == list):
            for i in range(0, len(data_list)):
                self.scn.CHK("RDATA_FIFO_RX", data_list[i], "OK") # Check the current data
                self.scn.WTFS("CLK")                              # Wait of CLK falling edge for synchronization
                self.scn.SET("RD_EN_FIFO_RX", 1)                  # Set pulse on read enable
                self.scn.WTFS("CLK")                              # Wait of CLK falling edge for synchronization
                self.scn.SET("RD_EN_FIFO_RX", 0)                  # Set pulse on read enable
                self.scn.WTFS("CLK")                              # Wait of CLK falling edge for synchronization
                self.scn.WTFS("CLK")                              # Wait of CLK falling edge for synchronization
                self.scn.WTFS("CLK")                              # Wait of CLK falling edge for synchronization
        else:
            Error


                
        
