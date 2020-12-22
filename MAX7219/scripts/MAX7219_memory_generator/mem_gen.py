#
# Description : Memory  Generator for MAX7219 RAM decoder 
#
# Author : J.P
# Date   : 21/12/2020
# Version : 1.0

import sys
from PySide2 import QtCore, QtGui, QtWidgets
import numpy as np


class window(QtWidgets.QDialog):
    def __init__(self, parent=None):

        QtWidgets.QDialog.__init__(self,parent)

        self.matrix_line_nb = 8
        self.matrix_nb = int(sys.argv[1])
        
        self.grid = np.zeros([self.matrix_line_nb,8*self.matrix_nb], dtype=bool)
        self.x_pos, self.y_pos = 0, 0
        self.grid_layout = QtWidgets.QGridLayout()
        self.setLayout(self.grid_layout)
        
        for j in range (0, self.matrix_line_nb):
            for i in range (0, 8*self.matrix_nb):
                check_btn = QtWidgets.QCheckBox()
                self.grid_layout.addWidget(check_btn,j,i)
                #check_btn.stateChanged.connect(self.click)

        self.__boutonGenerer = QtWidgets.QPushButton("Generer")
        self.grid_layout.addWidget(self.__boutonGenerer, 8, 8*self.matrix_nb)

        self.__boutonGenerer.clicked.connect(self.generer_mem)


        print(dir(QtCore))
        
    def click(self, state):
        if state == QtCore.Qt.Checked :
            for j in range(self.matrix_line_nb):
                for i in range(8*self.matrix_nb):
                    item = self.grid_layout.itemAtPosition(j,i)
                    widget = item.widget()
                    self.grid[j][i] = widget.isChecked()
                    print(self.grid[j][i])
        else :
            pass

    def generer_mem(self):
        print("Generer Mem fctn")
        for j in range(self.matrix_line_nb):
            for i in range(8*self.matrix_nb):
                item = self.grid_layout.itemAtPosition(j,i)
                widget = item.widget()
                self.grid[j][i] = widget.isChecked()
                print(self.grid[j][i])



app = QtWidgets.QApplication(sys.argv)
dialog = window()
dialog.exec_()
