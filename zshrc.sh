# Lines configured by zsh-newuser-install
setopt inc_append_history
setopt share_history
setopt prompt_subst
unsetopt autocd beep

plugins=(zsh-completions)

export CDPATH="$HOME:"

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTFILE=~/.zsh_history  # ensure history file visibility
export HH_CONFIG=monochromatics # get more colors
export HISTSIZE=100000
export SAVEHIST=100000
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Color prompt and git
export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'
vcs_info_wrapper() { vcs_info; if [ -n "$vcs_info_msg_0_" ]; then echo "%{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%}$del"; fi; }
autoload -Uz vcs_info compinit && compinit
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' formats '%F{white}[%F{cyan}%b%F{white}]%f '

autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# Functions and aliases
alias l='ls -lFh --color=auto --group-directories-first'     #size,show type,human readable
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias mocp='mocp -T black_orange'

# Navigation
alias cd='cd > /dev/null 2>&1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

pinta () {nohup pinta "$@" > /dev/null 2>&1 & disown}
evince () {nohup evince "$@" > /dev/null 2>&1 & disown}
office () {nohup libreoffice "$@" > /dev/null 2>&1 & disown}
nom () {nohup nomacs "$@" > /dev/null 2>&1 & disown}
vlc() {nohup vlc "$@" > /dev/null 2>&1 & disown}
yvid() { youtube-dl $1; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }

# Text and word find
fs() {find -iname \*$1\*; }
fss() {sudo find -iname \*$1\*; }
ws() {grep -rn $1; }
wss() {sudo grep -rn $1; }

# Git shortcuts
ga () {	if [[ $1 == "" ]]; then git add .;	else git add $1; fi }
gp () {git push}
gf () {git pull}
gs () {git status}
gc () {git commit -m "$1"}
gr () {git reset HEAD^}
gg () {git add .; git commit -m "no-commit-message"; git push;}
gd () {git difftool $1}
gm () {git mergetool $1}