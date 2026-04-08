# ~/.bashrc — entry point
# Modular shell config. Real settings live in ~/.dotfiles/bash/config/*.sh.
# Keep this file boring; put new things in a focused module instead.

# Bail out for non-interactive shells.
case $- in
    *i*) ;;
      *) return;;
esac

# Resolve the dotfiles directory regardless of where this rc lives.
if [ -L "$HOME/.bashrc" ]; then
    DOTFILES_DIR="$(cd "$(dirname "$(readlink "$HOME/.bashrc")")/.." && pwd)"
else
    DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
fi
export DOTFILES_DIR

# Source every module in config/, in lexical order.
if [ -d "$DOTFILES_DIR/bash/config" ]; then
    for _module in "$DOTFILES_DIR/bash/config"/*.sh; do
        [ -r "$_module" ] && . "$_module"
    done
    unset _module
fi

# Per-machine overrides — never tracked.
[ -r "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
