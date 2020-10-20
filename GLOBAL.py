from requests import get
import requests
import sys
from datetime import datetime as dt
import yaml

TYPE = sys.argv[1]
info="https://raw.githubusercontent.com/XiaomiFirmwareUpdater/xiaomifirmwareupdater.github.io/master/data/devices/latest/lavender.yml"
fw=yaml.safe_load(requests.get(info).content)
if TYPE == "BETA":
    version=fw[3]["versions"]["miui"]
elif TYPE == "STABLE":
    version=fw[1]["versions"]["miui"]
URL="https://bigota.d.miui.com/"
with open('/tmp/version','wb') as load:
    load.write(str.encode(version))
URL+=version
URL+="/"
if TYPE == "BETA":
    file=fw[3]["filename"]
elif TYPE == "STABLE":
    file=fw[1]["filename"]
file=file[12:]
URL+=file
print("Fetching Weekly ROM: " + file + "......")
with open("url", 'w+') as load:
    print("writing")
    load.write(URL)
