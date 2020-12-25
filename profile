# .profile

function addpath() {
  if [ -d "$1" ]; then
    case ":${PATH:=$1}:" in *:$1:*) ;; *) PATH="$1:$PATH" ;; esac;
  fi
}

addpath $HOME/local/sbin
addpath $HOME/.local/sbin
addpath $HOME/local/bin
addpath $HOME/.local/bin
export PATH
