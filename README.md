<div align="center">

# dotfiles

**A modular, opinionated environment for shell, git, editor, and terminal.**

[![Shell](https://img.shields.io/badge/shell-bash-1f425f.svg?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Editor](https://img.shields.io/badge/editor-vim-019733.svg?logo=vim&logoColor=white)](https://www.vim.org/)
[![Tmux](https://img.shields.io/badge/multiplexer-tmux-1bb91f.svg?logo=tmux&logoColor=white)](https://github.com/tmux/tmux)
[![Prompt](https://img.shields.io/badge/prompt-starship-DA627D.svg?logo=starship&logoColor=white)](https://starship.rs)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

</div>

---

## Highlights

- **Modular shell config** — exports, aliases, functions, and prompt split into focused files. No more 600-line `.bashrc`.
- **Sensible git defaults** — rebase pulls, autosquash, conflict markers, signed tags, sane diff/merge tools.
- **Minimal but powerful vim** — sane defaults, no plugin manager required.
- **Tmux that respects your terminal** — true color, vi keys, mouse support, intuitive splits.
- **Starship prompt** — fast, informative, language-aware.
- **One-command install** — symlink-based, idempotent, safely backs up anything it would overwrite.
- **No secrets, ever** — designed for public hosting.

## Layout

```
dotfiles/
├── bash/         shell rc, profile, aliases, modular config/
├── git/          gitconfig, ignore, commit message template
├── vim/          minimal vimrc with sane defaults
├── tmux/         tmux.conf with true-color + vi keys
├── starship/     starship.toml prompt config
├── editor/       .editorconfig
├── scripts/      utility scripts symlinked into ~/.local/bin
└── install.sh    idempotent installer
```

Each top-level directory mirrors the layout of `$HOME` — installing is just symlinking the right files into place.

## Install

```sh
git clone https://github.com/samhcharles/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer:

1. Backs up any existing file it would replace into `~/.dotfiles-backup/<timestamp>/`.
2. Creates symlinks from `$HOME` into this repo.
3. Skips files that are already correctly linked.
4. Prints a summary at the end.

To preview without changing anything:

```sh
./install.sh --dry-run
```

To uninstall:

```sh
./install.sh --uninstall
```

## What you get

### Shell

- `~/.bashrc` sources everything in `bash/config/*.sh` so you can drop in new modules without touching the entry point.
- History: large, deduplicated, shared across sessions, immune to losing the last command on Ctrl-C.
- Aliases for the things you actually type 100 times a day (`gs`, `gp`, `..`, `...`, `mkcd`, ...).
- Functions: `extract` (any archive), `mkcd`, `up N` (cd up N levels), `serve` (one-line http server), `gi` (gitignore.io fetch).

### Git

- `pull.rebase = true`, `rebase.autosquash = true`, `rebase.autostash = true`.
- `merge.conflictstyle = zdiff3` for vastly more readable conflicts.
- `diff.algorithm = histogram`, `diff.colorMoved = zebra`.
- Useful aliases: `git lg`, `git st`, `git amend`, `git fixup`, `git wip`, `git unwip`.
- A commit message template at `~/.gitmessage` with conventional-commit hints.

### Vim

- 2-space indent, smart indent, line numbers, relative numbers in normal mode.
- Persistent undo, sensible search defaults, no swap/backup litter.
- `<leader>` set to space, with quality-of-life mappings (`<leader>w` write, `<leader>q` quit).

### Tmux

- Prefix is `C-a` (still works alongside `C-b` if you're a traditionalist — see config).
- Splits with `|` and `-` that open in the current path.
- Vi-style copy mode, mouse on, true color enabled.
- Status bar that doesn't waste pixels.

### Starship

- Two-line prompt, command duration, git status, language versions, exit code.
- Fast even on slow filesystems thanks to scan timeouts.

## Philosophy

> Touch as little as possible. Make every line earn its place. Optimize for the next person reading this — even if that's future you.

This repo deliberately avoids:

- Plugin managers and large dependency trees.
- Anything that mutates files outside `$HOME`.
- Machine-specific or secret-bearing config (use `~/.bashrc.local`, `~/.gitconfig.local`).

## Per-machine overrides

The shell sources `~/.bashrc.local` at the very end if it exists. The git config includes `~/.gitconfig.local` if present. Put anything machine-specific or secret in those — they're never tracked.

## License

MIT — see [LICENSE](LICENSE).
