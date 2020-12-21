#
# Description : Memory  Generator for MAX7219 RAM decoder 
#
# Author : J.P
# Date   : 21/12/2020
# Version : 1.0

import sys
from PySide2 import QtCore, QtGui, QtWidgets

class window(QtWidgets.QDialog):
    def __init__(self, parent=None):
        
        QtWidgets.QDialog.__init__(self,parent)
        self.layout = QtWidgets.QGridLayout()
        self.checkbox_name = []

        matrix_nb = 1
        for j in range (0, 8):
            for i in range (0, 8*matrix_nb):
                self.checkbox = QtWidgets.QCheckBox("M_" + str(j) + "_" + str(i))
                #self.checkbox_name.append(self.checkbox)
                self.layout.addWidget(self.checkbox, j, i)

        self.__boutonGenerer = QtWidgets.QPushButton("Generer")
        self.layout.addWidget(self.__boutonGenerer, 8, 8*matrix_nb)

        #print(self.checkbox.M_0_0.isChecked())
        #print(dir(self))
        #print(dir(layout))
        #print(layout.columnCount())
        self.setLayout(self.layout)
        self.setWindowTitle("Memory Generator")
        self.__boutonGenerer.clicked.connect(self.generer_mem)
        #print(self.checkbox_name)
        
    def generer_mem(self):
        #print(dir(QtWidgets.QGridLayout()))
        print(dir(self.layout))
        print(self.layout.columnCount())
        print(dir(self.checkbox))
        print(self.checkbox.isChecked())
        self.checkbox.hide() 
        #self.layout.rowCount()
        #print(self.checkbox.columnCount())
        #Data_M0_D7_7 = self.__caseM0_D7_7.isChecked()
        #print(Data_M0_D7_7)


app = QtWidgets.QApplication(sys.argv)
dialog = window()
dialog.exec_()
        
