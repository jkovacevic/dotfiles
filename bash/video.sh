find_video_name() {
	VIDEO_NAME="/tmp/vid1.mp4"
	while [ -f $VIDEO_NAME ]
	do
		n=$(echo $VIDEO_NAME | sed -e 's#/tmp/vid\(.*\).mp4#\1#')
		n=$((n + 1))
		VIDEO_NAME="/tmp/vid$n.mp4"
	done
}

find_video_name
{
	ffmpeg -f x11grab -y -r 25 -s 1920x1080 -i :0.0 -q 1 -vcodec mpeg4 $VIDEO_NAME
} || {
	notify-send "Created video: $VIDEO_NAME"
}