# Programmable completion.

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Tool-provided completions, if installed.
command -v gh       >/dev/null && eval "$(gh completion -s bash 2>/dev/null)"
command -v kubectl  >/dev/null && eval "$(kubectl completion bash 2>/dev/null)"
command -v helm     >/dev/null && eval "$(helm completion bash 2>/dev/null)"
