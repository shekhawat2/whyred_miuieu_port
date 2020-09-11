"""Xiaomi.eu downloads scraper"""
import asyncio
import json
import re
import os
import xml.etree.ElementTree as eT

from telethon import events
from aiohttp import ClientSession

async def fetch(session, url):
    """ Fetch website page """
    async with session.get(url) as response:
        return await response.text()

async def load_eu_data():
    eu_url = "https://sourceforge.net/projects/xiaomi-eu-multilang-miui-roms/rss?path=/xiaomi.eu"
    async with ClientSession() as session:
        weekly = eT.fromstring(await fetch(session, f'{eu_url}/MIUI-WEEKLY-RELEASES'))
        weekly_links = [i.find('link').text for i in weekly[0].findall('item')]
        return [*weekly_links]

async def load_eu_codenames():
    """
    load Xiaomi.eu devices codenames
    """
    GITHUB_ORG = "https://raw.githubusercontent.com/XiaomiFirmwareUpdater"
    async with ClientSession() as session:
        raw = await fetch(session, f'{GITHUB_ORG}/xiaomi_devices/eu/devices.json')
        models = json.loads(raw)
        return models

async def get_eu(codename, eu_data, devices):
    """
    fetch latest xiaomi_eu links for a device
    """
    stable_link = ""
    weekly_link = ""
    device = devices[codename][1]
    try:
        weekly_link = [i for i in eu_data if re.search(f"{device}_", i)
                       and not re.search(f'{device}_V', i)][0]
    except IndexError:
        pass
    link = weekly_link
    return link

eu_data = asyncio.run(load_eu_data())
devices = asyncio.run(load_eu_codenames())
device = "lavender"
url = asyncio.run(get_eu(device, eu_data, devices))
file = "url"

with open(file, 'w+') as load:
    print("writing")
    load.write(url)

