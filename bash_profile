source ~/.bash/functions
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.bash/prompt

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.localrc ]; then
  . ~/.localrc
fi

[[ -s "/Users/geofflanotte/.rvm/scripts/rvm" ]] && source "/Users/geofflanotte/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
