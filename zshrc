. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
if [[ -s /Users/glanotte/.rvm/scripts/rvm ]] ; then source /Users/glanotte/.rvm/scripts/rvm ; fi

