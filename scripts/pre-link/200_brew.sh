if [ ! -d $HOME/.linuxbrew ]; then
  git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew
  mkdir ~/.linuxbrew/bin
  ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
  eval $($HOME/.linuxbrew/bin/brew shellenv)
fi
