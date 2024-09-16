command -v brew > /dev/null && eval "$($(brew --prefix)/bin/brew shellenv)"
command -v starship > /dev/null && eval "$(starship init $SHELL_NAME)"
command -v zoxide > /dev/null && eval "$(zoxide init $SHELL_NAME --cmd cd)"
command -v fzf > /dev/null && eval "$(fzf --$SHELL_NAME)"
command -v fzf > /dev/null && [[ -e ~/.config/fzf-git/fzf-git.sh ]] && source ~/.config/fzf-git/fzf-git.sh
[[ -e $HOME/.atuin/bin/env ]] && . "$HOME/.atuin/bin/env"
command -v atuin > /dev/null && eval "$(atuin init $SHELL_NAME --disable-up-arrow | awk '/output=\$\(/{system("cat ~/.config/atuin/tmux.'$SHELL_NAME'");next}1')" \
    && (pgrep -f "atuin daemon" &> /dev/null || atuin daemon &> $XDG_RUNTIME_DIR/atuin.log &)
command -v direnv &> /dev/null && export DIRENV_LOG_FORMAT=$'\033[95m󰓴 \033[94m%s\033[0m' && eval "$(direnv hook $SHELL_NAME)"

_fzf_git_fzf() {
  fzft --min-height=20 --border \
    --tmux center,80% \
    --preview-window='right,50%,border-left' \
    "$@"
}

if [ -S $XDG_RUNTIME_DIR/agent.sock ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/agent.sock
    if [[ "$(ssh-add -l 2>&1)" == *"Error"* ]]; then
        rm $XDG_RUNTIME_DIR/agent.sock && eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
    fi
else
    eval $(ssh-agent -t 12h -s -a $XDG_RUNTIME_DIR/agent.sock) > /dev/null
fi

if command -v steamos-update > /dev/null; then
    if [[ -n "$PS1" ]]; then
        distrobox enter arch && exit || return
    fi
else
    if [[ -z "$NO_TMUX" ]]; then
        [[ "$(basename $SHELL)" == "$SHELL_NAME" ]] && export TMUX_SHELL="$SHELL" || export TMUX_SHELL="$SHELL_NAME"
        if [[ -n "$PS1" ]] && [[ -z $TMUX ]] && [[ -z $ZELLIJ ]]; then
            if [[ -z $SSH_CONNECTION ]]; then
                command -v tmux > /dev/null && tmux -u new -As Main $TMUX_SHELL &> /dev/null && exit 0
                # zellij a -c main
            else
                # zellij a -c ssh; exit
                command -v tmux > /dev/null && tmux -u new -As SSH $TMUX_SHELL &> /dev/null && exit 0
            fi
        fi
    fi
fi

if command -v termux-reload-settings > /dev/null; then
    s && exit || return
fi
