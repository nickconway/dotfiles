export PATH=~/.cargo/bin/:~/.emacs.d/bin/:~/.config/emacs/bin:~/.local/bin:~/bin:~/.config/bin:"$PATH":/usr/lib/node_modules:/usr/local/lib/node_modules
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:~/.local/neovim/bin:~/.local/tmux/bin
export PATH=$PATH:$HOME/.local/podman/bin:$HOME/.local/go/bin:/home/linuxbrew/.linuxbrew/bin

plugins=(git vi-mode gpg-agent keychain npm zsh-autosuggestions zsh-syntax-highlighting)

eval `keychain -q --nogui --eval $(find $HOME/.ssh/ -name "id*" -not -path "*.pub")`

if [[ -n $FD_COMMAND ]]; then
    for f in $($FD_COMMAND .zshrc ~ -H -d 1 -E ".zshrc" -E "*##*"); do
        source $f
    done
fi

command -v starship > /dev/null && eval "$(starship init zsh)"

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias td='tmux detach'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias tmuxconf'$EDITOR ~/.tmux.conf'

alias ys="yadm status"
alias ya="yadm add"
alias yau="yadm add -u"
alias yc="yadm commit"
alias yca="yadm commit -a"
alias ycam="yadm commit -a -m"
function yp() {
    if [[ $# -eq 0 ]]; then
        ycam "Update config"
        yadm push
    else
        ycam $@; yadm push
    fi
}
alias yl="yadm pull"
alias yd="yadm diff"
alias yenc="yadm encrypt"
alias ydec="yadm decrypt"
alias yu="yadm upgrade"
alias sysyadm="yadm --yadm-dir /etc/yadm --yadm-data /etc/yadm/data"
function sy() {
    sudo chown -R $USER /etc/yadm
    case "$1" in
        ("") sudo -E $(alias sysyadm | cut -d\' -f2) status;;
        (i) sysyadm clone -w / https://github.com/nickconway/dotfiles -f --single-branch --branch sys; sysyadm remote set-url origin git@github.com:nickconway/dotfiles.git;;
        (p) sysyadm push;;
        (l) sysyadm pull;;
        (*) sudo -E $(alias sysyadm | cut -d\' -f2) "$@";;
    esac
}

alias lzd="lazydocker"

alias clipqr="xclip -o | qrencode -t utf8"

alias e="emacsclient -cna ''"
alias n="nvim"
alias v="n"

alias c="clear"

alias tldrf="tldr --list | fzf-tmux -p --preview 'tldr {1} --color=always' --preview-window=right:70% | xargs tldr --color=always"

function x(){
    if [[ -z $TMUX ]]; then
        exit
    else
        tmux detach
        clear
    fi
}

function pw() {
    rbw get $1 $2 | clip.exe
}

function ghpr() {
    GH_FORCE_TTY=100% gh pr list -L 1000 | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function ghc() {
    cd ~/git
    GH_FORCE_TTY=100% gh repo list | fzf-tmux -p --ansi --preview 'GH_FORCE_TTY=100% gh repo view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh repo clone 
    cd -
}

function lg() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        lazygit
    else
        cd ~
        yadm enter lazygit
        cd - &> /dev/null
    fi;
}

function s() {
    hide-tmux-statusbar &
    pid=$!
    tmux set prefix C-h
    tmux bind C-h send-prefix
    ssh -t $@ "SSH_HOSTNAME=$(hostname) '$SHELL' -l"
    tmux bind C-Space send-prefix
    tmux set prefix C-Space
    kill $pid
    tmux set status on
    clear
}

function svm() {
    s $@ -L 127.0.0.1:4200:127.0.0.1:4200 -L 127.0.0.1:9443:127.0.0.1:9443 nconway@192.168.220.130
}

make-svelte() {
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

replace () {
    if [ $# -lt 2 ]
    then
        echo "Recursive, interactive text replacement"
        echo "Usage: replace text replacement"
        return
    fi

    vim -u NONE -c ":execute ':argdo %s/$1/$2/gc | update' | :q" $(ag $1 -l)
}

toggleproxy() {
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

export NO_AT_BRIDGE=1

export VISUAL=nvim
export EDITOR=nvim

if [[ -n $KODIR ]]; then
    export PROJECT_DIR=$KODIR
else
    export PROJECT_DIR=~/git
fi

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export DROPBOX=/c/Users/nickc/Dropbox/

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp/

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm

command -v zoxide > /dev/null && eval "$(zoxide init zsh --cmd cd)"

export FZF_DEFAULT_OPTS="--color=gutter:-1"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_TMUX_OPTS="-p --reverse"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        tmux new -As main
        # zellij a -c main
    elif [[ $SSH_HOSTNAME != "" ]] && [[ -n SSH_HOSTNAME ]]; then
        tmux new -As ssh-$SSH_HOSTNAME; exit
        # zellij a -c ssh-$SSH_HOSTNAME; exit
    else
        # zellij a -c ssh; exit
        tmux new -As ssh; exit
    fi
fi

[[ -e /home/linuxbrew/.linuxbrew ]] && eval $($(brew --prefix)/bin/brew shellenv)
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
