# .bash_profile

# Custom and private settings (e.g. git credentials)
[ -r "$HOME/.extra" ] && source "$HOME/.extra"
# Exports
[ -r "$HOME/.dotfiles/exports" ] && source "$HOME/.dotfiles/exports"
# Aliases
[ -r "$HOME/.dotfiles/aliases" ] && source "$HOME/.dotfiles/aliases"
# Custom bash prompt
[ -r "$HOME/.dotfiles/bash_prompt" ] && source "$HOME/.dotfiles/bash_prompt"

# Append to the bash history file, rather than overwriting it
shopt -s histappend
