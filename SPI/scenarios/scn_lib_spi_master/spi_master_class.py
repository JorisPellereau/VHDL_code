import os
import sys

class spi_master_class:

    def __init__(self, scn, G_SPI_SIZE, G_SPI_DATA_WIDTH, G_FIFO_DATA_WIDTH, G_FIFO_DEPTH):

        self.scn               = scn
        self.G_SPI_SIZE        = G_SPI_SIZE
        self.G_SPI_DATA_WIDTH  = G_SPI_DATA_WIDTH
        self.G_FIFO_DATA_WIDTH = G_FIFO_DATA_WIDTH
        self.G_FIFO_DEPTH      = G_FIFO_DEPTH
    

    def start_spi_master(self, nb_wr, nb_rd, clk_div, full_duplex, cpha, cpol):

        self.scn.print_comment("Start the SPI transaction")
        self.scn.print_comment("nb_wr       : {0}" .format(nb_wr))
        self.scn.print_comment("nb_rd       : {0}" .format(nb_rd))
        self.scn.print_comment("clk_div     : {0}" .format(clk_div))
        self.scn.print_comment("full_duplex : {0}" .format(full_duplex))
        self.scn.print_comment("cpha        : {0}" .format(cpha))
        self.scn.print_comment("cpol        : {0}" .format(cpol))

        self.scn.WTFS("CLK")
        self.scn.SET("NB_WR",       nb_wr)
        self.scn.SET("NB_RD",       nb_rd)
        self.scn.SET("CLK_DIV",     clk_div)
        self.scn.SET("FULL_DUPLEX", full_duplex)
        self.scn.SET("CPHA",        cpha)
        self.scn.SET("CPOL",        cpol)
        self.scn.SET("START",       1)
        
        self.scn.WTFS("CLK")
        self.scn.SET("NB_WR",       0)
        self.scn.SET("NB_RD",       0)
        self.scn.SET("CLK_DIV",     0)
        self.scn.SET("FULL_DUPLEX", 0)
        self.scn.SET("CPHA",        0)
        self.scn.SET("CPOL",        0)
        self.scn.SET("START",       0)
       
        
                                                
        

    def wr_fifo(self, fifo_data):
        """
        Write Data into the FIFO
        """

        # Single Write
        if(type(fifo_data) == int):
            self.scn.print_comment("Write One data (0x%X) in FIFO TX" %(fifo_data))
            self.scn.WTFS("CLK")
            self.scn.SET("WR_EN_FIFO_TX", 1)
            self.scn.SET("WDATA_FIFO_TX", fifo_data)
            self.scn.WTFS("CLK")
            self.scn.SET("WR_EN_FIFO_TX", 0)
            self.scn.SET("WDATA_FIFO_TX", 0)
            
        elif(type(fifo_data) == list):

            self.scn.print_comment("Write Several data into FIFO TX")
            for i in range(0, len(fifo_data)):
                self.scn.WTFS("CLK")
                self.scn.SET("WR_EN_FIFO_TX", 1)
                self.scn.SET("WDATA_FIFO_TX", fifo_data[i])
                self.scn.WTFS("CLK")
                self.scn.SET("WR_EN_FIFO_TX", 0)
                self.scn.SET("WDATA_FIFO_TX", 0)
