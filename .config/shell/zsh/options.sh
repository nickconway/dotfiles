if [[ -d ~/.zsh/zsh-completions ]]; then
    fpath=(~/.zsh/zsh-completions/src $fpath)
fi

autoload -Uz compinit && compinit

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
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always --icons $realpath'

zstyle ':fzf-tab:*cd*' accept-line enter
zstyle ':fzf-tab:*ls*' accept-line enter

zstyle ':fzf-tab:*' switch-group '<' '>'

set -o vi
