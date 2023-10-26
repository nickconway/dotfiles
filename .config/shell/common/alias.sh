SHELL_NAME="$(basename "$(ps -p $$ | awk 'NR==2 {print $4}')")"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias c='clear'

alias clipqr='xclip -o | qrencode -t utf8'

alias e="emacsclient -cna ''"

alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gcam='git commit --all --message'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='git diff --staged'
function ggp() {
    git push origin HEAD:refs/for/$(git rev-parse --abbrev-ref HEAD)
}
alias glgg='git log --graph'
alias gm='git merge'
alias gms='git merge --squash'
alias gl='git pull'
alias gp='git push'
alias gr='git remote'
alias grh='git reset --hard'
alias gst='git status'
alias gsw='git switch'

function ghc() {
    mkdir -p $PROJECT_DIR
    cd $PROJECT_DIR
    GH_FORCE_TTY=100% gh repo list | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh repo view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh repo clone 
    cd -
}

function ghpr() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

# List directory contents
alias l='ls -h --color'
alias la='ls -lAh --color'
alias ll='ls -lh --color'
alias ls='ls --color'
alias lsa='ls -lah --color'

alias lzd='lazydocker'

function lg() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        lazygit
    else
        cd ~
        yadm enter lazygit
        cd - &> /dev/null
    fi;
}

function make-svelte() {
    selected_name=$(basename "$1")
    session_name=$(basename "$1" | tr . _)
    dir=$PWD

    cd $PROJECT_DIR
    npm create svelte@latest $1
    cd $1
    npm install
    git init && git add -A && git commit -m "Initial commit"

    TMUXP_START_DIR=$selected TMUXP_SESSION_NAME=$session_name tmuxp load ~/.config/tmuxp/svelte-kit.yaml -y > /dev/null
    cd $dir
}

alias md='mkdir -p'
function mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

alias n="nvim"

function np() {
    ntfy publish -u $@
}

function npa() {
    $@ && ntfy publish notifications "$@ is finished" > /dev/null 2>&1 || ntfy publish notifications "$@ failed" > /dev/null 2>&1
}

function pw() {
    rbw get $1 $2 | clip.exe
}

alias rd="rm -rf"

function replace () {
    if [ $# -lt 2 ]
    then
        echo "Recursive, interactive text replacement"
        echo "Usage: replace text replacement"
        return
    fi

    vim -u NONE -c ":execute ':argdo %s/$1/$2/gc | update' | :q" $(ag $1 -l)
}

function s() {
    if [[ -n $TMUX ]]; then
        touch /tmp/tmux-$(tmux display -p "#S-#P")
        hide-tmux-statusbar &
        pid=$!
        tmux set prefix C-h
        tmux bind C-h send-prefix
    fi
    ssh -t $@ SSH_HOSTNAME=$(hostname) '$SHELL' -l
    if [[ -n $TMUX ]]; then
        tmux bind C-Space send-prefix
        tmux set prefix C-Space
        kill $pid
        tmux set status on
        rm /tmp/tmux-$(tmux display -p "#S-#P")
        clear
    fi
}

function svm() {
    s $@ -L 127.0.0.1:4200:127.0.0.1:4200 -L 127.0.0.1:9443:127.0.0.1:9443 nconway@192.168.220.130
}

alias tldrf="tldr --list | fzf-tmux -p --preview 'tldr {1} --color=always' --preview-window=right:70% | xargs tldr --color=always"

function toggleproxy() {
    test -z $http_proxy && {
        echo "Enabling proxy ✅"
        for i in http_proxy https_proxy HTTP_PROXY HTTPS_PROXY; do
                export $i=$PROXY
        done
    } || {
        echo "Disabling proxy ❌"
        unset http{,s}_proxy HTTP{,S}_PROXY
    }
}

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias td='tmux detach'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias tmuxconf='$EDITOR ~/.tmux.conf'

alias v="nvim"

alias x='tmux detach && clear || exit'

alias ya="yadm add"
alias yalt="yadm alt"
alias yau="yadm add -u"
alias yc="yadm commit"
alias yca="yadm commit -a"
alias ycam="yadm commit -a -m"
alias yd="yadm diff"
alias ydec="yadm decrypt"
alias yenc="yadm encrypt"
alias yl="yadm pull"
function yp() {
    if [[ $# -eq 0 ]]; then
        ycam "Update config"
        yadm push
    else
        ycam $@; yadm push
    fi
}
alias yrh="yadm reset --hard"
alias ys="yadm status"
alias yu="yadm upgrade"

alias sysyadm='sudo GPG_TTY=$GPG_TTY SSH_AUTH_SOCK=$SSH_AUTH_SOCK PATH=$PATH $(which yadm) --yadm-dir /etc/yadm --yadm-data /etc/yadm/data'
alias sya='sysyadm add'
alias syalt='sysyadm alt'
alias sycam='sysyadm commit -am'
alias syd='sysyadm diff'
alias sydec="sysyadm decrypt"
alias syenc="sysyadm encrypt"
alias syi='sysyadm clone -w / https://github.com/nickconway/dotfiles --single-branch --branch sys; sysyadm remote set-url origin git@github.com:nickconway/dotfiles.git'
alias syl='sysyadm pull'
function syp() {
    if [[ $# -eq 0 ]]; then
        sycam "Update config"
        sysyadm push
    else
        sycam $@; sysyadm push
    fi
}
alias sys='sysyadm status'

alias z="zellij"
