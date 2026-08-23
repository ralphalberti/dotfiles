# Git Command Reference

**Version:** 1.0
**Last Updated:** 2026-08-21
**Status:** Living Document

# About This Document

This reference collects useful Git commands for quick lookup during day-to-day
work.

It complements the Git workflows playbook. Use the playbook when a task
requires a sequence of commands; use this reference when the question is:

> What was that Git command I used to do this?

The commands are grouped by purpose rather than by workflow. Situational and
experimental commands are retained so useful one-off commands are not lost.

## Contents

- [Repository Status and Inspection](#repository-status-and-inspection)
- [Branches](#branches)
- [Staging and Restoring Changes](#staging-and-restoring-changes)
- [Commits](#commits)
- [Diffs](#diffs)
- [Logs and History](#logs-and-history)
- [Searching Commit History](#searching-commit-history)
- [Remotes and Pushing](#remotes-and-pushing)
- [Tags](#tags)
- [Stash](#stash)
- [Cherry-Pick](#cherry-pick)
- [Worktrees](#worktrees)
- [Interactive Commit Inspection with fzf](#interactive-commit-inspection-with-fzf)
- [Git Aliases](#git-aliases)
- [Related Documentation](#related-documentation)

# Repository Status and Inspection

## Show Repository Status

```bash
git status
```

Shows the current branch, staged changes, unstaged changes, and untracked files.

## Show Branches and Tracking Information

```bash
git branch -vv
```

Shows local branches together with their latest commits and upstream tracking
information.

## Show Local and Remote Branches

```bash
git branch -a
```

Lists both local branches and remote-tracking branches.

# Branches

## Create and Switch to a New Branch

```bash
git switch -c <branch-name>
```

## Switch to an Existing Branch

```bash
git switch <branch-name>
```

## Delete a Local Branch

```bash
git branch -d <branch-name>
```

The lowercase `-d` refuses to delete a branch Git considers unmerged.

## Delete a Remote Branch

```bash
git push origin --delete <branch-name>
```

## Prune Stale Remote-Tracking Branches

```bash
git fetch --prune
```

# Staging and Restoring Changes

## Stage Specific Files

```bash
git add <file1> <file2>
```

## Stage All Changes in the Current Directory

```bash
git add .
```

Use when all current changes intentionally belong in the next commit.

## Stage Selected Hunks Interactively

```bash
git add -p
```

Patch mode lets you choose which changed portions of files are staged rather
than staging every change in a modified file.

Git presents groups of nearby changed lines, called **hunks**, and asks whether
each hunk should be staged.

Mental model:

```text
git add <file>  → stage all changes in the file
git add -p      → interactively choose which changed hunks to stage
```

This is useful when one file contains unrelated changes that should be split
across separate commits.

## Restore an Unstaged File

```bash
git restore <file>
```

Discards unstaged changes in the specified file. Use deliberately because the
discarded working-tree changes are not preserved by Git.

## Unstage a File

```bash
git restore --staged <file>
```

Removes the file from the staging area while leaving its working-tree changes
intact.

# Commits

## Create a Commit

```bash
git commit -m "<message>"
```

## Show the Latest Commit

```bash
git show HEAD
```

## Show a Specific Commit

First, find the commit:

```bash
git log --oneline
```

Then use its abbreviated commit hash:

```bash
git show <commit-hash>
```

Example:

```bash
git show 43fde96
```

This displays the commit information and the changes introduced by that commit.

# Diffs

## Show Unstaged Changes

```bash
git diff
```

## Show Staged Changes

```bash
git diff --cached
```

## Check a Diff for Whitespace Errors

```bash
git diff --check
```

## Compare Two Branches

```bash
git diff <branch1>..<branch2>
```

## Show Only Changed File Names

```bash
git diff --name-only <branch1>..<branch2>
```

# Logs and History

## Compact Commit History

```bash
git log --oneline
```

## Graphical Branch History

```bash
git log --oneline --decorate --graph --all
```

Limit the output when useful:

```bash
git log --oneline --decorate --graph --all -n 10
```

## Show Recent Commits

```bash
git log -5 --oneline
```

## Show Commits on One Branch but Not Another

```bash
git log --oneline <branch1>..<branch2>
```

Example:

```bash
git log --oneline main..feat/example
```

# Searching Commit History

## Search Commit Messages

```bash
git log --grep="<text>"
```

## Search Commit Messages in Compact Form

```bash
git log --oneline --grep="<text>"
```

## Search Patch History for Added or Removed Text

```bash
git log -S"<text>"
```

Useful for finding commits that changed the number of occurrences of a string.

## Search Diffs with a Regular Expression

```bash
git log -G"<regex>" --oneline
```

Searches commit history for changes whose added or removed lines match the
regular expression.

Example:

```bash
git log -G"mullvad" --oneline
```

This finds commits whose changes contain lines matching `mullvad`.

Inspect a matching commit with:

```bash
git show <commit-hash>
```

# Remotes and Pushing

## Show Configured Remotes

```bash
git remote -v
```

## Push and Establish Upstream Tracking

```bash
git push -u origin <branch-name>
```

After upstream tracking is established, `git push` is normally sufficient.

## Push main Explicitly

```bash
git push origin main
```

## Update the Current Branch by Fast-Forward Only

```bash
git pull --ff-only
```

Refuses to create a merge commit if the local and remote histories have
diverged.

# Tags

## List Tags

```bash
git tag
```

## List Tags in Descending Version Order

```bash
git tag --sort=-v:refname
```

## Create an Annotated Tag

```bash
git tag -a <tag> -m "<description>"
```

## Inspect a Tag

```bash
git show <tag>
```

## Push One Tag

```bash
git push origin <tag>
```

## Push All Local Tags

```bash
git push origin --tags
```

Use deliberately when all local tags should be published.

## Show Tags on the Remote

```bash
git ls-remote --tags origin
```

## Delete a Local Tag

```bash
git tag -d <tag>
```

## Delete a Remote Tag

```bash
git push origin --delete <tag>
```

# Stash

## Save Current Changes

```bash
git stash push -m "<description>"
```

## List Stashes

```bash
git stash list
```

## Apply a Stash and Keep It

```bash
git stash apply
```

Leaves the stash available as a recovery point after applying its changes.

## Apply a Stash and Remove It

```bash
git stash pop
```

Applies the stash and removes it after a successful application.

## Delete a Stash Deliberately

```bash
git stash drop stash@{0}
```

Inspect `git stash list` before deleting a stash.

# Cherry-Pick

Cherry-pick is a situational history operation rather than part of the normal
working-branch workflow.

## Apply a Specific Commit to the Current Branch

```bash
git cherry-pick <commit>
```

The original Fav Commands notes describe this as a way to put a commit on the
correct branch and mark the command for further investigation.

# Worktrees

Worktrees were retained in the original notes as commands to experiment with
rather than as part of the established daily workflow.

## Create a Worktree

```bash
git worktree add ../nvim-config-changelog docs/changelog
```

## List Worktrees

```bash
git worktree list
```

## Remove a Worktree

```bash
git worktree remove ../nvim-config-changelog
```

# Interactive Commit Inspection with fzf

## Select a Commit and Show It

```bash
git log --oneline | fzf | cut -d' ' -f1 | xargs git show
```

Presents the compact log through `fzf`, extracts the selected commit hash, and
passes it to `git show`.

## Select a Commit Hash

```bash
git log --oneline | fzf | cut -d' ' -f1
```

# Git Aliases

The original Fav Commands notes preserve several aliases for frequently used
Git commands.

Aliases are configuration conveniences rather than separate Git operations.
Their exact definitions should remain synchronized with the active Git
configuration.

Useful aliases from the source notes include shortcuts for:

- Status.
- Compact logs.
- Graphical logs.
- Recent commit history.
- Branch inspection.

Before documenting an alias as authoritative, compare it with the current
`.gitconfig` so this reference does not preserve an outdated definition.

# Related Documentation

- [`../playbooks/git-workflows.md`](../playbooks/git-workflows.md)
- [`../house-conventions.md`](../house-conventions.md)
- [`../documentation-standards.md`](../documentation-standards.md)
