
PATTERN='##non-interactive## load ~/.bash_noninteractive'

if ! grep -Fxq "$PATTERN" $HOME/.bashrc; then
  str=$(cat << EOS - ~/.bashrc
${PATTERN}
if [[ \$- != *i* ]]; then
  if [ -f ~/.bash_noninteractive ]; then
    . ~/.bash_noninteractive
  fi
fi

EOS
)
  echo "$str" > $HOME/.bashrc
fi
