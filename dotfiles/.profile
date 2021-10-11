#umask 022

# load ~/.env
if [ -r "$HOME/.env" ]; then
  source "$HOME/.env"
fi

function addpath() {
  if [ -d "$1" ]; then
    case ":${PATH:=$1}:" in *:$1:*) ;; *) PATH="$1:$PATH" ;; esac
  fi
}

addpath "$HOME/.bin"
addpath "$HOME/bin"
addpath "$HOME/.local/bin"
addpath "$HOME/local/bin"
addpath "$HOME/.sbin"
addpath "$HOME/sbin"
addpath "$HOME/.local/sbin"
addpath "$HOME/local/sbin"

# keychain
if command -v keychain 1>/dev/null 2>&1; then
  keychain \
    --quiet \
    --ignore-missing \
    $(find "$HOME/.ssh" -name 'id_*' -and -not -name '*.pub')

  eval "$(keychain --quiet --eval)"
fi

# Editor
if command -v vim 1>/dev/null 2>&1; then
  export EDITOR=vim
elif command -v vi 1>/dev/null 2>&1; then
  export EDITOR=vi
fi
export GIT_EDITOR=${EDITOR}
export SVN_EDITOR=${EDITOR}

# TimeZone
export TZ=Asia/Tokyo

# Bookmarks
if [ -d "$HOME/.bookmarks" ]; then
  export CDPATH=".:$HOME/.bookmarks:/"
  alias goto="cd -P"
fi

# anyenv
if [ -d "$HOME/.anyenv" ] ; then
  addpath "$HOME/.anyenv/bin"
fi
if command -v anyenv 1>/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# spack
spack_user_root=${SPACK_ROOT:-"${HOME}/.cache/spack"}
if [ -r "${spack_user_root}/share/spack/setup-env.sh" ]; then
    . "${spack_user_root}/share/spack/setup-env.sh"
fi
unset spack_user_root

# activate default spack env
if [ -n "$DOTFILES_DEFAULT_SPACK_ENV" ]; then
  if command -v spack 1>/dev/null 2>&1; then
    if spack env st | grep -q "No active environment"; then
      spack env activate "$DOTFILES_DEFAULT_SPACK_ENV"
    fi
  fi
fi

# load node-specific profile
node_specific_profile="$HOME/.config/node_specific_profile/$(hostname -s)"
if [ -n "$BASH_VERSION" -a -r "$node_specific_profile/.bash_profile" ]; then
  source "$node_specific_profile/.bash_profile"
elif [ -r "$node_specific_profile/.profile" ]; then
  source "$node_specific_profile/.profile"
fi
unset node_specific_profile

# clean up
unset addpath
