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

If you're returning to this project after some time away, start with these documents.

- `docs/architecture.md` — Overall repository architecture and design.
- `docs/house-conventions.md` — Engineering conventions and maintenance philosophy.
- `docs/machine-status.md` — Current state of each development machine.
- `docs/new-machine.md` — Checklist for provisioning a new machine.
- `ROADMAP.md` — Planned enhancements and future work.

## Design Principles

- GitHub is the canonical source of truth.
- `~/.dotfiles` is the home of environment configuration.
- `~/Projects` is reserved for software and creative projects.
- Shared configuration is preferred whenever possible.
- Platform-specific behavior is isolated into small, focused files.
- Documentation should explain **why** decisions were made, not only **what** they are.

## Current Status

- ✅ Multi-platform zsh configuration completed.
- ✅ Repository relocated to `~/.dotfiles`.
- 🚧 GNU Stow integration planned.
- 🚧 Additional application configurations will be migrated over time.
