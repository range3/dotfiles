
PATTERN='##dotfiles## load ~/.bashrc.d'

if ! grep -Fxq "$PATTERN" $HOME/.bashrc; then
  cat << EOS >> $HOME/.bashrc
$PATTERN
if [ -d "\${HOME}/.bashrc.d" ]; then
  for f in \${HOME}/.bashrc.d/*.sh ; do
    . \$f
  done
  unset f
fi
EOS
fi

