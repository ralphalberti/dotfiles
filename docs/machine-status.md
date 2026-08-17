# Machine Status

**Version:** 1.0
**Last Updated:** 2026-08-16
**Status:** Living Document

---

# About This Document

This document summarizes the current operational state, role, and important
configuration differences of each development machine.

It is intended as a high-level status reference rather than a complete
inventory of installed software or machine-specific configuration.

---

## Contents

- [Current Status](#current-status)
- [Shared Environment](#shared-environment)
- [Machine-Specific Configuration](#machine-specific-configuration)
  - [iMac](#imac)
  - [MacBook Pro](#macbook-pro)
  - [Arch Linux](#arch-linux)
- [Cross-Machine Connectivity](#cross-machine-connectivity)
- [Maintenance](#maintenance)
- [Related Documentation](#related-documentation)

# Current Status

| Machine | Status | Role |
| --- | :---: | --- |
| **iMac** | ✅ Operational | Primary dotfiles maintainer and macOS workstation. |
| **MacBook Pro** | ✅ Operational | Portable macOS development workstation. |
| **Arch Linux** | ✅ Operational | Primary Linux development workstation. |

All three machines use the shared dotfiles repository at `~/.dotfiles`.

# Shared Environment

The following configuration is synchronized or maintained consistently across
the three machines:

- Dotfiles repository located at `~/.dotfiles`
- Git and GitHub workflow
- GNU Stow deployment
- Zsh configuration
- Ghostty configuration
- Neovim development environment
- SSH configuration and machine aliases
- Tailscale connectivity

GitHub is the canonical source of truth for the dotfiles repository.

Neovim is maintained in a separate GitHub repository rather than as part of
the dotfiles repository.

# Machine-Specific Configuration

Shared configuration is preferred where practical. Platform-specific behavior
is isolated when macOS and Arch Linux require different implementations.

## iMac

- Primary dotfiles maintainer.
- Primary macOS workstation.
- Uses Homebrew Python 3.14.
- Uses pipx-managed Black and Ruff.
- Shared Python virtual environment: `~/.venvs/sandbox`.

## MacBook Pro

- Portable macOS development workstation.
- Uses the shared macOS configuration while retaining machine-specific settings
  where required.
- Participates in both LAN and Tailscale remote-access workflows.

## Arch Linux

- Primary Linux development workstation.
- Uses the Arch package ecosystem (`pacman`).
- Platform-specific shell behavior is isolated in `arch.zsh`.
- Participates in both LAN and Tailscale remote-access workflows.
- Can use Mullvad exit nodes through Tailscale when alternate Internet egress
  is required.

Detailed Mullvad, exit-node, and qBittorrent configuration belongs in the
dedicated Tailscale and Mullvad reference rather than in this status document.

# Cross-Machine Connectivity

The machines support two SSH transport paths:

- **LAN SSH** — direct communication across the home network using reserved
  local IP addresses.
- **Tailscale SSH transport** — communication across the Tailscale network
  using Tailscale names and addresses.

The SSH configuration provides separate aliases for the LAN and Tailscale
paths so the desired transport can be selected explicitly.

Detailed host aliases, SSH behavior, troubleshooting, and remote-development
examples are maintained in the SSH and remote-development reference.

# Maintenance

Update this document when:

- A machine's primary role changes.
- A machine is added, retired, rebuilt, or no longer operational.
- The shared development environment changes materially.
- A major cross-machine capability is added or removed.
- A machine-specific difference becomes important enough to document at the
  environment level.

Package versions and short-lived implementation details should generally be
documented elsewhere unless they materially affect the role or status of a
machine.

# Related Documentation

- [`architecture.md`](architecture.md)
- [`developer-toolkit.md`](developer-toolkit.md)
- [`new-machine.md`](new-machine.md)
- [`references/ssh-and-remote-development.md`](references/ssh-and-remote-development.md)
- [`references/tailscale-and-mullvad.md`](references/tailscale-and-mullvad.md)
