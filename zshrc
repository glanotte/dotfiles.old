
. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

# added support for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
