# dotfiles

My bash, git, vim, tmux, and editorconfig setup. Symlink-based install.

## Install

```sh
git clone https://github.com/samhcharles/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` creates symlinks from `$HOME` into this repo. Anything it would
overwrite is moved to `~/.dotfiles-backup/<timestamp>/` first. Re-running is safe.

Preview without changes:

```sh
./install.sh --dry-run
```

Uninstall (removes only symlinks that point into this repo):

```sh
./install.sh --uninstall
```

## Layout

```
bash/      .bashrc, .bash_profile, modular config/*.sh
git/       .gitconfig, .gitignore_global, .gitmessage
vim/       .vimrc
tmux/      .tmux.conf
editor/    .editorconfig
install.sh
```

## Per-machine overrides

These files are never tracked. Put identity and machine-specific settings here:

- `~/.bashrc.local` — sourced at the end of `.bashrc`
- `~/.gitconfig.local` — included at the end of `.gitconfig`

Git identity **must** go in `~/.gitconfig.local`:

```
[user]
    name = Your Name
    email = you@example.com
```

## License

MIT — see [LICENSE](LICENSE).
