source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source $HOME/dotfiles/zsh/functions.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
plugins=(zsh-completions)

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --exact --sort'
export FZF_ALT_C_COMMAND='find $HOME -type d ! -path "*\.git*" ! -path "*venv*" ! -path "*__pycache__*" ! -path "*sublime-history*"'
export WORDCHARS="*?_-.[]~=:&;!#$%^(){}<>"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

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

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}~ %f%F{red}%b%f%f '
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f $(vcs_info_wrapper)> '

# Functions and aliases
alias l='ls -lFh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias lt='ls -lhtr --color=auto --group-directories-first'
alias ldot='ls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T black_orange'
alias cat='bat --style=plain'
alias clip='xclip -selection clipboard'
alias edit='cat > /tmp/_.txt; subl /tmp/_.txt'

# Navigation
alias ..='cd ..'
alias ....='cd ../..'

# Terminal navigation
bindkey    	"^[[3~"		delete-char
bindkey    	"^[3;5~"	delete-char
bindkey    	"^[[7~"		beginning-of-line
bindkey    	"^[[8~"		end-of-line
bindkey    	"^Z"		undo
bindkey    	";5D"		vi-backward-blank-word
bindkey    	";5C"		.vi-forward-blank-word

# Custom commands
bindkey  	"^Y"		copy_cmd
bindkey 	"^[t"		template

eval "$(ntfy shell-integration)"