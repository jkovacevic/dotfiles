export FZF_DEFAULT_OPTS="--prompt='search > ' --height 60% --layout=reverse --border --exact --sort"

FD_OPTS=(--hidden --no-ignore --ignore-case)

fzf-file-home() {
    LBUFFER="${LBUFFER}$(command fd "${FD_OPTS[@]}" . $HOME | fzf)"
    zle reset-prompt
}
zle -N fzf-file-home

fzf-file-system() {
    LBUFFER="${LBUFFER}$(command fd "${FD_OPTS[@]}" . / | fzf)"
    zle reset-prompt
}
zle -N fzf-file-system

fzf-cd-home() {
    local dir=$(command fd "${FD_OPTS[@]}" -t d . $HOME | fzf)
    [[ -n "$dir" ]] && cd "$dir"
    zle reset-prompt
}
zle -N fzf-cd-home

fzf-cd-system() {
    local dir=$(command fd "${FD_OPTS[@]}" -t d . / | fzf)
    [[ -n "$dir" ]] && cd "$dir"
    zle reset-prompt
}
zle -N fzf-cd-system
