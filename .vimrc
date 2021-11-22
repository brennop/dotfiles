call plug#begin('~/.vim/plugged')

" tpope
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'

call plug#end()

filetype plugin indent on
syntax on

let mapleader = " "

" mouse
set mouse+=a

" cursor motion
set scrolloff=7

set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" A buffer becomes hidden when it is abandoned
set hid

" cliboard
set clipboard=unnamedplus

set number

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <silent><leader>l :let @/=''<cr> " clear search

" set inccommand=split

" turn backup off (gonna regret this)
set nobackup
set nowb
set noswapfile

set updatetime=100

" tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set noshiftround
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-b> :Buffers<CR>

set termguicolors
colors base16-seti
