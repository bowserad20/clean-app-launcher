# from configLoader import appsConfig
# apps = appsConfig('./data/apps.yaml')
# apps.sections[0].name = 'testing 123'
# apps.save()

import requests
from io import BytesIO
from PIL import Image
from configLoader import appsConfig
from pathlib import Path
import yaml


apps = appsConfig('./data/apps.yaml')
urls = []

curName = ''
for sec in apps.sections:
    for cell in sec.cells:
        curName = Path(cell.path).stem
        curName = curName.replace(' ','-')
        urls.append((cell.cellName, 'https://medias.arturia.net/cdn-cgi/image/quality=100/images/products/'+curName+'/icon.png'))

entries = []
for url in urls:
    entries.append({
        "label": url[0],
        "icon": url[1]
    })

outFile = open('./data/icons.yaml','w')
yaml.dump(entries, outFile)


# response = requests.get(url)
# img = Image.open(BytesIO(response.content))
# img.show()