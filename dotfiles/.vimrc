" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" mkdir backup directory if not exist
if empty(glob(data_dir . '/backup'))
  silent execute '!mkdir -p  '.data_dir.'/backup > /dev/null 2>&1'
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/yanktmp.vim'
call plug#end()

" mapping for yanktmp.vim 
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" syntax
if has("syntax")
  syntax on
endif

" mapping timeout
set timeout
set timeoutlen=200

" tab
set ts=2 sw=2
set ai
set smartindent
set smarttab
set expandtab

" cursor movement
set whichwrap=b,s,h,l,<,>,[,]

" ctrl-a increment is always based on base-10
set nrformats=

" buffer
set hidden

" search
set hlsearch
set smartcase

" backup and swap dir
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//
set undodir=~/.vim/backup//
