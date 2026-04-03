#!/usr/bin/env python3
"""Forward matching desktop notifications to Telegram."""

import re
import subprocess
from notifications import send_telegram_message

WATCH = [
    "Gemstone Crab HP threshold reached!",
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
        if len(strings) >= 4 and any(w.lower() in f"{strings[2]} {strings[3]}".lower() for w in WATCH):
            send_telegram_message(f"{strings[0]}\n{strings[2]}\n{strings[3]}")
        buf = ""
