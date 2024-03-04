# I2C_MASTER_01
#
# Test of read access on I2C Interface
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

# ============= 1 DATA ============= #
# Load 256 into I2C Slave FIFO TX
scn.print_step("Load 256 into I2C SLAVE FIFO TX")
data_list = [i for i in range(256)]
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE", data_list)

scn.print_step("Send 256 times one I2C MASTER READ Access")
for i in range(0, 256):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "READ", 1)
    scn.WTFS("BUSY", 1, "ms")
    i2c_master_tb_macro_class.rd_fifo_rx_and_check([data_list[i]])

scn.WAIT(5, "us")

# ============= 2 DATA ============= #
# Load 256 into I2C Slave FIFO TX
scn.print_step("Load 256 into I2C SLAVE FIFO TX")
data_list = [255 - i for i in range(256)]
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE", data_list)

scn.print_step("Send 128 times 2 I2C MASTER READ Access")
for i in range(0, 128):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "READ", 2)
    scn.WTFS("BUSY", 1, "ms")
    i2c_master_tb_macro_class.rd_fifo_rx_and_check(data_list[i*2:(i+1)*2])

scn.WAIT(5, "us")

# ============= 128 DATA ============= #
# Load 256 into I2C Slave FIFO TX
scn.print_step("Load 256 into I2C SLAVE FIFO TX")
data_list = [i for i in range(256)]
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE", data_list)

scn.print_step("Send 2 times 128 I2C MASTER READ Access")
for i in range(0, 2):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "READ", 128)
    scn.WTFS("BUSY", 1, "ms")
    i2c_master_tb_macro_class.rd_fifo_rx_and_check(data_list[i*128:(i+1)*128])

scn.WAIT(1, "us")

# ============= 256 DATA ============= #
# Load 256 into I2C Slave FIFO TX
scn.print_step("Load 256 into I2C SLAVE FIFO TX")
data_list = [255 - i for i in range(256)]
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE", data_list)

scn.print_step("Send one time 256 I2C MASTER READ Access")
for i in range(0, 1):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "READ", 256)
    scn.WTFS("BUSY", 1, "ms")
i2c_master_tb_macro_class.rd_fifo_rx_and_check(data_list)

scn.WAIT(1, "us")


scn.END_TEST()


