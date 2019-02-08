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

inoremap <C-c> <Esc>
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a

nnoremap <silent><C-t> :NERDTreeToggle<CR>

"----------------------------------------------------------------------------
" Set up plugin
"----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'Shougo/unite.vim' " opening file
Plug 'Shougo/neomru.vim' " showing recent used file
Plug 'alvan/vim-closetag' " closing tag
Plug 'fatih/vim-go' " golang
Plug 'scrooloose/nerdtree' " opening file tree
Plug 'airblade/vim-gitgutter' "vim with git
Plug 'ctrlpvim/ctrlp.vim' "search with file name

call plug#end()

"----------------------------------------------------------------------------
" Config for plugin
"----------------------------------------------------------------------------

let NERDTreeShowHidden = 1
