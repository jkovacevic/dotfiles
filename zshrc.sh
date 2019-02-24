setopt inc_append_history
setopt share_history
setopt prompt_subst
unsetopt autocd beep

source $HOME/.fzf/shell/key-bindings.zsh
source $HOME/.fzf/shell/completion.zsh

plugins=(zsh-completions)

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTFILE=~/.zsh_history  # ensure history file visibility
export HH_CONFIG=monochromatics # get more colors
export HISTSIZE=100000
export SAVEHIST=100000
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Color prompt and git
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'
export EDITOR="micro"

vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "%{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%}$del"; fi; }
autoload -Uz vcs_info compinit && compinit
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}[%F{cyan}%b%F{white}]%f '
zstyle ':completion:*' verbose yes

autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# Functions and aliases
alias l='ls -lFh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias ldot='ls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T black_orange'
alias cat='bat --theme=Monokai\ Extended --style=plain'
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
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a .; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
yvid() { youtube-dl $1; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }
cpcat() { cat $1 | xclip -selection clipboard; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\' }

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
gd () {git diff $1}

# Arch terminal delete issue
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char