#!/bin/zsh
if [[ "$1" == "normal" ]]; then
	print -n -- "\033[3 q"
elif [[ "$1" == "selection" ]]; then
	print -n -- "\033[1 q"
fi