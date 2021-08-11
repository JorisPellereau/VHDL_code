# A class for the conversion of Serial CRC to A Parallel CRC implementation

from crc_class import *
import numpy as np

class crc_serial2parallel_class:

    def __init__(self, data_in_length, polynom_width):
        
        self.crc_class_inst = crc_class()

        self.data_in_length = data_in_length
        self.polynom_width  = polynom_width

        # Init Variables
        self.h1_matrix = np.zeros([data_in_length, polynom_width], int)
        self.h2_matrix = np.zeros([polynom_width, polynom_width], int)
        print("Init. crc_serial2parallel_class done !")



    def fill_h1(self, crc_init):

        # Init internal variables
        data    = [0 for i in range(self.data_in_length)]
        data[0] = 1 # Init LSB to 1

        # Compute CRC for the data
        if(self.polynom_width == 16):

            for nb_bit_i in range(0, self.data_in_length):
                next_crc_serial, crc_16 = self.crc_class_inst.crc_16_parallel(data, self.data_in_length, crc_init)

                # Fill h1
                for j in range(0, self.polynom_width):
                    self.h1_matrix[nb_bit_i][j] = next_crc_serial[j]

                # Shift Data
                data[1:self.data_in_length - 1] = data[0:self.data_in_length - 2]
                data[0] = 0
                
        else:
            print("Other polynom width not implemented !!")

        
