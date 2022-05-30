import sys
import ast

from crc_class import *

crc_class = crc_class()
crc_init = int(sys.argv[2], 16)

if(sys.argv[1][0] == '['):
    data = ast.literal_eval(sys.argv[1])
    crc_list, crc, crc_out_data_list      = crc_class.crc_16(data, crc_init)
        
else:
    data     = int(sys.argv[1], 16)
    crc_list, crc     = crc_class.crc_16(data, crc_init)

#data = [0x1, 0x1]
#crc_list, crc, crc_out_data_list      = crc_class.crc_16(data, crc_init)

if(type(data) == int):
    print("crc(0x%X) : 0x%x" %(data, crc))
else:
    print("crc(0x%s) : 0x%x" %(data, crc))

# if(type(data) == int):
#     crc = crc_class.crc_16_par(data = data,
#                                crc_init = crc_init)


#     if(type(data) == int):
#         print("crc(0x%X) : 0x%x" %(data, crc))
#     else:
#         print("crc(0x%s) : 0x%x" %(data, crc))
# crc_class.crc_serial_to_parallel(data_width = 8,
#                                  poly_width = 16)

# Script de test
# If its a list => arg STR to list
# if(sys.argv[1][0] == '['):
#     i_data = sys.argv[1][1:len(sys.argv[1]) - 1].split(',')
#     for i in range(0, len(i_data)):
#         i_data[i] = int(i_data[i], 16)
# else:
#     i_data        = int(sys.argv[1], 16)


# i_data_length = int(sys.argv[2], 16)
# i_crc_init    = int(sys.argv[3], 16)

# # Init class

# crc_class_inst = crc_class()

# crc_16_computed_list, crc_16_computed = crc_class_inst.crc_16_parallel(i_data, i_data_length, i_crc_init)
# if(type(i_data) == int):
#     print("CRC_16(0x%X) : 0x%X" %(i_data, crc_16_computed))
# elif(type(i_data) == list):
#     print("CRC_16(%s) : 0x%X" %(i_data, crc_16_computed))
