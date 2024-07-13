if [ -z "${TMUX}" ]; then
    __atuin_output=$(ATUIN_SHELL_BASH=t ATUIN_LOG=error ATUIN_QUERY="$READLINE_LINE" atuin search "$@" -i 3>&1 1>&2 2>&3)
else
    tmpdir=$(mktemp -d)
    mkfifo "$tmpdir/pipe"
    trap "rm -rf '$tmpdir'" EXIT HUP INT TERM
    __atuin_output=$(
        cat "$tmpdir/pipe" &
        tmux display-popup -d $(pwd) -E -E -h 80% -w 80% -- \
            "$(printf "%q " ATUIN_SHELL_BASH=t ATUIN_LOG=error ATUIN_QUERY="$READLINE_LINE" atuin search "$@" -i) 1>&2 2>$tmpdir/pipe"
    )
    rm -rf "$tmpdir"
fi
