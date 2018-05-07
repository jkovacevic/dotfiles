# Lines configured by zsh-newuser-install
setopt inc_append_history
setopt share_history              
HISTCONTROL=ignoredups:erasedups  # no duplicate entries
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt prompt_subst

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
unsetopt autocd beep
bindkey -e

[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || eval $(dircolors -b)


autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{white}[%F{cyan}%b%F{white}|%F{cyan}%a%F{cyan}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{white}[%F{cyan}%b%F{white}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{cyan}:%F{cyan}%r'

zstyle ':vcs_info:*' enable git cvs svn

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}


zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export PROMPT='[%F{cyan}%*%f] %F{cyan}%m%f %F{red}%/%f > '
export RPROMPT='$(vcs_info_wrapper)'

alias l='ls -lFh --color=auto --group-directories-first'     #size,show type,human readable
alias ls='ls --color=auto --group-directories-first'
alias la='ls -lAFh --color=auto --group-directories-first'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh --color=auto --group-directories-first'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh --color=auto --group-directories-first'   #long list,sorted by date,show type,human readable
alias ll='ls -l --color=auto --group-directories-first'      #long list
alias ed=" cat > /tmp/a.txt; subl /tmp/a.txt"
alias grep='grep --color=auto'

gwenview () {nohup gwenview "$@" > /dev/null 2>&1 & disown}
pinta () {nohup pinta "$@" > /dev/null 2>&1 & disown}
evince () {nohup evince "$@" > /dev/null 2>&1 & disown}
libreoffice () {nohup libreoffice "$@" > /dev/null 2>&1 & disown}
ipython () {nohup jupyter qtconsole --style paraiso-dark --gui-completion droplist > /dev/null 2>&1 & disown}

alias mnt="sudo mkdir /tmp/android/; sudo simple-mtpfs --device 1 /tmp/android/; cd /tmp/android/; l"
alias umnt="fusermount -u /tmp/android/; rm -r /tmp/android/"

yvid() { youtube-dl $1; }
ymp3() { youtube-dl --extract-audio --audio-format mp3 $1; }
cpth() { readlink -f $1 | xargs echo -n | xclip -selection clipboard; }