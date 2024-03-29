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

alias a='ansible'
alias ah='ansible-doc --list | awk "{print \$1}" | fzf-tmux -p --preview "ansible-doc {1}" --preview-window=right:70% | xargs ansible-doc'
alias ap='ansible-playbook'
alias apl='ansible-playbook --limit localhost'

alias c='clear'

alias clipqr='xclip -o | qrencode -t utf8'

alias common='grep -xf'

alias desktop='s desktop'

alias dbr='eval "$(devbox global shellenv --recompute)"'

function dr() {

    if [[ $# -gt 0 ]]; then
        docker restart $@
    else
        SELECTED=$(docker ps -a --format {{.Names}} | fzf-tmux -p --prompt=" > ")
        [[ -z $SELECTED ]] || docker restart $SELECTED
        unset SELECTED
    fi
}

alias dc="docker compose"
alias dcb="docker compose build"
alias dcd="docker compose down"
alias dce="docker compose exec"
alias dck="docker compose kill"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dcps="docker compose ps"
alias dcpull="docker compose pull"
alias dcr="docker compose run"
alias dcrs="docker compose restart"
alias dcrm="docker compose rm"
alias dcstart="docker compose start"
alias dcstop="docker compose stop"
alias dcu="docker compose up -d"
alias dcub="docker compose up --build"
alias dcudb="docker compose up -d --build"
alias dcupdate="docker compose down && docker compose pull && docker compose up -d"

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
    if [[ -n $1 ]]; then
        git push origin HEAD:refs/for/$1
    else
        git push origin HEAD:refs/for/master
    fi
}
alias gif='git update-index --assume-unchanged'
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
    (
        cd $PROJECT_DIR
        GH_FORCE_TTY=100% gh repo list | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh repo view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh repo clone
    )
}

function ghpr() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function ghprm() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
    gsw -
    gm -
}

alias internet-connection='ping -c 1 8.8.8.8 &> /dev/null'

function lab() {
    cd ~/Git/ansible/lab
    ansible-galaxy install -f -r requirements.yml > /dev/null
    if vault-keyring-client &> /dev/null; then
        ansible-playbook main.yml --vault-id $HOME/.local/bin/vault-keyring-client $@
    else
        ansible-playbook main.yml --ask-vault-pass $@
    fi
}

alias l='ls -h --color'
alias la='ls -lAh --color'
alias ll='ls -lh --color'
alias ls='ls --color'
alias lsa='ls -lah --color'

alias lzd='[[ -n $TMUX ]] && tmux display-popup -w 90% -h 80% -E lazydocker || lazydocker'

function lg() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        [[ -n $TMUX ]] && tmux display-popup -w 90% -h 80% -E "cd $(pwd); lazygit" || lazygit
    else
        (
            cd ~
            [[ -n $TMUX ]] && tmux display-popup -w 90% -h 80% -E yadm enter lazygit || yadm enter lazygit
        )
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
    curl -d "$@" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null
}

function npa() {
    ARGS="$@"
    eval $@ \
        && curl -d "$ARGS finished successfully" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null \
        || curl -d "$ARGS failed" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null
}

alias pls='sudo $(fc -ln -1)'

function pw() {
    rbw get $1 $2 | clip.exe
}

alias rd="rm -rf"

function replace() {
    if ! command -v rg > /dev/null; then
        echo "rg not found"
        return
    fi
    if [ $# -lt 2 ]
    then
        echo "Recursive, interactive text replacement"
        echo "Usage: replace text replacement"
        return
    fi

    nvim -c ":execute ':argdo %s/$1/$2/gc | update' | :q" $(rg "$1" -l)
}

function remove-whitespace() {
    rg '\s+$' -l | xargs sed -i 's/\s\+$//g'
}

function s() {
    if [[ -n $TMUX ]]; then
        TMUX_PID="$(tmux display -p "#{pane_pid}")"
        touch /tmp/tmux-"$TMUX_PID"
        hide-tmux-statusbar &
        STATUSBAR_PID=$!
        tmux set prefix C-h
        tmux bind C-h send-prefix
    fi

    if [[ $# -gt 0 ]]; then
        ssh $@
    else
        SELECTED=$((grep "Host " ~/.ssh/config | awk '{print $2}'; command -v tailscale > /dev/null && tailscale status | grep -v '^#' | awk '{print $2}') | sort | uniq | awk 'NF' | fzf-tmux -p --prompt=" > ")
        [[ -z $SELECTED ]] || ssh $SELECTED
        unset SELECTED
    fi

    if [[ -n $TMUX ]]; then
        tmux bind C-Space send-prefix
        tmux set prefix C-Space
        kill $STATUSBAR_PID
        tmux set status on
        rm /tmp/tmux-"$TMUX_PID"
    fi
}

alias server='s server'

alias steamdeck='s steamdeck'

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

function tu() {
    if [[ "$(uname -r)" == *"WSL"* ]]; then
        TS_COMMAND="tailscale.exe"
        TS_FLAGS="up --accept-routes --authkey $VPN_KEY"
    else
        TS_COMMAND="tailscale"
        TS_FLAGS="up --ssh --accept-routes --operator=$(whoami) --authkey $VPN_KEY"
    fi

    if [[ $(uname -n) == "steamdeck" ]]; then
        TS_FLAGS+=" --advertise-tags=tag:client,tag:server"
    elif [[ $(yadm config --get-all local.class) == *"work"* ]]; then
        TS_FLAGS+=" --advertise-tags=tag:work"
    elif [[ $(yadm config --get-all local.class) == *"server"* ]]; then
        TS_FLAGS+=" --advertise-tags=tag:server"
    else
        TS_FLAGS+=" --advertise-tags=tag:client"
    fi

    if [[ "$(uname -r)" == *"WSL"* ]]; then
        TS_FLAGS+=" --unattended"
    fi

    if [[ $(yadm config --get-all local.class) == *"dns"* ]]; then
        TS_FLAGS+=" --accept-dns=false"
    fi

    echo "$TS_COMMAND $TS_FLAGS $@"
    eval "$TS_COMMAND $TS_FLAGS $@"

    echo "$TS_COMMAND set --auto-update"
    eval "$TS_COMMAND set --auto-update"
}

alias v="nvim"
alias vm='s alma'

alias work='s alma'

alias x='[[ -z $TMUX ]] && exit 0 || [[ $(tmux list-panes | wc -l) -gt 1 || $(tmux list-windows | wc -l) -gt 1 ]] && exit 0 || tmux detach'
alias xc='[[ -z $TMUX ]] && exit 0 || [[ $(tmux list-panes | wc -l) -gt 1 || $(tmux list-windows | wc -l) -gt 1 ]] && exit 0 || (tmux detach && clear)'

alias ya="yadm add"
alias yalt="yadm alt"
alias yau="yadm add -u"
alias yb='yadm bootstrap'
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

alias winget='winget.exe'
alias wsls='wsl.exe --shutdown'

alias z="zellij"
