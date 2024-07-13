if [ -z "${TMUX}" ]; then
    output=$(ATUIN_SHELL_ZSH=t ATUIN_LOG=error ATUIN_QUERY=$BUFFER atuin search $* -i 3>&1 1>&2 2>&3)
else
    tmpdir=$(mktemp -d)
    mkfifo "$tmpdir/pipe"
    trap "rm -rf '$tmpdir'" EXIT HUP INT TERM
    output=$(
        cat "$tmpdir/pipe" &;
        tmux display-popup -d $(pwd) -E -E -h 80% -w 80% -- \
            "$(printf "%q " ATUIN_SHELL_ZSH=t ATUIN_LOG=error ATUIN_QUERY=$BUFFER atuin search $* -i) 1>&2 2>$tmpdir/pipe"
    )
    rm -rf "$tmpdir"
fi
