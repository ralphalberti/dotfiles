#------------------------------------------------------------------------------
# common.zsh
#
# Shared shell configuration loaded by all supported platforms.
#
# This file should contain only settings that are common to every machine.
# Platform-specific configuration belongs in macos.zsh or arch.zsh.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# PATH
#------------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$PATH"

#------------------------------------------------------------------------------
# Zinit Plugin Manager
#
# Zinit manages the shell theme, plugins, and Oh My Zsh snippets used
# throughout the development environment. If it is not already installed,
# bootstrap it automatically.
#------------------------------------------------------------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

#------------------------------------------------------------------------------
# Shell Theme
#
# Powerlevel10k provides the prompt and status information displayed in the
# terminal.
#------------------------------------------------------------------------------

zinit ice depth=1
zinit light romkatv/powerlevel10k

#------------------------------------------------------------------------------
# Plugins
#
# Core shell plugins loaded on every supported platform.
#------------------------------------------------------------------------------

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Helpful suggestions when a command is not installed.
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit
zinit cdreplay -q

#------------------------------------------------------------------------------
# Prompt Configuration
#
# Load the Powerlevel10k prompt configuration if it exists.
#------------------------------------------------------------------------------

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#------------------------------------------------------------------------------
# Keybindings
#
# Configure command-line editing using Emacs-style keybindings. Add shortcuts
# for command history, autosuggestions, and command-line editing.
#------------------------------------------------------------------------------

bindkey -e                              # Enable Emacs-style command-line editing.
bindkey '^f' autosuggest-accept         # Ctrl-F: accept the current autosuggestion.
bindkey '^p' history-search-backward    # Ctrl-P: search backward through matching history.
bindkey '^n' history-search-forward     # Ctrl-N: search forward through matching history.
bindkey '^[w' kill-region               # Alt-W: delete the selected text region.

#------------------------------------------------------------------------------
# History
#
# Configure command history to be shared across shell sessions while avoiding
# duplicate entries and preserving useful command history.
#------------------------------------------------------------------------------

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt HIST_REDUCE_BLANKS

#------------------------------------------------------------------------------
# Completion
#
# Configure completion matching and let fzf-tab provide the interactive preview
# behavior. Platform-specific preview commands live in macos.zsh and arch.zsh.
#------------------------------------------------------------------------------

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

#------------------------------------------------------------------------------
# Shell Integrations
#
# Enable shell integrations for fuzzy finding and smarter directory navigation.
#------------------------------------------------------------------------------

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

