# Aliases.

# ls
if ls --color=auto >/dev/null 2>&1; then
    alias ls='ls --color=auto --group-directories-first'
else
    alias ls='ls -G'
fi
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alFh'
alias lt='ls -alFht'   # newest first

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Disk and system
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias path='echo "${PATH//:/$'\''\n'\''}"'
alias ports='ss -tulanp 2>/dev/null || netstat -tulanp'
alias myip='curl -s https://api.ipify.org && echo'

# Git
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --all --prune'
alias gl='git lg'
alias gst='git stash'
alias gsp='git stash pop'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Misc
alias h='history'
alias c='clear'
alias reload='exec "$SHELL" -l'
alias please='sudo $(fc -ln -1)'
