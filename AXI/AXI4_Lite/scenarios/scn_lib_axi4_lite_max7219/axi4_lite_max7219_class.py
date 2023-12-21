class axi4_lite_max7219_class:

    def __init__(self, scn):
        self.ctrl_reg_addr   = 0x00
        self.cmd_reg_addr    = 0x04
        self.status_reg_addr = 0x08

        self.G_NB_MATRIX = 4
        self.scn = scn # SCN class
        self.FIFO_mem_path = "/tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/mem"

    def write_commands(self, cmd, data, matrix_idx):

        self.scn.print_comment("Write commands : %s - 0x%X - matrix : %d" %(cmd, data, matrix_idx))
        data_to_write = 0
        if(cmd == "NOOP"):
            data_to_write = 1 << 0
        elif(cmd == "DIGIT0"):
            data_to_write = 1 << 1
        elif(cmd == "DIGIT1"):
            data_to_write = 1 << 2
        elif(cmd == "DIGIT2"):
            data_to_write = 1 << 3
        elif(cmd == "DIGIT3"):
            data_to_write = 1 << 4
        elif(cmd == "DIGIT4"):
            data_to_write = 1 << 5
        elif(cmd == "DIGIT5"):
            data_to_write = 1 << 6
        elif(cmd == "DIGIT6"):
            data_to_write = 1 << 7
        elif(cmd == "DIGIT7"):
            data_to_write = 1 << 8
        elif(cmd == "DECODE_MODE"):
            data_to_write = 1 << 9
        elif(cmd == "INTENSITY"):
            data_to_write = 1 << 10
        elif(cmd == "SCAN_LIMIT"):
            data_to_write = 1 << 11
        elif(cmd == "SHUTDOWN"):
            data_to_write = 1 << 12
        elif(cmd == "DISPLAY_TEST"):
            data_to_write = 1 << 13

        # Add Matrix index and data
        data_to_write = (data_to_write + (data << 16) + (matrix_idx << 24)) & 0xFFFFFFFF
            
        # Reconstruct Command Data
        self.scn.MASTER_AXI4LITE_WRITE("MASTER_AXI4LITE_0", self.cmd_reg_addr, data_to_write, 0x0, 0x0)
        
