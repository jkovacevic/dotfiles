#!/bin/zsh
# Aliases
alias l='gls -lh --color=auto --group-directories-first'
alias ls='gls --color=auto --group-directories-first'
alias lt='gls -lhrt --color=auto --group-directories-first'
alias ldot='gls -ld .*'
alias grep='grep --color=auto'
alias mocp='mocp -T rhowaldt'
alias clip='gsed -z "$ s/\n$//" | pbcopy'
alias edit='cat > /tmp/_shell.txt; subl /tmp/_shell.txt'
alias cat='bat --theme=Nord --style=plain'
alias ipy='$HOME/ipython/venv/bin/python'
alias ipip='$HOME/ipython/venv/bin/pip'
alias ienv='source $HOME/ipython/venv/bin/activate'
alias mi='TERM=xterm-256color micro'
alias f='open'

export FZF_DEFAULT_OPTS="--prompt='search > ' --height 60% --layout=reverse --border --exact --sort"
export FZF_CTRL_T_COMMAND="command fd --hidden --no-ignore --ignore-case . /"
export FZF_ALT_C_COMMAND="command fd --hidden --no-ignore --ignore-case -t d . /"

# Functions used as commands
bg() { nohup $@ > /dev/null 2>&1 & disown }
sxiv () { if [[ $# -eq '0' ]]; then bg /usr/bin/sxiv -t -a .; elif [[ -d $1 ]]; then bg /usr/bin/sxiv -t -a $1; else bg /usr/bin/sxiv -a $@; fi; }
fd() { eval subl --command \'sbs_compare_files {\"A\":\"$(realpath $1)\", \"B\":\"$(realpath $2)\"}\'; }
cpcat() { cat $1 | pbcopy }
cppsh() { pbpaste > $1; }
cpth() { greadlink -f $1 | xargs echo -n | pbcopy }
ws() { rg -n $@ --ignore-case --color=auto; }
wss() { sudo rg -n $@ --ignore-case --color=auto; }
ymp3() { $HOME/ipython/venv/bin/youtube-dl --extract-audio --audio-format mp3 $1; }
yvid() { $HOME/ipython/venv/bin/youtube-dl $1; }
venv() { if [[ "$VIRTUAL_ENV" == "" ]]; then source venv/bin/activate; else deactivate; fi; }
log() { echo "$1" && notify-send "$1"; }
ts() { ct=$(date +"%Y%m%d_%H%M%S"); cp $1 $1.$ct }
npw() { pass show cg/network --clip }

# Other functions
tmux-init() {
    if [ -z "$TMUX" ] && [ ! -z "$DISPLAY" ];
    then
        echo "---- TMUX Startup ----\n[w]orkshell\n[h]omeshell\n[s]erveshell"
        vared -p '' -c shell
        if [[ ${shell:l} == "h" ]]; then
            $HOME/dotfiles/shared/tmux/tmux.startup.home;
        elif [[ ${shell:l} == "w" ]]; then
            $HOME/dotfiles/shared/tmux/tmux.startup.shell;
        elif [[ ${shell:l} == "s" ]]; then
            $HOME/dotfiles/shared/tmux/tmux.startup.serve;
        else
            tmux new-session -d -s $shell;
            tmux attach -t $shell;
        fi;
    fi;
}

# ZLE functions
go-back() {
    cd ..; echo "";
    zle reset-prompt;
}; zle -N go-back

list-dir() {
    text="$BUFFER"
    dir=$(awk '{print $NF}' <<< $text)
    if [ -d "$dir" ]; then
        (cd $dir && echo "" && ls -lFh --color=auto --group-directories-first;)
    else
        echo ""; ls -lFh --color=auto --group-directories-first;
    fi;
    zle reset-prompt;
}; zle -N list-dir

home-dir() {
    LBUFFER="$LBUFFER~/"
    zle reset-prompt;
}; zle -N home-dir

copy-text() {
    text="$BUFFER"
    BUFFER=""
    zle reset-prompt
    echo -n $text | pbcopy
    notify-send "ZSH copy:" $text
}; zle -N copy-text

fzf-pass() {
    # https://github.com/ficoos/pass-fzf
    PASSWORD_STORE_ENABLE_EXTENSIONS=true pass fzf
    zle reset-prompt
}; zle -N fzf-pass

reset-term() {
    source ~/dotfiles/$PLATFORM/zsh/zshrc.zsh
    tmux source ~/dotfiles/shared/tmux/tmux.conf
    zle reset-prompt
    notify-send "Reset prompt"
}; zle -N reset-term

doc-project-list() {
    # Do not throw error if one element of {md,py,sql} expression does not exist
    setopt -s nullglob
    project_home="$HOME/documents"
    for directory in $(ls $project_home); do
        if [ -f $project_home/$directory/*{md,py,sql,sh}.md ]; then
            echo $directory;
        fi;
    done;
}

dinit() {
    find_name() {
        n=$(ls -rt $1 | grep item | tail -n 1 | sed -e s/item// -e s/\.md//)
        n=$((n+1))
        FILE_NAME="$1/item$n.md"
    }

    project_home="$HOME/documents"
    if [ ! "$#" -eq 1 ]; then 
        project_name=$(doc-project-list | sort | fzf --no-sort)
        if [ -z $project_name ]; then
            return
        fi;
    else
        project_name=$1
    fi;

    if [ ! -d $project_home/$project_name ]; then
        echo "Creating directory $project_home/$project_name"
        mkdir -p $project_home/$project_name
    fi;

    find_name $project_home/$project_name
    if [ ! -f $FILE_NAME ]; then
        echo "Creating file: $FILE_NAME"
        echo "# <Insert ticket title>" > $FILE_NAME
        echo "https://trello.com/c/" >> $FILE_NAME
        subl $FILE_NAME
    fi;
}

doc-item-list() {
    setopt -s nullglob
    project_home="$HOME/documents"
    for directory in $(ls $project_home); do
        for file in $project_home/$directory/*{md,py,sql,sh}; do
            echo $file;
        done;
    done;
}

dlist() {
    file_path=$(doc-item-list | sort | fzf --no-sort --preview 'bat {}' | awk '{print $1}')
    if [ ! -z $file_path ]; then
        echo $file_path
        subl $file_path
    fi;        
}

# Docker functions
docker-rmi() {
    docker rmi $(docker images -q) --force
}

docker-rmc() {
    docker rm $(docker ps -a -q) --force
}

docker-rma() {
    docker-rmc;
    docker-rmi;
}

docker-extract() {
    docker_image="$1"
    docker create --name="tmp_" $docker_image

    dir="/tmp/_docker"
    mkdir $dir
    echo "Exporting docker image: $docker_image to: $dir"
    docker export tmp_ -o $dir/_.tar
    echo "Extracting to $dir"
    (cd $dir && extract _.tar)
    rm $dir/_.tar
}

# Kubernetes functions
ka() {
    kubectl apply -f $1
}

kall() {
    kubectl get all --all-namespaces   
}

kd() {
    kubectl get deployment.apps --all-namespaces
}

kp() {
    kubectl get pods --all-namespaces
}

kpi() {
    if [ "$#" -eq 2 ]; then
        kubectl describe pods -n $1 $2 && echo "\nkubectl logs:" && kubectl logs -n $1 $2
    else
        kubectl describe pods -n default $1 && echo "\nkubectl logs:" && kubectl logs -n default $1
    fi;
}

kpd() {
    if [ "$#" -eq 2 ]; then
        kubectl delete pods -n $1 $2
    else
        kubectl delete pods -n default $1
    fi;
}

kde() {
    if [ "$#" -eq 2 ]; then
        kubectl edit deployments.apps -n $1 $2
    else
        kubectl edit deployments.apps -n default $1
    fi;
}

kdd() {
    if [ "$#" -eq 2 ]; then
        kubectl delete deployments.apps -n $1 $2
    else
        kubectl delete deployments.apps -n default $1
    fi;
}

kpb() {
    if [ "$#" -eq 2 ]; then
        kubectl exec -n $1 -it $2 -- sh
    else
        kubectl exec -n default -it $1 -- sh
    fi;
}

# Git functions
gg () { git add .; git commit -m "automated commit message"; git push; }
ga () { if [[ $1 == "" ]]; then git add .;  else git add $@; fi }
gp () { git push }
gf () { git pull }
gs () { git status }
gss () { git status --short }
gr () { git checkout $1 }
grh () { git reset --hard origin/$(git branch | awk '{print $NF}') }
gh () { smerge log $1 }
gc () { git commit -m "$1" }
gd () { git diff $1; }
gb () { 
    local branch=$(git branch -a | grep -v HEAD | fzf --prompt='checkout-branch > ' | awk '{print $NF}';)
    if [[ $branch == *"remotes/origin"* ]]; then git checkout -t $branch; else git checkout $branch; fi;  
}
gb-dead-list() {
    git branch -v | grep "\[gone\]" | awk '{print $1}'
}
gb-dead-del() {
    git branch -v | grep "\[gone\]" | awk '{print $1}' | xargs git branch -D
}

gdr() {
    if [ "$#" -ne 1 ]; then echo "Usage: gdr file.txt"; return 1; fi;
    remote_branch=$(git branch -r | grep -v HEAD | fzf --prompt='origin-branch > ' | xargs)
    local_path=/tmp/$(basename $remote_branch)-$(basename $1)
    git cat-file blob $remote_branch:$(git ls-files --full-name $1) > $local_path;
    readlink -f $1 | xargs echo -n | pbcopy;
    fd $1 $local_path;
    subl $1;
}

gsa() {
    echo "- Status notes"
    (cd $HOME/notes; gss;)
    echo "- Status dotfiles"
    (cd $HOME/dotfiles; gss;)
}

gpa() {
    echo "- Pushing notes"
    (cd $HOME/notes; if [[ $(git status --short) ]]; then gg; fi;)
    echo "- Pushing dotfiles"
    (cd $HOME/dotfiles; if [[ $(git status --short) ]]; then gg; fi;)
}

gfa() {
    echo "- Syncing notes"
    (cd $HOME/notes; gf;)
    echo "- Syncing dotfiles"
    (cd $HOME/dotfiles; gf;)
}

# Utility functions
start-wifi() {
    # wlp3s0 enp0s31f6 - home
    # wlp58s0 enp0s31f6 - work
    rm /tmp/create_ap.all.lock; sudo create_ap $1 $2 Pi jankowifi7
}

weather() {
    curl wttr.in/$1
}

rtfm() {
    tldr $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; 
}

upload() {
    RESPONSE=$(curl -s https://apiv2.gofile.io/getServer)
    SERVER_STATUS=$(jq -r .status <<< $RESPONSE)
    if [ $SERVER_STATUS = "ok" ]; then
        SERVER=$(jq -r .data.server <<< $RESPONSE)
        FILE_ID=$(jq -r .data.code <<< $(curl -s -F file=@"$1" https://$SERVER.gofile.io/uploadFile))
        URL="https://gofile.io/d/$FILE_ID"
        pbcopy <<< $URL
        notify-send "Uploaded file $1 to $URL"
    else
        echo "Failed to find server in $RESPONSE. See https://gofile.io/api"
    fi
}

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *.7z)             7zr e $1          ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

short-url() {
    urlencode() {
      lpython -c 'import urllib, sys; print(urllib.quote(sys.argv[1], sys.argv[2]))' "$1" "$urlencode_safe"
    }

    encoded=$(urlencode "$1")
    local url=$(curl --silent "https://is.gd/create.php?format=simple&url=$encoded")
    pbcopy <<< $url
    echo $url
}

port-list() {
    local v=$(sudo lsof -i -P -n)
    echo $v | fzf
}

pid-list() {
    local v=$(sudo ps -aux)
    echo $v | fzf
}

path-list() {
    echo $PATH | sed s/:/\\n/g | sort
}

str-format() {
    x=$(awk '{print tolower($0)}' <<< $1)
    x=$(sed s#/##g <<< $x)
    x=$(sed s/-/\ /g <<< $x)
    x=$(sed s/\ /-/g <<< $x)
    x=$(sed s/,//g <<< $x)
    echo $x
}

notify-send() {
    osascript -e "display notification \"$2\" with title \"$1\""
}

aws-login() {
    profiles=$(for profile id (
      igt-data-sdev 083093769399
      igt-data-ndev 238033857216
      igt-data-prod 732054177457
      volta-sdev 930213607358
      volta-sqa 708349838311
      volta-gamma 669720549060
    ) echo "$profile ($id)")
    
    selection=$(echo $profiles | fzf)
    aws_profile=$(cut -d ' ' -f 1 <<< $selection)
    aws_id=$(cut -d ' ' -f 2 <<< $selection | sed s/\(//g | sed s/\)//g)

    AWS_PROFILE=$aws_profile aws sts get-caller-identity &> /dev/null
    if [ $? -ne 0 ]; then
        gimme-aws-creds --profile $aws_profile
    fi
    
    echo "Switching to $aws_profile ($aws_id) AWS account"
    export AWS_PROFILE=$aws_profile
    aws sts get-caller-identity
}

print-parquet() {
    local_file="/tmp/_.parquet"
    
    s3_folder=$(sed 's/\/*$//' <<< $1)
    s3_file=$(aws s3 ls $s3_folder/ | awk '{print $NF}' | head -n 1)

    aws s3 cp $s3_folder/$s3_file $local_file

    parquet-tools rowcount $local_file
    echo ""
    parquet-tools meta $local_file
    echo ""
    parquet-tools cat --json $local_file | head -n 5
}

dl-parquet() {
    local_file="/tmp/a.parquet"
    
    s3_folder=$(sed 's/\/*$//' <<< $1)
    s3_file=$(aws s3 ls $s3_folder/ | awk '{print $NF}' | head -n 1)

    aws s3 cp $s3_folder/$s3_file $local_file
}

restart-karabiner() {
    launchctl stop org.pqrs.karabiner.karabiner_console_user_server && launchctl start org.pqrs.karabiner.karabiner_console_user_server
}

spark-start() {
    export SPARK_HOME="$HOME/spark/spark-3.0.3-bin-hadoop2.7"
    export PYSPARK_PYTHON="$HOME/ipython/venv/bin/python3"
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
    export PATH=$SPARK_HOME/bin/:$PATH
    pyspark
}