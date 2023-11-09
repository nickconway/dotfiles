setopt hist_ignore_all_dups
setopt INC_APPEND_HISTORY

if type brew &>/dev/null; then
     FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

     autoload -Uz compinit
     compinit
fi

fpath=(
    /home/linuxbrew/.linuxbrew/share/zsh/site-functions
    "${fpath[@]}"
)

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
