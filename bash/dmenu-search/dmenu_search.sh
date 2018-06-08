#!/bin/bash

URL='https://www.google.com/search?q='
QUERY=$(echo '' | dmenu -p "Search: ")
if [ -n "$QUERY" ]; then
  xdg-open "${URL}${QUERY}" 2> /dev/null
  exec i3-msg [class="Google-chrome"] focus
fi