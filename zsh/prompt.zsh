function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\/git:\1/'
}

function pair_info {
  local pairname=$(git config --get user.initials)
  if [[ ${pairname} == 'ch' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi
  echo "$pairname"
}

function git_prompt_info {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "%{$reset_color%}/%{$fg[blue]%}${ref#refs/heads/}"
  fi
}

function git_status {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(git status 2> /dev/null)"
  local pairname=$(git config --get user.initials)
  if [[ ${pairname} == 'ch' ]]; then
    pairname=''
  elif [[ ${pairname} == '' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg[red]%}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$reset_color%}$gitstatus$pairname "
  fi
}
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}
#PROMPT='${PR_MAGENTA}%~%<< $(git_prompt_info)${PR_BOLD_WHITE}>%{${reset_color}%} '

project_pwd() {
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/~\/projects\/\([^\/]*\)\/current/\\1/" -e "s/~\/Sites\/\([^\/]*\)\/current/http:\/\/\\1/"
}

rvm_info() {
  echo " $(~/.rvm/bin/rvm-prompt)"
}

export PROMPT=$'$(git_status)%{\e[0;%(?.32.31)m%}⁕%{\e[0m%} '
export RPROMPT=$'%{\e[0;90m%}$(project_pwd)${PR_YELLOW}$(rvm_info)$(git_prompt_info)${PR_GREEN} +next:($(todo))%{\e[0m%}'
