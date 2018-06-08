#!/bin/bash

x="/tmp/img1.png" && touch $x && scrot -s $x;
echo "/tmp/img1.png" | xclip -selection clipboard;