#!/bin/bash
# Toggle X11 Mouse Keys on/off

if xkbset q | grep -q "Mouse-Keys = On"; then
    xkbset -m
    notify-send "Mouse Keys OFF"
else
    xkbset m
    notify-send "Mouse Keys ON"
fi
