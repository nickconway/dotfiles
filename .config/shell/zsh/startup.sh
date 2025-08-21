if [[ -e ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -e $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -e ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -e $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

[[ -e ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh ]] && source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
[[ -e ~/.config/zsh/sudo.plugin.zsh ]] && source ~/.config/zsh/sudo.plugin.zsh
[[ -e ~/.config/zsh/command-not-found.plugin.zsh ]] && source ~/.config/zsh/command-not-found.plugin.zsh
