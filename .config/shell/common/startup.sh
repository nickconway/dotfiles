command -v brew > /dev/null && eval "$($(brew --prefix)/bin/brew shellenv)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"

if [ -S $XDG_RUNTIME_DIR/agent.sock ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/agent.sock
    if [[ "$(ssh-add -l 2>&1)" == *"Error"* ]]; then
        rm $XDG_RUNTIME_DIR/agent.sock && eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock)
    fi
else
    eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock)
fi

if command -v termux-reload-settings > /dev/null; then
    SELECTED=$((grep "Host " ~/.ssh/config | awk '{print $2}') | sort | uniq | fzf-tmux -p --prompt=" > ")
    if [[ -z $SELECTED ]]; then
        unset SELECTED
        return
    else
        ssh $SELECTED
        unset SELECTED
        exit
    fi
fi

[[ -f ~/.fzf.$SHELL_NAME ]] && source ~/.fzf.$SHELL_NAME

[[ "$(basename $SHELL)" == "$SHELL_NAME" ]] && export TMUX_SHELL="$SHELL" || export TMUX_SHELL="$SHELL_NAME"
if [[ -n "$PS1" ]] && [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
        command -v tmux > /dev/null && tmux new -As main $TMUX_SHELL && exit 0
        # zellij a -c main
    else
        # zellij a -c ssh; exit
        command -v tmux > /dev/null && tmux new -As ssh $TMUX_SHELL && exit 0
    fi
fi
