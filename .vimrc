set directory^=$HOME/.vim/tmp//

set path+=**
set title

set timeoutlen=1000 ttimeoutlen=10

" Defaults from NeoVim
syntax enable
filetype plugin indent on
set autoindent
set autoread
set backspace=indent,eol,start
set complete=.,w,b,u,t
set display=lastline
set encoding=utf-8
if exists('formatoptions')
  set formatoptions=tcqj
endif
set history=10000
set hlsearch
set incsearch
if exists('langnoremap')
  set langnoremap
endif
set laststatus=2
set listchars="tab:> ,trail:-,nbsp:+"
set mouse=a
set mousehide
set nocompatible
if exists('nrformats')
  set nrformats=bin,hex
endif
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
" set smarttab
set tabpagemax=50
set tags=./tags;,tags
set viminfo=!,'100,<50,s10,h
set wildmenu

" http://dougblack.io/words/a-good-vimrc.html
inoremap jk <esc>
nnoremap <space> <C-f>
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" My crazy tab setup
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <esc>:tabnew<CR>
if !has('gui_running')
  nnoremap <silent> <tab>     :tabnext<CR>
else
  set guioptions-=e " Do not use GUI tabs
endif

" Set the theme
set background=dark
colorscheme base16-tomorrow

" Set GUI options
if has('gui_running')
  set fullscreen
  let base16colorspace=256
  set guioptions-=r " Do not show scrollbar
  set guiheadroom=0 " Maximize window
  set guifont=Source\ Code\ Pro:h30
endif

" Terminal Navigation
if has('nvim')
  tnoremap <silent> <Esc>   <C-\><C-n>:close<CR>   " Escape exits terminal mode
  noremap  <silent> <C-d>   <esc>:below :5split term://bash<CR>i
elseif has('osx') && has('gui_running')
  noremap  <silent> <C-d>   <esc>:below :5split<CR>:ConqueTerm bash<CR>
endif

" Highlight column 80
set textwidth=80
highlight ColorColumn ctermbg=235 guibg=#222222
let &colorcolumn=join(range(81,200),",")

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Strip trailing whitespace on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Tabs
set tabstop=4
set shiftwidth=4
" set softtabstop=4
set noexpandtab
set list listchars=tab:»·,trail:·,nbsp:·

" Vundle Plugins
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'chriskempson/base16-vim'
call vundle#end()
filetype on

" LightLine Config
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night',
    \ 'active': {
    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'filetype' ] ]
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
set noshowmode
