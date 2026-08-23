# Git Workflows

**Version:** 1.0
**Last Updated:** 2026-08-19
**Status:** Living Document

# About This Document

This playbook records repeatable Git workflows used when working with feature,
documentation, fix, and other short-lived branches.

It is organized around tasks rather than individual Git commands. Use it when
the question is:

> What sequence of Git commands should I follow to accomplish this safely?

Individual commands that are useful outside a repeatable workflow belong in
the Git command reference.

If the workflow is already familiar and only the command sequence is needed
while working in the terminal, jump directly to
[Quick Checklists](#quick-checklists).

The workflows favor deliberate staging, verification before destructive
operations, clean branch history, and keeping GitHub synchronized with
completed local work.

## Contents

- [Quick Checklists](#quick-checklists)
- [Normal Working Branch Workflow](#normal-working-branch-workflow)
- [Finish and Merge a Working Branch](#finish-and-merge-a-working-branch)
- [Start the Next Working Branch](#start-the-next-working-branch)
- [Move Uncommitted Work](#move-uncommitted-work)
- [Release and Tag Workflow](#release-and-tag-workflow)
- [Verification Workflows](#verification-workflows)
- [Situational and Advanced Workflows](#situational-and-advanced-workflows)
- [Related Documentation](#related-documentation)

# Normal Working Branch Workflow

Use a short-lived working branch for meaningful changes rather than working
directly on `main`.

Examples include:

```text
feat/python-debugging
fix/alias-files
docs/git-operations
```

## 1. Inspect the Starting State

Before creating or changing branches:

```bash
git status
git branch -vv
```

The working tree should normally be clean before starting unrelated work.

If useful, inspect recent history:

```bash
git log --oneline --decorate --graph --all -n 10
```

## 2. Create the Working Branch

Create and switch to the new branch:

```bash
git switch -c <branch-name>
```

Example:

```bash
git switch -c feat/python-debugging
```

## 3. Make and Review Changes

Make the desired changes, then inspect the repository:

```bash
git status
git diff
```

`git diff` shows unstaged changes and is useful before deciding what should be
included in the next commit.

## 4. Stage Deliberately

Prefer staging the files that belong in the commit:

```bash
git add <file1> <file2>
```

When appropriate, stage interactively:

```bash
git add -p
```

`git add -p` is useful when a file contains changes that should be split across
multiple commits.

Use:

```bash
git add .
```

when all current changes intentionally belong in the same commit.

## 5. Review the Staged Work

Before committing:

```bash
git status
git diff --cached
```

For documentation and other text-heavy changes, also consider:

```bash
git diff --check
```

The goal is to know exactly what is about to become part of the commit.

## 6. Commit

Create a focused commit:

```bash
git commit -m "<message>"
```

Example:

```bash
git commit -m "feat: moved autopairs"
```

## 7. Push the Working Branch

The first push can create the remote branch and establish upstream tracking:

```bash
git push -u origin <branch-name>
```

Example:

```bash
git push -u origin feat/python-debugging
```

After upstream tracking exists, later commits on the same branch can normally
be published with:

```bash
git push
```

# Finish and Merge a Working Branch

Use this workflow when the work on a branch is complete and ready for `main`.

## 1. Verify the Working Branch

Before leaving the branch:

```bash
git status
git log --oneline --decorate --graph --all -n 10
```

Confirm that:

- The intended work has been committed.
- The working tree is clean.
- The completed branch has been pushed if it is being tracked remotely.

## 2. Switch to main

```bash
git switch main
```

Immediately verify where you are:

```bash
git status
```

## 3. Update main

Make sure local `main` is current:

```bash
git pull --ff-only
```

Using `--ff-only` prevents `git pull` from silently creating a merge commit.

## 4. Merge the Working Branch

When the branch should be fully contained in a straight-line history, use:

```bash
git merge --ff-only <branch-name>
```

Example:

```bash
git merge --ff-only feat/python-debugging
```

If Git reports that a fast-forward merge is not possible, stop and inspect the
branch history rather than changing merge strategy automatically.

### If Fast-Forward Is Not Possible

If Git reports that a fast-forward merge is not possible, do not switch to a
different merge strategy automatically.

First, inspect the repository and branch history:

```bash
git status
git branch -vv
git log --oneline --decorate --graph --all -n 20
```

Look for commits that were added independently to both `main` and the working
branch after the working branch was created.

A failed fast-forward means the expected straight-line history is not present.
The appropriate next step depends on why the branches diverged, so there is no
single follow-up merge command that is always correct.

If the cause of the divergence is unclear, preserve the current repository
state and investigate before issuing additional merge, rebase, reset, or
branch-deletion commands.

## 5. Push main

Publish the updated `main` branch:

```bash
git push origin main
```

## 6. Delete the Local Working Branch

After verifying the merge and push:

```bash
git branch -d <branch-name>
```

Example:

```bash
git branch -d feat/python-debugging
```

The lowercase `-d` provides a useful safety check because Git refuses to delete
a branch it considers unmerged.

## 7. Delete the Remote Working Branch

If the branch was pushed to GitHub:

```bash
git push origin --delete <branch-name>
```

## 8. Prune Stale Remote-Tracking References

When useful:

```bash
git fetch --prune
```

## 9. Verify the Final State

```bash
git status
git branch -vv
git log --oneline --decorate --graph -n 10
```

A completed workflow should normally leave:

- `main` checked out.
- A clean working tree.
- Local `main` synchronized with `origin/main`.
- The completed working branch removed locally.
- The remote working branch removed when no longer needed.

# Start the Next Working Branch

After completing and cleaning up the previous branch, create the next branch
from the updated `main`:

```bash
git switch -c <next-branch-name>
```

Example:

```bash
git switch -c feat/vpn-wireguard
```

Verify:

```bash
git status
git branch -vv
```

# Move Uncommitted Work

Uncommitted changes are part of the working tree rather than part of a branch
commit. The safest workflow depends on whether the destination branch already
exists.

## Create a New Branch and Keep Current Changes

Use this when work was started before the intended branch was created and the
destination branch does not exist yet.

Inspect the current state:

```bash
git status
```

Create and switch to the new branch:

```bash
git switch -c <new-branch-name>
```

Verify that the uncommitted work is still present:

```bash
git status
git diff
```

The working-tree changes normally remain in place because creating the new
branch changes the branch pointer without replacing the current working tree.

Example:

```bash
git status
git switch -c docs/git-operations
git status
```

This is the preferred workflow when the goal is simply to create the branch
that should have existed before the work began.

## Move Changes to an Existing Branch with Stash

Use a stash when:

1. The destination branch already exists.
2. The working tree needs to be temporarily cleared.
3. Keeping a recovery copy of the uncommitted work is useful.

Preserve the work:

```bash
git stash push -m "WIP: move to <branch-name>"
```

Switch to the destination branch:

```bash
git switch <branch-name>
```

Recover the changes while retaining the stash as a safety copy:

```bash
git stash apply
```

Inspect the result:

```bash
git status
git diff
git stash list
```

Do not assume the stash applied cleanly.

After the recovered work has been verified and committed, remove the retained
stash deliberately:

```bash
git stash drop stash@{0}
```

The original Fav Commands notes used `git stash pop`, which applies the stash
and removes it after a successful application. `git stash apply` is preferred
here because it leaves the stash available as a recovery point until the
restored work has been inspected and committed.

# Release and Tag Workflow

Use an annotated tag to mark a meaningful release or milestone.

The source notes emphasize updating `CHANGELOG.md` before tagging so the
changelog reflects the version represented by the tag.

## 1. Prepare the Release Commit

Make the required changes, including the changelog:

```bash
git status
git add <files>
git commit -m "<release-related message>"
```

## 2. Create an Annotated Tag

```bash
git tag -a <tag> -m "<description>"
```

Example:

```bash
git tag -a v0.3.0 -m "Unit-aware scheduling"
```

## 3. Inspect the Tag

```bash
git show <tag>
```

Example:

```bash
git show v0.3.0
```

## 4. Push the Branch and Tag

A branch push and a tag push are separate operations:

```bash
git push origin <branch-name>
git push origin <tag>
```

Mental model:

```text
git push origin main    → pushes commits reachable from main
git push origin <tag>   → pushes one tag
git push origin --tags  → pushes all local tags
```

Prefer pushing the intended tag explicitly when only one new tag should be
published.

## 5. Verify Remote Tags

```bash
git ls-remote --tags origin
```

To list local tags:

```bash
git tag
git tag --sort=-v:refname
```

## Removing an Unwanted Tag

Delete the local tag:

```bash
git tag -d <tag>
```

Delete the remote tag:

```bash
git push origin --delete <tag>
```

# Verification Workflows

Verification commands are intentionally repeated throughout this playbook.
They are cheap and help prevent mistakes.

## Before a Merge

```bash
git status
git branch -vv
git log --oneline --decorate --graph --all -n 10
```

## After a Merge

```bash
git status
git branch -vv
git log --oneline --decorate --graph -n 10
```

## Inspect a Commit

```bash
git show HEAD
git show <hash>
```

## Inspect Changes

Unstaged changes:

```bash
git diff
```

Staged changes:

```bash
git diff --cached
```

Whitespace and related diff problems:

```bash
git diff --check
```

# Situational and Advanced Workflows

Some commands in the original Fav Commands notes are useful but are not part
of the normal branch lifecycle.

They should be used deliberately rather than treated as routine workflow
steps.

## Cherry-Pick

The source notes record:

```bash
git cherry-pick <commit>
```

as a way to place a commit onto the correct branch.

This is a situational history operation. Inspect the current branch and the
commit carefully before using it.

## Worktrees

The source notes also preserve these commands for future experimentation:

```bash
git worktree add ../nvim-config-changelog docs/changelog
git worktree list
git worktree remove ../nvim-config-changelog
```

Worktrees allow multiple branches from the same repository to be checked out
at the same time in different directories.

They are retained here as an advanced workflow to explore rather than part of
the normal branch process.

# Quick Checklists

These condensed workflows are intended for side-by-side use with the terminal.
Use the detailed sections above when the reason for a step or command needs to
be reviewed.

## Finish → Merge → Push → Delete

```bash
# Working branch
git status
git diff
git add <files>
git diff --cached
git commit -m "<message>"
git push

# Merge
git switch main
git status
git pull --ff-only
git merge --ff-only <branch-name>
git push origin main

# Cleanup
git branch -d <branch-name>
git push origin --delete <branch-name>
git fetch --prune

# Verify
git status
git branch -vv
git log --oneline --decorate -5
```

## New Branch → Work → First Push

```bash
# Start
git status
git switch -c <branch-name>

# Make changes

# Review and commit
git diff
git add <files>
git diff --cached
git commit -m "<message>"

# Publish
git push -u origin <branch-name>
```

## Create a New Branch and Keep Current Changes

```bash
git status
git switch -c <new-branch-name>
git status
git diff
```

## Move Changes to an Existing Branch with Stash

```bash
# Preserve the work
git stash push -m "WIP: move to <branch-name>"

# Move and recover
git switch <branch-name>
git stash apply

# Verify before deleting the stash
git status
git diff
git stash list
```

Keep the stash until the recovered work has been verified and committed.

## Release and Tag

```bash
# Prepare and commit
git status
git add <files>
git commit -m "<message>"

# Tag
git tag -a <tag> -m "<description>"
git show <tag>

# Publish
git push origin <branch-name>
git push origin <tag>

# Verify
git ls-remote --tags origin
```

# Related Documentation

- [`../house-conventions.md`](../house-conventions.md)
- [`../documentation-standards.md`](../documentation-standards.md)
- [`../references/git-command-reference.md`](../references/git-command-reference.md)
