if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    [[ -n "${VERSION_ID:-}" ]] && VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
# elif [ -f /etc/SuSe-release ]; then
#     # Older SuSE/etc.
# elif [ -f /etc/redhat-release ]; then
#     # Older Red Hat, CentOS, etc.
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi
KERNEL=$(uname -r)

export GOROOT=~/.local/go/go
export GOPATH=~/.local/go/packages

export PATH=~/.local/bin:/opt/homebrew/bin:~/.local/podman/bin:/home/linuxbrew/.linuxbrew/bin:~/.local/homebrew/bin:$HOME/.cargo/bin:"$GOROOT"/bin:"$GOPATH"/bin:~/.config/fzf/bin:~/.dotnet/tools:$PATH

[[ -n "${TTY:-}" ]] && export GPG_TTY=$TTY

export HOSTNAME="$(uname -n)"

if command -v termux-reload-settings > /dev/null; then
    export XDG_RUNTIME_DIR=$HOME/.termux
elif [[ -e ~/Library/Caches/TemporaryItems ]]; then
    export XDG_RUNTIME_DIR=~/Library/Caches/TemporaryItems
else
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

command -v brew > /dev/null && export HOMEBREW_PREFIX="$(brew --prefix)" && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters

export VISUAL=nvim
export EDITOR=nvim

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

export PROJECT_DIR=~/Git

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export DROPBOX=/c/Users/nickc/Dropbox

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp/

export FZF_DEFAULT_OPTS='-m --pointer=▶ --preview-window down,border-top --bind "ctrl-/:change-preview-window(80%|20%|hidden|)"
    --bind ctrl-d:preview-half-page-down --bind ctrl-u:preview-half-page-up --bind ctrl-a:select-all
    --color=fg:7,fg+:15,bg:-1,bg+:-1,gutter:-1,info:11,prompt:10,spinner:12,pointer:14,marker:13,border:7,header:9,label:7,hl:10
'

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export GITEA_USER=nick

if [[ -e /run/docker.sock ]]; then
    export DOCKER_HOST=unix:///run/docker.sock
elif [[ -e /var/run/docker.sock ]]; then
    export DOCKER_HOST=unix:///var/run/docker.sock
else
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
fi

export GIT_NAME="Nick Conway"
export GIT_EMAIL="nick@conway.dev"
export GIT_GPG_KEY="AA850592E4C1D453"

export ATUIN_USER=nick

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=~/.config/zsh/zsh-syntax-highlighting/highlighters

export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0

command -v dircolors &>/dev/null && eval "$(dircolors)"
