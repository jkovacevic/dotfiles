# FZF Configuration
# Custom fuzzy finder widgets and keybindings

export FZF_DEFAULT_OPTS="--prompt='search > ' --height 60% --layout=reverse --border --exact --sort"

# File search widget - home directory only
fzf-file-home() {
    LBUFFER="${LBUFFER}$(command fd --hidden --no-ignore --ignore-case . $HOME | fzf)"
    zle reset-prompt
}
zle -N fzf-file-home

# File search widget - whole system
fzf-file-system() {
    LBUFFER="${LBUFFER}$(command fd --hidden --no-ignore --ignore-case . / | fzf)"
    zle reset-prompt
}
zle -N fzf-file-system

# Directory search widget - home directory only
# Overrides ignore_eof behavior for Ctrl+D
fzf-cd-home() {
    local dir=$(command fd --hidden --no-ignore --ignore-case -t d . $HOME | fzf)
    if [[ -n "$dir" ]]; then
        cd "$dir"
    fi
    zle reset-prompt
}
zle -N fzf-cd-home
bindkey "^D" fzf-cd-home

# Directory search widget - whole system
fzf-cd-system() {
    local dir=$(command fd --hidden --no-ignore --ignore-case -t d . / | fzf)
    if [[ -n "$dir" ]]; then
        cd "$dir"
        zle reset-prompt
    fi
}
zle -N fzf-cd-system

# Remove default fzf keybinds
bindkey -r "^[c"  # fzf-cd-widget
bindkey -r "^T"   # fzf-file-widget

# File search keybinds
bindkey "^F"        fzf-file-home     # Ctrl+F - search home directory
bindkey "^[[102;6u" fzf-file-system   # Ctrl+Shift+F - search whole system

# Directory search keybinds
bindkey "^D"        fzf-cd-home       # Ctrl+D - search home directory
bindkey "^[[100;6u" fzf-cd-system     # Ctrl+Shift+D - search whole system
