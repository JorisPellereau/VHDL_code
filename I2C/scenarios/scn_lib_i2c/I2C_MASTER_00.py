# I2C_MASTER_00
#
# Test of write access on I2C Interface
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
# Load 256 into I2C Master FIFO TX
scn.print_step("Load 256 into I2C Master FIFO TX")
data_list = [i for i in range(256)]
i2c_master_tb_macro_class.load_i2c_master_tx_fifo(data_list = data_list)


scn.print_step("Send 256 times one I2C MASTER WRITE Access")
for i in range(0, 256):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "WRITE", 1)
    scn.WTFS("BUSY", 1, "ms")


scn.print_step("Check the 256 data received by the I2C Slave")
scn.I2C_SLAVE_CHECK_RX_DATA("I2C_SLAVE", data_list)

scn.WAIT(1, "us")


# ============= 2 DATA ============= #
# Load 256 into I2C Master FIFO TX
scn.print_step("Load 256 into I2C Master FIFO TX")
data_list = [255 - i for i in range(256)]
i2c_master_tb_macro_class.load_i2c_master_tx_fifo(data_list = data_list)


scn.print_step("Send 128 times 2 I2C MASTER WRITE Access")
for i in range(0, 128):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "WRITE", 2)
    scn.WTFS("BUSY", 1, "ms")
scn.print_step("Check the 256 data received by the I2C Slave")
scn.I2C_SLAVE_CHECK_RX_DATA("I2C_SLAVE", data_list)

scn.WAIT(1, "us")

# ============= 128 DATA ============= #
# Load 256 into I2C Master FIFO TX
scn.print_step("Load 256 into I2C Master FIFO TX")
data_list = [i for i in range(256)]
i2c_master_tb_macro_class.load_i2c_master_tx_fifo(data_list = data_list)


scn.print_step("Send 2 times I2C MASTER WRITE Access")
for i in range(0, 2):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "WRITE", 128)
    scn.WTFS("BUSY", 1, "ms")
scn.print_step("Check the 256 data received by the I2C Slave")
scn.I2C_SLAVE_CHECK_RX_DATA("I2C_SLAVE", data_list)

scn.WAIT(1, "us")

# ============= 256 DATA ============= #
# Load 256 into I2C Master FIFO TX
scn.print_step("Load 256 into I2C Master FIFO TX")
data_list = [255 - i for i in range(256)]
i2c_master_tb_macro_class.load_i2c_master_tx_fifo(data_list = data_list)


scn.print_step("Send 1 time I2C MASTER WRITE Access")
for i in range(0, 1):
    i2c_master_tb_macro_class.start_i2c_master(0xA, "WRITE", 256)
    scn.WTFS("BUSY", 1, "ms")
scn.print_step("Check the 256 data received by the I2C Slave")
scn.I2C_SLAVE_CHECK_RX_DATA("I2C_SLAVE", data_list)

scn.WAIT(1, "us")

scn.END_TEST()


