if [ ! -d $HOME/.cargo ]; then
  curl https://sh.rustup.rs -sSf \
    | bash -s -- -y --no-modify-path
  ${HOME}/.cargo/bin/rustup completions bash \
    > ${HOME}/.bash_completion.d/rustup.bash-completion
fi
