#!/bin/bash
xsel -o | dmenu -fn "DejaVu Sans-12" -p "Google:" | xargs -I {} google-chrome-stable https://www.google.com/search\?q={}