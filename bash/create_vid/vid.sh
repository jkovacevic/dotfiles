#!/bin/bash
string=$(xrandr | fgrep '*' -m1 | awk 'END {print $1}')
IFS='x' read -r -a array <<< "$string"
x=${array[0]}
y=${array[1]}

byzanz-record -x 0 -y 0 --width $x --height $y --exec=$HOME/dotfiles/bash/create_vid/cflag.sh /tmp/f.mp4;
echo "/tmp/f.mp4" | xclip -selection clipboard;
paplay sound.ogg;
