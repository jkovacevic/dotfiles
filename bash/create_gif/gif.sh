#!/bin/bash
string=$(xrandr | fgrep '*' -m1 | awk 'END {print $1}')
IFS='x' read -r -a array <<< "$string"
x=${array[0]}
y=${array[1]}

byzanz-record -x 0 -y 0 --width $x --height $y --exec=$HOME/dotfiles/bash/create_gif/cflag.sh /tmp/f.ogg;
echo "/tmp/f.ogg" | xclip -selection clipboard;
paplay sound.ogg;
