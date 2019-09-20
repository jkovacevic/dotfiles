#!/bin/sh
keypress_single_selection() {
    file_name=$(realpath "$1")
    key="$2"
    case "$key" in
    "C-h")
        notify-send "Help: 
X: delete file,
P: copy file path,
E: open with pinta" ;;
    "C-x")
        rm "$file_name"
        notify-send "Deleted $file_name" ;;
    "C-p")
        echo "$file_name" | xclip -selection clipboard
        notify-send "Copied $file_name to clipboard" ;;
    "C-e")
        pinta "$file_name" ;;
    esac
}

file=$(cat $file)
keypress_single_selection "$file" "$1"