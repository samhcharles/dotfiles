# ~/.bashrc — entry point. Bail for non-interactive shells.
case $- in *i*) ;; *) return ;; esac

# Resolve the dotfiles directory from this file's symlink target.
_src="${BASH_SOURCE[0]}"
[ -L "$_src" ] && _src="$(readlink "$_src")"
DOTFILES_DIR="$(cd "$(dirname "$_src")/.." && pwd)"
unset _src
export DOTFILES_DIR

for _m in "$DOTFILES_DIR/bash/config"/*.sh; do
    [ -r "$_m" ] && . "$_m"
done
unset _m

# Per-machine overrides — never tracked.
[ -r "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
