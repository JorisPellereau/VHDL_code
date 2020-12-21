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

        # Case a cocher
        self.__caseM0_D7_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_7 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_7 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_6 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_6 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_5 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_5 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_4 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_4 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_3 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_3 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_2 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_2 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_1 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_1 = QtWidgets.QCheckBox("")

        self.__caseM0_D7_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D6_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D5_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D4_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D3_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D2_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D1_0 = QtWidgets.QCheckBox("")
        self.__caseM0_D0_0 = QtWidgets.QCheckBox("")

        self.__boutonGenerer = QtWidgets.QPushButton("Generer")

        layout = QtWidgets.QGridLayout()
        # Definition de la position de ma matrix
        layout.addWidget(self.__caseM0_D7_7, 0, 0)
        layout.addWidget(self.__caseM0_D6_7, 0, 1)
        layout.addWidget(self.__caseM0_D5_7, 0, 2)
        layout.addWidget(self.__caseM0_D4_7, 0, 3)
        layout.addWidget(self.__caseM0_D3_7, 0, 4)
        layout.addWidget(self.__caseM0_D2_7, 0, 5)
        layout.addWidget(self.__caseM0_D1_7, 0, 6)
        layout.addWidget(self.__caseM0_D0_7, 0, 7)

        layout.addWidget(self.__caseM0_D7_6, 1, 0)
        layout.addWidget(self.__caseM0_D6_6, 1, 1)
        layout.addWidget(self.__caseM0_D5_6, 1, 2)
        layout.addWidget(self.__caseM0_D4_6, 1, 3)
        layout.addWidget(self.__caseM0_D3_6, 1, 4)
        layout.addWidget(self.__caseM0_D2_6, 1, 5)
        layout.addWidget(self.__caseM0_D1_6, 1, 6)
        layout.addWidget(self.__caseM0_D0_6, 1, 7)

        layout.addWidget(self.__caseM0_D7_5, 2, 0)
        layout.addWidget(self.__caseM0_D6_5, 2, 1)
        layout.addWidget(self.__caseM0_D5_5, 2, 2)
        layout.addWidget(self.__caseM0_D4_5, 2, 3)
        layout.addWidget(self.__caseM0_D3_5, 2, 4)
        layout.addWidget(self.__caseM0_D2_5, 2, 5)
        layout.addWidget(self.__caseM0_D1_5, 2, 6)
        layout.addWidget(self.__caseM0_D0_5, 2, 7)

        layout.addWidget(self.__caseM0_D7_4, 3, 0)
        layout.addWidget(self.__caseM0_D6_4, 3, 1)
        layout.addWidget(self.__caseM0_D5_4, 3, 2)
        layout.addWidget(self.__caseM0_D4_4, 3, 3)
        layout.addWidget(self.__caseM0_D3_4, 3, 4)
        layout.addWidget(self.__caseM0_D2_4, 3, 5)
        layout.addWidget(self.__caseM0_D1_4, 3, 6)
        layout.addWidget(self.__caseM0_D0_4, 3, 7)
        
        layout.addWidget(self.__caseM0_D7_3, 4, 0)
        layout.addWidget(self.__caseM0_D6_3, 4, 1)
        layout.addWidget(self.__caseM0_D5_3, 4, 2)
        layout.addWidget(self.__caseM0_D4_3, 4, 3)
        layout.addWidget(self.__caseM0_D3_3, 4, 4)
        layout.addWidget(self.__caseM0_D2_3, 4, 5)
        layout.addWidget(self.__caseM0_D1_3, 4, 6)
        layout.addWidget(self.__caseM0_D0_3, 4, 7)

        layout.addWidget(self.__caseM0_D7_2, 5, 0)
        layout.addWidget(self.__caseM0_D6_2, 5, 1)
        layout.addWidget(self.__caseM0_D5_2, 5, 2)
        layout.addWidget(self.__caseM0_D4_2, 5, 3)
        layout.addWidget(self.__caseM0_D3_2, 5, 4)
        layout.addWidget(self.__caseM0_D2_2, 5, 5)
        layout.addWidget(self.__caseM0_D1_2, 5, 6)
        layout.addWidget(self.__caseM0_D0_2, 5, 7)

        layout.addWidget(self.__caseM0_D7_1, 6, 0)
        layout.addWidget(self.__caseM0_D6_1, 6, 1)
        layout.addWidget(self.__caseM0_D5_1, 6, 2)
        layout.addWidget(self.__caseM0_D4_1, 6, 3)
        layout.addWidget(self.__caseM0_D3_1, 6, 4)
        layout.addWidget(self.__caseM0_D2_1, 6, 5)
        layout.addWidget(self.__caseM0_D1_1, 6, 6)
        layout.addWidget(self.__caseM0_D0_1, 6, 7)

        layout.addWidget(self.__caseM0_D7_0, 7, 0)
        layout.addWidget(self.__caseM0_D6_0, 7, 1)
        layout.addWidget(self.__caseM0_D5_0, 7, 2)
        layout.addWidget(self.__caseM0_D4_0, 7, 3)
        layout.addWidget(self.__caseM0_D3_0, 7, 4)
        layout.addWidget(self.__caseM0_D2_0, 7, 5)
        layout.addWidget(self.__caseM0_D1_0, 7, 6)
        layout.addWidget(self.__caseM0_D0_0, 7, 7)

        layout.addWidget(self.__boutonGenerer, 8, 8)
     
        self.setLayout(layout)
        self.setWindowTitle("Memory Generator")
        self.__boutonGenerer.clicked.connect(self.generer_mem)
        
    def generer_mem(self):
        Data_M0_D7_7 = self.__caseM0_D7_7.isChecked()
        print(Data_M0_D7_7)

app = QtWidgets.QApplication(sys.argv)
dialog = window()
dialog.exec_()
        
