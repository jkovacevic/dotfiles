#!/bin/sh
keypress_single_selection() {
	file_name=$(realpath "$1")
	key="$2"
	case "$key" in
	"C-x")
		rm "$file_name"
		notify-send "Deleted $file_name" ;;
	"C-e")
		pinta "$file_name" ;;
	"C-r")
		convert -rotate 90 "$file_name" "$file_name" ;;
	esac
}

keypress_multi_selection() {
	file_names="$1"
	key="$2"
	case $key in
	"C-h")
		output=$(pwd)/"img-append.png"
        convert -append $file_names $output
        notify-send "Horizontally stacked $file_names to $output" ;;
	"C-v")
        output=$(pwd)/"img-append.png"
        convert +append $file_names $output
        notify-send "Vertically stacked $file_names to $output" ;;
	esac	
}

files=$(cat $file)
files_arr=($files)
n=${#files_arr[@]}

if [ "$n" -eq "1" ]; then
	keypress_single_selection "$files" "$1"
else
	keypress_multi_selection "$files" "$1"
fi;