[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/dotfiles/mac/zsh/functions.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
select-word-style normal
plugins=(zsh-completions)

# Environment variables
export WORDCHARS="<>()[]?-+.\"'"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export TERM='xterm-256color'
export EDITOR='/usr/local/bin/micro'
export PLATFORM="mac"

# Append to path without duplications due to TMUX
typeset -aU path
path=( $path $HOME/script )

setopt auto_cd
setopt prompt_subst
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

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}[%f%F{red}%b%f%f] '
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
aws_info_wrapper() { vcs_info; if [ -n "$AWS_PROFILE" ]; then echo "%F{white}[%f%F{yellow}AWS:$AWS_PROFILE%f%f]"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(aws_info_wrapper) $(vcs_info_wrapper)'

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
CTRL_Y="^Y"
CTRL_D="^D"
CTRL_F="^F"
CTRL_BKSP="^H"
CTRL_SP="^@"
SHIFT_LARROW="^[[1;2D"
SHIFT_RARROW="^[[1;2C"
CTRL_LARROW="^[[1;5D"
CTRL_RARROW="^[[1;5C"
ALT_H="^[h"
ALT_P="^[p"

# Remove keybinds
bindkey -r "^[c"    # fzf-cd-widget
bindkey -r "^d"     # delete-char-or-list
bindkey -r "^T"     # fzf-file-widget
bindkey -r "^Y"     # unknown
bindkey -r "^p"     # fzf-pass

# https://www.windmill.co.uk/ascii-control-codes.html
bindkey -r $CTRL_LARROW
bindkey -r $CTRL_RARROW
bindkey -r $ALT_H

bindkey     $CAPS_LOCK          list-dir
bindkey     $CTRL_BKSP          go-back
bindkey     $CTRL_Y             copy-text
bindkey     $ALT_P             fzf-pass
bindkey     $CTRL_D             fzf-cd-widget
bindkey     $CTRL_F             fzf-file-widget
bindkey     $ALT_H              home-dir

tmux-init
export PATH="$HOME/.poetry/bin:$PATH"
