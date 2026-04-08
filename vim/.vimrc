" ~/.vimrc — minimal but useful. No plugin manager required.

set nocompatible
filetype plugin indent on
syntax on

" --- Behavior ---------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set hidden                  " allow buffers in background
set autoread                " reload files changed outside vim
set backspace=indent,eol,start
set mouse=a
set clipboard^=unnamed,unnamedplus
set ttyfast
set lazyredraw
set updatetime=300
set timeoutlen=500

" --- UI ---------------------------------------------------------------------
set number
set relativenumber
set cursorline
set ruler
set showcmd
set showmatch
set wildmenu
set wildmode=longest:full,full
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set termguicolors
set background=dark
set laststatus=2
set noshowmode

" --- Indentation ------------------------------------------------------------
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smartindent
set autoindent

" --- Search -----------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

" --- Files ------------------------------------------------------------------
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undo//
silent! call mkdir(expand('~/.vim/undo'), 'p')

" --- Splits -----------------------------------------------------------------
set splitbelow
set splitright

" --- Leader & mappings ------------------------------------------------------
let mapleader = " "

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Better wrapped-line motion
nnoremap j gj
nnoremap k gk

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv

" Yank to end of line, like D and C
nnoremap Y y$

" --- Tweaks -----------------------------------------------------------------
" Trim trailing whitespace on save (except markdown).
augroup trim_trailing
    autocmd!
    autocmd BufWritePre * if &filetype !~# 'markdown' | %s/\s\+$//e | endif
augroup END

" Restore last cursor position.
augroup restore_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
