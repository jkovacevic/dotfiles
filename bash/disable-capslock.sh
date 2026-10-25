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

echo "Caps Lock has been disabled and remapped to F13."
echo "Ghostty converts F13 to its terminal escape sequence directly (see ghostty.ini);"
echo "other apps (editor, IDE) should bind the F13 key natively in their own keymaps."