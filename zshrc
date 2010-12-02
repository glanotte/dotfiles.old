. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
if [[ -s /Users/glanotte/.rvm/scripts/rvm ]] ; then source /Users/glanotte/.rvm/scripts/rvm ; fi

