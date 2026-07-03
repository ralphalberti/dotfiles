# Dotfiles

Personal development environment for macOS and Arch Linux.

This repository contains the configuration, documentation, and conventions used to maintain a consistent development environment across multiple machines.

## Goals

- Maintain a consistent development environment across macOS and Arch Linux.
- Keep configuration modular, documented, and easy to understand.
- Make changes incrementally using Git feature branches.
- Optimize the environment for long-term maintainability.

## Repository Layout

```text
docs/       Documentation and project notes
ghostty/    Ghostty terminal configuration
git/        Git configuration
zsh/        Zsh configuration
```

## Documentation

If you're returning to this project after some time away, these documents provide the quickest path back into the repository.

- `docs/architecture.md` — Repository architecture and GNU Stow package layout.
- `docs/developer-toolkit.md` — Core development tools and supporting utilities.
- `docs/house-conventions.md` — Engineering conventions and maintenance philosophy.
- `docs/machine-status.md` — Current deployment status of all supported machines.
- `docs/new-machine.md` — Provisioning guide for a new development machine.
- `ROADMAP.md` — Planned enhancements and future work.

## Design Principles

- GitHub is the canonical source of truth.
- `~/.dotfiles` is the home of environment configuration.
- `~/Projects` is reserved for software and creative projects.
- Shared configuration is preferred whenever possible.
- Platform-specific behavior is isolated into small, focused files.
- Documentation should explain **why** decisions were made, not only **what** they are.

## Deployment

Configuration is deployed using GNU Stow.

Each top-level application directory is maintained as an independent Stow package.

```text
zsh/
git/
ghostty/
dircolors/
```

Packages are deployed into the home directory using symbolic links.

```bash
stow zsh
stow git
stow ghostty
stow dircolors
```

See `docs/architecture.md` for additional information about the repository structure and package layout.

## Current Status

- ✅ Multi-platform zsh configuration completed.
- ✅ Repository relocated to `~/.dotfiles`.
- ✅ GNU Stow adopted for deployment of dotfiles.
- ✅ zsh, git, Ghostty, and dircolors managed as Stow packages.
- 🚧 Additional application packages will be added over time.

## Architecture Diagram

~/.dotfiles
│
├── dircolors
├── ghostty
├── git
└── zsh
     │
     ▼
GNU Stow
     │
     ▼
Home directory
