"----------------------------------------------------------------------------
" Edit
"----------------------------------------------------------------------------
set fenc=utf-8
set encoding=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set clipboard=unnamed,autoselect
set backspace=indent,eol,start

"----------------------------------------------------------------------------
" UI
"----------------------------------------------------------------------------

syntax on
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set cursorcolumn

"----------------------------------------------------------------------------
" Tab
"----------------------------------------------------------------------------
set expandtab
set tabstop=2
set shiftwidth=2

"----------------------------------------------------------------------------
" Search
"----------------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

"----------------------------------------------------------------------------
" Key mapping
"----------------------------------------------------------------------------

inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a
