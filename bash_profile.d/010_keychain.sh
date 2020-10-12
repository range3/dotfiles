# keychain
if command -v keychain 1>/dev/null 2>&1; then
  keychain \
    --quiet \
    --ignore-missing \
    $HOME/.ssh/id_rsa \
    $HOME/.ssh/id_dsa

  eval "$(keychain --quiet --eval)"
fi
