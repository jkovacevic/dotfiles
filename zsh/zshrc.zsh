source /usr/share/fzf/key-bindings.zsh
source $HOME/dotfiles/zsh/functions.zsh
source $HOME/dotfiles/zsh/fzf-config.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
select-word-style normal
plugins=(zsh-completions)

# Environment variables
export WORDCHARS="<>()[]?-_+.\"'"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export TERM='xterm-256color'
export TERMINAL='ghostty'
export EDITOR='/usr/bin/micro'
export PLATFORM="arch"


# Append to path without duplications due to TMUX
typeset -aU path
path=( $path $HOME/script )

setopt auto_cd
setopt prompt_subst
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_ignore_all_dups   # ignore duplicated commands history list    
setopt hist_find_no_dups      # do not display a line previously found.
setopt hist_save_no_dups      # don't write duplicate entries in the history file.
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt nomatch                # disables zsh-magic-matching with brackets []
unsetopt PROMPT_SP

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{white}[%f%F{red}%b%f%f] '
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'

# Terminal navigation
bindkey     "^[[3~"     delete-char
bindkey     "^[3;5~"    delete-char
bindkey     "^[d"       delete-word
bindkey     ";5D"       vi-backward-blank-word
bindkey     ";5C"       .vi-forward-blank-word
bindkey     "^Z"        undo

# Remove default keybinds
bindkey -r "^d"   # delete-char-or-list
bindkey -r "^Y"
bindkey -r "^[h"

# Custom keybinds
bindkey "^[[20~" list-dir         # Caps Lock
bindkey "^H"     go-back          # Ctrl+Backspace
bindkey "^Y"     copy-text
bindkey "^P"     fzf-pass
bindkey "^[h"    home-dir         # Alt+H