source /usr/share/fzf/key-bindings.zsh
source $HOME/dotfiles/zsh/functions.zsh
source $HOME/dotfiles/zsh/fzf-config.zsh
source $HOME/dotfiles/zsh/bindkeys.zsh
source $HOME/dotfiles/claude/shell.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
select-word-style normal
plugins=(zsh-completions)

export WORDCHARS="<>()[]?-_+.\"'"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export TERM='xterm-256color'
export TERMINAL='ghostty'
export EDITOR='/usr/bin/micro'
export PLATFORM="arch"

typeset -aU path
path=( $path $HOME/script )

setopt auto_cd
setopt prompt_subst
setopt nomatch
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
unsetopt PROMPT_SP

stty eof undef

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{white}[%f%F{red}%b%f%f] '
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

vcs_info_wrapper() { vcs_info; [[ -n "$vcs_info_msg_0_" ]] && echo "$vcs_info_msg_0_"; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'