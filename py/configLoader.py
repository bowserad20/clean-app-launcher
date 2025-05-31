import yaml
from models import *
from pathlib import Path
import os

class appsConfig:
    def __init__(self, filePath):
        self._filePath = filePath
        directory = os.path.dirname(filePath)
        if (not(os.path.exists(directory))):
            os.makedirs(directory)
        if (not(os.path.exists(filePath))):
            open(filePath, 'w').close()

        self._appsFile = open(filePath, 'r')
        self.sections = self._getSections(yaml.full_load(self._appsFile))

    def save(self):
        yaml.dump(self.toDict(), open(self._filePath, 'w'))
    
    def toDict(self):
        sectionDicts = []
        for sec in self.sections:
            sectionDicts.append(sec.toDict())
        return {
            "sections": sectionDicts
        }

    def _getCells(self, sec):
        cells = []
        curCell = None
        for app in sec.get('apps'):
            curCell = CellModel()
            curCell.cellName = app.get('name')
            curCell.path = app.get('path')
            curCell.icon = app.get('icon')
            cells.append(curCell)
        return cells

    def _getSections(self, apps):
        if (apps == None): return []
        secs = []
        curSec = None
        for sec in apps.get('sections'):
            curSec = SectionModel()
            curSec.name = sec.get('name')
            curSec.cells = self._getCells(sec)
            secs.append(curSec)

        return secs