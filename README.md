# Dotfiles

Note: if you are trying to use hyperland, it's better if you install gnome (gdm3) first.
Personal Linux development environment managed with Git and GNU Stow.

## Requirements

- Git
- GNU Stow

### Debian

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
git clone https://github.com/JiruGutema/dotfiles.git ~/dotfiles
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

## Adding new Packages

First move the configuration files to a new package directory. For example, to add a new package called `.config/custom` that lives under your home directory, do the following:

1. Move the configuration files to `dotfiles/custom/.config/custom/`
2. Then run the following command to create symlinks:

   ```bash
   stow custom
   ```

3. verify that the symlinks were created correctly:

   ```bash
   ls -l ~/.config/custom
   ```

4. Update your repository with the new package if you have set up a remote repository:

## Adding new packages that exist in the home directory

If you already have a configuration file on your system and want to avoid moving it manually, you can use the --adopt flag. This tells Stow to automatically move the existing file into your dotfiles directory and create the symlink.

<!-- WARNING: Make sure you have your configuration backed up with Git before doing this, as --adopt will instantly stage and link the file. -->

```bash
cd ~/dotfiles
stow --adopt <package_name>
```

## Updating a Packages

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

## for firefox styles

Please run the following to stow for snap firefox:

```
cd ~/dotfiles
stow -t /home/jiren/snap/firefox/common firefox
```

Note: please check your firefox profile first. you can get one by going to
`about:support` and then opening the folder.

## Common Packages

- `bash` — Bash configuration and aliases
- `git` — Git configuration
- `nvim` — Neovim configuration
- `zellij` — Zellij terminal workspace configuration
- `tmux` — Tmux confifguration
- `hypr` — Hyprland tiling compositor (Omarchy aesthetic)
- `waybar` — Waybar status bar (Tokyo Night Omarchy theme)
- `wofi` — Wofi application launcher (Omarchy style)

### Requirements for neovim

- Neovim ≥ 0.10
- Node.js ≥ 18 (required for Copilot and several LSP servers)
- Git
- A Nerd Font (recommended: FiraCode Nerd Font or JetBrainsMono Nerd Font)

## Keybindings

Original Lazyvim keybindings are used for most operations.

- <http://www.lazyvim.org/keymaps>
- key bindingings can be found under config/keymaps.lua

## Notes

- Stow manages symlinks only.
- Existing files may need to be moved or backed up before stowing.
- Package directories should mirror the target directory structure in `$HOME`.
- For tmux, make sure you have installed tpm (Tmux Plugin Manager)
