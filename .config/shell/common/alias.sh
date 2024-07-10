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

alias bat='bat --style=plain'

alias c='clear'
alias cat='bat --style=plain'

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
alias dcupdate="docker compose up -d --pull=always"

function fn() {
    SELECTED=("${(@f)$(fzf-tmux -m -p --preview="bat --color=always --style=plain {}")}")
    [[ -n "$SELECTED" ]] && $EDITOR "${SELECTED[@]}"
    unset SELECTED
}

alias g='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -av'
alias gcam='git commit -a -m'
alias gce='git commit -e'
alias gce='git commit -m'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout'
alias gcom='git checkout main && git pull origin main'
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
alias gl='git pull'
alias glog='git log --graph --pretty=format:'\''%Cred%h%Creset %Cblue(%an) %Cred-%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias gm='git merge'
alias gmm='git merge main'
alias gms='git merge --squash'
alias gp='git push'
alias gr='git remote'
alias gre='git reset'
alias grh='git reset --hard'
alias gru='git remote update'
alias gs='git stash'
alias gsa='git stash --all'
alias gsu='git stash --include-untracked'
function gsp() {
    if ! git rev-parse --is-inside-work-tree &> /dev/null; then
        return
    fi

    if [[ -z "$@" ]]; then
        if [[ "$(git stash list | wc -l)" == "1" ]]; then
            git stash pop
        else
            git stash pop "$(git stash list | fzf-tmux -p --preview 'git stash show --color -p $(echo {1} | tr -d :) | delta' | awk '{print $1}' | tr -d :)"
        fi
    else
        git stash pop $@
    fi
}
function gsw() {
    if [[ -z "$@" ]] || [[ "$@" == "-" ]]; then
        git switch -
    else
        git show-branch $@ &>/dev/null && git switch $@ || git switch -c $@
    fi
}

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

function gpge() {
    gpg --export --armor "$@" > ~/.config/gpg/"$@".pub.asc
    gpg --export-secret-keys --armor "$@" > ~/.config/gpg/"$@".priv.asc
    gpg --export-secret-subkeys --armor "$@" > ~/.config/gpg/"$@".sub-priv.asc
    gpg --export-ownertrust > ~/.config/gpg/"$@".trust
}

alias internet-connection='ping -c 1 8.8.8.8 &> /dev/null'

alias l='ls'
alias la='ls -lA'
alias ll='ls -l'
function ls() {
    if command -v eza &> /dev/null; then
        eza --icons=always --color $@
    else
        command ls -h --color $@
    fi
}

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

alias n='nvim'
alias notes='(cd ~/Documents/Notes; n)'

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

alias r='rip'
alias rg='rg --hidden'

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
    if [[ $# -gt 0 ]]; then
        SELECTED=$@
    else
        SSH_HOSTS=$(grep "Host " ~/.ssh/config | awk '{print $2}')
        TAILSCALE_HOSTS="$(command -v tailscale > /dev/null && tailscale status | grep -v '^#' | awk '{print $2}')"
        TAILSCALE_WSL_HOSTS="$(command -v tailscale.exe > /dev/null && tailscale.exe status | grep -v '^#' | awk '{print $2}')"
        SELECTED=$((echo "$SSH_HOSTS"; echo "$TAILSCALE_HOSTS"; echo "$TAILSCALE_WSL_HOSTS") | sort | uniq | awk NF | fzf-tmux -p --prompt=" > ")
    fi

    if [[ -n $TMUX ]]; then
        PANE_PID="$(tmux display -p '#{pane_pid}')"
        S_FILE="/tmp/tmux-$PANE_PID"
        (&>/dev/null hide-tmux-statusbar $PANE_PID & echo $! > $S_FILE)
        tmux set prefix C-h
        tmux bind C-h send-prefix
    fi

    [[ -z $SELECTED ]] || ssh $(echo $SELECTED)

    if [[ -n $TMUX ]]; then
        if ps -p "$(cat $S_FILE)" &> /dev/null; then
            kill "$(cat $S_FILE)"
        fi
        tmux set status on
        tmux bind C-Space send-prefix
        tmux set prefix C-Space
        rm "$S_FILE"
    fi

    [[ -z $SELECTED ]] && return 1
    unset SELECTED
    unset S_FILE
}

alias server='s server'

alias steamdeck='s steamdeck'

function sci() {
    if [[ -e ~/.ssh/id_ed25519 ]]; then
        PUB_KEY="$(cat ~/.ssh/id_ed25519.pub)"
        ssh $@ "grep \"$PUB_KEY\" ~/.ssh/authorized_keys -q || echo \"$PUB_KEY\" >> ~/.ssh/authorized_keys"
    fi
}

function sudo(){
    command sudo -E $(which $1 | cut -d ' ' -f 4-) ${@:2}
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

alias v='nvim'
alias venv='. ~/.venvs/$(ls --color=never ~/.venvs | fzf-tmux -p)/bin/activate'
alias vm='s alma'

alias work='s alma'

function x(){
    if command -v termux-reload-settings > /dev/null; then
        exit 0
    elif [[ -z $TMUX ]]; then
        exit 0
    else
        if [[ $(tmux list-panes | wc -l) -gt 1 || $(tmux list-windows | wc -l) -gt 1 ]]; then
            exit 0
        else
            tmux detach
        fi
    fi
}
alias xc='x && clear'

alias ya="yadm add"
alias yalt="yadm alt"
alias yau="yadm add -u"
alias yb='yadm bootstrap'
alias yc="yadm commit"
alias yca="yadm commit -av"
alias ycam="yadm commit -a -m"
alias ycl="yadm config --get-all local.class"
alias ycla="yadm config --add local.class"
alias yclu="yadm config --unset-all local.class"
alias yconfig='yadm gitconfig user.name $GIT_NAME && yadm gitconfig user.email $GIT_EMAIL && yadm gitconfig user.signingkey $GIT_GPG_KEY'
alias yd="yadm diff"
alias ydec="yadm decrypt"
alias ye="(cd; n)"
alias yenc="yadm encrypt"
function yl(){
    YADM_ARCHIVE_BEFORE="$(sha1sum ~/.local/share/yadm/archive)"
    SHELL_FILES_BEFORE="$(sha1sum ~/.config/shell/*/*)"
    ALT_FILES_BEFORE="$(sha1sum $(command -v fd && fd -H '##' ~/.config || find ~/.config -name '*##*'))"
    RESULT="$(yadm pull $@)"
    echo "$RESULT"
    [[ "$RESULT" == "Already up to date." ]] && return

    YADM_ARCHIVE_AFTER="$(sha1sum ~/.local/share/yadm/archive)"
    if [[ $YADM_ARCHIVE_BEFORE != $YADM_ARCHIVE_AFTER ]]; then
        ydec
    fi

    ALT_FILES_AFTER="$(sha1sum $(command -v fd && fd -H '##' ~/.config || find ~/.config -name '*##*'))"
    if [[ $ALT_FILES_BEFORE != $ALT_FILES_AFTER ]]; then
        yalt
    fi

    SHELL_FILES_AFTER="$(sha1sum ~/.config/shell/*/*)"
    if [[ $SHELL_FILES_BEFORE != $SHELL_FILES_AFTER ]]; then
        exec $SHELL_NAME
    fi
}
function yp() {
    if yadm status --porcelain | grep "^M"; then
        yadm commit -m "Update config" || return
    elif [[ -n $(yadm status --porcelain) ]]; then
        if [[ $# -eq 0 ]]; then
            yca || return
        else
            ycam $@ || return
        fi
    fi
    yadm push
}
alias yrh="yadm reset --hard"
alias ys="yadm status"
alias yu="yadm upgrade"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f "$tmp"
}

alias winget='winget.exe'
alias wsls='wsl.exe --shutdown'

alias z="zellij"

function dis() {
    $@ &> /dev/null & disown
}
