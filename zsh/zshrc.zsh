source /opt/fzf/shell/key-bindings.zsh
source $HOME/dotfiles/zsh/functions.zsh
source $HOME/dotfiles/zsh/alias.zsh

autoload -Uz vcs_info compinit && compinit
autoload -U select-word-style
plugins=(zsh-completions)

export FZF_DEFAULT_OPTS='--prompt="search > " --height 40% --layout=reverse --border --exact --sort'
export FZF_CTRL_T_COMMAND='command fd --hidden --no-ignore --ignore-case . /'
export FZF_ALT_C_COMMAND='command fd --hidden --no-ignore --ignore-case -t d . /'
export WORDCHARS="*?_-.[]~=:&;!#$%^(){}<>"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export EDITOR='micro'

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
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'

# Remove keybinds
bindkey -r "^[c" 	# fzf-cd-widget
bindkey -r "^d" 	# delete-char-or-list
bindkey -r "^T"     # fzf-file-widget

# Terminal navigation
bindkey    	"^[[3~"		delete-char
bindkey    	"^[3;5~"	delete-char
bindkey    	"^[[7~"		beginning-of-line
bindkey    	"^[[8~"		end-of-line
bindkey    	"^Z"		undo
bindkey    	";5D"		vi-backward-blank-word
bindkey    	";5C"		.vi-forward-blank-word
bindkey     "^[[25~"    go_back
bindkey     "^[[1;2P"   go_back

# Custom commands
bindkey  	"^Y"		copy_cmd
bindkey 	"^D"		fzf-cd-widget
bindkey 	"^F"		fzf-file-widget

eval "$(ntfy shell-integration)"

aws-prod() { alias aws='aws --profile=smaato-prod-admin' }
aws-test() { alias aws='aws --profile=smaato-test-admin' }
aws-ssh() {ssh -i ~/.ssh/smart-platform-test.pem ec2-user@$1}
foxy-proxy() { ssh -i ~/.ssh/smart-platform-test.pem -N -D 8157 hadoop@$1 }

function setup_tmux {
    if [ -z "$TMUX" ]
    then

        echo "Shell: [W]orkshell or [H]omeshell?"
        read shell
        if [[ ${shell:l} == "w" ]] then $HOME/dotfiles-shared/tmux/tmux.startup.shell; fi
        if [[ ${shell:l} == "h" ]] then $HOME/dotfiles-shared/tmux/tmux.startup.home; fi
    fi
}
setup_tmux