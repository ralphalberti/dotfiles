# Changelog

All notable changes to this repository will be documented in this file.

## Unreleased

### Added

- Created the initial dotfiles repository.
- Added Ghostty configuration.
- Added Git configuration snapshots.
- Added zsh configuration snapshots.
- Added documentation for provisioning a new machine.
- Added repository architecture documentation.
- Added engineering house conventions.

### Changed

- Refactored the zsh configuration into shared and platform-specific modules.
- Relocated the repository from `~/Projects/dotfiles` to `~/.dotfiles`.
- Reorganized the repository around shared and platform-specific configuration.
- Replaced the monolithic `.zshrc` with a modular configuration consisting of:
  - `common.zsh`
  - `aliases.zsh`
  - `macos.zsh`
  - `arch.zsh`
- Updated the repository documentation to describe the architecture, goals, and engineering conventions.

### Tested

- Verified the refactored zsh configuration on macOS.
- Confirmed that the live shell behaves identically after the refactor.
- Verified that platform-specific configuration is correctly isolated.

### Planned

- Introduce GNU Stow for symlink management.
- Convert application configurations into Stow packages.
- Synchronize the completed architecture across all supported machines.

### Notes

- GitHub is the canonical source of truth for this repository.
- The iMac is currently the primary maintainer machine during the initial build-out.
- Neovim configuration is maintained separately in the `kickstart-modular.nvim` repository.
