[[ -z $SSH_AUTH_SOCK ]] && eval (ssh-agent -s)

if command -v termux-reload-settings > /dev/null; then
    . source-ssh-agent
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

if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.$SHELL_NAME"
    source "$(fzf-share)/completion.$SHELL_NAME"
fi

export NODE_PATH=$HOME/.npm-global/lib/node_modules
