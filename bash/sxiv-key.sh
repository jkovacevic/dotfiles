#!/bin/sh
keypress_single_selection() {
	file_name=$(realpath "$1")
	key="$2"
	case "$key" in
	"C-h")
		notify-send "Help: 
X: delete file,
P: copy file path,
E: open with pinta,
S: copy to hard-disk/image,
C: copy to hard-disk/chan,
F: copy to hard-disk/funny,
G: copy to hard-disk/gif,
W: copy to hard-disk/webm" ;;
	"C-x")
		rm "$file_name"
		notify-send "Deleted $file_name" ;;
	"C-p")
		echo "$file_name" | xclip -selection clipboard
		notify-send "Copied $file_name to clipboard" ;;
	"C-e")
		pinta "$file_name" ;;
	"C-s")
		output="$HOME/hard-disk/image"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-c")
		output="$HOME/hard-disk/chan"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-f")
		output="$HOME/hard-disk/funny"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-g")
		output="$HOME/hard-disk/gif"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-w")
		output="$HOME/hard-disk/webm"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
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