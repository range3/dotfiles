" syntax
if has("syntax")
  syntax on
endif

" mapping timeout
set timeout
set timeoutlen=200

" tab
set tabstop=2
set shiftwidth=2
set ai
set expandtab
set smartindent
set smarttab

" cursor movement
set whichwrap=b,s,h,l,<,>,[,]

" ctrl-a increment is always based on base-10
set nrformats=

" buffer
set hidden

" search
set hlsearch
set ignorecase
set smartcase
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc> " clear highlight
