# Codex CLI Workflows

**Version:** 1.0
**Last Updated:** 2026-09-13
**Status:** Living Document

# About This Document

This playbook describes a repeatable way to use Codex CLI for changes to this
repository and others with a documented Git workflow. It focuses on the
decisions and review points between an initial problem and an integrated change.
Use the repository's own conventions and tests when working elsewhere.

Give Codex the problem and constraints first. Inspect and agree on an approach
before editing; verify the result in the environment that matters before
committing. The example prompts below can be adapted to the task.

## Contents

- [Working with Codex](#working-with-codex)
- [1. Describe the Problem](#1-describe-the-problem)
- [2. Inspect and Propose](#2-inspect-and-propose)
- [3. Review the Approach and Start a Branch](#3-review-the-approach-and-start-a-branch)
- [4. Implement and Verify](#4-implement-and-verify)
- [5. Validate in the Real Environment](#5-validate-in-the-real-environment)
- [6. Commit and Integrate](#6-commit-and-integrate)
- [7. Verify the Final State Independently](#7-verify-the-final-state-independently)
- [Operational Notes](#operational-notes)
- [Related Documentation](#related-documentation)

# Working with Codex

Start Codex from the repository you intend to change. Treat its explanations
and test results as evidence to review, not as a substitute for reading the
diff or trying behavior it cannot observe. Keep each request clear about the
current boundary: inspection, implementation, validation, or integration.

For a substantial task, let Codex investigate the repository before deciding
which files or implementation to use. A short conversation about the proposed
approach can prevent a plausible but ill-fitting change.

# 1. Describe the Problem

State what happens now, what should happen, where it matters, and any known
constraints. Include a concrete example or error when available. Avoid
prescribing a particular edit unless that edit is itself a requirement.

Guidance:

> In this repository, [current behavior] occurs when [trigger]. I need
> [desired behavior] on [relevant machines or environments]. Preserve
> [constraints or existing behavior]. First inspect the repository and explain
> the likely cause and options. Do not create a branch or change files yet.

Example:

> On the Arch Linux virtual console at tty1, Powerlevel10k's prompt is hard to
> read before X starts. I need a plain, readable prompt there while keeping the
> normal prompt elsewhere. Inspect the Zsh setup and propose a fix. Do not
> create a branch or edit files yet.

# 2. Inspect and Propose

Ask Codex to read the relevant code, documentation, tests, Git state, and
recent history. Its proposal should identify the intended files, explain why
the change fits the repository, describe how it will verify the result, and
name any validation that requires access to another machine or physical device.

Guidance:

> Check the repository's structure, conventions, related implementation, and
> Git workflow. Propose the smallest suitable change and a verification plan.
> Tell me what you can test here and what I will need to test in the actual
> environment. Show your findings and approach before editing.

Example:

> Inspect the Zsh startup files, Powerlevel10k loading, and recent Git history
> for the tty1 prompt. Explain where to select a plain console prompt, how you
> would keep it limited to the Linux virtual console, and what you can verify
> locally versus what needs a physical tty1 test. Do not edit yet.

# 3. Review the Approach and Start a Branch

Check that the proposal addresses the stated problem, respects constraints,
and has a meaningful validation plan. Correct assumptions before work begins.
Once the approach is settled, inspect the working tree and use a short-lived
branch. This repository's [Git Workflows](git-workflows.md) playbook describes
the branch and integration steps; follow the destination repository's workflow
when working elsewhere.

Guidance:

> The approach looks right, with this adjustment: [correction, if any].
> Inspect Git status, create an appropriate working branch, and implement the
> agreed change. Keep the scope to [boundary]. Do not commit or push yet.

Example:

> The proposed console-only prompt approach looks right. Check Git status,
> create a fix branch, and make the smallest Zsh change needed for a plain
> ASCII prompt on tty1. Preserve Powerlevel10k elsewhere. Do not commit or
> push yet.

# 4. Implement and Verify

Have Codex run checks suited to the change, then explain what changed and why.
Review the actual diff for unintended files, changed behavior, and missing
documentation. Ask for a targeted correction when the implementation or
explanation does not match the plan. Keep the work uncommitted while validation
is still outstanding.

Guidance:

> Run the relevant syntax checks, tests, or linting for this change. Explain
> the behavior before and after, report exactly what you verified and could not
> verify, and show me the full relevant diff. Do not commit yet.

Example:

> Check the Zsh syntax and verify that the console prompt is plain ASCII while
> the usual prompt remains in place outside the console. Explain the change,
> identify what a local check cannot prove about physical tty1, and show the
> full diff. Do not commit yet.

# 5. Validate in the Real Environment

Local checks cannot prove behavior on a machine, console, device, network, or
service Codex cannot access. Test there yourself and report the observed
result, including the trigger and environment. If it fails or needs refinement,
give Codex that evidence and repeat implementation, verification, diff review,
and real-world validation before committing.

Guidance:

> I tested [scenario] on [actual environment]. I observed [result], which
> [matches or differs from] the intended behavior. Use this result to assess
> whether the change is ready. If refinement is needed, adjust [specific
> behavior], verify again, and show the diff. Do not commit yet.

Example:

> The physical tty1 test passed: the plain prompt is readable and Powerlevel10k
> still works outside the console. I want one refinement before committing:
> end the console prompt with `>` for a normal user or `#` for root, followed
> by exactly one space. Change only that, verify it, and show the diff. Do not
> commit yet.

# 6. Commit and Integrate

After the change passes both available checks and required real-world
validation, review the final diff and Git status. Then ask Codex to stage only
the intended files and make a focused commit. Integrate through the
repository's documented Git workflow. For this repository, that means
updating `main`, using a fast-forward-only merge, pushing `main`, and cleaning
up the working branch after verifying the merge and push. Stop to inspect an
unexpected Git state rather than silently changing merge strategy.

Guidance:

> The validation passed. Review Git status and the final diff, stage only the
> intended files, and commit with a focused message. Then integrate and push
> according to [repository Git workflow]. Verify each step and stop if anything
> unexpected occurs.

Example:

> The initial console prompt passed the physical tty1 test, and the refined
> `>`/`#` suffix passed the available Zsh checks. I have reviewed the result.
> Review the final diff, commit the console prompt work with a focused message,
> then integrate the branch into `main` and push using this repository's Git
> Workflows playbook. Stop if the Git state or any step is unexpected.

# 7. Verify the Final State Independently

After Codex reports completion, inspect the repository yourself. Confirm the
intended commit is on `main`, the working tree is clean, `main` matches its
remote-tracking branch, and branch cleanup is complete where applicable. For a
behavioral change, retain the real-world test result as the evidence that the
change worked; a clean Git state alone does not establish that.

Guidance:

> Report the final branch, working-tree status, latest commits, and remote
> tracking state. Identify any remaining local or remote working branch. Give
> me the commands and evidence I can use to verify the result independently.

Example:

> Show the final branch, working-tree status, recent commits, and whether
> `main` matches `origin/main`. Confirm the tty1 branch is cleaned up. Give me
> the commands to check those facts myself, and identify the physical tty1
> result as the behavior check.

# Operational Notes

- Review a sandbox or permission request for the specific command and scope it
  grants. If a command is blocked, distinguish a sandbox restriction from a
  failure in the project before approving a retry. Do not broaden access just
  to avoid understanding the failure.
- Resume an existing conversation when continuing the same task so its
  decisions and validation results remain available. The installed CLI
  provides `codex resume` and `codex resume --last`; check `codex resume --help`
  for the options supported by your installed version.
- In an interactive CLI session, `/status` shows session configuration and
  token usage. Account usage is a separate view. Check the
  [official Developer commands documentation](https://learn.chatgpt.com/docs/developer-commands?surface=cli)
  for current slash commands and usage details. Ask Codex to report its
  verification evidence directly; token counts do not measure correctness.

# Related Documentation

- [Git Workflows](git-workflows.md)
- [Documentation Standards](../documentation-standards.md)
- [House Conventions](../house-conventions.md)
- [Official Codex CLI documentation](https://learn.chatgpt.com/docs/codex/cli)
