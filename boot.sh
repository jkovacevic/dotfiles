#!/usr/bin/zsh
sudo systemctl start NetworkManager
sudo mount --mkdir /dev/nvme1n1p1 dsk
autorandr --load home

xmodmap -e 'clear Lock'
xmodmap -e "keycode 66 = F13"

xset s off && xset -dpms

pulseaudio --check
pulseuadio -D

# Start apps
google-chrome-stable
cursor
telegram-desktop
viber
discord
thunderbird