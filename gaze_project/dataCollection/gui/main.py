# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'main2.ui'
#
# Created by: PyQt5 UI code generator 5.14.1
#
# WARNING! All changes made in this file will be lost!
from operator import eq

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtGui import QDragEnterEvent, QDropEvent
from PyQt5.QtWidgets import QFrame, QLabel

import gui.icon_rc


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(389, 400)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(MainWindow.sizePolicy().hasHeightForWidth())
        MainWindow.setSizePolicy(sizePolicy)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.centralwidget.sizePolicy().hasHeightForWidth())
        self.centralwidget.setSizePolicy(sizePolicy)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayout = QtWidgets.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName("gridLayout")
        self.stack = QtWidgets.QStackedWidget(self.centralwidget)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.stack.sizePolicy().hasHeightForWidth())
        self.stack.setSizePolicy(sizePolicy)
        self.stack.setObjectName("stack")
        self.page_main = QtWidgets.QWidget()
        self.page_main.setObjectName("page_main")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.page_main)
        self.verticalLayout.setObjectName("verticalLayout")
        self.frame_bubble = QtWidgets.QFrame(self.page_main)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.frame_bubble.sizePolicy().hasHeightForWidth())
        self.frame_bubble.setSizePolicy(sizePolicy)
        self.frame_bubble.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_bubble.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_bubble.setObjectName("frame_bubble")
        self.gridLayout_7 = QtWidgets.QGridLayout(self.frame_bubble)
        self.gridLayout_7.setContentsMargins(0, 0, 0, 0)
        self.gridLayout_7.setSpacing(0)
        self.gridLayout_7.setObjectName("gridLayout_7")
        self.hLayout_bubble = QtWidgets.QHBoxLayout()
        self.hLayout_bubble.setObjectName("hLayout_bubble")
        self.label_bubble = QtWidgets.QLabel(self.frame_bubble)
        self.label_bubble.setObjectName("label_bubble")
        self.hLayout_bubble.addWidget(self.label_bubble)
        self.pushButton_bubble = QtWidgets.QPushButton(self.frame_bubble)
        self.pushButton_bubble.setObjectName("pushButton_bubble")
        self.hLayout_bubble.addWidget(self.pushButton_bubble)
        self.gridLayout_7.addLayout(self.hLayout_bubble, 0, 0, 1, 1)
        self.verticalLayout.addWidget(self.frame_bubble)
        self.box_database = QtWidgets.QGroupBox(self.page_main)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.box_database.sizePolicy().hasHeightForWidth())
        self.box_database.setSizePolicy(sizePolicy)
        self.box_database.setObjectName("box_database")
        self.gridLayout_13 = QtWidgets.QGridLayout(self.box_database)
        self.gridLayout_13.setObjectName("gridLayout_13")
        self.frame_box = QtWidgets.QFrame(self.box_database)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.frame_box.sizePolicy().hasHeightForWidth())
        self.frame_box.setSizePolicy(sizePolicy)
        self.frame_box.setMinimumSize(QtCore.QSize(0, 0))
        self.frame_box.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_box.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_box.setObjectName("frame_box")
        self.gridLayout_12 = QtWidgets.QGridLayout(self.frame_box)
        self.gridLayout_12.setContentsMargins(0, 0, 0, 0)
        self.gridLayout_12.setSpacing(0)
        self.gridLayout_12.setObjectName("gridLayout_12")
        self.hLayout_box = QtWidgets.QHBoxLayout()
        self.hLayout_box.setObjectName("hLayout_box")
        self.label_id = QtWidgets.QLabel(self.frame_box)
        self.label_id.setObjectName("label_id")
        self.hLayout_box.addWidget(self.label_id)
        self.hlayout_id = QtWidgets.QHBoxLayout()
        self.hlayout_id.setContentsMargins(10, -1, -1, -1)
        self.hlayout_id.setSpacing(20)
        self.hlayout_id.setObjectName("hlayout_id")
        self.edit_id = QtWidgets.QLineEdit(self.frame_box)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.edit_id.sizePolicy().hasHeightForWidth())
        self.edit_id.setSizePolicy(sizePolicy)
        self.edit_id.setMinimumSize(QtCore.QSize(0, 0))
        self.edit_id.setMaximumSize(QtCore.QSize(16777215, 16777215))
        self.edit_id.setObjectName("edit_id")
        self.hlayout_id.addWidget(self.edit_id)
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.hlayout_id.addItem(spacerItem)
        self.check_id = QtWidgets.QCheckBox(self.frame_box)
        self.check_id.setObjectName("check_id")
        self.hlayout_id.addWidget(self.check_id)
        self.hLayout_box.addLayout(self.hlayout_id)
        self.gridLayout_12.addLayout(self.hLayout_box, 0, 0, 1, 1)
        self.gridLayout_13.addWidget(self.frame_box, 0, 0, 1, 1)
        self.pushButton_dbsetting = QtWidgets.QPushButton(self.box_database)
        self.pushButton_dbsetting.setObjectName("pushButton_dbsetting")
        self.gridLayout_13.addWidget(self.pushButton_dbsetting, 1, 0, 1, 1)
        self.verticalLayout.addWidget(self.box_database)
        self.pushButton_start = QtWidgets.QPushButton(self.page_main)
        self.pushButton_start.setObjectName("pushButton_start")
        self.verticalLayout.addWidget(self.pushButton_start)
        self.stack.addWidget(self.page_main)
        self.page_database = QtWidgets.QWidget()
        self.page_database.setObjectName("page_database")
        self.gridLayout_2 = QtWidgets.QGridLayout(self.page_database)
        self.gridLayout_2.setObjectName("gridLayout_2")
        self.box_setting = QtWidgets.QGroupBox(self.page_database)
        self.box_setting.setObjectName("box_setting")
        self.gridLayout_6 = QtWidgets.QGridLayout(self.box_setting)
        self.gridLayout_6.setObjectName("gridLayout_6")
        self.table = QtWidgets.QTableWidget(self.box_setting)
        self.table.setFrameShadow(QtWidgets.QFrame.Sunken)
        self.table.setSizeAdjustPolicy(QtWidgets.QAbstractScrollArea.AdjustToContents)
        self.table.setShowGrid(True)
        self.table.setGridStyle(QtCore.Qt.SolidLine)
        self.table.setWordWrap(True)
        self.table.setCornerButtonEnabled(True)
        self.table.setObjectName("table")
        self.table.setColumnCount(1)
        self.table.setRowCount(6)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(0, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(1, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(2, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(3, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(4, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setVerticalHeaderItem(5, item)
        item = QtWidgets.QTableWidgetItem()
        self.table.setHorizontalHeaderItem(0, item)
        self.gridLayout_6.addWidget(self.table, 0, 0, 1, 1)
        self.hLayout_setting = QtWidgets.QHBoxLayout()
        self.hLayout_setting.setObjectName("hLayout_setting")
        self.pushButton_cancel = QtWidgets.QPushButton(self.box_setting)
        self.pushButton_cancel.setObjectName("pushButton_cancel")
        self.hLayout_setting.addWidget(self.pushButton_cancel)
        self.pushButton_apply = QtWidgets.QPushButton(self.box_setting)
        self.pushButton_apply.setObjectName("pushButton_apply")
        self.hLayout_setting.addWidget(self.pushButton_apply)
        self.gridLayout_6.addLayout(self.hLayout_setting, 1, 0, 1, 1)
        spacerItem4 = QtWidgets.QSpacerItem(20, 40, QtWidgets.QSizePolicy.Minimum, QtWidgets.QSizePolicy.Expanding)
        self.gridLayout_6.addItem(spacerItem4, 2, 0, 1, 1)
        self.gridLayout_2.addWidget(self.box_setting, 0, 0, 1, 1)
        self.stack.addWidget(self.page_database)
        self.gridLayout.addWidget(self.stack, 0, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        self.stack.setCurrentIndex(2)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.label_bubble.setText(_translate("MainWindow", "Gaze Visalizaition"))
        self.pushButton_bubble.setText(_translate("MainWindow", "on"))
        self.box_database.setTitle(_translate("MainWindow", "Database"))
        self.label_id.setText(_translate("MainWindow", "ID:"))
        self.check_id.setText(_translate("MainWindow", "Apply"))
        self.pushButton_dbsetting.setText(_translate("MainWindow", "Database Setting"))
        self.pushButton_start.setText(_translate("MainWindow", "Start"))
        self.box_setting.setTitle(_translate("MainWindow", "Database Setting"))
        self.table.setSortingEnabled(False)
        item = self.table.verticalHeaderItem(0)
        item.setText(_translate("MainWindow", "Host"))
        item = self.table.verticalHeaderItem(1)
        item.setText(_translate("MainWindow", "USER"))
        item = self.table.verticalHeaderItem(2)
        item.setText(_translate("MainWindow", "PASSWORD"))
        item = self.table.verticalHeaderItem(3)
        item.setText(_translate("MainWindow", "DB_NAME"))
        item = self.table.verticalHeaderItem(4)
        item.setText(_translate("MainWindow", "CHARSET"))
        item = self.table.verticalHeaderItem(5)
        item.setText(_translate("MainWindow", "TABLE"))
        item = self.table.horizontalHeaderItem(0)
        item.setText(_translate("MainWindow", "Setting"))
        self.pushButton_cancel.setText(_translate("MainWindow", "CANCEL"))
        self.pushButton_apply.setText(_translate("MainWindow", "APPLY"))

    def toggleName(self, object):
        if eq(object.text(), "on"):
            object.setText("off")
        else:
            object.setText("on")

class Board(QLabel):
    def __init__(self, parent):
        super().__init__(parent=parent)
        self.setAcceptDrops(True)
    def dragEnterEvent(self, e: QDragEnterEvent):
        if e.mimeData().hasUrls():
            e.accept()
        else:
            e.ignore()
    def dropEvent(self, e: QDropEvent):
        if e.mimeData().hasUrls():
            e.accept()
        else:
            e.ignore()

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
