# Neovim Configs

This repo contains my Neovim configurations for WSL.

## Structure

- `wsl/` — Neovim config for WSL (Ubuntu)

## Requirements

- Neovim (recommended: latest stable)
- Git
- A terminal emulator:
  - Alacritty

Optional (depending on plugins):
- `ripgrep` (`rg`) for Telescope `live_grep`
- A Nerd Font (for icons, if using a file explorer like neo-tree)

## Install (WSL)

Neovim config location:

- `~/.config/nvim`

To install the WSL config:

```bash
# from your home directory
mkdir -p ~/.config/nvim

# If you prefer symlink: clone this repo and symlink the env config (ssh)
git clone git@github.com:sudo-Marius/wsl-nvim.git ~/repos/nvim-configs
ln -sfn ~/repos/nvim-configs/wsl ~/.config/nvim

# simple approach: copy files (no symlink)
cp -r ~/repos/nvim-configs/wsl/* ~/.config/nvim/
