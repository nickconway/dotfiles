for f in ~/.config/shell/zsh/*; do
    source $f
done

for f in ~/.config/shell/common/*; do
    source $f
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
