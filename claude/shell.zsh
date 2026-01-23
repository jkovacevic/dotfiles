#!/usr/bin/zsh
# Claude Code shell customizations

# Wrapper that sets tmux tab to green (idle) on startup
claude() {
    [[ -n "$TMUX" ]] && $HOME/dotfiles/claude/hooks/set-tmux-color.sh idle
    command claude "$@"
}
