#------------------------------------------------------------------------------
# macos.zsh
#
# macOS-specific shell configuration.
# Can included mac specific aliases here too
#------------------------------------------------------------------------------

# Load GNU dircolors from Homebrew coreutils.
eval "$(gdircolors -b ~/.dircolors)"

# Use GNU ls for fzf-tab previews.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'gls --color=auto $realpath'
