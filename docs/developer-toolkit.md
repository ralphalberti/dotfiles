# Developer Toolkit

This document summarizes the core tools that make up the development environment across all supported machines.

## Terminal

- Ghostty
- JetBrainsMono Nerd Font
- TokyoNight theme

## Shell

- zsh
- GNU Stow
- zinit
- zoxide

## Editor

- Neovim
- Configuration maintained in the separate `kickstart-modular.nvim` repository.

## Core CLI Tools

- bat
- eza
- fd
- fzf
- jq
- ripgrep

## Version Control

- Git
- GitHub (SSH authentication)

Global Git identity:

- Name: Ralph Alberti
- Email: <ralphalberti21@gmail.com>

## Python

- Homebrew Python on macOS
- System Python on Arch Linux
- pipx for globally installed Python CLI tools
- Shared virtual environment: `~/.venvs/sandbox`

Common Python tools:

- Black
- Ruff

## JavaScript

- Node.js
- npm

Global tools:

- markdownlint-cli
- prettier
- prettierd

## Deployment

Configuration is managed in the `~/.dotfiles` repository and deployed using GNU Stow.

Current application packages:

- zsh
- git
- ghostty
- dircolors
