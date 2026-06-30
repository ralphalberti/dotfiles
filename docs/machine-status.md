# Machine Status

This document summarizes the current state of each development machine.

| Machine | Status | Notes |
|----------|:------:|-------|
| **iMac** | ✅ Complete | Primary dotfiles maintainer. |
| **MacBook Pro** | ✅ Complete | Portable macOS development machine. |
| **Arch Linux** | ✅ Complete | Primary Linux development machine. |

## Shared Configuration

The following configuration is synchronized across all machines.

- GNU Stow deployment
- Git configuration
- Zsh configuration
- Ghostty configuration
- Dotfiles repository located at `~/.dotfiles`

## Machine-Specific Notes

### iMac

- Homebrew Python 3.14
- pipx-managed Black and Ruff
- Shared virtual environment: `~/.venvs/sandbox`

### MacBook Pro

- Mirrors the iMac development environment.
- Serves as the portable macOS workstation.

### Arch Linux

- Uses the Arch package ecosystem (`pacman`).
- Platform-specific shell behavior isolated in `arch.zsh`.

## Notes

- GitHub is the canonical source of truth.
- The iMac remains the primary repository maintainer.
- Neovim is maintained in a separate GitHub repository.
- Configuration is deployed using GNU Stow.
