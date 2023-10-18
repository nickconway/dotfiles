setopt hist_ignore_all_dups
setopt INC_APPEND_HISTORY

fpath+=(
    $DEVBOX_PROFILE/share/zsh/site-functions
    $DEVBOX_PROFILE/share/zsh/$ZSH_VERSION/functions
    $DEVBOX_PROFILE/share/zsh/vendor-completions
)

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
