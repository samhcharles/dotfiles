# Functions — small, sharp, frequently used.

# mkdir + cd
mkcd() {
    [ -z "$1" ] && { echo "usage: mkcd <dir>" >&2; return 1; }
    mkdir -p -- "$1" && cd -- "$1" || return
}

# cd up N levels: `up 3` == `cd ../../..`
up() {
    local n="${1:-1}" path=""
    while [ "$n" -gt 0 ]; do path="../$path"; n=$((n-1)); done
    cd "$path" || return
}

# Extract any common archive.
extract() {
    [ -f "$1" ] || { echo "extract: '$1' is not a file" >&2; return 1; }
    case "$1" in
        *.tar.bz2|*.tbz2)  tar xjf  "$1" ;;
        *.tar.gz|*.tgz)    tar xzf  "$1" ;;
        *.tar.xz|*.txz)    tar xJf  "$1" ;;
        *.tar.zst)         tar --zstd -xf "$1" ;;
        *.tar)             tar xf   "$1" ;;
        *.bz2)             bunzip2  "$1" ;;
        *.gz)              gunzip   "$1" ;;
        *.xz)              unxz     "$1" ;;
        *.zip)             unzip    "$1" ;;
        *.7z)              7z x     "$1" ;;
        *.rar)             unrar x  "$1" ;;
        *.Z)                uncompress "$1" ;;
        *) echo "extract: unsupported format: $1" >&2; return 1 ;;
    esac
}

# One-line HTTP server in the current directory.
serve() {
    local port="${1:-8000}"
    if command -v python3 >/dev/null; then
        python3 -m http.server "$port"
    elif command -v python >/dev/null; then
        python -m SimpleHTTPServer "$port"
    else
        echo "serve: need python or python3" >&2
        return 1
    fi
}

# Fetch a .gitignore from gitignore.io.
gi() {
    [ -z "$1" ] && { echo "usage: gi <lang>[,lang...]" >&2; return 1; }
    curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$*"
}

# Find files by name from current directory.
ff() {
    [ -z "$1" ] && { echo "usage: ff <pattern>" >&2; return 1; }
    find . -type f -iname "*$1*" 2>/dev/null
}

# Pretty-print PATH.
ppath() {
    echo "$PATH" | tr ':' '\n'
}

# Quick scratchpad in $EDITOR.
scratch() {
    local f
    f="$(mktemp -t scratch.XXXXXX.md)"
    "$EDITOR" "$f"
    echo "$f"
}

# Weather in your terminal.
weather() {
    curl -s "https://wttr.in/${1:-}?Fn"
}
