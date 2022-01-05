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
