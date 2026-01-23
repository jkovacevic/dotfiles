#!/bin/bash

# Restores Claude tmux colors after tmux restart
# Run this after tmux starts to set idle (green) status for windows with Claude running

# Get all tmux panes with their TTYs
tmux list-panes -a -F '#{session_name}:#{window_index} #{pane_tty}' 2>/dev/null | while read -r target tty; do
    # Check if a Claude process is running on this TTY
    if ps -t "$tty" -o comm= 2>/dev/null | grep -q "^claude$"; then
        tmux set-option -w -t "$target" @claude_status "idle"
    fi
done
