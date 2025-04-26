from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot, Property
import subprocess

QML_IMPORT_NAME = "InstrumentLib"
QML_IMPORT_MAJOR_VERSION = 1
@QmlElement
class CellModel(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    def toDict(self):
        return {
            "path": self._path,
            "name": self._cellName,
            "icon": self._icon
        }

    @Slot(str)
    def cellClicked(self, path):
        subprocess.Popen('',executable=path)

    @Property(str)
    def cellName(self):
        return self._cellName
    
    @cellName.setter
    def cellName(self, name):
        self._cellName = name

    @Property(str)
    def path(self):
        return self._path
    
    @path.setter
    def path(self, path):
        self._path = path

    @Property(str)
    def icon(self):
        return self._icon
    
    @icon.setter
    def icon(self, icon):
        self._icon = icon

@QmlElement
class SectionModel(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    def toDict(self):
        cellsDicts = []
        for cell in self._cells:
            cellsDicts.append(cell.toDict())

        return {
            "name": self._name,
            "apps": cellsDicts
        }
    
    @Slot(str,str,str)
    def addCell(self, name, path, icon):
        curCell = CellModel()
        curCell.cellName = name
        curCell.path = path
        curCell.icon = icon
        self._cells.append(curCell)

    @Slot(int)
    def removeCell(self, index):
        del self._cells[index]
        
    @Property(str)
    def name(self):
        return self._name
    
    @name.setter
    def name(self, name):
        self._name = name

    @Property(list)
    def cells(self):
        return self._cells
    
    @cells.setter
    def cells(self, cells):
        self._cells = cells

