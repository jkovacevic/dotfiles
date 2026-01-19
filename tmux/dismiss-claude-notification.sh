#!/bin/bash
# Dismiss Claude Code notification for the current tmux window
# This sends a replacement notification with 1ms timeout to effectively dismiss it

window_name=$(tmux display-message -p '#W')

# Only dismiss if there are displayed notifications
if [[ $(dunstctl count displayed) -gt 0 ]]; then
    notify-send -t 1 -h "string:x-dunst-stack-tag:claude-$window_name" ""
fi
