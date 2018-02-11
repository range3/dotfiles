call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/yanktmp.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/endwise.vim'
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
call plug#end()

" mapping for yanktmp.vim 
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" netrw
"" tree view
let g:netrw_liststyle = 3

" syntax
if has("syntax")
	syntax on
endif

noremap   
noremap!  
noremap <BS> 
noremap! <BS> 
set backspace=indent,eol,start

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

" search
set hlsearch
set smartcase

" buffer
set hidden

" backup and swap dir
set backupdir=~/.vim/backup
set directory=~/.vim/swap

if has("autocmd")
  " auto {} for c and cpp
  autocmd FileType c,cpp,cc,hpp inoremap { {<RETURN>}<UP><ESC>o

  " for .vue file
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.css
  autocmd FileType jsp,asp,php,xml,perl,vue.html.css syntax sync minlines=500 maxlines=1000

  " disable auto comment line insertion
  autocmd Filetype * setlocal formatoptions-=ro

	" save the cursor position
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
endif
