[[ $- != *i* ]] && return

export SHELL_NAME=bash
export SHELL="$(which "$SHELL_NAME")"

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/"$SHELL_NAME"/*; do
    source $f
done
