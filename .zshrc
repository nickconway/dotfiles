SHELL_NAME=zsh

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/zsh/*; do
    source $f
done
