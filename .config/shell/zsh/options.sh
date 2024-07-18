if [[ -d ~/.zsh/zsh-completions ]]; then
    command -v gh &> /dev/null && [[ -e ~/.zsh/zsh-completions/src/_gh ]] || gh completion --shell zsh > ~/.zsh/zsh-completions/src/_gh
    command -v rg &> /dev/null && [[ -e ~/.zsh/zsh-completions/src/_rg ]] || rg --generate complete-zsh > ~/.zsh/zsh-completions/src/_rg
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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-follow-cursor false
zstyle ':fzf-tab:*' popup-min-size 120 24

zstyle ':fzf-tab:*cd*' accept-line enter
zstyle ':fzf-tab:*ls*' accept-line enter
zstyle ':fzf-tab:*eza*' accept-line enter

zstyle ':fzf-tab:*' switch-group '<' '>'

set -o vi
