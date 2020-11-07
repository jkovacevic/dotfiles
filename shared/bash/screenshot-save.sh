#!/bin/bash
find_image_name() {
	IMAGE_NAME="~/hard-disk/save/img1.png"
	while [ -f $IMAGE_NAME ]
	do
		n=$(echo $IMAGE_NAME | sed -e 's#~/hard-disk/save/img\(.*\).png#\1#')
		n=$((n + 1))
		IMAGE_NAME="~/hard-disk/save/img$n.png"
	done
}

find_image_name
scrot -s $IMAGE_NAME
echo -n $IMAGE_NAME | xclip -selection clipboard;
notify-send "Created screenshot: $IMAGE_NAME"