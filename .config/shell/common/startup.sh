if [ -S $XDG_RUNTIME_DIR/agent.sock ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/agent.sock
else
    eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock)
fi

if command -v termux-reload-settings > /dev/null; then
    SELECTED=$((grep "Host " ~/.ssh/config | awk '{print $2}') | sort | uniq | fzf-tmux -p --prompt=" > ")
    if [[ -z $SELECTED ]]; then
        unset SELECTED
        return
    else
        ssh -t $SELECTED SSH_HOSTNAME=$(hostname) '$SHELL' -l
        unset SELECTED
        exit
    fi
fi

if [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        command -v tmux > /dev/null && tmux new -As main $SHELL_NAME && exit
        # zellij a -c main
    # elif [[ $SSH_HOSTNAME != "" ]] && [[ -n SSH_HOSTNAME ]]; then
    #     tmux new -As ssh-$SSH_HOSTNAME; exit
    #     # zellij a -c ssh-$SSH_HOSTNAME; exit
    else
        # zellij a -c ssh; exit
        command -v tmux > /dev/null && tmux new -As ssh $SHELL_NAME && exit
    fi
fi

if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.$SHELL_NAME"
    source "$(fzf-share)/completion.$SHELL_NAME"
fi

export NODE_PATH=$HOME/.npm-global/lib/node_modules
