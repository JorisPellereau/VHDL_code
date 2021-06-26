
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

import numpy as np




uart_cmd_list = dict()
uart_cmd_list[0] = "INIT_RAM_STATIC"
uart_cmd_list[1] = "INIT_RAM_SCROLLER"
uart_cmd_list[2] = "UPDATE_MATRIX_CONFIG"
uart_cmd_list[3] = "LOAD_MATRIX_CONFIG"
uart_cmd_list[4] = "LOAD_PATTERN_STATIC"
uart_cmd_list[5] = "LOAD_PATTERN_SCROLL"
uart_cmd_list[6] = "RUN_PATTERN_STATIC"
uart_cmd_list[7] = "RUN_PATTERN_SCROLLER"


def str_cmd_2_hex_data_cmd(cmd):

    data_list = []
    for i in range(0, len(cmd)):
        data_list.append(ascii_str_2_hex(cmd[i]))

    # Fill Command with 0x00 if command < 20 bytes  
    if(len(data_list) < 20):
        for i in range(20-len(data_list)):
            data_list.append(0x00)

            
    print data_list    

    return data_list

# Convert an ASCII String to HEX int
def ascii_str_2_hex(ascii_str):

    if(ascii_str == "A"):
        data_hex = 0x41
    elif(ascii_str == "C"):
        data_hex = 0x43
    elif(ascii_str == "D"):
        data_hex = 0x44    
    elif(ascii_str == "E"):
        data_hex = 0x45
    elif(ascii_str == "F"):
        data_hex = 0x46
    elif(ascii_str == "G"):
        data_hex = 0x47    
    elif(ascii_str == "I"):
        data_hex = 0x49
    elif(ascii_str == "L"):
        data_hex = 0x4C
    elif(ascii_str == "M"):
        data_hex = 0x4D
    elif(ascii_str == "N"):
        data_hex = 0x4E
    elif(ascii_str == "O"):
        data_hex = 0x4F
    elif(ascii_str == "P"):
        data_hex = 0x50
    elif(ascii_str == "R"):
        data_hex = 0x52
    elif(ascii_str == "S"):
        data_hex = 0x53
    elif(ascii_str == "T"):
        data_hex = 0x54
    elif(ascii_str == "U"):
        data_hex = 0x55
    elif(ascii_str == "X"):
        data_hex = 0x58
    elif(ascii_str == "Y"):
        data_hex = 0x59

    # Special Char
    elif(ascii_str == "_"):
        data_hex = 0x5F
    else:
        data_hex = 0xFF
        print("data_hex error")
        
    return data_hex



# Check SPI Generation After Reset
def check_spi_config_after_reset(scn, decode_mode, intensity, scan_limit, shutdown, display_test):

    data_list = [(0x09 << 8) |decode_mode, (0x0A << 8) | intensity, (0x0B << 8) | scan_limit, (0x0C << 8) | shutdown, (0x0F << 8) | display_test]

    for nb_config in range(0, 5):
        for nb_matrix in range(0, 8):
            scn.generic_tb_cmd.WTR("SPI_FRAME_RECEIVED", 1, "ms")
            scn.generic_tb_cmd.CHK("O_SPI_DATA_RECEIVED",data_list[nb_config], 'OK')





# Check SPI transaction during a Scroller Pattern
# SPI transaction number :
# 8*8*(64 + pattern_length)
# Digit 0 updated 1st
# Digit 7 updated in last position
def check_spi_scroller(scn, data_to_check):

    # data[0] == Value of Digit 0 - Matrix 7
    # data[1] == Value of digit 0 - Marix 6
    data      = np.zeros([64], int)
    data_next = np.zeros([64], int)
    loop_nb = 64 + len(data_to_check)

    print("data_to_check : %s" %(data_to_check) )

    data[0] = data_to_check[0] # Init
    
    for loop_nb_i in range(0, loop_nb):

        # Update until it remains data in the list
        if(loop_nb_i < len(data_to_check) ):
            data[0] = data_to_check[loop_nb_i]
            
        # Else Add 0
        else:
            data[0] = 0

        # Select 1 digit at a time    
        for digit_i in range(0, 8):

            # Update the Same digit for all MATRIX
            for matrix_i in range(0, 8):

                scn.print_line("//-- loop_nb_i : %d - frame_nb : %d\n" %(loop_nb_i, matrix_i + digit_i*8))
                scn.generic_tb_cmd.WTR("SPI_FRAME_RECEIVED")#, 1, "ms")
                data_tmp = ( (digit_i + 1) << 8) | data[matrix_i + digit_i*8]
                scn.generic_tb_cmd.CHK("O_SPI_DATA_RECEIVED", int(data_tmp), 'OK')



       
        data_next = np.zeros([64], int)
        # Shift data
        # Update D0 => D7
        for matrix_i in range(0, 8-1):

            data_next[8 + matrix_i*8 + 0] = data[0 + matrix_i*8] # M7
            data_next[8 + matrix_i*8 + 1] = data[1 + matrix_i*8] # M6
            data_next[8 + matrix_i*8 + 2] = data[2 + matrix_i*8] # M5
            data_next[8 + matrix_i*8 + 3] = data[3 + matrix_i*8] # M4
            data_next[8 + matrix_i*8 + 4] = data[4 + matrix_i*8] # M3
            data_next[8 + matrix_i*8 + 5] = data[5 + matrix_i*8] # M2
            data_next[8 + matrix_i*8 + 6] = data[6 + matrix_i*8] # M1
            data_next[8 + matrix_i*8 + 7] = data[7 + matrix_i*8] # M0

        # Update D7 => D0 - D0(M7) updated at the beginning
        data_next[1] = data[56] # D0(M6) <= D7(M7)
        data_next[2] = data[57] # D0(M5) <= D7(M6)
        data_next[3] = data[58] # D0(M4) <= D7(M5)
        data_next[4] = data[59] # D0(M3) <= D7(M4)
        data_next[5] = data[60] # D0(M2) <= D7(M3)
        data_next[6] = data[61] # D0(M1) <= D7(M2)
        data_next[7] = data[62] # D0(M0) <= D7(M1)

        data = data_next


        print("loop_nb_i : %d" %(loop_nb_i) )
        print("data : %s" %(data) )
        print("data_next : %s \n" %(data_next) )
            
           

    
    
