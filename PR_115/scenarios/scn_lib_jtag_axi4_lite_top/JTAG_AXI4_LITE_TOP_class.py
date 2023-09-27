import sys

scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class
import JTAG_AXI4_LITE_TOP_class



class JTAG_AXI4_LITE_TOP_class:

    def __init__(self, scn):
        # Create SCN Class
        self.scn = scn

        # == CONSTANTS ==
        self.counter_init_path = "sim:/tb_top/i_dut/i_jtag_axi4_lite_core_0/i_axi4_lite_lcd_0/i_lcd_cfah_top_0/i_lcd_cfah_init_0/s_duration_cnt"

#        

    
    def axi4_lite_write(self, addr, wdata, strobe, status):

        # self.scn.print_line_break(2)
        self.scn.print_comment("Write : 0x{:08X} at 0x{:08X} - strobe : 0x{:01X}".format(wdata, addr, strobe))
        self.scn.WTFS("CLK")
        self.scn.SET("START_MASTER", 1)
        self.scn.SET("ADDR_MASTER", addr)
        self.scn.SET("RNW_MASTER",0)
        self.scn.SET("STROBE_MASTER", strobe)
        self.scn.SET("WDATA_MASTER", wdata)
        self.scn.WTFS("CLK")
        self.scn.SET("START_MASTER", 0)
        self.scn.SET("ADDR_MASTER", 0)
        self.scn.SET("RNW_MASTER",0)
        self.scn.SET("STROBE_MASTER", 0)
        self.scn.SET("WDATA_MASTER", 0)

        self.scn.WTRS("DONE_MASTER", 10, "ms")
        self.scn.CHK("STATUS_MASTER", status, "OK")
        
    def axi4_lite_read(self, addr, rdata, status):

        self.scn.print_comment("Read in : 0x{:08X} : 0x{:08X} - status : 0x{:01X}".format(addr, rdata, status))
        self.scn.WTFS("CLK")
        self.scn.SET("START_MASTER", 1)
        self.scn.SET("ADDR_MASTER", addr)
        self.scn.SET("RNW_MASTER",1)
        self.scn.SET("STROBE_MASTER", 0)
        self.scn.SET("WDATA_MASTER", 0)
        self.scn.WTFS("CLK")
        self.scn.SET("START_MASTER", 0)
        self.scn.SET("ADDR_MASTER", 0)
        self.scn.SET("RNW_MASTER",0)
        self.scn.SET("STROBE_MASTER", 0)
        self.scn.SET("WDATA_MASTER", 0)
        self.scn.WTRS("DONE_MASTER", 10, "ms")
        self.scn.CHK("RDATA_MASTER", rdata, "OK")
        self.scn.CHK("STATUS_MASTER", status, "OK")


    # Convert a char string into its ADDR in the DDRAM of the LCD
    def lcd_char_decoder(self, char):
        ddram_addr = ord(char)
        
        return ddram_addr

    # Return a list of DDRAM addr from the string input
    def lcd_str_to_ddram_addr(self, string):
        ddram_addr_list = []

        for i in string:
            ddram_addr_list.append(self.lcd_char_decoder(i))

        return ddram_addr_list
