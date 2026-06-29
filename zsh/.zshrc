#------------------------------------------------------------------------------
# .zshrc
#
# Bootstrap zsh configuration. Shared configuration lives in common.zsh and
# platform-specific configuration lives in macos.zsh or arch.zsh.
#------------------------------------------------------------------------------

# Powerlevel10k instant prompt should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

source "$DOTFILES_DIR/zsh/common.zsh"
source "$DOTFILES_DIR/zsh/aliases.zsh"

case "$(uname)" in
  Darwin)
    source "$DOTFILES_DIR/zsh/macos.zsh"
    ;;
  Linux)
    source "$DOTFILES_DIR/zsh/arch.zsh"
    ;;
esac
