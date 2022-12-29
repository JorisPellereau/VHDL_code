import sys
import os


# Class for TB UNIT LCD CFAH TOP
class macros_tb_unit_lcd_cfah_top:

    
        def __init__(self, scn):
                self.scn = scn


        # Load data to line buffer
        def lcd_load_lines_buffer(self, lines_data_list = [[None for i in range(16)] for j in range(2)]):

                self.scn.print_comment(" == MACRO lcd_load_lines_buffer ==")
                # Loop on each lines
                for i in range(0, len(lines_data_list)):
                        for j in range(0, len(lines_data_list[i])):
                                if(lines_data_list[i][j] != None):                        
                                        self.scn.WTFS("CLK")
                                        self.scn.SET("I_CHAR_WDATA",     lines_data_list[i][j])
                                        self.scn.SET("I_CHAR_POSITION",  j)
                                        self.scn.SET("I_LINE_SEL",       i)
                                        self.scn.SET("I_CHAR_WDATA_VAL", 1)
                                        self.scn.WTFS("CLK")
                                        self.scn.SET("I_CHAR_WDATA",     0)
                                        self.scn.SET("I_CHAR_POSITION",  0)
                                        self.scn.SET("I_LINE_SEL",       0)
                                        self.scn.SET("I_CHAR_WDATA_VAL", 0)
                self.scn.print_comment(" =================================")

        # Load Data to CGRAM buffer
        def lcd_load_cgram_buffer(self, cgram_data_list):
                self.scn.print_comment(" == MACRO lcd_load_cgram_buffer ==")


                
                self.scn.print_comment(" =================================")


        # Run an LCD command
        def lcd_start_cmd(self, lcd_on = 0, clear_display_cmd = 0, display_ctrl_cmd = 0, dcb = 0,
                          update_lcd = 0, lcd_all_char = 0, lcd_line_sel = 0, lcd_char_position = 0, lcd_init = 0):
                
                self.scn.print_comment(" == MACRO lcd_start_cmd ==")

                if(lcd_on == 1):
                        str_input = "I_LCD_ON"
                elif(clear_display_cmd == 1):
                        str_input = "I_CLEAR_DISPLAY"
                elif(display_ctrl_cmd == 1):
                        str_input = "I_DISPLAY_CTRL_CMD"                        
                elif(update_lcd == 1):
                        str_input = "I_UPDATE_LCD"
                elif(lcd_init == 1):
                        str_input = "I_START_INIT"
                        
                self.scn.WTFS("CLK")
                self.scn.SET(str_input, 1)
                self.scn.SET("I_DCB",               dcb)          if (display_ctrl_cmd == 1 or lcd_init == 1) else None
                self.scn.SET("I_LCD_ALL_CHAR",      lcd_all_char) if update_lcd == 1 else None
                self.scn.SET("I_LCD_LINE_SEL",      lcd_line_sel) if update_lcd == 1 else None
                self.scn.SET("I_LCD_CHAR_POSITION", lcd_char_position) if update_lcd == 1 else None
                self.scn.WTFS("CLK")
                self.scn.SET(str_input, 0)
                self.scn.SET("I_DCB",               0) if (display_ctrl_cmd == 1 or lcd_init == 1) else None
                self.scn.SET("I_LCD_ALL_CHAR",      0) if update_lcd == 1 else None
                self.scn.SET("I_LCD_LINE_SEL",      0) if update_lcd == 1 else None
                self.scn.SET("I_LCD_CHAR_POSITION", 0) if update_lcd == 1 else None
                
                self.scn.print_comment(" =================================")


        # Set Static config of LCD
        def lcd_set_static_config(self, dl_n_f):

                self.scn.print_comment(" == MACRO lcd_set_static_config  ==")
                self.scn.SET("I_DL_N_F", dl_n_f)
                self.scn.print_comment(" =================================")
