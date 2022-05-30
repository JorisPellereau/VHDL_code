# A class for computation of CRC

import sys
import os
import numpy as np

class crc_class:

    # Constructor
    def __init__(self):
        print("Init. crc_class")



        
    # CRC 16 - CCIT
    # Polynome : x^16 + x^12 + x^5 +1
    # i_data : int - Value 0 or 1 (Bit of the input data - MSB First)
    # i_data : an int - value 0 or 1
    # current_crc: an int
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

        # For each data compute bit per bit CRC - MSB First
        for data_bit_i in range(0, i_data_length):

            current_bit  = (i_data >> (i_data_length - 1 - data_bit_i)) & 0x1 # Current bit - MSB First
            current_crc  = self.crc_16_serial(current_bit, current_crc)       # Compute CRC

        # Reshape Data
        crc_16_for_1_data = 0
        for i in range(0, 16):            
            crc_16_for_1_data = crc_16_for_1_data | (current_crc[i] << i)
            
        return current_crc, crc_16_for_1_data



    def crc_16(self, data_in, crc_init, data_length = 8):

        # Only 1 data computed
        if(type(data_in) == int):
            crc, crc_16_for_1_data = self.crc_16_parallel(i_data        = data_in,
                                                          i_data_length = data_length,
                                                          crc_init      = crc_init)
            return crc, crc_16_for_1_data
        elif(type(data_in) == list):

            crc_out_data_list = []
            for i in range(0, len(data_in)):               
                    
                crc, crc_16_for_1_data = self.crc_16_parallel(i_data        = data_in[i],
                                                              i_data_length = data_length,
                                                              crc_init      = crc_init if i == 0 else crc_16_for_1_data)
                crc_out_data_list.append(crc_16_for_1_data)
            return crc, crc_16_for_1_data, crc_out_data_list
        


    def crc_16_par(self, data, crc_init):

        crc_current = []
        data_in     = []
        crc_out     = [0 for i in range(16)]
        for i in range(0, 16):
            crc_current.append( (crc_init >> i) & 0x1)

        for i in range(0, 8):
            data_in.append( (data >> i) & 0x1)
        

        crc_out[0]  =  data_in[0] ^ data_in[4] ^ crc_current[8] ^ crc_current[12]
        crc_out[1]  =  data_in[1] ^ data_in[5] ^ crc_current[9] ^ crc_current[13]
        crc_out[2]  =  data_in[2] ^ data_in[6] ^ crc_current[10] ^ crc_current[14]
        crc_out[3]  =  data_in[3] ^ data_in[7] ^ crc_current[11] ^ crc_current[15]
        crc_out[4]  =  data_in[4] ^ crc_current[12]
        crc_out[5]  =  data_in[0] ^ data_in[4] ^ data_in[5] ^ crc_current[8] ^ crc_current[12] ^ crc_current[13]
        crc_out[6]  =  data_in[1] ^ data_in[5] ^ data_in[6] ^ crc_current[9] ^ crc_current[13] ^ crc_current[14]
        crc_out[7]  =  data_in[2] ^ data_in[6] ^ data_in[7] ^ crc_current[10] ^ crc_current[14] ^ crc_current[15]
        crc_out[8]  =  data_in[3] ^ data_in[7] ^ crc_current[0] ^ crc_current[11] ^ crc_current[15]
        crc_out[9]  =  data_in[4] ^ crc_current[1] ^ crc_current[12]
        crc_out[10] =  data_in[5] ^ crc_current[2] ^ crc_current[13]
        crc_out[11] =  data_in[6] ^ crc_current[3] ^ crc_current[14]
        crc_out[12] =  data_in[0] ^ data_in[4] ^ data_in[7] ^ crc_current[4] ^ crc_current[8] ^ crc_current[12] ^ crc_current[15]
        crc_out[13] =  data_in[1] ^ data_in[5] ^ crc_current[5] ^ crc_current[9] ^ crc_current[13]
        crc_out[14] =  data_in[2] ^ data_in[6] ^ crc_current[6] ^ crc_current[10] ^ crc_current[14]
        crc_out[15] =  data_in[3] ^ data_in[7] ^ crc_current[7] ^ crc_current[11] ^ crc_current[15]

        crc_out_data = 0
        for i in range(0, 16):            
            crc_out_data = crc_out_data | (crc_out[i] << i)
            
        return crc_out_data

    
    def crc_serial_to_parallel(self, data_width, poly_width):

        
        h1_matrix = np.zeros([data_width, poly_width], int)
        h2_matrix = np.zeros([poly_width, poly_width], int)

        # Build H1 Matrix
        # Loop on Data width
        for i in range(0, data_width):
            current_crc, crc_16_for_1_data = self.crc_16_parallel(i_data        = (1 << i),
                                                                  i_data_length = data_width,
                                                                  crc_init      = 0)

            for j in range(0, poly_width):
                h1_matrix[i, j] = current_crc[j]

        # Build H2 Matrix
        for i in range(0, poly_width):
            
            current_crc, crc_16_for_1_data = self.crc_16_parallel(i_data        = 0,
                                                                  i_data_length = data_width,
                                                                  crc_init      = (1 << i))

            for j in range(0, poly_width):
                h2_matrix[i, j] = current_crc[j]


        # print("H1 Matrix :")
        # print("%s" %(h1_matrix))
        # print("H2 Matrix :")
        # print("%s" %(h2_matrix))



        # == PRINT CRC SERIAL 2 PAR ==
        for i in range(0, poly_width):

            str_out = "".format(i)
            for j in range(0, data_width):
                if(h1_matrix[j, i] == 1):
                    str_out = str_out + ("" if str_out == "" else " xor") + " data_in[{0}]".format(j)

            for j in range(0, poly_width):
                if(h2_matrix[j, i] == 1):
                    str_out = str_out + ("" if str_out == "" else " xor") + " crc_current[{0}]".format(j)


            print("crc_out[{0}] = ".format(i) + str_out)
