_file_path="${DOTPATH}/bash_completion.d/yarn-completion.bash"

if [ ! -f ${_file_path} ]; then
  curl -fLo ${_file_path} \
    https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
fi

unset _file_path
