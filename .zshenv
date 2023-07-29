[[ -e $HOME/.cargo/env ]] && . "$HOME/.cargo/env"

if [[ -e ~/.local/bin/fd ]]; then
    FIND_COMMAND=~/.local/bin/fd
elif command -v fdfind; then
    FIND_COMMAND=fdfind
fi

for f in $($FIND_COMMAND .zshenv -H -d 1 -E ".zshenv" -E "*##*"); do
    source $f
done
