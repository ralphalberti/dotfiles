# House Conventions

These are the working conventions for maintaining this development environment.

## Repository Workflow

- Use short-lived feature branches for meaningful changes.
- Keep `main` clean and stable.
- Test locally before committing.
- Commit focused, understandable changes.
- Merge only after the change feels complete.

## Tool Preferences

Prefer modern CLI tools where they improve readability and workflow.

- Use `bat` instead of `cat` when reviewing files.
- Use `rg` instead of recursive `grep`.
- Use `fd` instead of `find`.
- Use `ls` or `eza` depending on which gives the clearest output.
- Prefer Markdown that reads well as plain text, not only when rendered.

## Dotfiles Philosophy

- GitHub is the source of truth.
- `~/.dotfiles` contains environment configuration.
- `~/Projects` is reserved for software and creative projects.
- Shared configuration belongs in common files.
- Platform-specific configuration belongs in platform-specific files.
- Preserve useful experiments in documentation rather than loading them automatically.

## Engineering Style

- Make small, incremental, reversible changes.
- Understand the architecture before introducing new tools.
- Prefer clear structure over clever shortcuts.
- Optimize configuration files for Future Ralph.
