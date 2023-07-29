[[ -e $HOME/.cargo/env ]] && . "$HOME/.cargo/env"

for f in $(fd .zshenv -H -d 1 -E ".zshenv"); do
    source $f
done
