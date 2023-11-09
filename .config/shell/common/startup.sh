command -v && eval "$($(brew --prefix)/bin/brew shellenv)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"

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

if command -v fzf-share > /dev/null; then
    source "$(fzf-share)/key-bindings.$SHELL_NAME"
    source "$(fzf-share)/completion.$SHELL_NAME"
fi

[[ "$(basename $SHELL)" == "$SHELL_NAME" ]] && export TMUX_SHELL="$SHELL" || export TMUX_SHELL="$SHELL_NAME"
if [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        command -v tmux > /dev/null && tmux new -As main $TMUX_SHELL && exit 0
        # zellij a -c main
    else
        # zellij a -c ssh; exit
        command -v tmux > /dev/null && tmux new -As ssh $TMUX_SHELL && exit 0
    fi
fi
