#!/bin/sh
keypress_single_selection() {
	file_name=$(realpath "$1")
	key="$2"
	case "$key" in
	"C-h")
		notify-send "Help: 
D: delete file
R: rotate file
P: copy file path
E: open with pinta
1: copy to hard-disk/save
2: copy to hard-disk/chan
3: copy to hard-disk/funny
4: copy to hard-disk/chan
5: copy to hard-disk/neat
6: copy to hard-disk/gif
7: copy to hard-disk/webm
8: copy to hard-disk/food" ;;
	"C-d")
		rm "$file_name"
		notify-send "Deleted $file_name" ;;
	"C-p")
		echo -n "$file_name" | xclip -selection clipboard
		notify-send "Copied $file_name to clipboard" ;;
	"C-e")
		pinta "$file_name" ;;
    "C-r")
            convert -rotate 90 $file_name $file_name ;;
	"C-1")
		output="$HOME/hard-disk/save"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-2")
		output="$HOME/hard-disk/chan"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-3")
		output="$HOME/hard-disk/funny"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-4")
		output="$HOME/hard-disk/chan"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-5")
		output="$HOME/hard-disk/neat"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-6")
		output="$HOME/hard-disk/gif"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	"C-7")
		output="$HOME/hard-disk/webm"
		cp "$file_name" $output
		notify-send "Copied $file_name to $output" ;;
	esac
}


files=$(cat $file)
keypress_single_selection "$files" "$1"