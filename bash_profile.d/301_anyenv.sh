# anyenv
if [ -d "$HOME/.anyenv" ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi
