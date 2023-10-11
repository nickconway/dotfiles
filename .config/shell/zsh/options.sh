HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

fpath+=(
    $DEVBOX_PROFILE/share/zsh/site-functions
    $DEVBOX_PROFILE/share/zsh/$ZSH_VERSION/functions
    $DEVBOX_PROFILE/share/zsh/vendor-completions
)


