set directory^=$HOME/.vim/tmp//

" Defaults from NeoVim
filetype plugin indent on
set autoindent
set autoread
set backspace="indent,eol,start"
set complete=".,w,b,u,t"
set display="lastline"
set encoding=utf-8
set formatoptions="tcqj"
set history=10000
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set listchars="tab:> ,trail:-,nbsp:+"
set mouse="a"
set nocompatible
set nrformats="bin,hex"
set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize"
set smarttab
set tabpagemax=50
set tags="./tags;,tags"
set ttyfast
set viminfo="!"
set wildmenu
set mousehide

if has('mouse')
  set mouse=a
endif

let macvim_skip_colorscheme=1 " Silly MacVim :p

set background=dark
colorscheme base16-tomorrow

" jk is escape
inoremap jk <esc>

if has('gui_running')
  set transparency=1
  set guifont=Source\ Code\ Pro:h30
else
  set lazyredraw          " redraw only when we need to.
endif


" Highlight column 80
set textwidth=80
if has('gui_running')
  set columns=100
endif

if has('nvim')
  syntax on
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
  highlight ColorColumn ctermbg=235 guibg=#282a2e
  highlight CursorColumn ctermbg=235 guibg=#1d1f21
  let &colorcolumn=join(range(81,200),",")
endif

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
set softtabstop=4
set expandtab
set list listchars=tab:»·,trail:·,nbsp:·

nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <esc>:tabnew<CR>
if !has('gui_running')
  nnoremap <silent> <tab>     :tabnext<CR>
else
  set guioptions-=e
endif


" Ruler
set ruler

" Vundle Plugins
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'

Plugin 'shirk/vim-gas'

Plugin 'chriskempson/base16-vim'
call vundle#end()
filetype on

" LightLine Config
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'component': {
    \   'readonly': '%{&readonly?"":""}',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
autocmd BufEnter * call lightline#update_once()
set noshowmode
function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction
function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction
function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction
function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
