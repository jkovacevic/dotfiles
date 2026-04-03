#!/usr/bin/bash
sdcv "$(xsel | sed "s/[^a-zA-Z0-9 '-]//g" | xargs)" | zenity --text-info --width=1000 --height=800 --font="Monospace 14"