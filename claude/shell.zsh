#!/usr/bin/zsh
# Claude Code shell customizations

# Mark this tmux window green (idle) when launching Claude.
claude() {
    [[ -n "$TMUX" ]] && tmux set-option -w @claude_status idle
    command claude "$@"
}
