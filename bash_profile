# .bash_profile

# load .profile
if [ -f ~/.profile ]; then
  . ~/.profile
fi

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
