copy_cmd() { 
	zle kill-buffer; 
	print -rn -- $CUTBUFFER | xclip -selection clipboard; 
}; zle -N copy_cmd

template() {
	list=("awk\nsed")
	choice=$(echo -e "$list" | rofi -dmenu)
	if [[ "$choice" == "awk" ]]; then
		zle -U " | awk '{ print }'";
	elif [[ "$choice" == "sed" ]]; then
		zle -U " | sed 's/word/replacement/g'";
	fi;
}; zle -N template