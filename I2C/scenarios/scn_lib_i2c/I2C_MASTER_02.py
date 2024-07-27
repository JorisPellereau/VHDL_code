# I2C_MASTER_02
#
# Test of polling function of I2C Master
#
import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class
import i2c_master_tb_macro_class


# Create SCN Class
scn = scn_class.scn_class()
i2c_master_tb_macro_class = i2c_master_tb_macro_class.i2c_master_tb_macro_class(scn)

scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

# Initialized I2C SLAVE EEPROM
scn.I2C_SLAVE_SET_ADDR("I2C_SLAVE", 0x0A)


# Load 256 into I2C Slave FIFO TX
scn.print_step("Load 256 into I2C SLAVE FIFO TX")
data_list = [i for i in range(256)]
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE", data_list)

scn.print_step("Load 256 into I2C Master FIFO TX")
data_list = [i for i in range(256)]
i2c_master_tb_macro_class.load_i2c_master_tx_fifo(data_list = data_list)


scn.print_step("Start a write access with polling")

i2c_master_tb_macro_class.start_i2c_master(0xA, "WRITE", 1, True)
scn.SET("MAX_POLLING_I2C_SLAVE", 5)
scn.WTFS("BUSY", 1, "ms")


scn.WAIT(5, "us")

scn.END_TEST()


