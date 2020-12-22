#
# Description : Memory  Generator for MAX7219 RAM decoder 
#
# Author : J.P
# Date   : 21/12/2020
# Version : 1.0
#
#
#
#
#

import sys
from PySide2 import QtCore, QtGui, QtWidgets
import numpy as np


class window(QtWidgets.QDialog):
    def __init__(self, parent=None):

        QtWidgets.QDialog.__init__(self,parent)

        # == Window Config. ==
        self.matrix_line_nb = 8
        self.matrix_nb = int(sys.argv[1])
        self.grid = np.zeros([self.matrix_line_nb,8*self.matrix_nb], dtype=bool)
        self.grid_layout = QtWidgets.QGridLayout()
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

        # == Set bouton generer ==
        self.__boutonGenerer = QtWidgets.QPushButton("Generer")
        self.grid_layout.addWidget(self.__boutonGenerer, 17, 8*self.matrix_nb)
        self.__boutonGenerer.clicked.connect(self.generer_mem)
        # ========================

        # == DEBUG ==
        #print(dir(self.field_display_test))
        # ===========

        self.setWindowTitle("Memory Generator")

    def generer_mem(self):
        #print("Generer Mem fctn")
        for j in range(self.matrix_line_nb):
            for i in range(8*self.matrix_nb):
                item = self.grid_layout.itemAtPosition(j,i)
                widget = item.widget()
                self.grid[j][i] = widget.isChecked()
                #print(self.grid[j][i])

        #print(self.field_decod_mode.text())
        self.write_file()


    def write_file(self):

        # == Data to Writes in Memory ==
        wdata = []

        # Init WDATA list
        for i in range(0, int(self.field_memory_size.text())):
            wdata.append("0000")

        for i in range (0, 5*self.matrix_nb):
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
        # =============================
        
                    

        f = open(self.field_file_name.text(), "w")
        f.writelines("// memory data file (do not edit the following line - required for mem load use)\n")
        f.writelines("// instance=" + self.field_instance_path.text() + "\n")
        f.writelines("// format=mti addressradix=d dataradix=h version=1.0 wordsperline=1\n")
        for i in range(0, int(self.field_memory_size.text())):
            if len(str(i)) == 1 :
                f.writelines("  " + str(i) + ": " + wdata[i] + "\n")
            elif len(str(i)) == 2 :
                f.writelines(" " + str(i) + ": " + wdata[i] + "\n")
            else :
                f.writelines(str(i) + ": " + wdata[i] + "\n")
    
            
        f.close()



app = QtWidgets.QApplication(sys.argv)
dialog = window()
dialog.exec_()
