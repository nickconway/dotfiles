for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/bash/*; do
    source $f
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
