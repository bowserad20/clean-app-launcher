import sys
import os
from PySide6.QtGui import QGuiApplication, QFont
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot
from models import *
from configLoader import appsConfig

def getTestCells(count):
    cells = []
    curCell = None
    for i in range(count):
        curCell = CellModel()
        curCell.cellName = 'test' + str(i)
        cells.append(curCell)
    return cells

@Slot(str)
def handleError(url):
    print('resource failed to load',url)
    exit(1)

@QmlElement
class ConfigLoader(QObject):

    @Slot()
    def save(self):
        apps.save()


if __name__ == "__main__":
    # setup
    app = QGuiApplication(sys.argv)
    font = QFont("Arial",12)
    app.setFont(font)

    engine = QQmlApplicationEngine()
    engine.objectCreationFailed.connect(handleError)
    engine.addImportPath("./qml")

    apps = appsConfig('./data/apps.yaml')
    engine.setInitialProperties({"gridSections": apps.sections})

    # run
    engine.load("./qml/main.qml")
    res = app.exec()