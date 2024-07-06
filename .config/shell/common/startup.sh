command -v brew > /dev/null && eval "$($(brew --prefix)/bin/brew shellenv)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"

if [ -S $XDG_RUNTIME_DIR/agent.sock ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/agent.sock
    if [[ "$(ssh-add -l 2>&1)" == *"Error"* ]]; then
        command rm $XDG_RUNTIME_DIR/agent.sock && eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
    fi
else
    eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
fi

command -v fzf > /dev/null && eval "$(fzf --$SHELL_NAME)"

if command -v termux-reload-settings > /dev/null; then
    s && exit || return
elif command -v steamos-update > /dev/null; then
    if [[ -n "$PS1" ]]; then
        distrobox enter arch && exit || return
    fi
else
    if [[ -z "$NO_TMUX" ]]; then
        [[ "$(basename $SHELL)" == "$SHELL_NAME" ]] && export TMUX_SHELL="$SHELL" || export TMUX_SHELL="$SHELL_NAME"
        if [[ -n "$PS1" ]] && [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
            if [[ -z $SSH_CONNECTION ]]; then
                command -v tmux > /dev/null && tmux -u new -As Main $TMUX_SHELL && exit 0
                # zellij a -c main
            else
                # zellij a -c ssh; exit
                command -v tmux > /dev/null && tmux -u new -As SSH $TMUX_SHELL && exit 0
            fi
        fi
    fi
fi
