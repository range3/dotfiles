# Get the aliases and functions
if [ -r ~/.bashrc ]; then
  case $- in *i*) . ~/.bashrc ;; esac
fi

prepend_var() { [[ -d "$2" && ! ":${!1}:" =~ ":$2:" ]] && printf -v "$1" "$2${!1:+":${!1}"}"; }
append_var()  { [[ -d "$2" && ! ":${!1}:" =~ ":$2:" ]] && printf -v "$1" "${!1:+"${!1}:"}$2"; }

# envs
prepend_var PATH "$HOME/.local/bin"
prepend_var PATH "$HOME/.local/sbin"
prepend_var PATH "$HOME/.cache/npm-global/bin"

# Editor
if command -v vim 1>/dev/null 2>&1; then
  export EDITOR=vim
elif command -v vi 1>/dev/null 2>&1; then
  export EDITOR=vi
fi

export TZ=Asia/Tokyo
#export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export GPG_TTY=$(tty)

# keychain
if command -v keychain 1>/dev/null 2>&1; then
  keychain --quiet --ignore-missing \
    $(find ~/.ssh -name 'id_*' -and -not -name '*.pub')
  eval "$(keychain --quiet --eval)"
fi
