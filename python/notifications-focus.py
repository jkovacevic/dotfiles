#!/usr/bin/env python3
"""Mark the i3 window urgent (red border) when a matching RuneLite notification fires."""

import re
import subprocess

# Each entry: (substring to match in "summary body", optional client substring)
# summary is set by RuneLite to "RuneLite - <display name>", e.g. "RuneLite - Aeon IM".
# Leave client as None to match regardless of which client sent it.
WATCH = [
    ("You are now out of combat!", "Aeon IM"),
    ("Star layer mined (Shooting Star Info)", None),
    ("Inventory is full!", None),
    ("RS Salvaging - Cargo Hold is full", None),
]

proc = subprocess.Popen(
    ["dbus-monitor", "--session", "interface='org.freedesktop.Notifications',member='Notify'"],
    stdout=subprocess.PIPE, text=True
)


def find_window_for_title(title):
    out = subprocess.run(["wmctrl", "-l"], capture_output=True, text=True).stdout
    for line in out.splitlines():
        parts = line.split(None, 3)
        if len(parts) >= 4 and title.lower() in parts[3].lower():
            return parts[0]
    return None


def mark_urgent(win_id):
    subprocess.run(["wmctrl", "-i", "-r", win_id, "-b", "add,demands_attention"])


buf = ""
for line in proc.stdout:
    if "method call" in line:
        buf = ""
    buf += line
    if line.strip().startswith("int32 "):
        strings = re.findall(r'string "(.*?)"', buf)
        if len(strings) >= 4 and strings[0] == "RuneLite":
            summary, body = strings[2], strings[3]
            text = f"{summary} {body}".lower()

            matched = any(
                pattern.lower() in text and (client is None or client.lower() in summary.lower())
                for pattern, client in WATCH
            )

            if matched:
                win_id = find_window_for_title(summary)
                if win_id:
                    mark_urgent(win_id)
                    print(f"Marked urgent: {summary!r} -> {win_id}", flush=True)
                else:
                    print(f"No window found for title {summary!r}", flush=True)
        buf = ""
