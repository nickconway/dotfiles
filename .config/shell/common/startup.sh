command -v devbox > /dev/null && eval "$(devbox global shellenv --init-hook)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"

if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.$SHELL_NAME"
  source "$(fzf-share)/completion.$SHELL_NAME"
fi

if [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        tmux new -As main
        # zellij a -c main
    elif [[ $SSH_HOSTNAME != "" ]] && [[ -n SSH_HOSTNAME ]]; then
        tmux new -As ssh-$SSH_HOSTNAME; exit
        # zellij a -c ssh-$SSH_HOSTNAME; exit
    else
        # zellij a -c ssh; exit
        tmux new -As ssh; exit
    fi
fi

command -v keychain > /dev/null && eval `keychain -q --nogui --eval $(find $HOME/.ssh/ -name "id*" -not -path "*.pub")`
