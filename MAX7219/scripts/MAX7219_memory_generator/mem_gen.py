#
# Description : Memory  Generator for MAX7219 RAM decoder 
#
# Author : J.P
# Date   : 21/12/2020
# Version : 1.0
#
#
# Example 1 : python mem_gen.py 1
#            - Display a window for 1 Matrix configuration via Checkboxes
#
# Example 2 : python mem_gen.py 8
#            - Display a window for 8 Matrix configuration via Checkboxes#
#

import sys
from PySide2 import QtCore, QtGui, QtWidgets
import numpy as np


class window(QtWidgets.QDialog):
    def __init__(self, parent=None):

        QtWidgets.QDialog.__init__(self,parent)

        # == Window Config. ==
        self.matrix_line_nb = 8
        if int(sys.argv[1]) < 1 or int(sys.argv[1]) > 8 :
            sys.exit("ARGV ERROR - argv[1] must be between [1:8]")
        else:
            self.matrix_nb      = int(sys.argv[1])
        self.grid           = np.zeros([self.matrix_line_nb,8*self.matrix_nb], dtype=bool)
        self.grid_layout    = QtWidgets.QGridLayout()
        self.setLayout(self.grid_layout)
        # ====================

        # == Set Checkboxes ==
        for j in range (0, self.matrix_line_nb):
            for i in range (0, 8*self.matrix_nb):
                check_btn = QtWidgets.QCheckBox()
                self.grid_layout.addWidget(check_btn,j,i)
        # ===================

        # == Set Fields Registers Configuration ==
        self.field_decod_mode   = QtWidgets.QLineEdit("")
        self.text_decod_mode    = QtWidgets.QLabel("Decode Mode : ")
        
        self.field_intensity    = QtWidgets.QLineEdit("")
        self.text_intensity     = QtWidgets.QLabel("Intensity : ")
        
        self.field_scan_limit   = QtWidgets.QLineEdit("")
        self.text_scan_limit    = QtWidgets.QLabel("Scan Limit : ")
        
        self.field_shutdown     = QtWidgets.QLineEdit("")
        self.text_shutdown      = QtWidgets.QLabel("Shutdown : ")
        
        self.field_display_test = QtWidgets.QLineEdit("")
        self.text_display_test  = QtWidgets.QLabel("Display Test : ")
        
        self.grid_layout.addWidget(self.field_decod_mode,   8, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_decod_mode,    8, 8*self.matrix_nb)

        self.grid_layout.addWidget(self.field_intensity,    9, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_intensity,     9, 8*self.matrix_nb)

        self.grid_layout.addWidget(self.field_scan_limit,   10, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_scan_limit,    10, 8*self.matrix_nb)
        
        self.grid_layout.addWidget(self.field_shutdown,     11, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_shutdown,      11, 8*self.matrix_nb)
        
        self.grid_layout.addWidget(self.field_display_test, 12, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_display_test,  12, 8*self.matrix_nb)

        self.field_decod_mode.setText("00")
        self.field_intensity.setText("00")
        self.field_scan_limit.setText("00")
        self.field_shutdown.setText("00")
        self.field_display_test.setText("00")
        
        # =======================================

        # == Set Fields Memory File Configuration ==
        self.field_instance_path   = QtWidgets.QLineEdit("")
        self.text_instance_path    = QtWidgets.QLabel("Instance : ")
        self.grid_layout.addWidget(self.field_instance_path,    13, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_instance_path,     13, 8*self.matrix_nb)
        self.field_instance_path.setText("/tb_top/i_dut/tdpram_inst_0/v_ram")

        self.field_memory_size     = QtWidgets.QLineEdit("")
        self.text_memory_size      = QtWidgets.QLabel("Memory Size : ")
        self.grid_layout.addWidget(self.field_memory_size,      14, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_memory_size,       14, 8*self.matrix_nb)
        self.field_memory_size.setText("256")

        self.field_data_size     = QtWidgets.QLineEdit("")
        self.text_data_size      = QtWidgets.QLabel("Memory Size (in bits) : ")
        self.grid_layout.addWidget(self.field_data_size,      15, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_data_size,       15, 8*self.matrix_nb)
        self.field_data_size.setText("16")

        self.field_file_name     = QtWidgets.QLineEdit("")
        self.text_file_name      = QtWidgets.QLabel("File Name : ")
        self.grid_layout.addWidget(self.field_file_name,      16, 8*self.matrix_nb + 1)
        self.grid_layout.addWidget(self.text_file_name,       16, 8*self.matrix_nb)
        self.field_file_name.setText("max7219_ram.mem")
        
        # ==========================================

        # == Bouton Inversion CheckBoxes Matrix ==
        self.__boutonInvCheckbox = QtWidgets.QPushButton("Inverser CheckBox")
        self.grid_layout.addWidget(self.__boutonInvCheckbox, 17, 8*self.matrix_nb)
        self.__boutonInvCheckbox.clicked.connect(self.inv_checkbox)
        # =============================

        # == Set boutons generer ==
        self.__boutonGenerer = QtWidgets.QPushButton("Generer")
        self.grid_layout.addWidget(self.__boutonGenerer, 18, 8*self.matrix_nb)
        self.__boutonGenerer.clicked.connect(self.generer_mem)

        self.boutonGenCst = QtWidgets.QPushButton("Generer Constant")
        self.grid_layout.addWidget(self.boutonGenCst, 18, 8*self.matrix_nb + 1)
        self.boutonGenCst.clicked.connect(self.generer_cst)
        # ========================

        # == DEBUG ==
        #print(dir(self.field_display_test))
        # ===========

        self.setWindowTitle("Memory Generator")


    # Function : GetCheckboxes states
    def get_checkbox_states(self):
        for j in range(self.matrix_line_nb):
            for i in range(8*self.matrix_nb):
                item = self.grid_layout.itemAtPosition(j,i)
                self.widget = item.widget()
                self.grid[j][i] = self.widget.isChecked()

                
    # Function : Inversion de l'etat des checkboxes
    def inv_checkbox(self):
        for j in range(self.matrix_line_nb):
            for i in range(8*self.matrix_nb):
                item = self.grid_layout.itemAtPosition(j,i)
                widget = item.widget()
                self.grid[j][i] = widget.isChecked()

                if self.grid[j][i] == True :
                    widget.setChecked(False)
                else:
                    widget.setChecked(True)


        
    # Generation of Memory file Function
    def generer_mem(self):
        #print("Generer Mem fctn")

        self.digit_7_matrix_n = []
        self.digit_6_matrix_n = []
        self.digit_5_matrix_n = []
        self.digit_4_matrix_n = []
        self.digit_3_matrix_n = []
        self.digit_2_matrix_n = []
        self.digit_1_matrix_n = []
        self.digit_0_matrix_n = []
        
        # Creates Array
        for i in range (0, self.matrix_nb):
             self.digit_7_matrix_n.append("")
             self.digit_6_matrix_n.append("")
             self.digit_5_matrix_n.append("")
             self.digit_4_matrix_n.append("")
             self.digit_3_matrix_n.append("")
             self.digit_2_matrix_n.append("")
             self.digit_1_matrix_n.append("")
             self.digit_0_matrix_n.append("")
        
        # == Save in self.grid the state of checkboxes
        self.get_checkbox_states()
                     
        # == Fill Matrix af DIGITn Registers
        for j in range (0, self.matrix_line_nb):
            for i in range(0, self.matrix_nb):
                self.digit_7_matrix_n[i] = self.digit_7_matrix_n[i] + ("1" if self.grid[j][i*8] else "0")
                self.digit_6_matrix_n[i] = self.digit_6_matrix_n[i] + ("1" if self.grid[j][i*8 + 1] else "0")
                self.digit_5_matrix_n[i] = self.digit_5_matrix_n[i] + ("1" if self.grid[j][i*8 + 2] else "0")
                self.digit_4_matrix_n[i] = self.digit_4_matrix_n[i] + ("1" if self.grid[j][i*8 + 3] else "0")
                self.digit_3_matrix_n[i] = self.digit_3_matrix_n[i] + ("1" if self.grid[j][i*8 + 4] else "0")
                self.digit_2_matrix_n[i] = self.digit_2_matrix_n[i] + ("1" if self.grid[j][i*8 + 5] else "0")
                self.digit_1_matrix_n[i] = self.digit_1_matrix_n[i] + ("1" if self.grid[j][i*8 + 6] else "0")
                self.digit_0_matrix_n[i] = self.digit_0_matrix_n[i] + ("1" if self.grid[j][i*8 + 7] else "0")
                

        for i in range (0, self.matrix_nb):
            print(self.digit_7_matrix_n[i])
            print(self.digit_6_matrix_n[i])
            print(self.digit_5_matrix_n[i])
            print(self.digit_4_matrix_n[i])
            print(self.digit_3_matrix_n[i])
            print(self.digit_2_matrix_n[i])
            print(self.digit_1_matrix_n[i])
            print(self.digit_0_matrix_n[i])
            
        self.write_file()


    def write_file(self):

        # == Data to Writes in Memory ==
        wdata = []

        # Init WDATA list
        for i in range(0, int(self.field_memory_size.text())):
            wdata.append("0000")

        for i in range (0, int(self.field_memory_size.text())): #5*self.matrix_nb):

            # == Gestion Configuration Registres ==
            if i < 1*self.matrix_nb :
                if i == 1*self.matrix_nb - 1 :
                    wdata[i] = "19" + self.field_decod_mode.text()
                else :
                    wdata[i] = "09" + self.field_decod_mode.text()
                    
            elif i >= 1*self.matrix_nb and i < 2*self.matrix_nb :
                if i == 2*self.matrix_nb - 1 :
                    wdata[i] = "1A" + self.field_intensity.text()
                else:
                    wdata[i] = "0A" + self.field_intensity.text()
                    
            elif i >= 2*self.matrix_nb and i < 3*self.matrix_nb :
                if i == 3*self.matrix_nb - 1 :
                    wdata[i] = "1B" + self.field_scan_limit.text()
                else:
                    wdata[i] = "0B" + self.field_scan_limit.text()
            
            elif i >= 3*self.matrix_nb and i < 4*self.matrix_nb :
                if i == 4*self.matrix_nb - 1 : 
                    wdata[i] = "1C" + self.field_shutdown.text()
                else:
                    wdata[i] = "0C" + self.field_shutdown.text()
                    
            elif i >= 4*self.matrix_nb and i < 5*self.matrix_nb :
                if i == 5*self.matrix_nb - 1 :
                    wdata[i] = "1F" + self.field_display_test.text()
                else:
                    wdata[i] = "0F" + self.field_display_test.text()
            # ====================================

            # == Gestion DIGIT pour affichage Matrix ==

            # Write Digit 0
            elif i >= 5*self.matrix_nb and i < 6*self.matrix_nb :
                if i == 6*self.matrix_nb - 1 :
                    wdata[i] = "11" + format(int( (self.digit_0_matrix_n[self.matrix_nb - 1 - (i - 5*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "01" + format(int( (self.digit_0_matrix_n[self.matrix_nb - 1 - (i - 5*self.matrix_nb)]), 2), '02x')

            # Write Digit 1
            elif i >= 6*self.matrix_nb and i < 7*self.matrix_nb :
                if i == 7*self.matrix_nb - 1 :
                    wdata[i] = "12" + format(int( (self.digit_1_matrix_n[self.matrix_nb - 1 - (i - 6*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "02" + format(int( (self.digit_1_matrix_n[self.matrix_nb - 1 - (i - 6*self.matrix_nb)]), 2), '02x')

            # Write Digit 2
            elif i >= 7*self.matrix_nb and i < 8*self.matrix_nb :
                if i == 8*self.matrix_nb - 1 :
                    wdata[i] = "13" + format(int( (self.digit_2_matrix_n[self.matrix_nb - 1 - (i - 7*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "03" + format(int( (self.digit_2_matrix_n[self.matrix_nb - 1 - (i - 7*self.matrix_nb)]), 2), '02x')

            # Write Digit 3
            elif i >= 8*self.matrix_nb and i < 9*self.matrix_nb :
                if i == 9*self.matrix_nb - 1 :
                    wdata[i] = "14" + format(int( (self.digit_3_matrix_n[self.matrix_nb - 1 - (i - 8*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "04" + format(int( (self.digit_3_matrix_n[self.matrix_nb - 1 - (i - 8*self.matrix_nb)]), 2), '02x')

            # Write Digit 4
            elif i >= 9*self.matrix_nb and i < 10*self.matrix_nb :
                if i == 10*self.matrix_nb - 1 :
                    wdata[i] = "15" + format(int( (self.digit_4_matrix_n[self.matrix_nb - 1 - (i - 9*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "05" + format(int( (self.digit_4_matrix_n[self.matrix_nb - 1 - (i - 9*self.matrix_nb)]), 2), '02x')

            # Write Digit 5
            elif i >= 10*self.matrix_nb and i < 11*self.matrix_nb :
                if i == 11*self.matrix_nb - 1 :
                    wdata[i] = "16" + format(int( (self.digit_5_matrix_n[self.matrix_nb - 1 - (i - 10*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "06" + format(int( (self.digit_5_matrix_n[self.matrix_nb - 1 - (i - 10*self.matrix_nb)]), 2), '02x')

            # Write Digit 6
            elif i >= 11*self.matrix_nb and i < 12*self.matrix_nb :
                if i == 12*self.matrix_nb - 1 :
                    wdata[i] = "17" + format(int( (self.digit_6_matrix_n[self.matrix_nb - 1 - (i - 11*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "07" + format(int( (self.digit_6_matrix_n[self.matrix_nb - 1 - (i - 11*self.matrix_nb)]), 2), '02x')

            # Write Digit 7
            elif i >= 12*self.matrix_nb and i < 13*self.matrix_nb :
                if i == 13*self.matrix_nb - 1 :
                    wdata[i] = "18" + format(int( (self.digit_7_matrix_n[self.matrix_nb - 1 - (i - 12*self.matrix_nb)]), 2), '02x')
                else:
                    wdata[i] = "08" + format(int( (self.digit_7_matrix_n[self.matrix_nb - 1 - (i - 12*self.matrix_nb)]), 2), '02x')
                    
            
            # =========================================
        # =============================
        
                    

        f = open(self.field_file_name.text(), "w")
        f.writelines("// memory data file (do not edit the following line - required for mem load use)\n")
        f.writelines("// instance=" + self.field_instance_path.text() + "\n")
        f.writelines("// format=mti addressradix=d dataradix=h version=1.0 wordsperline=1\n")
        for i in range(0, int(self.field_memory_size.text())):
            # /!\ : Ajout des espaces pas bien gere
            if len(str(i)) == 1 :
                f.writelines("  " + str(i) + ": " + wdata[i] + "\n")
            elif len(str(i)) == 2 :
                f.writelines(" " + str(i) + ": " + wdata[i] + "\n")
            else :
                f.writelines(str(i) + ": " + wdata[i] + "\n")
    
            
        f.close()

    # Generation of a VHD file with a Constant wich contain the pattern of the Matrix
    def generer_cst(self):
        print("Generer Constant Def")
        data_array = []
        data_array_int = []
        tmp = 0
        self.get_checkbox_states()
        for i in range(8*self.matrix_nb):
            data_array.append("")
            data_array_int.append("")
            data_array[i] = str(int(self.grid[0][i])) + str(int(self.grid[1][i])) + str(int(self.grid[2][i])) + str(int(self.grid[3][i]))            
            data_array[i] = data_array[i] + str(int(self.grid[4][i])) + str(int(self.grid[5][i])) + str(int(self.grid[6][i])) + str(int(self.grid[7][i]))

            
            tmp = (int(self.grid[0][i]) << 7) | (int(self.grid[1][i]) << 6) | (int(self.grid[2][i]) << 5) | (int(self.grid[3][i]) << 4) 
            data_array_int[i] = hex(tmp | (int(self.grid[4][i]) << 3) | (int(self.grid[5][i]) << 2) | (int(self.grid[6][i]) << 1 ) | (int(self.grid[7][i])))
            
            #data_array_int[i] = data_array[i]
            #int(data_array_int[i])

        print("data array int : %s \n" % (data_array_int) )
        print(type(data_array_int[0]))
        
        f = open("constant_gen.vhd", "w")
        f.writelines("type t_cst_array is array (0 to %d) of std_logic_vector(7 downto 0);\n" %(self.matrix_nb * 8 - 1))
        f.writelines("constant C_CST_0 : t_cst_array := (\n")
        for i in range(0, self.matrix_nb * 8):
            if (i < self.matrix_nb * 8 - 1):
                f.writelines("  %s => x\"%s\",\n" %(i , format(int(data_array[i], 2), '02x') )  )
            else:
                f.writelines("  %s => x\"%s\"\n" %(i , format(int(data_array[i], 2), '02x') )  )
        f.writelines(");") 
        f.close()

    # Save the status of checkboxes in order to load a specific pattern
    def save_state_checkboxes(self):
        print("Save States checkboxes")



app = QtWidgets.QApplication(sys.argv)
dialog = window()
dialog.exec_()
