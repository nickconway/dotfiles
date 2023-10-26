command -v termux-reload-settings > /dev/null && ssh-picker && exit || exit

if [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        command -v tmux > /dev/null && tmux new -As main
        # zellij a -c main
    # elif [[ $SSH_HOSTNAME != "" ]] && [[ -n SSH_HOSTNAME ]]; then
    #     tmux new -As ssh-$SSH_HOSTNAME; exit
    #     # zellij a -c ssh-$SSH_HOSTNAME; exit
    else
        # zellij a -c ssh; exit
        command -v tmux > /dev/null && tmux new -As ssh && exit
    fi
fi

command -v keychain > /dev/null && eval `keychain -q --nogui --eval $(find $HOME/.ssh/ -name "id*" -not -path "*.pub")`

if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.$SHELL_NAME"
    source "$(fzf-share)/completion.$SHELL_NAME"
fi

export NODE_PATH=$HOME/.npm-global/lib/node_modules
