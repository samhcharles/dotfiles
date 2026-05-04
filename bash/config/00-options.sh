# Shell options and history.

# History: large, deduplicated, append-only, written immediately.
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '
HISTIGNORE='ls:ll:la:cd:pwd:exit:clear:history'
shopt -s histappend
shopt -s cmdhist

# Save history after every command so parallel shells share it.
PROMPT_COMMAND='history -a; history -n'"${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Better navigation.
shopt -s autocd 2>/dev/null
shopt -s cdspell 2>/dev/null
shopt -s dirspell 2>/dev/null
shopt -s checkwinsize
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null

# Disable Ctrl-S freezing the terminal.
[ -t 0 ] && stty -ixon 2>/dev/null
