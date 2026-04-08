#!/usr/bin/env bash
# install.sh — symlink dotfiles into $HOME.
#
# Usage:
#   ./install.sh              install
#   ./install.sh --dry-run    show what would happen
#   ./install.sh --uninstall  remove symlinks pointing into this repo
#
# Idempotent. Backs up anything it would overwrite into
# ~/.dotfiles-backup/<timestamp>/.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

DRY_RUN=0
UNINSTALL=0

usage() {
    cat <<'EOF'
Usage:
  ./install.sh              install
  ./install.sh --dry-run    show what would happen
  ./install.sh --uninstall  remove symlinks pointing into this repo
EOF
}

for arg in "$@"; do
    case "$arg" in
        --dry-run)   DRY_RUN=1 ;;
        --uninstall) UNINSTALL=1 ;;
        -h|--help)   usage; exit 0 ;;
        *) echo "unknown argument: $arg" >&2; usage >&2; exit 2 ;;
    esac
done

# source path (relative to repo) → destination (relative to $HOME)
LINKS=(
    "bash/.bashrc           .bashrc"
    "bash/.bash_profile     .bash_profile"
    "git/.gitconfig         .gitconfig"
    "git/.gitignore_global  .gitignore_global"
    "git/.gitmessage        .gitmessage"
    "vim/.vimrc             .vimrc"
    "tmux/.tmux.conf        .tmux.conf"
    "editor/.editorconfig   .editorconfig"
)

log() { printf '%s\n' "$*"; }

backup() {
    local target="$1"
    [ -e "$target" ] || [ -L "$target" ] || return 0
    if (( DRY_RUN )); then
        log "would back up $target → $BACKUP_DIR/"
        return 0
    fi
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    log "backed up $target → $BACKUP_DIR/"
}

link_one() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME/$2"

    if [ ! -e "$src" ]; then
        echo "missing source: $1" >&2
        return 1
    fi

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        log "ok   $2 (already linked)"
        return 0
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        backup "$dst"
    fi

    if (( DRY_RUN )); then
        log "link $dst → $src"
    else
        mkdir -p "$(dirname "$dst")"
        ln -s "$src" "$dst"
        log "link $2 → $1"
    fi
}

unlink_one() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME/$2"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        if (( DRY_RUN )); then
            log "remove $dst"
        else
            rm "$dst"
            log "removed $2"
        fi
    else
        log "skip $2 (not a link to this repo)"
    fi
}

if (( UNINSTALL )); then
    for entry in "${LINKS[@]}"; do
        read -r src dst <<<"$entry"
        unlink_one "$src" "$dst"
    done
    exit 0
fi

(( DRY_RUN )) && log "dry-run: no changes will be made"
for entry in "${LINKS[@]}"; do
    read -r src dst <<<"$entry"
    link_one "$src" "$dst"
done

(( DRY_RUN )) || log "done."
