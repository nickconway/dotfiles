export SHELL_NAME=zsh

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/$SHELL_NAME/*; do
    source $f
done
