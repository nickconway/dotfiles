if command -v steamos-update > /dev/null; then
    if [[ -n "$PS1" ]]; then
        distrobox enter arch && exit || return
    fi
else
    export PATH="$HOME/.local/bin:$PATH"
    export FZF_DEFAULT_OPTS='-m --pointer=▶ --preview-window down,border-top --bind "ctrl-/:change-preview-window(80%|20%|hidden|)"
        --bind ctrl-d:preview-half-page-down --bind ctrl-u:preview-half-page-up --bind ctrl-a:select-all
        --color=fg:7,fg+:15,bg:-1,bg+:-1,gutter:-1,info:11,prompt:10,spinner:12,pointer:14,marker:13,border:7,header:9,label:7,hl:10
        --gutter " "
    '

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
    immersive-ssh && exit || return
fi
