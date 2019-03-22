#!/bin/bash
find_image_name() {
	IMAGE_NAME="/tmp/img1.png"
	while [ -f $IMAGE_NAME ]
	do
		n=$(echo $IMAGE_NAME | sed -e 's#/tmp/img\(.*\).png#\1#')
		n=$((n + 1))
		IMAGE_NAME="/tmp/img$n.png"
	done
}

find_image_name
x=$IMAGE_NAME && touch $x && scrot -s $x;
echo -n $IMAGE_NAME | xclip -selection clipboard;
notify-send "Created screenshot: $IMAGE_NAME"