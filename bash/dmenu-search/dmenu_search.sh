#!/bin/bash
xsel -c
x=$(xsel -o | dmenu -fn "DejaVu Sans-12" -p "Google:" | xargs -r -I {} google-chrome-stable https://www.google.com/search\?q={} | wc -l)
if [ $x -eq 1 ]; then
	exec i3-msg [class="Google-chrome"] focus
fi;