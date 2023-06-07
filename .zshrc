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
plugins=(git vi-mode gpg-agent keychain tmux npm themes zsh-autosuggestions zsh-syntax-highlighting)
zstyle :omz:plugins:keychain agents gpg,ssh
zstyle :omz:plugins:keychain identities id_ed25519
zstyle :omz:plugins:keychain options -q

if [[ -n $SSH_CONNECTION ]]; then
    ZSH_TMUX_AUTOSTART=false
else
    ZSH_TMUX_AUTOSTART=true
fi

source $ZSH/oh-my-zsh.sh

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

eval "$(starship init zsh)"

alias ys="yadm status"
alias ya="yadm add"
alias yau="yadm add -u"
alias yc="yadm commit"
alias yca="yadm commit -a"
alias ycam="yadm commit -a -m"
alias yp="yadm push"
alias yl="yadm pull"
alias yd="yadm diff"
alias yenc="yadm encrypt"
alias ydec="yadm decrypt"
alias yu="yadm upgrade"

alias clipqr="xclip -o | qrencode -t utf8"

alias e="emacsclient -cna ''"
alias n="nvim"
alias v="n"

alias c="clear"

alias tldrf="tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right:70% | xargs tldr --color=always"

t_w() t
zle -N t_w
bindkey '^f' t_w
bindkey -s '^p' "tmuxp-sessionizer\n"

pw() {
    rbw get $1 $2 | clip.exe
}

function ghpr() {
    GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
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

replace () {
    if [ $# -lt 2 ]
    then
        echo "Recursive, interactive text replacement"
        echo "Usage: replace text replacement"
        return
    fi

    vim -u NONE -c ":execute ':argdo %s/$1/$2/gc | update' | :q" $(ag $1 -l)
}

export NO_AT_BRIDGE=1

export VISUAL=nvim
export EDITOR=nvim

export DISPLAY=$(ip route | grep default | awk '{print $3; exit;}'):0.0

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export PATH=~/.cargo/bin/:~/.emacs.d/bin/:~/.config/doom-emacs/bin:~/.local/bin:~/bin:~/.config/bin:"$PATH"
# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Angular CLI autocompletion.
if ! [ -x "$(command -v ng)"]; then
    source <(ng completion script)
fi

eval "$(zoxide init zsh --cmd cd)"

export FZF_DEFAULT_OPTS="--color=gutter:-1"
export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p --reverse"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
