#!/usr/bin/env python3
"""Forward matching desktop notifications to Telegram."""

import re
import subprocess
from telegram_api import send_telegram_message

# Each entry: (substring to match in "summary body", optional title/summary substring)
# summary is e.g. "RuneLite - Aeon IM". Leave title as None to match regardless of title.
WATCH = [
    ("Gemstone Crab HP threshold reached!", None),
    #("Star layer mined (Shooting Star Info)", None),
    ("RS Salvaging - Cargo Hold is full", None),
    ("Inventory is full!", "Aeoncrux"),
]

proc = subprocess.Popen(
    ["dbus-monitor", "--session", "interface='org.freedesktop.Notifications',member='Notify'"],
    stdout=subprocess.PIPE, text=True
)

buf = ""
for line in proc.stdout:
    if "method call" in line:
        buf = ""
    buf += line
    if line.strip().startswith("int32 "):
        strings = re.findall(r'string "(.*?)"', buf)
        if len(strings) >= 4:
            summary, body = strings[2], strings[3]
            text = f"{summary} {body}".lower()
            matched = any(
                pattern.lower() in text and (title is None or title.lower() in summary.lower())
                for pattern, title in WATCH
            )
            if matched:
                send_telegram_message(f"{strings[0]}\n{summary}\n{body}")
        buf = ""
