# Get the aliases and functions
if [ -r ~/.bashrc ]; then
  case $- in *i*) . ~/.bashrc ;; esac
fi

# load .profile
if [ -r ~/.profile ]; then
  source ~/.profile
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
  . /usr/share/bash-completion/bash_completion
