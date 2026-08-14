# Developer Toolkit

This document describes the software tools that make up the development environment across all supported machines.

The goal is to maintain a consistent, productive, and easily reproducible toolchain across macOS and Arch Linux.

---

# Core Development Environment

## Terminal

- **Ghostty** — Primary terminal emulator on all supported machines.
- **JetBrainsMono Nerd Font** — Programming font with integrated Nerd Font icons.
- **TokyoNight** — Preferred terminal color theme.

---

## Shell Environment

- **Zsh** — Primary interactive shell on all supported machines.
- **GNU Stow** — Deploys configuration by creating symbolic links from the repository into the home directory.
- **zinit** — Plugin manager for loading and managing Zsh plugins.
- **zoxide** — Smart directory jumper that learns frequently visited locations.

---

## Editor

- **Neovim** — Primary editor for software development, documentation, and Git workflows.
- Configuration is maintained in the separate `kickstart-modular.nvim` repository.

---

# Development Languages

## Python

- **Homebrew Python** — Standard Python installation on macOS.
- **System Python** — Standard Python installation on Arch Linux.
- **pipx** — Installs Python command-line applications into isolated virtual environments.
- **Shared virtual environment** (`~/.venvs/sandbox`) — Common Python environment created with Python's built-in `venv` module and shared by development tools such as Neovim and `debugpy`.

### Common Python Tools

- **Ruff** — Extremely fast Python linter and formatter.
- **Black** — Opinionated Python code formatter that produces consistent, readable code.

---

## JavaScript

- **Node.js** — JavaScript runtime used by many development tools.
- **npm** — Package manager used to install JavaScript packages and command-line utilities.

### Global Tools

- **markdownlint-cli** — Checks Markdown files for style and formatting issues.
- **prettier** — Formats Markdown, JSON, JavaScript, YAML, and many other file types.
- **prettierd** — Background service that keeps Prettier running for much faster formatting.

---

# Version Control

- **Git** — Distributed version control system used for source code, documentation, and configuration.
- **GitHub** — Remote repository hosting using SSH authentication.

### Global Git Identity

- **Name** — Ralph Alberti
- **Email** — <ralphalberti21@gmail.com>

---

# Remote Development

- **SSH** — Secure remote shell used to administer the other development machines.
- **SCP** — Secure file copy over SSH.
- **rsync** — Efficiently synchronizes files and directories between systems while transferring only changed data.

Remote administration is performed almost entirely over SSH.

---

# Networking

- **Tailscale** — Private overlay network connecting the iMac, MacBook Pro, and Arch Linux systems while preserving direct LAN access.
- **Mullvad Exit Nodes** — Optional VPN-protected Internet egress provided through the Tailscale Mullvad integration.
- **WireGuard** — Secure tunneling technology underlying Tailscale and Mullvad connectivity.

---

# Documentation

- **MarkText** — Primary Markdown editor for reviewing and maintaining documentation.
- **Markdown** — Standard format used throughout the documentation.
- **Mermaid** — Diagram language used to visualize architecture and workflows.

Documentation is maintained alongside configuration using Git.

---

# Productivity

## macOS

- **Raycast** — Application launcher and productivity utility.

## Linux

- **qBittorrent** — Torrent client on Arch Linux bound to `tailscale0` and verified to use Mullvad exit-node egress without falling back to the normal ISP path during fail-closed testing.

Platform-specific tools remain intentionally small.

---

# Command-Line Utilities

- **bat** — Improved replacement for `cat` with syntax highlighting.
- **GNU ls** — Primary directory listing utility enhanced with custom aliases and glob patterns.
- **eza** — Modern directory listing utility with rich formatting and tree views.
- **fd**— Simple and fast alternative to `find`.
- **fzf** — Interactive fuzzy finder for files, directories, commands, and history.
- **jq** — Command-line processor for parsing, filtering, and formatting JSON.
- **ripgrep** — Extremely fast recursive text search utility.

---

# Deployment

Configuration is maintained in `~/.dotfiles` and deployed using GNU Stow.

Managed packages:

- `dircolors`
- `ghostty`
- `git`
- `zsh`

Each package is self-contained and can be deployed independently.

---

# Design Philosophy

The toolkit is intentionally curated.

- Prefer one excellent tool over several similar tools.
- Standardize tools across all supported machines whenever practical.
- Keep platform-specific differences to a minimum.
- Document significant tools and workflows.
- Choose tools that integrate well with Git and Markdown.
- Favor simplicity, consistency, and long-term maintainability.

---

# Related Documentation

### Repository

- [README](../README.md)
- [Architecture](architecture.md)
- [House Conventions](house-conventions.md)
- [Documentation Standards](documentation-standards.md)

### Environment

- [Machine Status](machine-status.md)
- [New Machine](new-machine.md)

### Networking

- [Home Network](home-network.md)
- [SSH & Remote Development](references/ssh-and-remote-development.md)
- [Tailscale & Mullvad](references/tailscale-and-mullvad.md)
