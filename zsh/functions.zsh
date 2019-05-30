copy_cmd() { 
	zle kill-buffer; 
	print -rn -- $CUTBUFFER | xclip -selection clipboard; 
}; zle -N copy_cmd

template() {
	choices=("awk\nsed")
	selected=$(echo -e "$choices" | rofi -dmenu)
	if [[ "$selected" == "awk" ]]; then
		zle -U " | awk '{ print }'";
	elif [[ "$selected" == "sed" ]]; then
		zle -U " | sed 's/word/replacement/g'";
	fi;
}; zle -N template