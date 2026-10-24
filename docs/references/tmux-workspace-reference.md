# tmux Workspace Reference

## Mental Model: Which Layer Owns the Organization?

tmux overlaps with features provided by terminal emulators and editors such as
Ghostty and Neovim. The goal is not to choose one tool to handle everything,
but to give each layer a different responsibility.

A useful way to think about the layers is:

- **Ghostty** = the container. Usually one terminal window is enough.
- **tmux session** = the workspace or project.
- **tmux windows** = major activities within that workspace.
- **tmux panes** = simultaneous terminal processes that should be visible together.
- **Neovim buffers/windows** = organization inside the editing task.

The key question is:

> **Am I organizing files, or am I organizing terminal activities?**
>
> **Files → Neovim**
>
> **Terminal activities → tmux**
>
> **Application windows → Ghostty / desktop environment**

These are guidelines rather than rigid rules. The purpose is to avoid unnecessary
duplication between tools while allowing each tool to do what it does best.

## Sessions Are Persistent Workspaces

A tmux session is more than a collection of terminal windows. It is a persistent
workspace that continues running independently of the terminal used to view it.

For example:

```text
Ghostty window
    │
    └── tmux session: dotfiles
        ├── window 1: editor
        ├── window 2: shell / Git
        └── window 3: test
```

If the tmux session is detached, its windows, panes, shells, and running programs
remain available. The session can be attached again later and the workspace
continues where it was left.

### Detaching and Attaching

Detach from the current tmux session without stopping it:

```text
C-b d
```

List existing tmux sessions:

```bash
tmux ls
```

Attach to an existing session:

```bash
tmux attach
```

Attach to a specific session:

```bash
tmux attach -t <name>
```

Start a new tmux session:

```bash
tmux
```

The important distinction is:

> **Detaching from tmux is not the same as ending the session.**

Detaching leaves the workspace running. Its windows, panes, shells, and running
programs remain available until the session is explicitly ended.

This becomes particularly useful with SSH. A tmux session can remain running on
a remote machine after the SSH connection ends. Later, another SSH connection
can attach to that same session and restore the existing workspace.

## Windows: Major Activities

tmux windows are best used for major activities within the current workspace.
Each window can run its own shell, editor, SSH connection, or other terminal
program.

For example, a `dotfiles` session might contain:

```text
1: editor
2: shell / Git
3: SSH
4: logs
5: AI coding tool
```

These windows represent different terminal activities rather than individual
files. Switching between them changes the activity being performed while
remaining inside the same tmux workspace.

Create a new window:

```text
C-b c
```

Display the window list:

```text
C-b w
```

## Panes: Simultaneous Activities

A tmux window can be divided into panes. Panes are most useful when multiple
terminal processes should be visible at the same time.

For example:

```text
┌───────────────────────────────┐
│                               │
│            Neovim             │
│                               │
├──────────────────┬────────────┤
│   shell / Git    │   server   │
└──────────────────┴────────────┘
```

In this example, Neovim, a shell, and a server are separate terminal processes,
but seeing all three simultaneously is useful.

A useful distinction is:

- **Windows** separate major activities that do not need to be visible together.
- **Panes** display activities that benefit from being visible together.

A pane can temporarily fill the entire tmux window by zooming it:

```text
C-b z
```

Press `C-b z` again to restore the previous pane layout.

Cycle through the built-in pane layouts:

```text
C-b Space
```

## Neovim vs. tmux

Neovim and tmux both provide ways to divide and organize the screen, but they
operate at different layers.

Neovim understands files, buffers, editor windows, and the relationships between
them. tmux understands terminal processes and persistent terminal workspaces.

If two Markdown files are part of the same editing task, opening both inside a
single Neovim session will usually make more sense than opening a separate tmux
window for each file.

For example:

```text
tmux window: editor
    │
    └── Neovim
        ├── README.md
        ├── CHANGELOG.md
        └── tmux.conf
```

By contrast, these are naturally separate tmux activities:

```text
tmux session: dotfiles
    │
    ├── window 1: Neovim
    ├── window 2: Git / shell
    ├── window 3: SSH
    └── window 4: logs
```

The guiding question remains:

> **Am I organizing files, or am I organizing terminal activities?**
>
> **Files → Neovim**
>
> **Terminal activities → tmux**

There is no requirement to follow this rigidly. A Neovim split may be ideal for
comparing two files, while a tmux pane may be ideal for keeping Neovim visible
beside an independent shell. The goal is to let each tool organize the things it
understands best rather than creating unnecessary layers of windows and panes.

## Example: Dotfiles Workspace

A practical tmux workspace for working on the dotfiles repository might look
like this:

```text
tmux session: dotfiles
│
├── 1: editor
│   └── Neovim
│       ├── README.md
│       ├── tmux.conf
│       └── common.zsh
│
├── 2: shell
│   └── Git commands, file operations, and testing
│
├── 3: remote
│   └── SSH connection to another machine
│
└── 4: tools
    └── Other long-running terminal programs
```

The individual files remain Neovim's responsibility. tmux organizes the larger
activities surrounding the editing work.

A window can also be divided temporarily when two activities need to be visible
together. For example, the editor window could contain Neovim in one pane and a
shell in another while testing a configuration change.

The workspace can then be detached with:

```text
C-b d
```

Later, return to it with:

```bash
tmux attach
```

The important idea is that the tmux session represents the **workspace as a
whole**, not merely the terminal window currently displaying it.

## Common Commands and Keybindings

The tmux prefix is `C-b`. Press `Ctrl-b`, release it, and then press the
command key.

### Sessions

| Action | Command / Key |
| --- | --- |
| Start tmux | `tmux` |
| List sessions | `tmux ls` |
| Attach to a session | `tmux attach` |
| Attach to a specific session | `tmux attach -t <name>` |
| Detach from current session | `C-b d` |

### Windows

| Action | Key |
| --- | --- |
| Create a new window | `C-b c` |
| Display sessions and windows | `C-b w` |
| Next window | `C-b n` |
| Previous window | `C-b p` |
| Rename current window | `C-b ,` |
| Close current window | `C-b &` |

### Panes

| Action | Key |
| --- | --- |
| Split left/right | `C-b %` |
| Split top/bottom | `C-b "` |
| Move between panes | `C-b` + arrow key |
| Display pane numbers | `C-b q` |
| Zoom/unzoom current pane | `C-b z` |
| Cycle pane layouts | `C-b Space` |
| Close current pane | `C-b x` |

### Copy Mode

This configuration uses vi-style keys for tmux copy mode.

| Action | Key |
| --- | --- |
| Enter copy mode | `C-b [` |
| Navigate | vi movement keys / arrow keys |
| Begin selection | `Space` |
| Copy selection and exit | `Enter` |
| Exit copy mode | `q` |

Copied text is stored in a tmux paste buffer. The most recent tmux buffer can
be pasted with:

```text
C-b ]
```

With the current Ghostty and tmux configuration, copied text is also available
to the system clipboard and can be pasted normally with `Cmd-v` on macOS.
Clipboard behavior can vary by operating system and terminal emulator.

### Help

tmux can display its current key bindings directly, which is useful when a
binding is forgotten or before assigning a custom key.

Display all current key bindings:

```text
C-b ?
```

Look up what a particular key does:

```text
C-b /
```

After pressing `C-b /`, press the key to inspect. tmux will display the
description of its current binding.

This is particularly useful before creating a custom binding because it can
show whether the proposed key is already assigned to another tmux command.

The bindings can also be inspected from the shell:

```bash
tmux list-keys
```

## External Reference

For a more comprehensive list of tmux commands and keyboard shortcuts, see:

- [tmux Cheat Sheet](https://tmux.app/cheat-sheet/#shortcuts)
