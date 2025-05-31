import sys
import os
from PySide6.QtGui import QGuiApplication, QFont, QIcon
from PySide6.QtQml import QQmlApplicationEngine, QmlElement
from PySide6.QtCore import QObject, Slot
from models import *
from configLoader import appsConfig

# nuitka-project: --onefile
# nuitka-project: --enable-plugin=pyside6
# nuitka-project: --include-qt-plugins=qml
# nuitka-project: --include-data-dir=qml=qml
# nuitka-project: --include-data-dir=assets=assets
# nuitka-project: --include-package=imageio
# nuitka-project: --windows-console-mode=attach
# nuitka-project: --windows-icon-from-ico=assets/appIcon.png

@Slot(str)
def handleError(url):
    print('resource failed to load',url)
    exit(1)

if __name__ == "__main__":
    # setup
    if ("__compiled__" in globals()):
        ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
        CONFIG_DIR = os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), "data")
    else:
        PY_DIR = os.path.abspath(os.path.dirname(__file__))
        ROOT_DIR = os.path.dirname(PY_DIR)
        CONFIG_DIR = os.path.join(ROOT_DIR, "data")

    app = QGuiApplication(sys.argv)
    font = QFont("Arial",12)
    app.setFont(font)
    app.setWindowIcon(QIcon(os.path.join(ROOT_DIR, "assets/appIcon.png")))

    engine = QQmlApplicationEngine()
    engine.objectCreationFailed.connect(handleError)
    engine.addImportPath(os.path.join(ROOT_DIR, "qml"))

    apps = appsConfig(os.path.join(CONFIG_DIR, "apps.yaml"))
    engine.setInitialProperties({"gridSections": apps.sections, "apps": apps})

    # run
    engine.load(os.path.join(ROOT_DIR, "qml/main.qml"))
    res = app.exec()