#!/bin/bash

# Sets @claude_status for the current tmux window
# Called by Claude hooks in settings.json

[ -z "$TMUX" ] && exit 0

TARGET=$(tmux display-message -p -t "${TMUX_PANE:-}" '#{session_name}:#{window_index}')
FOCUSED=$(tmux display-message -p -t "${TMUX_PANE:-}" '#{window_active}')

case "$1" in
    computing) tmux set-option -w -t "$TARGET" @claude_status "computing" ;;
    prompt)    tmux set-option -w -t "$TARGET" @claude_status "prompt" ;;
    complete)  [ "$FOCUSED" = "1" ] && tmux set-option -w -t "$TARGET" @claude_status "idle" \
                                    || tmux set-option -w -t "$TARGET" @claude_status "unread" ;;
esac
