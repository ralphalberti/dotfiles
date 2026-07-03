# Architecture

This repository manages a personal development environment across macOS and Arch Linux.

The primary goals are:

- Maintain a consistent development environment across multiple machines.
- Keep configuration modular and easy to understand.
- Store all configuration in Git.
- Deploy configuration safely using GNU Stow.

## Repository Location

The dotfiles repository lives in:

```text
~/.dotfiles
```

Environment configuration belongs in `~/.dotfiles`.

Software development projects belong in `~/Projects`.

## Repository Structure

The repository consists of two types of content.

### Documentation

Repository documentation lives in:

```text
docs/
```

These documents describe the architecture, engineering conventions, machine status, and future plans.

### Stow Packages

Each top-level application directory is a GNU Stow package.

```text
~/.dotfiles/
├── git/
├── ghostty/
└── zsh/
```

Each package contributes part of the filesystem beneath the user's home directory.

## Package Architecture

GNU Stow deploys configuration by creating symbolic links from the home directory into this repository.

For example:

```text
zsh/
└── .zshrc

↓

~/.zshrc
```

```text
git/
└── .gitconfig

↓

~/.gitconfig
```

```text
ghostty/
└── .config/
    └── ghostty/
        └── config.ghostty

↓

~/.config/ghostty/config.ghostty
```

The package determines the directory structure beneath the target directory. GNU Stow mirrors that structure using symbolic links.

## Zsh Architecture

The zsh configuration is intentionally modular.

```text
.zshrc
    │
    ├── common.zsh
    ├── aliases.zsh
    └── Platform
          ├── macos.zsh
          └── arch.zsh
```

Shared behavior is defined once.

Platform-specific behavior is isolated into small, focused files.

## Design Principles

The repository follows a few guiding principles.

- GitHub is the canonical source of truth.
- The repository contains the authoritative configuration.
- Live configuration is deployed using symbolic links.
- Shared configuration is preferred over duplicated configuration.
- Platform-specific differences should remain small and isolated.
- Documentation explains why decisions were made, not only what they are.

## Current Stow Packages

The repository currently manages the following application packages:

- `zsh`
- `git`
- `ghostty`
- `dircolors`

Each package is self-contained and can be deployed independently using GNU Stow.
