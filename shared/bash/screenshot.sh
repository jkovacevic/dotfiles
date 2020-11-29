#!/bin/bash
find_name() {
    n=$(ls -rt /tmp | grep img | tail -n 1 | sed -e s/img// -e s/\.png//)
    n=$((n+1))
	IMAGE_NAME="/tmp/img$n.png"
}

find_name
if [[ "$1" -eq "full-screen" ]]; then
    scrot $IMAGE_NAME
else
    scrot -s $IMAGE_NAME
fi;
echo -n $IMAGE_NAME | xclip -selection clipboard;
notify-send "Created screenshot: $IMAGE_NAME"