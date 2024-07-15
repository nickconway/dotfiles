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

export PATH=~/.local/bin:~/bin:~/.npm-global/bin:~/.local/podman/bin:/home/linuxbrew/.linuxbrew/bin:~/.local/homebrew/bin:$HOME/.cargo/bin:~/.local/go/bin:~/.fzf/bin:$PATH
export GOPATH=~/.local/go
[[ -n "${TTY:-}" ]] && export GPG_TTY=$TTY

export HOSTNAME="$(uname -n)"

if command -v termux-reload-settings > /dev/null; then
    export XDG_RUNTIME_DIR=$HOME/.termux
else
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

command -v brew > /dev/null && export HOMEBREW_PREFIX="$(brew --prefix)" && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters

export VISUAL=nvim
export EDITOR=nvim

export PROJECT_DIR=~/Git

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export DROPBOX=/c/Users/nickc/Dropbox

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp/

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[[ ! -e $NVM_DIR ]] && mkdir -p $NVM_DIR
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

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

export FZF_TMUX_OPTS="-p"

export GITEA_USER=nick

[[ -e /run/docker.sock ]] && export DOCKER_HOST=unix:///run/docker.sock || export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

export GIT_NAME="Nick Conway"
export GIT_EMAIL="nick@conway.dev"
export GIT_GPG_KEY="AA850592E4C1D453"

export ATUIN_USER=nick

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=~/.zsh/zsh-syntax-highlighting/highlighters
