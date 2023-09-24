if [[ -n $FD_COMMAND ]]; then
    for f in $($FD_COMMAND .zprofile -H -d 1 -E ".zprofile" -E "*##*"); do
        $FD_COMMAND
        source $f
    done
fi
