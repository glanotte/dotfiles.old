. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

