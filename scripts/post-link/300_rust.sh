if [ ! -d $HOME/.cargo ]; then
  curl https://sh.rustup.rs -sSf \
    | bash -s -- -y --no-modify-path
fi

${HOME}/.cargo/bin/rustup completions bash rustup \
  > ${HOME}/.bash_completion.d/rustup.bash-completion
${HOME}/.cargo/bin/rustup completions bash cargo \
  > ${HOME}/.bash_completion.d/cargo.bash-completion
