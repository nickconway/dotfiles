if [[ -n "$DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

export SHELL_NAME=zsh

for f in ~/.config/shell/common/*; do
    source $f
done

for f in ~/.config/shell/"$SHELL_NAME"/*; do
    source $f
done

if [[ -n "$DEBUGRC" ]]; then
  zprof
fi

export GPG_EMAIL="nick@conway.dev"

export DOCKER_STACK_DIR="/home/nick/Docker"

export SERVICES_BASE_DOMAIN="conway.dev"
