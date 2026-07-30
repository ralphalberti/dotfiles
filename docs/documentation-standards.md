# Documentation Standards

**Version:** 1.0
**Last Updated:** 2026-07-29
**Status:** Living Document

------------------------------------------------------------------------

## Purpose

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

------------------------------------------------------------------------

## Scope

These standards apply to technical documentation maintained within this
repository.

They are intended to promote consistency, readability, and long-term
maintainability across all projects.

These standards are guidelines rather than rigid rules. Authors should
exercise judgment and adapt them when doing so improves the clarity or
effectiveness of a document.

------------------------------------------------------------------------

## Documentation Philosophy

The following principles guide all documentation.

### Document Intent Before Implementation

Describe the purpose of a system before describing how it is
implemented.

Readers should first understand **why** something exists.

------------------------------------------------------------------------

### Document Architecture Before Configuration

Focus on:

- Components
- Relationships
- Responsibilities
- Design decisions

Avoid documenting configuration details unless they are important to the
overall architecture.

------------------------------------------------------------------------

### Document What You Know

Record verified information.

If something has not yet been confirmed, avoid presenting it as fact.

Instead, capture it as an Outstanding Question.

------------------------------------------------------------------------

### Documentation Is Part of the Project

Documentation should evolve alongside the system.

Whenever a significant change is made, update the documentation while
the details are still fresh.

------------------------------------------------------------------------

## Standard Document Structure

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

------------------------------------------------------------------------

## Contents

Reference documents should include a **Contents** section near the
beginning of the document.

Guidelines:

- Place after "About This Document."
- Include only major headings.
- Use Markdown heading links.
- Do not include every subsection.

The Contents section serves both as navigation and as a high-level
summary of the document.

------------------------------------------------------------------------

## Section Formatting

Use consistent formatting to improve readability across all documents.

### Headings

Use Markdown headings (`#`, `##`, `###`) to establish a clear document
hierarchy.

- Use a single `#` heading for the document title.
- Avoid skipping heading levels.
- Use descriptive headings that reflect the content of each section.

### Section Separation

Use horizontal rules (`---`) to separate major sections within a
document.

Horizontal rules improve readability by visually separating major topics
and make longer documents easier to scan.

Avoid using horizontal rules between minor subsections unless additional
visual separation significantly improves readability.

### Paragraphs

Prefer short paragraphs focused on a single idea.

Use whitespace intentionally around headings, tables, bullet lists, and
horizontal rules to improve readability.

## Versioning

Use simple semantic versioning.

  Version   Meaning

  --------- -------------------------------------

  1.0       Initial completed document
  1.1       Meaningful additions or refinements
  2.0       Major redesign or restructuring

Update the **Last Updated** date whenever meaningful changes are made.

------------------------------------------------------------------------

## Standard Section Headings

When appropriate, consider using:

- Purpose
- Current Understanding
- Operational Notes
- Maintenance Notes
- Outstanding Questions

These headings provide consistency across documents while remaining
flexible enough for different projects.

------------------------------------------------------------------------

## Tables vs. Bullet Lists

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

------------------------------------------------------------------------

## Diagrams

Use diagrams when they communicate relationships more clearly than text.

Examples include:

- Physical topology
- Logical topology
- Process flows

Prefer simple diagrams over overly detailed ones.

------------------------------------------------------------------------

## Images

Photographs should supplement---not replace---written documentation.

Use images when they help identify:

- Equipment
- Cable routing
- Physical layouts
- Labels
- Connectors

Consider annotating photographs with callouts when appropriate.

------------------------------------------------------------------------

## Related Documentation

Where appropriate, include references to related documents.

Examples:

- `docs/home-network.md`
- `docs/cable-map.md`
- `docs/vpn.md`

This helps readers navigate between related topics.

------------------------------------------------------------------------

## Private Information

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

------------------------------------------------------------------------

## Writing Style

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

------------------------------------------------------------------------

## Revision Process

When making significant changes:

1. Update the appropriate documentation.
2. Verify accuracy.
3. Remove obsolete information.
4. Update related documents if necessary.
5. Commit documentation changes alongside implementation changes.

------------------------------------------------------------------------

------------------------------------------------------------------------

## Evolving Standards

These standards are expected to evolve as new documentation patterns and
best practices are identified.

When a convention consistently improves clarity, maintainability, or
readability across multiple projects, consider incorporating it into
this document.

## Guiding Principle

> Good documentation reduces future troubleshooting by preserving
> today's understanding.
