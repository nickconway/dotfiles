export PATH=$PATH:~/.local/bin:~/bin:~/.npm-global/bin
export GPG_TTY=$TTY

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export DEVBOX_PROFILE="$XDG_DATA_HOME/devbox/global/default/.devbox/virtenv/.wrappers"

export VISUAL=nvim
export EDITOR=nvim

if [[ -n $KODIR ]]; then
    export PROJECT_DIR=$KODIR
else
    export PROJECT_DIR=~/git
fi

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

export DROPBOX=/c/Users/nickc/Dropbox/

export TMUXP_CONFIGDIR=$HOME/.config/tmuxp/

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm

export FZF_DEFAULT_OPTS="--color=gutter:-1"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_TMUX_OPTS="-p --reverse"

export NODE_PATH=$HOME/.npm-global/lib/node_modules
