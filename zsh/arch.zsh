#------------------------------------------------------------------------------
# arch.zsh
#
# Arch Linux-specific shell configuration.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# SSH Agent
#
# Use the systemd user-managed SSH agent and automatically load the GitHub SSH
# key if it has not already been added.
#------------------------------------------------------------------------------

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/github_key >/dev/null 2>&1

#------------------------------------------------------------------------------
# Platform Aliases
#
# Aliases that are specific to the Arch Linux environment.
#------------------------------------------------------------------------------

alias ls='ls --color'

# Update the Arch keyring before performing a full system upgrade.
# This helps prevent signature verification failures after long periods
# between updates.
alias pacup='sudo pacman -Sy archlinux-keyring && sudo pacman -Syu'

#------------------------------------------------------------------------------
# Directory Colors
#
# Load GNU dircolors for colored directory listings.
#------------------------------------------------------------------------------

eval "$(dircolors ~/.dircolors)"

#------------------------------------------------------------------------------
# fzf-tab Preview
#
# Configure preview commands used by fzf-tab.
#------------------------------------------------------------------------------

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#------------------------------------------------------------------------------
# Node Version Manager (NVM)
#
# Load Node Version Manager if it is installed.
#------------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
