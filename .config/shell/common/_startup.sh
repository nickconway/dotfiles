if command -v steamos-update > /dev/null; then
    if [[ -n "$PS1" ]]; then
        distrobox enter arch && exit || return
    fi
else
    if [[ -z "$NO_TMUX" ]]; then
        [[ "$(basename "$SHELL")" == "$SHELL_NAME" ]] && export TMUX_SHELL="$SHELL" || export TMUX_SHELL="$SHELL_NAME"
        if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -z "$ZELLIJ" ]]; then
            if [[ -z "$SSH_CONNECTION" ]]; then
                if [[ -n "$TMUX_AUTO_SESSION" ]]; then
                    command -v tmux > /dev/null && tmux -u new -e "TMUX_AUTO_SESSION=$TMUX_AUTO_SESSION" "$TMUX_SHELL" &> /dev/null && exit 0
                else
                    command -v tmux > /dev/null && tmux -u new -As "${TMUX_SESSION_NAME:-Main}" "$TMUX_SHELL" &> /dev/null && exit 0
                fi
                # zellij a -c main
            else
                # zellij a -c ssh; exit
                command -v tmux > /dev/null && tmux -u new -As SSH "$TMUX_SHELL" &> /dev/null && exit 0
            fi
        fi
    fi
fi

if command -v termux-reload-settings > /dev/null; then
    export PATH="$PATH:$HOME/.local/bin"
    immersive-ssh && exit || return
fi
