from requests import get
import requests
import sys
from datetime import datetime as dt
import yaml

DEVICE = sys.argv[1]
VERSION = sys.argv[2]
info="https://raw.githubusercontent.com/XiaomiFirmwareUpdater/xiaomifirmwareupdater.github.io/master/data/devices/latest/" + DEVICE + ".yml"
fw=yaml.safe_load(requests.get(info).content)
if VERSION == "stable":
    version=fw[0]["versions"]["miui"]

URL="https://bigota.d.miui.com/"
with open('/tmp/version','wb') as load:
    load.write(str.encode(version))
URL+=version
URL+="/"

if VERSION == "stable":
    file=fw[0]["filename"]
if DEVICE == "lavender" or DEVICE == "lmi":
    file=file[12:]
elif DEVICE == "ginkgo" or DEVICE == "whyred":
    file=file[10:]

URL+=file

print("Fetching Weekly ROM: " + file + "......")
with open("url", 'w+') as load:
    print("URL: " + URL)
    load.write(URL)
