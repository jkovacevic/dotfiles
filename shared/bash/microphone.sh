find_name() {
    n=$(ls -rt /tmp | grep mic | tail -n 1 | sed -e s/mic// -e s/\.wav//)
    n=$((n+1))
    FILE_NAME="/tmp/mic$n.wav"
}

find_name
{
    amixer set Capture 100%+;
    arecord -vv -f S16_LE -c 2 $FILE_NAME;
} || {
    amixer set Capture 100%-;
    echo -n $FILE_NAME | xclip -selection clipboard;
    notify-send "Created record: $FILE_NAME";
}