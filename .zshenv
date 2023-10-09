[[ -e $HOME/.cargo/env ]] && . "$HOME/.cargo/env"

if [[ -e ~/.local/bin/fd ]]; then
    FD_COMMAND=fdfind
elif command -v fd > /dev/null; then
    FD_COMMAND=fd
fi

if [[ -n $FD_COMMAND ]]; then
    for f in $($FD_COMMAND .zshenv -H -d 1 -E ".zshenv" -E "*##*"); do
        source $f
    done
fi

if [ -e /home/nick/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nick/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
