#!/bin/bash
find_name() {
    n=$(ls -rt /tmp | grep vid | tail -n 1 | sed -e s/vid// -e s/\.mp4//)
    n=$((n+1))
	VIDEO_NAME="/tmp/vid$n.mp4"
}

find_name
{
	ffmpeg -f x11grab -y -r 25 -s $(xdpyinfo | awk '/dimensions/{print $2}') -i :0.0 -q 1 -c:v libx264 -c:a aac -pix_fmt yuv420p $VIDEO_NAME
} || {
	echo -n $VIDEO_NAME | xclip -selection clipboard;
	notify-send "v1"
}