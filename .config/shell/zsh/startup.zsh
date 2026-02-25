if [[ -n "$HOMEBREW_PREFIX" ]]; then
    for f in "$HOMEBREW_PREFIX"/share/*/*.zsh; do
        source "$f"
    done
fi

for f in ~/.config/zsh/*/*.zsh; do
    source "$f"
done
