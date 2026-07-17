# SSH & Remote Development Reference

Quick reference for remote development across the iMac, MacBook Pro, and
Arch Linux systems.

---

# Machine Roles

| Machine | Role |
|----------|------|
| iMac | Primary command center |
| MacBook Pro | Mobile development machine |
| Arch Linux | Primary Linux development environment |

---

# Reserved Addresses

DHCP reservations are configured in eero to ensure stable addressing.

| Host | Address |
|------|---------|
| imac | 192.168.4.140 |
| arch | 192.168.5.188 |
| macbook | 192.168.5.190 |

---

# SSH Host Aliases

Common aliases available via `~/.ssh/config`.

```text
github.com

imac
macbook

arch
archdev
archgolf
```

---

# Connect to a Machine

```bash
ssh imac
ssh macbook
ssh arch
```

Exit a remote session:

```bash
exit
```

or:

```text
Ctrl+D
```

---

# Run Remote Commands

Run a single command:

```bash
ssh arch 'git status'
```

Run multiple commands:

```bash
ssh arch 'cd ~/.dotfiles && git pull'
```

Update dotfiles remotely:

```bash
ssh macbook 'cd ~/.dotfiles && git pull'
```

---

# SCP Examples

Copy a file to another machine:

```bash
scp test1.txt arch:~/test1.txt
scp test1.txt macbook:~/test1.txt
scp test1.txt imac:~/test1.txt
```

Copy a file from another machine:

```bash
scp arch:~/test1.txt .
scp macbook:~/test1.txt .
scp imac:~/test1.txt .
```

Copy to a specific directory:

```bash
scp test1.txt arch:~/Projects/
```

---

# Copy Directories

Recursively copy an entire directory:

```bash
scp -r Projects/MyProject arch:~/Projects/
```

---

# SFTP

Connect:

```bash
sftp arch
```

Useful commands:

```text
pwd
lpwd
ls
lls
cd
lcd
put
get
exit
```

---

# Rsync

Synchronize a directory:

```bash
rsync -av ~/Projects/ arch:~/Projects/
```

---

# Remote Editing with Neovim

Open a remote file over SSH:

```bash
nvim scp://arch//home/ralph/.zshrc
```

Open a remote macOS file:

```bash
nvim scp://macbook//Users/ralphalberti/.zshrc
```

Open a remote project file:

```bash
nvim scp://arch//home/ralph/.dotfiles/README.md
```

Absolute remote paths require the double slash (`//`) after the hostname.

---

# SSH Configuration

View:

```bash
bat ~/.ssh/config
```

Edit:

```bash
nvim ~/.ssh/config
```

Verify the resulting configuration:

```bash
ssh -G arch
```

---

# Connectivity Checks

SSH test:

```bash
ssh arch
```

Identity check:

```bash
ssh arch 'whoami; pwd; uname -n'
```

---

# Project-Specific SSH Hosts

SSH aliases can represent workspaces rather than machines.

## General Development

```bash
ssh archdev
```

Behavior:

- Connect to Arch
- Prevent idle suspend
- Start an interactive shell

Current configuration:

```sshconfig
Host archdev
  HostName 192.168.5.188
  User ralph
  IdentityFile ~/.ssh/imac_ssh
  IdentitiesOnly yes
  RequestTTY yes
  RemoteCommand systemd-inhibit --what=idle --why="Remote development" zsh -l
```

Optional alternative:

```sshconfig
RemoteCommand systemd-inhibit --what=idle --why="Remote development" zsh -lc 'cd ~/Projects && exec zsh -l'
```

## Golf Club App Workspace

```bash
ssh archgolf
```

Behavior:

- Connect to Arch
- Prevent idle suspend
- Open directly into the Golf Club App project

```sshconfig
Host archgolf
  HostName 192.168.5.188
  User ralph
  IdentityFile ~/.ssh/imac_ssh
  IdentitiesOnly yes
  RequestTTY yes
  RemoteCommand systemd-inhibit --what=idle --why="Golf Club App" zsh -lc 'cd ~/Projects/Python/golf_club_app && exec zsh -l'
```

---

# Machine SSH Keys

Each machine maintains two independent SSH identities.

## GitHub Keys

| Machine | Key |
|----------|-----|
| iMac | github_imac |
| MacBook | github_macbook |
| Arch | github_key |

Used only for GitHub authentication.

## Remote Login Keys

| Machine | Key |
|----------|-----|
| iMac | imac_ssh |
| MacBook | macbook_ssh |
| Arch | arch_ssh |

Used only for machine-to-machine SSH access.

This separation allows GitHub and infrastructure credentials to be
rotated independently.

---

# Ghostty Support

Ghostty uses:

```text
TERM=xterm-ghostty
```

Remote systems must have the Ghostty terminfo definition installed.

Install:

```bash
infocmp -x xterm-ghostty | ssh imac 'tic -x -'
```

Examples:

```bash
infocmp -x xterm-ghostty | ssh macbook 'tic -x -'
infocmp -x xterm-ghostty | ssh arch 'tic -x -'
```

Symptoms of a missing terminfo definition include:

- duplicated characters
- duplicated prompts
- broken `clear`
- `xterm-ghostty: unknown terminal type`

---

# Philosophy

Host aliases should represent destinations of intent rather than simply
machines.

Examples:

| Command | Meaning |
|---------|---------|
| `ssh arch` | Access the Arch machine |
| `ssh archdev` | Enter a general development workspace |
| `ssh archgolf` | Enter the Golf Club App workspace |

As additional long-lived projects are created, additional workspace
aliases can be introduced:

- `archdotfiles`
- `archnvim`
- `archdjango`

This scales better than remembering IP addresses, usernames, and project
paths.
