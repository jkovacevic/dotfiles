source /opt/fzf/shell/key-bindings.zsh
source $HOME/dotfiles/debian/zsh/functions.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
select-word-style bash
plugins=(zsh-completions)

# Environment variables
export WORDCHARS="*?_-.[]~=:&;!#$%^(){}<>/"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export EDITOR='micro'

# FZF environment variables
export FZF_DEFAULT_OPTS='--prompt="search > " --height 40% --layout=reverse --border --exact --sort'
export FZF_CTRL_T_COMMAND='command fd --hidden --no-ignore --ignore-case . /'
export FZF_ALT_C_COMMAND='command fd --hidden --no-ignore --ignore-case -t d . /'
    
setopt auto_cd
setopt prompt_subst           # Ability to override PROMPT AND RPROMPT
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_ignore_all_dups    
setopt hist_find_no_dups      # do not display a line previously found.
setopt hist_save_no_dups      # don't write duplicate entries in the history file.
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt ignore_eof			  # disables closing zsh with ctrl + D
setopt nomatch                # disables zsh-magic-matching with brackets []

# Z-Autocompletion
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# Version control system info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}[%f%F{red}%b%f%f] '
vcs_info_wrapper() { if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'

eval "$(ntfy shell-integration)"

# Terminal navigation
bindkey     "^[[3~"     delete-char
bindkey     "^[3;5~"    delete-char
bindkey     "^[d"       delete-word
bindkey     "^[[7~"     beginning-of-line
bindkey     "^[[8~"     end-of-line
bindkey     ";5D"       vi-backward-blank-word
bindkey     ";5C"       .vi-forward-blank-word
bindkey     "^Z"        undo

# ZLE commands
CAPS_LOCK="^[[25~"
CMD_HOME="^[[1~"
CMD_END="^[[4~"
CTRL_Y="^Y"
CTRL_L="^L"
CTRL_G="^G"
CTRL_D="^D"
CTRL_F="^F"
CTRL_BKSP="^H"
CTRL_SP="^@"
SHIFT_LARROW="^[[1;2D"
SHIFT_RARROW="^[[1;2C"
CTRL_LARROW="^[[1;5D"
CTRL_RARROW="^[[1;5C"

# Remove keybinds
bindkey -r "^[c"    # fzf-cd-widget
bindkey -r "^d"     # delete-char-or-list
bindkey -r "^T"     # fzf-file-widget
bindkey -r "^L"     # clear-screen
bindkey -r "^Y"     # unknown

bindkey -r $CMD_HOME
bindkey -r $CMD_END
bindkey -r $CTRL_LARROW
bindkey -r $CTRL_RARROW

bindkey     $CMD_HOME           beginning-of-line
bindkey     $CMD_END            end-of-line
bindkey     $CTRL_LARROW        vi-backward-blank-word
bindkey     $CTRL_RARROW        .vi-forward-blank-word
bindkey     $CTRL_G             go
bindkey     $CTRL_L             clear-screen
bindkey     $CAPS_LOCK          list-dir
bindkey     $CTRL_BKSP          go-back
bindkey     $CTRL_Y             copy-text
bindkey     $CTRL_D             fzf-cd-widget
bindkey     $CTRL_F             fzf-file-widget

tmux-init