find_file_name() {
    FILE_NAME="/tmp/mic1.wav"
    while [ -f $FILE_NAME ]
    do
        n=$(echo $FILE_NAME | sed -e 's#/tmp/mic\(.*\).wav#\1#')
        n=$((n + 1))
        FILE_NAME="/tmp/mic$n.wav"
    done
}

find_file_name
{
    index=$(pacmd list-sources | grep "* index" | cut -d ':' -f 2)
    volume=$((65535 / 100 * 120))
    pacmd set-source-volume $index $volume
    arecord -vv -fdat -c 1 $FILE_NAME
} || {
    echo -n $FILE_NAME | xclip -selection clipboard;
    notify-send "Created record: $FILE_NAME"
}