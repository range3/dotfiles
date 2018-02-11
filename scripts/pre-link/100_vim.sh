if [ ! -f ${DOTPATH}/vim/autoload/plug.vim ]; then
  curl -fLo ${DOTPATH}/vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
