# Aliases.

if ls --color=auto >/dev/null 2>&1; then
    alias ls='ls --color=auto --group-directories-first'
else
    alias ls='ls -G'
fi
alias ll='ls -alFh'
alias la='ls -A'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

alias grep='grep --color=auto'

alias df='df -h'
alias du='du -h'

# git: one letter for the tool, everything else lives in .gitconfig aliases.
alias g='git'

alias reload='exec "$SHELL" -l'
