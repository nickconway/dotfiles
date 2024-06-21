HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
