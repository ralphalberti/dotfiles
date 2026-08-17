# House Conventions

**Version:** 1.0
**Last Updated:** 2026-08-17
**Status:** Living Document

# About This Document

This document records the working conventions used to maintain the development
environment.

These conventions favor clarity, consistency, reversibility, and long-term
maintainability. They are practical defaults rather than rigid rules.

# Repository Workflow

- Use short-lived feature branches for meaningful changes.
- Keep `main` clean and stable.
- Test locally before committing.
- Commit focused, understandable changes.
- Merge only after the change feels complete.
- Inspect repository state before destructive Git operations.
- Prefer reversible operations when learning or when repository state is
  complicated.
- Verify completed work before deleting branches, stashes, or other recovery
  points.
- Push meaningful completed work so GitHub remains the durable source of truth.

# Tool Preferences

Prefer modern CLI tools where they improve readability and workflow.

- Use `bat` instead of `cat` when reviewing files.
- Use `rg` instead of recursive `grep`.
- Use `fd` instead of `find`.
- Use `ls` or `eza` depending on which gives the clearest output.
- Prefer Markdown that reads well as plain text, not only when rendered.

# Dotfiles Philosophy

- GitHub is the source of truth.
- `~/.dotfiles` contains environment configuration.
- `~/Projects` is reserved for software and creative projects.
- Prefer shared configuration first.
- Introduce platform-specific configuration only when behavior genuinely
  differs.
- Preserve useful experiments in documentation rather than loading them
  automatically.

# Engineering Style

- Make small, incremental, reversible changes.
- Understand the architecture before introducing new tools.
- Prefer clear structure over clever shortcuts.
- Solve the problem you actually have before adding abstraction.
- Optimize configuration files for Future Ralph.
