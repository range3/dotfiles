if command -v __git_ps1 1>/dev/null 2>&1; then
  PS1='\u@\h:\w$(__git_ps1)\\$ '
fi
