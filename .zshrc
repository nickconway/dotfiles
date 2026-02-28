if [[ -n "$DEBUG_MODE" ]]; then
    zmodload zsh/datetime
    _startup_timer=$EPOCHREALTIME
    zmodload zsh/zprof
fi

export SHELL_NAME=zsh
export SHELL="$(which "$SHELL_NAME")"

for f in ~/.config/shell/common/*; do
    source $f
done

[[ -e ~/.config/zsh/zsh-defer/zsh-defer.plugin.zsh ]] && autoload -Uz ~/.config/zsh/zsh-defer/zsh-defer

for f in ~/.config/shell/"$SHELL_NAME"/*; do
    zsh-defer source $f || source $f
done

if [[ -n "$DEBUG_MODE" ]]; then
    zprof > ~/.zproflog
fi
