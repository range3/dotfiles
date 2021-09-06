# Get the aliases and functions
if [ -r ~/.bashrc ]; then
  case $- in *i*) . ~/.bashrc ;; esac
fi

# load .profile
if [ -r ~/.profile ]; then
  source ~/.profile
fi

# Use bash-completion, if available
if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi
