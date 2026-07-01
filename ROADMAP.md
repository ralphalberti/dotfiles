# Dotfiles Roadmap

## Completed

- ✅ Established a dedicated `~/.dotfiles` repository.
- ✅ Adopted GNU Stow for configuration deployment.
- ✅ Modularized zsh into shared and platform-specific components.
- ✅ Standardized Git configuration across all machines.
- ✅ Added Ghostty as a managed configuration package.
- ✅ Synchronized iMac, MacBook Pro, and Arch Linux.
- ✅ Documented repository architecture, toolkit, machine status, and provisioning workflow.

## Near Term

- Tag the initial stable release (`v1.0.0`).
- Continue refining documentation as the repository evolves.
- Remove temporary pre-Stow backup files after sufficient validation.
- Periodically review repository structure and documentation for clarity.

## Future Packages

Potential configuration packages include:

- tmux
- lazygit
- starship
- wezterm
- aerospace (macOS)
- additional terminal and shell tooling as they mature

Packages should be added only after their configuration has stabilized.

## Long-Term Goals

- Maintain a single, reproducible development environment across supported platforms.
- Keep platform-specific configuration isolated while maximizing shared configuration.
- Treat the repository as a living engineering project with clear documentation, clean Git history, and reproducible deployment.
