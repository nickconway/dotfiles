export SHELL_NAME="$(ps -p $$ | awk 'NR==2 {print $4}')"
export SHELL_PATH="$(which "$SHELL_NAME")"

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/"$SHELL_NAME"/*; do
    source $f
done
