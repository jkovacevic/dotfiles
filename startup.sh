#!/usr/bin/zsh
sudo systemctl start NetworkManager
sudo mount --mkdir /dev/nvme1n1p1 dsk
autorandr --load home

xmodmap -e 'clear Lock'
xmodmap -e "keycode 66 = F13"

xset s off && xset -dpms

pulseaudio --check
pulseuadio -D

# Disable HDA Nvidia so Jabra can take over
pactl set-card-profile alsa_card.pci-0000_01_00.1 off

# Start apps
google-chrome-stable
cursor
Telegram
discord
thunderbird