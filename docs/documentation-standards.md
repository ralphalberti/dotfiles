# Documentation Standards

**Version:** 1.1
**Last Updated:** 2026-08-17
**Status:** Living Document

# About This Document

This document defines the standards used when creating and maintaining
technical documentation within this repository.

The goal is to produce documentation that is:

- Consistent
- Easy to navigate
- Easy to maintain
- Accurate
- Useful to future readers

Documentation should explain not only *what* a system is, but also *why*
it is designed the way it is.

# Scope

These standards apply to technical documentation maintained within this
repository.

They are intended to promote consistency, readability, and long-term
maintainability across all projects.

These standards are guidelines rather than rigid rules. Authors should
exercise judgment and adapt them when doing so improves the clarity or
effectiveness of a document.

# Documentation Philosophy

The following principles guide all documentation.

### Document Intent Before Implementation

Describe the purpose of a system before describing how it is
implemented.

Readers should first understand **why** something exists.

### Document Architecture Before Configuration

Focus on:

- Components
- Relationships
- Responsibilities
- Design decisions

Avoid documenting configuration details unless they are important to the
overall architecture.

### Document What You Know

Record verified information.

If something has not yet been confirmed, avoid presenting it as fact.

Instead, capture it as an Outstanding Question.

When the question is resolved, update the document with the answer rather than
leaving the resolved question behind.

### Preserve Established Knowledge

Documentation cleanup and restructuring must not discard established
information simply because it does not fit a new layout.

Preserve information that remains accurate and useful. Remove or revise
information only when it is known to be obsolete, incorrect, duplicated
elsewhere, or no longer useful.

A cleaner document should not know less than the document it replaces unless
information was intentionally removed.

### Documentation Is Part of the Project

Documentation should evolve alongside the system.

Whenever a significant change is made, update the documentation while
the details are still fresh.

# Standard Document Structure

When appropriate, documents should follow this general structure.

```text
Title

Version
Last Updated
Status

About This Document

Contents

Main Sections

Related Documentation
```

Not every document requires every section.

Use only the sections that improve clarity.

# Metadata

Living technical documents should normally begin with this metadata block
directly below the document title:

```markdown
**Version:** 1.0
**Last Updated:** YYYY-MM-DD
**Status:** Living Document
```

Use the ISO `YYYY-MM-DD` date format for consistency.

# Contents Sections

Reference documents should include a **Contents** section near the
beginning of the document.

Guidelines:

- Place after "About This Document."
- Include major headings by default.
- Include selected subsections when they materially improve navigation.
- Use Markdown heading links.
- Do not reproduce the complete heading hierarchy unnecessarily.

The Contents section serves both as navigation and as a high-level
summary of the document.

# Section Formatting

Use consistent formatting to improve readability across all documents.

### Headings

Use Markdown headings (`#`, `##`, `###`) to establish a clear document
hierarchy.

- Use `#` for the document title and major document sections.
- Use `##` for subsections within major sections.
- Use `###` for sections nested beneath a subsection.
- Avoid skipping heading levels within a section hierarchy.
- Use descriptive headings that reflect the content of each section.

The document title and major sections intentionally share the `#` level. This
convention makes longer technical documents easier to scan in rendered
Markdown and text editors.

## Section Separation

Major headings normally provide sufficient visual separation between sections.

Horizontal rules are not part of the default documentation style going
forward. They may be used selectively when additional visual separation
materially improves readability.

This convention can be revisited if the documents become harder to scan
without horizontal rules.

### Paragraphs

Prefer short paragraphs focused on a single idea.

Use whitespace intentionally around headings, tables, bullet lists, and code
blocks to improve readability.

# Versioning

Use simple semantic versioning.

  Version   Meaning

  --------- -------------------------------------

  1.0       Initial completed document
  1.1       Meaningful additions or refinements
  2.0       Major redesign or restructuring

Update the **Last Updated** date whenever meaningful changes are made.

# Standard Section Headings

When appropriate, consider using:

- Purpose
- Current Understanding
- Operational Notes
- Maintenance Notes
- Outstanding Questions

These headings provide consistency across documents while remaining
flexible enough for different projects.

# Tables vs. Bullet Lists

Use tables when readers are expected to compare information.

Examples:

- Equipment inventories
- Cable maps
- Port assignments
- Device inventories

Use bullet lists for:

- Goals
- Responsibilities
- Procedures
- Checklists
- Observations

# Diagrams

Use diagrams when they communicate relationships more clearly than text.

Examples include:

- Physical topology
- Logical topology
- Process flows

Prefer simple diagrams over overly detailed ones.

# Images

Photographs should supplement---not replace---written documentation.

Use images when they help identify:

- Equipment
- Cable routing
- Physical layouts
- Labels
- Connectors

Consider annotating photographs with callouts when appropriate.

# Markdown Linting

Repository-level Markdown linting is used to catch structural and formatting
problems while editing documentation.

Intentional repository-wide exceptions belong in `.markdownlint.json`.

The current configuration disables MD013, the line-length rule. Technical
documentation frequently contains tables, paths, commands, links, and prose
where enforcing a strict line length creates noise without improving the
document.

Other lint rules remain useful and should stay enabled. Prefer project-level
lint configuration over disabling useful diagnostics globally in an editor.

# Related Documentation

Where appropriate, include references to related documents.

Examples:

- `docs/home-network.md`
- `docs/cable-map.md`
- `docs/references/tailscale-and-mullvad.md`

This helps readers navigate between related topics.

# Private Information

Do not include sensitive information in tracked documentation.

Examples include:

- Passwords
- Recovery codes
- API keys
- VPN private keys
- Account credentials

Sensitive information should instead be stored in:

```text
private/network-secrets.md
```

The `private/` directory is intentionally excluded from version control.

# Writing Style

Prefer documentation that is:

- Clear
- Concise
- Factual
- Consistent

Avoid:

- Marketing language
- Unnecessary jargon
- Long paragraphs
- Unsupported assumptions

Write for someone who may be unfamiliar with the system---even if that
reader is your future self.

# Revision Process

When making significant changes:

1. Identify the document's purpose and authoritative scope.
2. Review the existing factual content before restructuring it.
3. Update the appropriate documentation.
4. Verify accuracy and clearly distinguish unresolved information.
5. Preserve established knowledge that remains useful.
6. Remove or revise genuinely obsolete or incorrect information.
7. Resolve outdated Outstanding Questions when answers are now known.
8. Update related documents if necessary.
9. Run Markdown linting and `git diff --check`.
10. Review the Git diff before committing.
11. Commit documentation changes alongside implementation changes when they
    describe the same work.

# Evolving Standards

These standards are expected to evolve as new documentation patterns and
best practices are identified.

When a convention consistently improves clarity, maintainability, or
readability across multiple projects, consider incorporating it into
this document.

# Guiding Principle

> Good documentation reduces future troubleshooting by preserving
> today's understanding.
