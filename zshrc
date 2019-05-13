# opt settings
setopt SHARE_HISTORY
setopt PROMPT_SUBST
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

source $HOME/.fzf/shell/key-bindings.zsh
source $HOME/.fzf/shell/completion.zsh

plugins=(zsh-completions)

export HISTFILE=~/.zsh_history  # ensure history file visibility
export EDITOR="micro"
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}(%f%F{red}%b%f%F{white})%f '
vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "${vcs_info_msg_0_}"; fi; }
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f $(vcs_info_wrapper)> '

autoload -Uz vcs_info compinit && compinit
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

autoload -U select-word-style
select-word-style bash

# Functions and aliases
alias l='ls -lFh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias ldot='ls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T black_orange'
alias cat='bat --style=plain'
alias clip='xclip -selection clipboard'
alias edit='cat > /tmp/_.txt; subl /tmp/_.txt'

# Navigation
alias ..='cd ..'
alias ....='cd ../..'

# Function
bg() { nohup $@ > /dev/null 2>&1 & disown }
pinta () { bg pinta "$@" }
evince () { bg evince "$@" }
libreoffice () { bg libreoffice "$@" }
vlc() { bg vlc "$@" }
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a *; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
yvid() { youtube-dl $1; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
cpcat() { cat $1 | xclip -selection clipboard; }
cppsh() { xclip -selection clipboard -o > $1; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }

# Text and word find
fs() {find -iname \*$1\*; }
fss() {sudo find -iname \*$1\*; }
ws() {grep -rn $1; }
wss() {sudo grep -rn $1; }

# Git shortcuts
gg () {git add .; git commit -m "automated commit message"; git push;}
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $1; fi }
gp () {git push}
gf () {git pull}
gs () {git status}
gc () {git commit -m "$1"}
gr () {git checkout $1}
gh () {smerge log $1}
gd () { if [ "$#" -eq 1 ]; then git diff $1; return 1;
		elif [ "$#" -eq 3 ]; then f=$(cut -d "/" -f 2 <<< "$1"); b1=$2; b2=$3;
		else echo "Expected arguments: file name, first branch name, second branch name,"; return 1; fi;
		git cat-file blob origin/$b1:$f > /tmp/$b1-$f; 
		git cat-file blob origin/$b2:$f > /tmp/$b2-$f; 
		fd /tmp/$b1-$f /tmp/$b2-$f
}

# AWS
aws-prod () { alias aws='aws --profile=smaato-prod-admin'}
aws-test () { alias aws='aws --profile=smaato-test-admin'}

# Arch terminal delete issue
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
bindkey    "^[f"			vi-forward-word
bindkey    "^[b"			vi-backward-word

eval "$(ntfy shell-integration)"