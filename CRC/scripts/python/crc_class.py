# A class for computation of CRC

import sys
import os


class crc_class:

    # Constructor
    def __init__(self):
        print("Init. crc_class")



        
    # CRC 16
    # Polynome : x^16 + x^12 + x^5 +1
    # i_data : int - Value 0 or 1 (Bit of the input data - MSB First)
    #
    def crc_16_serial(self, i_data, current_crc):

        # Init CRC serial
        next_crc_serial = [0 for i in range(16)]
        
        next_crc_serial[0] = current_crc[15] ^ i_data;
        next_crc_serial[1] = current_crc[0];
        next_crc_serial[2] = current_crc[1];
        next_crc_serial[3] = current_crc[2];
        next_crc_serial[4] = current_crc[3];
        next_crc_serial[5] = current_crc[4] ^ current_crc[15] ^ i_data;
        next_crc_serial[6] = current_crc[5];
        next_crc_serial[7] = current_crc[6];
        next_crc_serial[8] = current_crc[7];
        next_crc_serial[9] = current_crc[8];
        next_crc_serial[10] = current_crc[9];
        next_crc_serial[11] = current_crc[10];
        next_crc_serial[12] = current_crc[11] ^ current_crc[15] ^ i_data;
        next_crc_serial[13] = current_crc[12];
        next_crc_serial[14] = current_crc[13];
        next_crc_serial[15] = current_crc[14];

        return next_crc_serial


    # Compute CRC_16 For 1 data
    # i_data :an int or a list
    def crc_16_parallel(self, i_data, i_data_length, crc_init):

        # Init Variables
        current_crc        = [0 for i in range(16)]
        nb_data_to_compute = 0
        data_list          = [] # An empty list

        # Init current_crc with crc_init
        for i in range(0, 16):
            current_crc[i] = (crc_init >> i) & 0x1


        # Get the number of data to compute
        if(type(i_data) == int):
            nb_data_to_compute = 1
            data_list.append(i_data)
        elif(type(i_data) == list):
            nb_data_to_compute = len(i_data) # Get the number of data to compute
            data_list = i_data
        else:
            print("Error: type(i_data) /= int or list")

        # For the number of data to compute CRC
        for data_i in range(0, nb_data_to_compute):

            # For each data compute bit per bit CRC - MSB First
            for data_bit_i in range(0, i_data_length):

                current_bit = (data_list[data_i] >> (i_data_length - 1 - data_bit_i)) & 0x1 # Current bit - MSB First
                next_crc_serial_tmp = self.crc_16_serial(current_bit, current_crc) # Compute CRC
                current_crc = next_crc_serial_tmp # Update current CRC

        # Reshape Data
        crc_16_for_1_data = 0
        for i in range(0, 16):            
            crc_16_for_1_data = crc_16_for_1_data | (next_crc_serial_tmp[i] << i)
        return next_crc_serial_tmp, crc_16_for_1_data
