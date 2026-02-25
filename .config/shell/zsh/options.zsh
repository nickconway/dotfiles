setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

setopt EXTENDED_GLOB
setopt AUTO_PARAM_SLASH
setopt GLOB_COMPLETE
setopt HASH_LIST_ALL
setopt GLOB_DOTS
unsetopt NOMATCH

setopt INTERACTIVE_COMMENTS

ZSH_AUTOSUGGEST_USE_ASYNC=1

ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
    orig-\*
    beep
    run-help
    set-local-history
    which-command
    yank
    yank-pop
)

export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

function _gen_completions() {
    local CMD=$1

    if [[ -e ~/.config/zsh/completions/_"$CMD" ]]; then
        return
    fi

    [[ "$2" == -- ]] && shift && shift
    $* > ~/.config/zsh/completions/_"$CMD"
}

[[ -d ~/.config/zsh/zsh-completions ]] && fpath=(~/.config/zsh/zsh-completions/src $fpath)
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

typeset -gU path fpath

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
_gen_completions uv generate-shell-completion zsh
_gen_completions uvx --generate-shell-completion zsh
_gen_completions yadm -- curl -sSL https://raw.githubusercontent.com/yadm-dev/yadm/refs/heads/develop/completion/zsh/_yadm

_dotnet_zsh_complete() {
    local completions=("$(dotnet complete "")")

    if [ -z "${completions[*]}" ]; then
        _arguments '*::arguments: _normal'
        return
    fi

    _values = $(xargs <<< $completions)
}

_comp_options+=(globdots)

COMP_DUMP="$HOME/.zcompdump"

if [[ ! -f "$COMP_DUMP" || -n "$COMP_DUMP"(#qN.mh+24) ]]; then
    zsh-defer compinit -i -u -d "$COMP_DUMP"
    touch "$COMP_DUMP"
else
    zsh-defer compinit -C -d "$COMP_DUMP"
fi

if [[ ! -f "$COMP_DUMP.zwc" || "$COMP_DUMP" -nt "$COMP_DUMP.zwc" ]]; then
    zcompile "$COMP_DUMP" &!
fi

command -v dotnet &>/dev/null && zsh-defer compdef _dotnet_zsh_complete dotnet

mkdir -p "$HOME/.cache/zsh"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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
    zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'fzf-preview $realpath'

    zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
    zstyle ':fzf-tab:*' popup-follow-cursor false
    zstyle ':fzf-tab:*' popup-min-size 120 24

    zstyle ':fzf-tab:*cd*' accept-line enter
    zstyle ':fzf-tab:*ls*' accept-line enter
    zstyle ':fzf-tab:*eza*' accept-line enter

    zstyle ':fzf-tab:*' switch-group '<' '>'
fi

set -o vi
