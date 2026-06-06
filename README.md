# Dotfiles

Personal Linux development environment managed with Git and GNU Stow.

## Requirements

* Git
* GNU Stow

### Ubuntu

```bash
sudo apt update
sudo apt install git stow
```

## Repository Structure

```text
.
├── bash/
├── git/
├── nvim/
├── zellij/
└── ...
```

Each top-level directory is a Stow package. Files inside each package mirror their destination in `$HOME`.

Example:

```text
nvim/
└── .config/
    └── nvim/
        └── init.lua
```

This becomes:

```text
~/.config/nvim/init.lua
```

## Installation

Clone the repository:

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Create symlinks with Stow:

```bash
stow bash git nvim zellij
```

Or stow all packages:

```bash
stow */
```

## Updating

Edit configuration files normally through their locations in `$HOME`:

```bash
nvim ~/.config/nvim/init.lua
```

Changes are stored in this repository because the files are symlinked.

Commit and push updates:

```bash
git add .
git commit -m "Update configuration"
git push
```

## Removing a Package

Unstow a package:

```bash
stow -D nvim
```

Restow it:

```bash
stow nvim
```

## Common Packages

* `bash` — Bash configuration and aliases
* `git` — Git configuration
* `nvim` — Neovim configuration
* `zellij` — Zellij terminal workspace configuration

## Notes

* Stow manages symlinks only.
* Existing files may need to be moved or backed up before stowing.
* Package directories should mirror the target directory structure in `$HOME`.
