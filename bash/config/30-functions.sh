# Functions.

mkcd() {
    [ -z "${1-}" ] && { echo "usage: mkcd <dir>" >&2; return 1; }
    mkdir -p -- "$1" && cd -- "$1"
}

extract() {
    [ -f "${1-}" ] || { echo "extract: '$1' is not a file" >&2; return 1; }
    case "$1" in
        *.tar.bz2|*.tbz2)  tar xjf  "$1" ;;
        *.tar.gz|*.tgz)    tar xzf  "$1" ;;
        *.tar.xz|*.txz)    tar xJf  "$1" ;;
        *.tar)             tar xf   "$1" ;;
        *.bz2)             bunzip2  "$1" ;;
        *.gz)              gunzip   "$1" ;;
        *.xz)              unxz     "$1" ;;
        *.zip)             unzip    "$1" ;;
        *) echo "extract: unsupported format: $1" >&2; return 1 ;;
    esac
}
