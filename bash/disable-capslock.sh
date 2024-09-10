#!/bin/bash

# Disable Caps Lock
xmodmap -e "clear lock"

# Map Caps Lock to the desired keybind (^[[25~)
xmodmap -e "keycode 66 = F13"
xmodmap -e "keysym F13 = F13"

# Create an .Xmodmap file to make the changes persistent
cat << EOF > ~/.Xmodmap
clear lock
keycode 66 = F13
keysym F13 = F13
EOF

# Set up the key binding in your X server
xmodmap ~/.Xmodmap

# Check if xbindkeys is installed
if command -v xbindkeys &> /dev/null; then
    # Map F13 to the desired sequence using xbindkeys
    echo "\"xdotool key ctrl+bracketleft 2 5 asciitilde\"" > ~/.xbindkeysrc
    echo "  F13" >> ~/.xbindkeysrc

    # Restart xbindkeys to apply the changes
    pkill xbindkeys
    xbindkeys

    echo "Caps Lock has been disabled and mapped to ^[[25~"
else
    echo "xbindkeys is not installed. Caps Lock has been disabled and mapped to F13, but the final key sequence mapping is not complete."
    echo "Please install xbindkeys to complete the setup:"
    echo "sudo pacman -S xbindkeys"
fi