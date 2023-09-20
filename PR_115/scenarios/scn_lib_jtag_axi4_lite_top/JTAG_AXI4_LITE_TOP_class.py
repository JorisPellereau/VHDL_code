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

    
    def axi4_lite_write(self, addr, wdata, strobe, status):

        self.scn.print_comment("Write : 0x{08X} at 0x{08X} - strobe : 0x{08X}")#.format(wdata, addr, strobe))
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
