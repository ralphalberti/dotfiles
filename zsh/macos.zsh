#------------------------------------------------------------------------------
# macos.zsh
#
# macOS-specific shell configuration.
# Can included mac specific aliases here too
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Platform Aliases
#
# Aliases that are specific to the MacOS environment.
#------------------------------------------------------------------------------

alias ls='gls --color=auto'

#------------------------------------------------------------------------------
# Directory Colors
#
# Load GNU dircolors from Homebrew coreutils.
#------------------------------------------------------------------------------
eval "$(gdircolors -b ~/.dircolors)"

#------------------------------------------------------------------------------
# fzf-tab Preview
#
# Configure preview commands used by fzf-tab.
# Use GNU ls for fzf-tab previews.
#------------------------------------------------------------------------------
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'gls --color=auto $realpath'
