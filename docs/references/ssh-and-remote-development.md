# SSH & Remote Development Cheat Sheet

Quick reference for remote development across the iMac, MacBook Pro, and Arch Linux systems.

---

# Connect to a Machine

```bash
ssh imac
ssh macbook
ssh arch
```

Exit the remote session:

```bash
exit
```

or press:

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

# Copy Files (scp)

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

# Remote Editing with Neovim

Open a remote file over SSH:

```bash
nvim scp://arch//home/ralph/.zshrc
```

Open a remote file on macOS:

```bash
nvim scp://macbook//Users/ralphalberti/.zshrc
```

Open a remote project file:

```bash
nvim scp://arch//home/ralph/.dotfiles/README.md
```

> **Note**
>
> Absolute remote paths require the double slash (`//`) after the hostname.

---

# Interactive File Transfer

Connect with SFTP:

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

# Synchronize Directories

Synchronize a directory using rsync:

```bash
rsync -av ~/Projects/ arch:~/Projects/
```

---

# SSH Configuration

View the SSH configuration:

```bash
bat ~/.ssh/config
```

Edit the SSH configuration:

```bash
nvim ~/.ssh/config
```

Verify the configuration for a host:

```bash
ssh -G arch
```

---

# Verify Connectivity

Ping a machine:

```bash
ping arch
```

Test an SSH connection:

```bash
ssh arch
```

Run a quick identity check:

```bash
ssh arch 'whoami; pwd; uname -n'
```

---

# Common Host Aliases

```text
github.com

arch
archdev
archgolf

macbook
```

---

# Project-Specific SSH Hosts

Host aliases can represent more than just machines—they can represent
development workspaces. A host may automatically:

- connect to a specific machine
- prevent idle suspend during the session
- open in a project directory
- start an interactive shell ready for development

## General Development Session

```bash
ssh archdev
```

Connects to the Arch development machine and prevents idle suspend for
the duration of the SSH session.

Current configuration:

```sshconfig
Host archdev
  HostName 192.168.5.170
  User ralph
  IdentityFile ~/.ssh/imac_ssh
  IdentitiesOnly yes
  RequestTTY yes
  RemoteCommand systemd-inhibit --what=idle --why="Remote development" \
    zsh -c 'exec zsh'
```

To start in `~/Projects` instead:

```sshconfig
RemoteCommand systemd-inhibit --what=idle --why="Remote development" \
  zsh -c 'cd ~/Projects && exec zsh'
```

---

## Golf Club App Workspace

```bash
ssh archgolf
```

Connects to the Arch machine, prevents idle suspend, and opens directly
into the Golf Club App project.

```sshconfig
Host archgolf
  HostName 192.168.5.170
  User ralph
  IdentityFile ~/.ssh/imac_ssh
  IdentitiesOnly yes
  RequestTTY yes
  RemoteCommand systemd-inhibit --what=idle --why="Golf Club App" \
    zsh -c 'cd ~/Projects/Python/golf_club_app && exec zsh'
```

---

## Why This Is Useful

Instead of thinking about *which computer* you want to connect to, think
about *which workspace* you want to enter.

Examples:

| Command | Purpose |
|---------|---------|
| `ssh arch` | General login to the Arch machine |
| `ssh archdev` | General remote development session |
| `ssh archgolf` | Golf Club App development workspace |

This approach scales naturally as additional long-lived projects are
created.

Examples:

- `archdotfiles`
- `archnvim`
- `archdjango`

Each host becomes a named development workspace rather than simply a
network connection.

---

# Machine-to-Machine SSH Keys

Each machine has two SSH identities:

## GitHub

```text
github_imac
github_macbook
github_key        (Arch)
```

Used only for GitHub authentication.

## Remote Login

```text
imac_ssh
macbook_ssh
arch_ssh
```

Used only for SSH between personal machines.

This separation keeps GitHub authentication independent from remote administration.

---

# Notes

- GitHub and machine SSH use separate key pairs.
- All machines use `~/.ssh/config` host aliases.
- Passwordless authentication uses Ed25519 keys.
- The iMac serves as the primary Command Center.
