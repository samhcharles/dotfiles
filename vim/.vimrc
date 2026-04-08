" ~/.vimrc — minimal, no plugin manager.

set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set hidden
set autoread
set backspace=indent,eol,start
set mouse=a
if has('clipboard')
    set clipboard^=unnamed,unnamedplus
endif

set number
set relativenumber
set laststatus=2
set wildmenu
set wildmode=longest:full,full

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smartindent
set autoindent

set ignorecase
set smartcase
set incsearch
set hlsearch

set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undo//
silent! call mkdir(expand('~/.vim/undo'), 'p')

set splitbelow
set splitright

let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <silent> <leader><space> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap Y y$

" Restore last cursor position.
augroup restore_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
