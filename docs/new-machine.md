# New Machine Setup

This document describes the process for provisioning a new development machine.

## Prerequisites

Install the core tools appropriate for the platform.

### Common

- Git
- zsh
- GNU Stow
- Neovim
- Python
- pipx
- Node.js / npm

### macOS

- Homebrew
- Ghostty

### Arch Linux

- `pacman`
- Ghostty

## Clone Repositories

Clone the required repositories into the home directory.

```bash
git clone git@github.com:ralphalberti/dotfiles.git ~/.dotfiles
git clone git@github.com:ralphalberti/kickstart-modular.nvim.git ~/Projects/kickstart-modular.nvim
```

## Deploy Dotfiles

From the repository root:

```bash
cd ~/.dotfiles

stow zsh
stow git
stow ghostty
```

If configuration files already exist, back them up before deploying the Stow packages.

## Verification

Verify the symbolic links.

```bash
ls -l ~/.zshrc
ls -l ~/.gitconfig
ls -l ~/.config/ghostty
```

Verify the active configuration.

```bash
git config --get user.name
git config --get user.email

ghostty +show-config
```

## Post-Installation

- Install additional development tools as needed.
- Restore or create the shared Python virtual environment.
- Verify Neovim plugins and language servers.
- Confirm shell aliases and platform-specific configuration.
