#!/usr/bin/env bash
# install.sh — symlink dotfiles into $HOME.
#
# Usage:
#   ./install.sh              install (default)
#   ./install.sh --dry-run    show what would happen
#   ./install.sh --uninstall  remove symlinks pointing into this repo
#
# Idempotent. Backs up anything it would overwrite into ~/.dotfiles-backup/<ts>/.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${HOME_DIR}/.dotfiles-backup/${TIMESTAMP}"

DRY_RUN=0
UNINSTALL=0

for arg in "$@"; do
    case "$arg" in
        --dry-run)   DRY_RUN=1 ;;
        --uninstall) UNINSTALL=1 ;;
        -h|--help)
            sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *) echo "unknown argument: $arg" >&2; exit 2 ;;
    esac
done

# --- pretty output ----------------------------------------------------------
c_reset=$'\033[0m'; c_dim=$'\033[2m'; c_red=$'\033[31m'
c_grn=$'\033[32m'; c_ylw=$'\033[33m'; c_blu=$'\033[34m'
say()  { printf '%s\n' "$*"; }
info() { printf '%s==>%s %s\n' "$c_blu" "$c_reset" "$*"; }
ok()   { printf '  %s✓%s %s\n' "$c_grn" "$c_reset" "$*"; }
warn() { printf '  %s!%s %s\n' "$c_ylw" "$c_reset" "$*"; }
err()  { printf '  %s✗%s %s\n' "$c_red" "$c_reset" "$*" >&2; }
dim()  { printf '  %s%s%s\n'   "$c_dim" "$*" "$c_reset"; }

# --- Mapping: source path inside repo  →  destination inside $HOME ----------
# Edit this list when you add new dotfiles.
declare -a LINKS=(
    "bash/.bashrc                    .bashrc"
    "bash/.bash_profile              .bash_profile"
    "git/.gitconfig                  .gitconfig"
    "git/.gitignore_global           .gitignore_global"
    "git/.gitmessage                 .gitmessage"
    "vim/.vimrc                      .vimrc"
    "tmux/.tmux.conf                 .tmux.conf"
    "editor/.editorconfig            .editorconfig"
    "starship/starship.toml          .config/starship.toml"
)

# --- helpers ----------------------------------------------------------------
backup() {
    local target="$1"
    [ -e "$target" ] || [ -L "$target" ] || return 0
    if (( DRY_RUN )); then
        dim "would back up $target → $BACKUP_DIR/"
        return 0
    fi
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    warn "backed up existing $target → $BACKUP_DIR/"
}

link_one() {
    local src_rel="$1" dst_rel="$2"
    local src="$DOTFILES_DIR/$src_rel"
    local dst="$HOME_DIR/$dst_rel"

    if [ ! -e "$src" ]; then
        err "missing source: $src_rel"
        return 1
    fi

    # Already correctly linked?
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        ok "$dst_rel (already linked)"
        return 0
    fi

    # Make parent dir.
    if (( ! DRY_RUN )); then
        mkdir -p "$(dirname "$dst")"
    fi

    # Back up anything in the way.
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        backup "$dst"
    fi

    if (( DRY_RUN )); then
        dim "would link $dst → $src"
    else
        ln -s "$src" "$dst"
        ok "linked $dst_rel → $src_rel"
    fi
}

unlink_one() {
    local src_rel="$1" dst_rel="$2"
    local src="$DOTFILES_DIR/$src_rel"
    local dst="$HOME_DIR/$dst_rel"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        if (( DRY_RUN )); then
            dim "would remove $dst"
        else
            rm "$dst"
            ok "removed $dst_rel"
        fi
    else
        dim "skip $dst_rel (not a link to this repo)"
    fi
}

# --- main -------------------------------------------------------------------
if (( UNINSTALL )); then
    info "uninstalling dotfiles symlinks"
    for entry in "${LINKS[@]}"; do
        # shellcheck disable=SC2086
        set -- $entry
        unlink_one "$1" "$2"
    done
    say
    ok "done."
    exit 0
fi

info "installing dotfiles from $DOTFILES_DIR"
(( DRY_RUN )) && warn "dry-run mode — no changes will be made"

for entry in "${LINKS[@]}"; do
    # shellcheck disable=SC2086
    set -- $entry
    link_one "$1" "$2"
done

# Symlink any scripts in scripts/ into ~/.local/bin
if [ -d "$DOTFILES_DIR/scripts" ]; then
    info "installing scripts → ~/.local/bin"
    if (( ! DRY_RUN )); then
        mkdir -p "$HOME_DIR/.local/bin"
    fi
    shopt -s nullglob
    for script in "$DOTFILES_DIR/scripts/"*; do
        [ -f "$script" ] || continue
        name="$(basename "$script")"
        dst="$HOME_DIR/.local/bin/$name"
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$script" ]; then
            ok "$name (already linked)"
            continue
        fi
        [ -e "$dst" ] && backup "$dst"
        if (( DRY_RUN )); then
            dim "would link $dst → $script"
        else
            ln -s "$script" "$dst"
            chmod +x "$script"
            ok "linked $name"
        fi
    done
fi

say
if (( DRY_RUN )); then
    info "dry run complete."
else
    info "installation complete."
    [ -d "$BACKUP_DIR" ] && say "  backups saved to: $BACKUP_DIR"
    say "  start a new shell or run: exec \$SHELL -l"
fi
