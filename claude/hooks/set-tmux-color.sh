#!/bin/bash

# Sets the Claude status color for the current tmux window
# Usage: set-tmux-color.sh <status>
# Status: computing (red), prompt (yellow), idle (green)

STATUS="${1:-idle}"

# Only proceed if we're in tmux
if [ -z "$TMUX" ]; then
    exit 0
fi

# Get the window where this script is running (not the active window)
# $TMUX_PANE contains the pane ID inherited from the Claude process
if [ -n "$TMUX_PANE" ]; then
    WINDOW_TARGET=$(tmux display-message -p -t "$TMUX_PANE" '#{session_name}:#{window_index}')
else
    # Fallback to active window if TMUX_PANE not set
    WINDOW_TARGET=$(tmux display-message -p '#{session_name}:#{window_index}')
fi

case "$STATUS" in
    computing|red|r)
        tmux set-option -w -t "$WINDOW_TARGET" @claude_status "computing"
        ;;
    prompt|yellow|y)
        tmux set-option -w -t "$WINDOW_TARGET" @claude_status "prompt"
        ;;
    idle|green|g)
        tmux set-option -w -t "$WINDOW_TARGET" @claude_status "idle"
        ;;
    clear|none)
        tmux set-option -w -u -t "$WINDOW_TARGET" @claude_status
        ;;
esac
