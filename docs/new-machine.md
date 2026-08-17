# New Machine Setup

**Version:** 1.0
**Last Updated:** 2026-08-17
**Status:** Living Document

# About This Document

This document describes the process for provisioning a new development machine
and bringing it into the existing development environment.

The procedure favors safety and verification over speed. Existing configuration
should be inspected and backed up before anything is replaced or managed by
GNU Stow.

## Contents

- [Before You Begin](#before-you-begin)
- [Install Prerequisites](#install-prerequisites)
- [Configure GitHub SSH Access](#configure-github-ssh-access)
- [Clone Repositories](#clone-repositories)
- [Deploy Dotfiles](#deploy-dotfiles)
- [Configure Tailscale](#configure-tailscale)
- [Verification](#verification)
- [Post-Installation](#post-installation)
- [Related Documentation](#related-documentation)

# Before You Begin

Inspect the machine for existing configuration before cloning repositories or
deploying dotfiles.

Pay particular attention to:

```text
~/.zshrc
~/.gitconfig
~/.config/ghostty
~/.config/nvim
```

If any of these paths already contain configuration that should be preserved,
back them up before continuing.

Do not run Stow until potential conflicts have been identified and handled.

# Install Prerequisites

Install the core tools appropriate for the platform.

## Common

- Git
- Zsh
- GNU Stow
- Neovim
- Python
- pipx
- Node.js / npm
- Tailscale

## macOS

- Homebrew
- Ghostty
- GNU coreutils where required by the shared shell environment

## Arch Linux

- `pacman`
- Ghostty

Use the platform's normal package-management workflow rather than treating this
document as a package-version inventory.

# Configure GitHub SSH Access

GitHub SSH access must work before cloning the repositories with their SSH
URLs.

Configure or restore the machine's SSH key and add the corresponding public key
to GitHub as appropriate.

Verify authentication before continuing:

```bash
ssh -T git@github.com
```

Detailed SSH configuration, machine aliases, key information, and
troubleshooting belong in the SSH and remote-development reference.

# Clone Repositories

Clone the dotfiles repository directly into the home directory:

```bash
git clone git@github.com:ralphalberti/dotfiles.git ~/.dotfiles
```

Clone the Neovim configuration directly into the location Neovim uses:

```bash
git clone git@github.com:ralphalberti/kickstart-modular.nvim.git ~/.config/nvim
```

The Neovim configuration is maintained as its own Git repository and is not
deployed through the dotfiles Stow packages.

# Deploy Dotfiles

Before running Stow, confirm that conflicting configuration files have already
been backed up or otherwise handled.

From the dotfiles repository root:

```bash
cd ~/.dotfiles

stow dircolors
stow ghostty
stow git
stow zsh
```

The managed Stow packages are:

- `dircolors`
- `ghostty`
- `git`
- `zsh`

Repository directories such as `docs/` and `private/` are not Stow packages.

# Configure Tailscale

Install and authenticate Tailscale on the new machine.

Verify that the machine appears in the tailnet and can communicate with the
other development machines.

Tailscale provides an alternate remote-access path in addition to LAN SSH.
Detailed host aliases, exit-node configuration, Mullvad integration, and
troubleshooting belong in the dedicated reference documents.

# Verification

Verify the environment before considering provisioning complete.

## Machine Identity

Confirm the machine identity:

```bash
hostname
```

## Dotfiles

Verify representative symbolic links:

```bash
ls -l ~/.zshrc
ls -l ~/.gitconfig
ls -l ~/.config/ghostty
```

Confirm that the expected paths resolve into `~/.dotfiles`.

## Git

Verify Git identity:

```bash
git config --get user.name
git config --get user.email
```

Verify GitHub SSH authentication:

```bash
ssh -T git@github.com
```

## Shell

Start a fresh Zsh session and verify:

- The expected prompt loads.
- Shared aliases are available.
- Platform-specific configuration is active.
- File-listing behavior is correct for the platform.

## Ghostty

Verify that Ghostty loads the expected configuration:

```bash
ghostty +show-config
```

## Neovim

Open Neovim and verify:

- The configuration loads without errors.
- Plugins are available.
- Language servers and formatters required by the current workflow are
  available.

Confirm the repository itself is healthy:

```bash
git -C ~/.config/nvim status
git -C ~/.config/nvim remote -v
```

## Python Tooling

Verify the Python environment and pipx-managed tools required by the current
development workflow.

On machines using the shared sandbox environment, restore or create:

```text
~/.venvs/sandbox
```

## Network and Remote Access

Verify both remote-access paths where applicable:

- LAN SSH
- Tailscale connectivity and SSH transport

Confirm that the new machine can reach the other development machines using the
documented SSH aliases.

# Post-Installation

After the core environment is working:

- Install additional development tools as needed.
- Restore or create the shared Python virtual environment where applicable.
- Verify Neovim plugins, language servers, and formatters.
- Confirm shell aliases and platform-specific configuration.
- Confirm Git repositories are clean and connected to the expected remotes.
- Update `machine-status.md` if the new machine changes the documented machine
  inventory or roles.

# Related Documentation

- [`architecture.md`](architecture.md)
- [`developer-toolkit.md`](developer-toolkit.md)
- [`house-conventions.md`](house-conventions.md)
- [`machine-status.md`](machine-status.md)
- [`references/ssh-and-remote-development.md`](references/ssh-and-remote-development.md)
- [`references/tailscale-and-mullvad.md`](references/tailscale-and-mullvad.md)
