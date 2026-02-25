if [[ -n "$DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

export SHELL_NAME=zsh
export SHELL="$(which "$SHELL_NAME")"

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/"$SHELL_NAME"/*; do
    source $f
done

if [[ -n "$DEBUGRC" ]]; then
  zprof
fi

# pnpm
export PNPM_HOME="/home/nick/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
