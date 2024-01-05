setopt hist_ignore_all_dups
setopt INC_APPEND_HISTORY

if [[ ~/.zsh/zsh-completions ]]; then
    fpath=(~/.zsh/zsh-completions/src $fpath)
fi

autoload -Uz compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
