#!/bin/bash
# After tmux restarts, find windows running Claude and make them green

# Go through each tmux pane
# For each pane, we get: "session:window" and "/dev/pts/X" (the terminal)
tmux list-panes -a -F '#{session_name}:#{window_index} #{pane_tty}' | while read -r target tty; do

    # Is "claude" running in this terminal?
    if pgrep -t "${tty#/dev/}" -x claude >/dev/null; then
        # Yes - set status to idle (green)
        tmux set-option -w -t "$target" @claude_status idle
    fi

done
