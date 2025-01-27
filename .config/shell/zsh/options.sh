if [[ -d ~/.config/zsh/zsh-completions ]]; then
    command -v gh &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_gh ]] || gh completion --shell zsh > ~/.config/zsh/zsh-completions/src/_gh)
    command -v rg &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_rg ]] || rg --generate complete-zsh > ~/.config/zsh/zsh-completions/src/_rg)
    command -v fzf &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_fzf ]] || fzf --zsh > ~/.config/zsh/zsh-completions/src/_fzf)
    command -v pnpm &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_pnpm ]] || pnpm completion zsh > ~/.config/zsh/zsh-completions/src/_pnpm)
    command -v kubectl &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_kubectl ]] || kubectl completion zsh > ~/.config/zsh/zsh-completions/src/_kubectl)
    command -v minikube &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_minikube ]] || minikube completion zsh > ~/.config/zsh/zsh-completions/src/_minikube)
    command -v helm &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_helm ]] || helm completion zsh > ~/.config/zsh/zsh-completions/src/_helm)
    command -v talosctl &> /dev/null && ([[ -e ~/.config/zsh/zsh-completions/src/_talosctl ]] || talosctl completion zsh > ~/.config/zsh/zsh-completions/src/_talosctl)

    fpath=(~/.config/zsh/zsh-completions/src $fpath)
    [[ -e /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

_dotnet_zsh_complete()
{
    local completions=("$(dotnet complete "$words")")

    if [ -z "$completions" ]
    then
        _arguments '*::arguments: _normal'
        return
    fi

    _values = "${(ps:\n:)completions}"
}

autoload -Uz compinit && compinit
command -v dotnet &>/dev/null && compdef _dotnet_zsh_complete dotnet

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

if [[ -e ~/.config/zsh/fzf-tab/fzf-tab.zsh ]]; then
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' menu no

    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:eza:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:mv:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:cp:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:rm:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:cat:*' fzf-preview 'fzf-preview $realpath'
    zstyle ':fzf-tab:complete:bat:*' fzf-preview 'fzf-preview $realpath'

    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
    zstyle ':fzf-tab:*' popup-follow-cursor false
    zstyle ':fzf-tab:*' popup-min-size 120 24

    zstyle ':fzf-tab:*cd*' accept-line enter
    zstyle ':fzf-tab:*ls*' accept-line enter
    zstyle ':fzf-tab:*eza*' accept-line enter

    zstyle ':fzf-tab:*' switch-group '<' '>'
fi

set -o vi
