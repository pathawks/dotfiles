set directory^=$HOME/.vim/tmp//
set encoding=utf-8
set guifont=Source\ Code\ Pro:h30

colorscheme base16-tomorrow
set transparency=1
set background=dark

" Highlight column 80
set textwidth=80
if has('gui_running')
  set columns=100
endif

highlight ColorColumn ctermbg=235 guibg=#282a2e
highlight CursorColumn ctermbg=235 guibg=#1d1f21
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
set laststatus=2
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
