# keychain
if command -v keychain 1>/dev/null 2>&1; then
  keychain \
    --quiet \
    --ignore-missing \
    $(find $HOME/.ssh -name 'id_*' -and -not -name '*.pub')

  eval "$(keychain --quiet --eval)"
fi
