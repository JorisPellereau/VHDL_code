import sys


import numpy as np


class max7219_utils_class:


    
    # Sort Mem list from mem_generator to a list for STATIC RAM
    # Data_list organization :
    # D0_M0 - D1_M0 .. D7_M0 - .. - D0_M7 - .. - D7_M7
    # to
    # @n   : D7_M7
    # @n+1 : D7_M6
    # ..
    # @n+7 : D7_M0 + LOAD ENABLE
    # @n+8 : D6_M7
    # ..
    # @n+15 : D6_M0 + LOAD ENABLE
    # ..
    # @n+63 : D0_M0 + LOAD ENABLE
    def sort_mem_list(self, data_list):

        matrix_nb     = len(data_list) // 8 # Get Number of matrix
        out_data_list = [0 for i in range(len(data_list))]

        # For 8 DIGITS - Digit 7 first
        for i in range(0, 8):

            # For n Matrix
            for j in range(0, matrix_nb):
                # Digit i
                out_data_list[(i + 1)*matrix_nb - j - 1] = ((i + 1) << 8) | data_list[j*matrix_nb + (7-i)] # Concat ADDR and DATA
                if(j == matrix_nb - 1):
                    out_data_list[j + i*matrix_nb] = out_data_list[j + i*matrix_nb] + 0x1000 # Add Load Enable
                
        return out_data_list

