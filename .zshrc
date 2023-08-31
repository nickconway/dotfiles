if [[ -z $TMUX ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        tmux new -As main
    else
        num=
        if tmux has-session -t ssh 2> /dev/null; then
            num=2
            while tmux has-session -t ssh"$num" 2> /dev/null
            do
                ((num=num+1))
            done
        fi
        tmux new -As ssh$num || tmux kill-session -t ssh$num; exit
    fi
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

export PATH=~/.cargo/bin/:~/.emacs.d/bin/:~/.config/emacs/bin:~/.local/bin:~/bin:~/.config/bin:"$PATH":/usr/lib/node_modules:/usr/local/lib/node_modules
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

plugins=(git vi-mode gpg-agent keychain npm zsh-autosuggestions zsh-syntax-highlighting)
zstyle :omz:plugins:keychain agents gpg,ssh
zstyle :omz:plugins:keychain identities $(find $HOME/.ssh/ -name "id_*" -not -path "*.pub")
zstyle :omz:plugins:keychain options -q --nogui

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ -n $FD_COMMAND ]]; then
    for f in $($FD_COMMAND .zshrc ~ -H -d 1 -E ".zshrc" -E "*##*"); do
        source $f
    done
fi

command -v starship > /dev/null && eval "$(starship init zsh)"

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
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
alias sysyadm="sudo yadm --yadm-dir /etc/yadm --yadm-data /etc/yadm/data"

alias clipqr="xclip -o | qrencode -t utf8"

alias e="emacsclient -cna ''"
alias n="nvim"
alias v="n"

alias c="clear"

alias tldrf="tldr --list | fzf-tmux -p --preview 'tldr {1} --color=always' --preview-window=right:70% | xargs tldr --color=always"

t_w() tmux-sessionizer
zle -N t_w
bindkey '^f' t_w

alias x="clear; tmux detach -P"

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
    num=
    if tmux has-session -t ssh-client 2> /dev/null; then
        num=2
        while tmux has-session -t ssh-client"$num" 2> /dev/null
        do
            ((num=num+1))
        done
    fi
    tmux new -ds ssh-client$num "[[ -f ~/.keychain/NCONWAY-DEV-sh ]] && . ~/.keychain/NCONWAY-DEV-sh; hide-tmux-statusbar & tmux set prefix C-h; tmux bind C-h send-prefix; tmux unbind -n C-f; ssh -t $@; tmux switch-client -l"
    tmux switch-client -t ssh-client$num
}

function svm() {
    s "$@ -L 127.0.0.1:4200:127.0.0.1:4200 -L 127.0.0.1:9443:127.0.0.1:9443 nconway@192.168.220.130"
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

[[ -z $SSH_CONNECTION ]] && [[ -e /mnt/c/Users ]] && export DISPLAY=$(ip route | grep default | awk '{print $3; exit;}'):0.0 && export LIBGL_ALWAYS_INDIRECT=1

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export DROPBOX=/c/Users/nickc/Dropbox/

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp/

export NVM_DIR="$HOME/.nvm"
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
