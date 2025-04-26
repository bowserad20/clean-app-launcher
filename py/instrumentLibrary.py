import sys
import os
from PySide6.QtGui import QGuiApplication, QFont
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot
from models import *
from configLoader import appsConfig

# nuitka-project: --standalone
# nuitka-project: --enable-plugin=pyside6
# nuitka-project: --include-qt-plugins=qml
# nuitka-project: --include-data-dir=qml=qml

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
    if ("__compiled__" in globals()):
        ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
    else:
        PY_DIR = os.path.abspath(os.path.dirname(__file__))
        ROOT_DIR = os.path.dirname(PY_DIR)

    app = QGuiApplication(sys.argv)
    font = QFont("Arial",12)
    app.setFont(font)

    engine = QQmlApplicationEngine()
    engine.objectCreationFailed.connect(handleError)
    engine.addImportPath(os.path.join(ROOT_DIR, "qml"))

    apps = appsConfig(os.path.join(ROOT_DIR, "data/apps.yaml"))
    engine.setInitialProperties({"gridSections": apps.sections})

    # run
    engine.load(os.path.join(ROOT_DIR, "qml/main.qml"))
    res = app.exec()