. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
