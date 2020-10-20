"""Xiaomi.eu downloads scraper"""
import asyncio
import json
import os
import re
import sys
import xml.etree.ElementTree as eT

from aiohttp import ClientSession

async def fetch(session, url):
    """ Fetch website page """
    async with session.get(url) as response:
        return await response.text()

async def load_eu_data():
    """
    load Xiaomi.eu devices downloads
    """
    eu_url = "https://sourceforge.net/projects/xiaomi-eu-multilang-miui-roms/rss?path=/xiaomi.eu"
    async with ClientSession() as session:
        stable = eT.fromstring(await fetch(session, f'{eu_url}/MIUI-STABLE-RELEASES'))
        weekly = eT.fromstring(await fetch(session, f'{eu_url}/MIUI-WEEKLY-RELEASES'))
        stable_links = [i.find('link').text for i in stable[0].findall('item')]
        weekly_links = [i.find('link').text for i in weekly[0].findall('item')]
        return [*stable_links, *weekly_links]


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
        stable_link = [i for i in eu_data if re.search(f"{device}_", i)
                       and re.search(f'{device}_V', i)][0]
    except IndexError:
        pass
    try:
        weekly_link = [i for i in eu_data if re.search(f"{device}_", i)
                       and not re.search(f'{device}_V', i)][0]
    except IndexError:
        pass
    links = [stable_link, weekly_link]
    return links


eu_data = asyncio.run(load_eu_data())
devices = asyncio.run(load_eu_codenames())
device = "lavender"
url = asyncio.run(get_eu(device, eu_data, devices))
stable_link = url[0]
weekly_link = url[1]

TYPE = sys.argv[1]
if TYPE == "STABLE":
    file = "url"
    with open(file, 'w+') as load:
        print("stable link: " + stable_link)
        load.write(stable_link)
elif TYPE == "BETA":
    file = "url"
    with open(file, 'w+') as load:
        print("weekly link: " + weekly_link)
        load.write(weekly_link)
