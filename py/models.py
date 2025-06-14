from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot, Property, QUrl
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
    
    @Slot(str,QUrl,QUrl)
    def addCell(self, name, path, icon):
        curCell = CellModel()
        curCell.cellName = name
        print(path, icon)
        curCell.icon = icon.toLocalFile() if icon.isLocalFile() else icon.toString()
        curCell.path = path.toLocalFile() if path.isLocalFile() else path.toString()
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

@QmlElement
class ConfigLoader(QObject):

    @Slot()
    def save(self):
        self.apps.save()

    @Slot(str)
    def addSection(self, name):
        section = SectionModel()
        section.name = name if name else f"Section {len(self._apps.sections) + 1}"
        section.cells = []
        self._apps.sections.append(section)

    @Slot(QObject, str)
    def renameSection(self, section, name):
        i = self._apps.sections.index(section)
        self._apps.sections[i].name = name

    @Slot(QObject)
    def removeSection(self, section):
        self._apps.sections.remove(section)

    @Slot(result=list)
    def getSections(self):
        return self._apps.sections

    @Property(object)
    def apps(self):
        return self._apps
    
    @apps.setter
    def apps(self, apps):
        self._apps = apps
