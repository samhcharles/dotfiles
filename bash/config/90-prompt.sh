# Prompt. Use starship if installed; otherwise a clean PS1.
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
else
    __git_branch() {
        local b
        b=$(git symbolic-ref --short HEAD 2>/dev/null) || return
        printf ' (%s)' "$b"
    }
    PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]$(__git_branch)\[\e[0m\]\$ '
fi
