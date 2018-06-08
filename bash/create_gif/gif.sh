#!/bin/bash
string=$(xrandr | fgrep '*' -m1 | awk 'END {print $1}')
IFS='x' read -r -a array <<< "$string"
x=${array[0]}
y=${array[1]}

byzanz-record -x 0 -y 0 --width $x --height $y --exec=/home/janko/bash/create_gif/cflag.sh /tmp/gif1.gif > /dev/null 2>&1;
echo "/tmp/gif1.gif" | xclip -selection clipboard;
paplay /usr/share/sounds/ubuntu/notifications/Blip.ogg > /dev/null 2>&1;
