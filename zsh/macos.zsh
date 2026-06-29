#------------------------------------------------------------------------------
# macos.zsh
#
# macOS-specific shell configuration.
#------------------------------------------------------------------------------

# Use GNU ls from Homebrew coreutils.
alias ls='gls --color=auto'

# Load GNU dircolors from Homebrew coreutils.
eval "$(gdircolors -b ~/.dircolors)"

# Use GNU ls for fzf-tab previews.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'gls --color=auto $realpath'
