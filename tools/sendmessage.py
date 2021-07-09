#!/usr/bin/env python3
import os
from telethon import TelegramClient
from telethon.sessions import StringSession

api_id = os.environ['APPID']
api_hash = os.environ['APIHASH']
session_name = os.environ['SESSIONSTRING']
chat_name = "shekhawat2"

Image = os.environ['MIUIPIC']
File = os.environ['INFOFILE']

with open(File,'r') as file:
    message = file.read()

client = TelegramClient(StringSession(session_name), api_id, api_hash)
client.start()
async def main():
    await client.send_file(chat_name, Image, caption=message, parse_mode='md')

with client:
    client.loop.run_until_complete(main())
