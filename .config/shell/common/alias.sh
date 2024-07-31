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
alias ah='ansible-doc --list | awk "{print \$1}" | fzft --preview "ansible-doc {1}" --preview-window=right:70% | xargs ansible-doc'
alias ap='ansible-playbook'
alias apl='ansible-playbook --limit localhost'
alias av='ansible-vault'

function atuin-fix() {
    atuin store purge
    atuin store verify
    atuin store push --force
    atuin store pull --force
    atuin store rebuild history
    atuin sync
}

alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'

alias atuin-login='atuin login -u "$ATUIN_USER" -p "$ATUIN_PASSWORD" -k "$ATUIN_KEY"'

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
        SELECTED=$(docker ps -a --format {{.Names}} | fzft --prompt=" > ")
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

alias er='systemctl --user restart pipewire pipewire-pulse && flatpak kill com.github.wwmm.easyeffects && flatpak run com.github.wwmm.easyeffects --gapplication-service &> /dev/null &!'

function fn() {
    SELECTED="$(fzft --preview="bat --color=always --style=plain {}")"
    [[ -n "$SELECTED" ]] && echo "$SELECTED" | xargs -d '\n' $EDITOR
    unset SELECTED
}

alias g='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -av'
alias gcam='git commit -a -m'
alias gcamend='git commit --amend --no-edit'
alias gce='git commit -e'
alias gcm='git commit -m'
alias gcl='git clone --recurse-submodules'
function gco() {
    if [[ $# -gt 0 ]]; then
        git checkout "$1"
    else
        HASH=$(_fzf_git_stashes)
        [[ -n "$HASH" ]] && git checkout "$(_fzf_git_hashes)"
    fi
}
alias gcom='git checkout main && git pull origin main'
alias gcp='git cherry-pick'
alias gd='git diff HEAD'
alias gds='git diff --staged HEAD'
function ggp() {
    if [[ -n $1 ]]; then
        git push origin HEAD:refs/for/$1
    else
        git push origin HEAD:refs/for/master
    fi
}

function gi() {
    if [[ $# -eq 0 ]]; then
        GI_TYPE="$(curl -sfL https://www.toptal.com/developers/gitignore/api/list | tr "," "\n" \
            | fzft --preview="curl -sfLw '\n' https://www.toptal.com/developers/gitignore/api/{} | bat -l 'Git Ignore' --color=always --style=plain")"
    else
        GI_TYPE="$(echo $@ | sed "s/ /,/g")"
    fi
    [[ -n "$GI_TYPE" ]] && curl -sfLw '\n' https://www.toptal.com/developers/gitignore/api/"$GI_TYPE" \
        | grep -v '# Created' | grep -v '# Edit at' | grep -v '# End of' \
        | sed '1{/^$/d}' | sed '1{/^$/d}' \
        | sed '${/^$/d}' | sed '${/^$/d}'
    unset GI_TYPE

}

GIT_LOG_FORMAT='%Cred%h -%C(auto)%d%Creset %s %C(bold)%Cgreen(%cd) %Cblue(%an)%Creset'
alias gif='git update-index --assume-unchanged'
alias gl='git pull'
alias glog='git log --graph --pretty=format:$GIT_LOG_FORMAT --abbrev-commit --date=short'
alias glogv='_fzf_git_hashes'
alias gm='git merge'
alias gmm='git merge main'
alias gms='git merge --squash'
alias gp='git push'
alias gr='git reset'
alias grb='git rebase'
alias gre='git remote'
alias grh='git reset --hard'
alias greu='git remote update'
alias gs='git stash'
alias gsa='git stash --all'
alias gsu='git stash --include-untracked'
function gsp() {
    if ! git rev-parse --is-inside-work-tree &> /dev/null; then
        return
    fi

    if [[ -z "$@" ]]; then
        if [[ "$(git stash list | wc -l)" == "0" ]]; then
            return
        elif [[ "$(git stash list | wc -l)" == "1" ]]; then
            git stash pop
        else
            STASH=$(_fzf_git_stashes)
            [[ -n "$STASH" ]] && git stash pop $STASH
        fi
    else
        git stash pop $@
    fi
}
function gsw() {
    if [[ "$@" == "-" ]]; then
        git switch -
    elif [[ -z "$@" ]]; then
        BRANCH=$(_fzf_git_all_branches)
        [[ -n "$BRANCH" ]] && git switch "$(echo "$BRANCH" | cut -d '/' -f 2-)"
    else
        git switch $@ 2>/dev/null || git switch -c $@
    fi
}

function gwt(){
    WORKTREE="$(_fzf_git_worktrees)"
    [[ -n "$WORKTREE" ]] && cd "$WORKTREE"
}

function gwta(){
    if [[ -z "${2:-}" ]]; then
        REF="$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')"
    elif [[ "${2:-}" == "-s" ]]; then
        REF="$(_fzf_git_all_refs)"
    else
        REF="$2"
    fi
    BRANCH="$(echo "$REF" | cut -d '/' -f 2-)"
    SUFFIX="$(echo "${1:-${BRANCH}}" | tr '/' '-')"
    WORKTREE_PATH="$(git worktree list | awk 'NR==1{print $1}')"+"$SUFFIX"
    [[ -n "$REF" ]] && git worktree add -b "$SUFFIX" "$WORKTREE_PATH" "$REF" && cd "$WORKTREE_PATH"
}

function ghc() {
    mkdir -p $PROJECT_DIR
    (
        cd $PROJECT_DIR
        GH_FORCE_TTY=100% gh repo list | fzft --ansi --preview 'GH_FORCE_TTY=100% gh repo view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh repo clone
    )
}

function ghpr() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzft --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function ghprm() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzft --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
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

function lazynvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh
}

function nvm() {
    lazynvm
    nvm $@
}

function node() {
    lazynvm
    node $@
}

function npm() {
    lazynvm
    npm $@
}

function npx() {
    lazynvm
    npx $@
}

alias md='mkdir -p'
function mkcd() {
    mkdir -p -- "$1" && cd "$1"
}

alias n='$EDITOR'
alias notes='(cd ~/Documents/Notes && n)'

function np() {
    curl -d "$@" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null
}

function npa() {
    ARGS="$@"
    eval $@ \
        && (curl -d "$ARGS finished successfully" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null; \
            command -v notify-send &> /dev/null && notify-send "$ARGS finished successfully") \
        || (curl -d "$ARGS failed" https://ntfy.conway.dev/notifications -H "Authorization: Bearer ${NTFY_TOKEN}" &> /dev/null; \
            command -v notify-send &> /dev/null && notify-send "$ARGS failed")
}

alias pls='sudo $(fc -ln -1)'

alias r='rip'
function rgn() {
    SELECTED=$(
        rm -f /tmp/rg-fzf-{r,f}
        RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden -g '!{**/node_modules/*,**/.github/*,**/.git/*}' "
        INITIAL_QUERY="${*:-}"
        fzft --ansi --disabled --query "$INITIAL_QUERY" \
            --bind "start:reload:$RG_PREFIX {q}" \
            --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
            --bind 'ctrl-r:transform:[[ ! $FZF_PROMPT =~ RG ]] &&
              echo "rebind(change)+change-prompt(RG > )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
              echo "unbind(change)+change-prompt(FZF > )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --prompt 'RG > ' \
            --delimiter : \
            --header 'CTRL-R: Switch between ripgrep/fzf' \
            --preview 'bat --color=always {1} --style=plain --highlight-line {2}' \
            --preview-window 'down,+{2}+3/3,~3'
    )

    [[ -z "$SELECTED" ]] && return

    COMMANDS=""
    while IFS= read -r line; do
        if [[ "$COMMANDS" == "" ]]; then
            COMMANDS+="$(echo $line | awk -F ':' '{printf "\"%s\" +%s", $1, $2}')"
        else
            COMMANDS+="$(echo $line | awk -F ':' '{printf " -c \"e %s | %s\"", $1, $2}')"
        fi
    done <<< "$SELECTED"

    eval "$EDITOR $COMMANDS -c first"
    unset SELECTED
}

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

    if rg "$1" -q
    then
        AUTOSESSION_ENABLED="no" nvim -c ":set nohlsearch | :execute ':argdo %s/$1/$2/gc | update' | :q" $(rg "$1" -l ${@:3})
    else
        echo Pattern not found
    fi
}

function remove-whitespace() {
    rg '\s+$' -l | xargs sed -i 's/\s\+$//g'
}

alias s='immersive-ssh'
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

alias tldrf="tldr --list | fzft --preview 'tldr {1} --color=always' --preview-window=right:70% | xargs tldr --color=always"

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
        TS_FLAGS="up --unattended --accept-routes=true --authkey $VPN_KEY"
    else
        TS_COMMAND="tailscale"
        TS_FLAGS="up --ssh --accept-routes=true --operator=$(whoami) --authkey $VPN_KEY"
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

    if [[ $(yadm config --get-all local.class) == *"dns"* ]]; then
        TS_FLAGS+=" --accept-dns=false"
    fi

    echo "$TS_COMMAND $TS_FLAGS $@"
    eval "$TS_COMMAND $TS_FLAGS $@"

    echo "$TS_COMMAND set --auto-update"
    eval "$TS_COMMAND set --auto-update"
}

alias v='$EDITOR'
alias venv='. ~/.venvs/$(ls --color=never ~/.venvs | fzft)/bin/activate'
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

alias y="yadm status"
alias ya="yadm add"
alias yalt="yadm alt"
alias yau="yadm add -u"
alias yb='yadm bootstrap'
alias yc="yadm commit -v"
alias yca="yadm commit -av"
alias ycam="yadm commit -a -m"
alias ycl="yadm config --get-all local.class"
alias ycla="yadm config --add local.class"
alias yclu="yadm config --unset-all local.class"
alias yconfig='yadm gitconfig user.name $GIT_NAME && yadm gitconfig user.email $GIT_EMAIL && yadm gitconfig user.signingkey $GIT_GPG_KEY'
alias yd="yadm diff HEAD"
alias yds="yadm diff --staged HEAD"
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
alias ylog='yadm log --graph --pretty=format:'\''%Cred%h%Creset %Cblue(%an) %Cred-%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative'
function yp() {
    if [[ $# -eq 0 ]]; then
        yca
    else
        ycam $@
    fi
    if [[ "$(yadm status -sb)" == *"ahead"* ]]; then
        yadm push
    fi
}
alias yrh="yadm reset --hard"
alias ys="yadm stash"
function ysp() {
    if [[ -z "$@" ]]; then
        if [[ "$(yadm stash list | wc -l)" == "1" ]]; then
            yadm stash pop
        else
            yadm stash pop "$(yadm stash list | fzft --preview 'yadm stash show --color -p $(echo {1} | tr -d :) | delta' | awk '{print $1}' | tr -d :)"
        fi
    else
        yadm stash pop $@
    fi
}
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

alias pacupg='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias paclean='sudo pacman -Sc'
alias pacins='sudo pacman -U'
alias paclr='sudo pacman -Scc'
alias pacre='sudo pacman -R'
alias pacrem='sudo pacman -Rns'
alias pacrep='pacman -Si'
alias pacreps='pacman -Ss'
alias pacloc='pacman -Qi'
alias paclocs='pacman -Qs'
alias pacinsd='sudo pacman -S --asdeps'
alias pacmir='sudo pacman -Syy'
alias paclsorphans='sudo pacman -Qdt'
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'
alias pacfileupg='sudo pacman -Fy'
alias pacfiles='pacman -F'
alias pacls='pacman -Ql'
alias pacown='pacman -Qo'
alias pacupd="sudo pacman -Sy"

function paclist() {
  pacman -Qqe | xargs -I{} -P0 --no-run-if-empty pacman -Qs --color=auto "^{}\$"
}

function pacdisowned() {
  local tmp_dir db fs
  tmp_dir=$(mktemp --directory)
  db=$tmp_dir/db
  fs=$tmp_dir/fs

  trap "rm -rf $tmp_dir" EXIT

  pacman -Qlq | sort -u > "$db"

  find /etc /usr ! -name lost+found \
    \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"

  rm -rf $tmp_dir
}

alias pacmanallkeys='sudo pacman-key --refresh-keys'

function pacmansignkeys() {
  local key
  for key in $@; do
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key $key
  done
}

if command -v xdg-open &> /dev/null; then
  function pacweb() {
    if [[ $# = 0 || "$1" =~ '--help|-h' ]]; then
      local underline_color="\e[${color[underline]}m"
      echo "$0 - open the website of an ArchLinux package"
      echo
      echo "Usage:"
      echo "    $bold_color$0$reset_color ${underline_color}target${reset_color}"
      return 1
    fi

    local pkg="$1"
    local infos="$(LANG=C pacman -Si "$pkg")"
    if [[ -z "$infos" ]]; then
      return
    fi
    local repo="$(grep -m 1 '^Repo' <<< "$infos" | grep -oP '[^ ]+$')"
    local arch="$(grep -m 1 '^Arch' <<< "$infos" | grep -oP '[^ ]+$')"
    xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
  }
fi

alias yaconf='yay -Pg'
alias yaclean='yay -Sc'
alias yaclr='yay -Scc'
alias yaupg='yay -Syu'
alias yasu='yay -Syu --noconfirm'
alias yain='yay -S'
alias yains='yay -U'
alias yare='yay -R'
alias yarem='yay -Rns'
alias yarep='yay -Si'
alias yareps='yay -Ss'
alias yaloc='yay -Qi'
alias yalocs='yay -Qs'
alias yalst='yay -Qe'
alias yaorph='yay -Qtd'
alias yainsd='yay -S --asdeps'
alias yamir='yay -Syy'
alias yaupd="yay -Sy"

function upgrade() {
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt upgrade -y
    elif command -v pacman &> /dev/null; then
        echo ":: Checking Arch Linux PGP Keyring..."
        local installedver="$(LANG= sudo pacman -Qi archlinux-keyring | grep -Po '(?<=Version         : ).*')"
        local currentver="$(LANG= sudo pacman -Si archlinux-keyring | grep -Po '(?<=Version         : ).*')"
        if [ $installedver != $currentver ]; then
            echo " Arch Linux PGP Keyring is out of date."
            echo " Updating before full system upgrade."
            sudo pacman -Sy --needed --noconfirm archlinux-keyring
        else
            echo " Arch Linux PGP Keyring is up to date."
            echo " Proceeding with full system upgrade."
        fi
        if command -v yay &> /dev/null; then
            yay -Syu --noconfirm --color=always
        elif command -v trizen &> /dev/null; then
            trizen -Syu
        elif command -v pacaur &> /dev/null; then
            pacaur -Syu
        elif command -v aura &> /dev/null; then
            sudo aura -Syu
        else
            sudo pacman -Syu --noconfirm
        fi
    fi
}

alias shell-debug='time DEBUGRC=1 '$SHELL_NAME' -i -c exit'
