# .bash_profile

# load .profile
if [ -f ~/.profile ]; then
  . ~/.profile
fi

# load node-specific profile
node_specific_profile="$HOME/.config/node_specific_profile/$(hostname -s)/.bash_profile"
if [ -f "$node_specific_profile" ]; then
  source "$node_specific_profile"
fi
unset node_specific_profile

# User specific environment and startup programs
if [ -d "${HOME}/.bash_profile.d" ] ; then
  for f in ${HOME}/.bash_profile.d/*.sh ; do
    . $f
  done
  unset f
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  case  $- in *i*) . ~/.bashrc;; esac
fi
