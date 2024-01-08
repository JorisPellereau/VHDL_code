# SPI_MASTER_00
#
# Test of Write in the FIFOs and perform single Write
# 
# DUT Configuration :
#
#
#  G_SPI_SIZE        : 4;    -- SPI Size
#  G_SPI_DATA_WIDTH  : 8;    -- SPI DATA WIDTH
#  G_FIFO_DATA_WIDTH : 8;    -- FIFO DATA WIDTH
#  G_FIFO_DEPTH      : 1024  -- FIFO DEPTH
#
#


import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

# Create SCN Class
scn = scn_class.scn_class()

import spi_master_class

spi_master_class = spi_master_class.spi_master_class(scn, 4, 8, 8, 10)

scn.WTRS("RST_N")

scn.WAIT(200, "ns")

scn.print_step("Write into FIFO TX and Start SPI Write Transaction : only one data to write")
spi_master_class.wr_fifo(0xAA)

scn.WAIT(200, "ns")

scn.print_step("")
spi_master_class.start_spi_master(nb_wr       = 1,
                                  nb_rd       = 0,
                                  clk_div     = 1,
                                  full_duplex = 0,
                                  cpha        = 0,
                                  cpol        = 0)

scn.WTFS("SPI_BUSY") # Synchronization on the end of the SPI


scn.print_step("Write into FIFO TX and Start SPI Write Transaction : only one data to write")
spi_master_class.wr_fifo(0xBC)

scn.WAIT(200, "ns")

scn.print_step("")
spi_master_class.start_spi_master(nb_wr       = 1,
                                  nb_rd       = 0,
                                  clk_div     = 1,
                                  full_duplex = 0,
                                  cpha        = 0,
                                  cpol        = 0)

scn.WTFS("SPI_BUSY") # Synchronization on the end of the SPI

scn.print_step("Write into FIFO TX and Start SPI Write Transaction : only one data to write")
spi_master_class.wr_fifo(0x98)

scn.WAIT(200, "ns")

scn.print_step("")
spi_master_class.start_spi_master(nb_wr       = 1,
                                  nb_rd       = 0,
                                  clk_div     = 1,
                                  full_duplex = 0,
                                  cpha        = 0,
                                  cpol        = 0)

scn.WTFS("SPI_BUSY") # Synchronization on the end of the SPI


# scn.print_step("Write into FIFO TX and Start SPI Write Transaction : only one data to write")
# spi_master_class.wr_fifo(0x12)

# scn.WAIT(200, "ns")

# scn.print_step("")
# spi_master_class.start_spi_master(nb_wr       = 1,
#                                   nb_rd       = 0,
#                                   clk_div     = 20,
#                                   full_duplex = 0,
#                                   cpha        = 0,
#                                   cpol        = 1)

# scn.WTFS("SPI_BUSY") # Synchronization on the end of the SPI

# scn.print_step("Write into FIFO TX and Start SPI Write Transaction : only one data to write")

# for i in range(0,256):
#     spi_master_class.wr_fifo(i)

#     scn.WAIT(200, "ns")

#     scn.print_step("")
#     spi_master_class.start_spi_master(nb_wr       = 1,
#                                       nb_rd       = 0,
#                                       clk_div     = 50,
#                                       full_duplex = 0,
#                                       cpha        = 0,
#                                       cpol        = 0)
    
#     scn.WTFS("SPI_BUSY") # Synchronization on the end of the SPI


# scn.WAIT(200, "ns")


scn.END_TEST()
