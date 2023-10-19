for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/bash/*; do
    source $f
done

if [ -e /home/nick/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nick/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
