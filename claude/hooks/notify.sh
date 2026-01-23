#!/bin/bash

# Sends a notification for Claude Code events
# Usage: notify.sh <message>

MESSAGE="${1:-Claude Code}"

# Get tmux window name for the notification tag
WINDOW=$(tmux display-message -p -t "$TMUX_PANE" '#W' 2>/dev/null || echo "claude")

notify-send -t 60000 \
    -h "string:x-dunst-stack-tag:claude-${WINDOW}" \
    'Claude Code' \
    "${MESSAGE} - ${WINDOW}"
