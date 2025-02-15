function _gen_completions() {
    if command -v $1 &> /dev/null && [[ ! -e ~/.config/zsh/completions/_"$1" ]]; then
        $* > ~/.config/zsh/completions/_"$1"
    fi
}

[[ -d ~/.config/zsh/zsh-completions ]] && fpath=(~/.config/zsh/zsh-completions/src $fpath)
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

mkdir -p ~/.config/zsh/completions
fpath=(~/.config/zsh/completions $fpath)

_gen_completions gh completion --shell zsh
_gen_completions rg --generate complete-zsh
_gen_completions fzf --zsh
_gen_completions pnpm completion zsh
_gen_completions kubectl completion zsh
_gen_completions minikube completion zsh
_gen_completions helm completion zsh
_gen_completions talosctl completion zsh
_gen_completions gitleaks completion zsh
_gen_completions fd --gen-completions zsh

[[ ! -e ~/.config/zsh/completions/_yadm ]] && curl -sSL https://raw.githubusercontent.com/yadm-dev/yadm/refs/heads/develop/completion/zsh/_yadm -o ~/.config/zsh/completions/_yadm

_dotnet_zsh_complete() {
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
