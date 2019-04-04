if [ ! -d $HOME/.cargo ]; then
  curl https://sh.rustup.rs -sSf \
    | bash -s -- -y --no-modify-path
fi
