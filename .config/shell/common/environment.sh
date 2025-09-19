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
export PATH="$GOROOT"/bin:"$GOPATH"/bin:$PATH

export DOTNET_ROOT=~/.local/dotnet
export PATH="$DOTNET_ROOT":"$DOTNET_ROOT"/tools:"$PATH"

export PATH=/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:~/.local/homebrew/bin:$PATH
export PATH=~/.local/podman/bin:~/.cargo/bin:~/.config/fzf/bin:$PATH

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH=~/.local/bin:$PATH

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

command -v brew > /dev/null && export HOMEBREW_PREFIX="$(brew --prefix)"

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=~/.config/zsh/zsh-syntax-highlighting/highlighters
[[ -n $HOMEBREW_PREFIX ]] && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters

export VISUAL="$(which nvim)"
export EDITOR="$(which nvim)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[[ -n $HOMEBREW_PREFIX ]] && [[ -e "$HOMEBREW_PREFIX/opt/nvm" ]] && export NVM_DIR=$HOMEBREW_PREFIX/opt/nvm

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
  --tmux
  --border-label ' Command History '
  --preview 'echo {}' --preview-window 3:wrap
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
command -v pbcopy &> /dev/null && export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
command -v wl-copy &> /dev/null && export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'"

if [[ -e "$HOME/.config/colima/default/docker.sock" ]]; then
    export DOCKER_HOST=unix://$HOME/.config/colima/default/docker.sock
elif [[ -e ~/.docker/run/docker.sock ]]; then
    export DOCKER_HOST=unix://$HOME/.docker/run/docker.sock
elif [[ -e /run/docker.sock ]]; then
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

export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0

command -v dircolors &>/dev/null && eval "$(dircolors)"

export JUST_CHOOSER='fzft --preview="just --color always --show {}"'

export TESSDATA_PREFIX=~/.local/share/tessdata

export TEXMFHOME="$HOME/.local/share/texmf"

[ -s ~/.bun/_bun ] && source ~/.bun/_bun

export GPG_EMAIL="nick@conway.dev"
export DOCKER_STACK_DIR="$HOME/Docker"
export SERVICES_BASE_DOMAIN="conway.dev"
export GITEA_USER=nick

command -v brew > /dev/null && eval "$($(brew --prefix)/bin/brew shellenv)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"
command -v fzf > /dev/null && eval "$(fzf --$SHELL_NAME)"
command -v fzf > /dev/null && [[ -e ~/.config/fzf-git/fzf-git.sh ]] && source ~/.config/fzf-git/fzf-git.sh
[[ -e $HOME/.atuin/bin/env ]] && . "$HOME/.atuin/bin/env"
command -v atuin > /dev/null && eval "$(atuin init $SHELL_NAME --disable-up-arrow | awk '/output=\$\(/{system("cat ~/.config/atuin/tmux.'$SHELL_NAME'");next}1')" \
    && (pgrep -f "atuin daemon" &> /dev/null || atuin daemon &> $XDG_RUNTIME_DIR/atuin.log &)
command -v direnv &> /dev/null && export DIRENV_LOG_FORMAT=$'\033[95m󰓴 \033[94m%s\033[0m' && eval "$(direnv hook $SHELL_NAME)"

_fzf_git_fzf() {
    fzft --min-height=20 --border \
        --tmux center,80% \
        --preview-window='right,50%,border-left' \
        "$@"
}

# if command -v bitwarden &>/dev/null; then
#     export BITWARDEN_SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/bitwarden.sock"
#     touch "$BITWARDEN_SSH_AUTH_SOCK" && chmod 770 "$BITWARDEN_SSH_AUTH_SOCK"
#     export SSH_AUTH_SOCK="$BITWARDEN_SSH_AUTH_SOCK"
if [ -S $XDG_RUNTIME_DIR/agent.sock ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/agent.sock
    if [[ "$(ssh-add -l 2>&1)" == *"Error"* ]]; then
        rm $XDG_RUNTIME_DIR/agent.sock && eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
    fi
else
    if ! [[ -f ~/.work ]]; then
        eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
    fi
fi
