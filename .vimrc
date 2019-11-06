" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'dense-analysis/ale'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'styled-components/vim-styled-components'

Plugin 'vim-ruby/vim-ruby'

" Plugin 'honza/vim-snippets'
" Plugin 'SirVer/ultisnips'
Plugin 'mattn/emmet-vim'

Plugin 'raimondi/delimitmate'

Plugin 'ycm-core/YouCompleteMe'
Plugin 'junegunn/goyo.vim'

Plugin 'prettier/vim-prettier'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'chriskempson/base16-vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" let mapleader = "alt"

" autocomplete preview window
let g:ycm_autoclose_preview_window_after_insertion = 1

" nerdtree
" Map ctrl+i to nerdtree 
map <C-n> :NERDTreeToggle<CR>

" start automatically with just vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" dies when alone
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" close on open
let g:NERDTreeQuitOnOpen = 1

" Security
set modelines=0

" Show line numbers
" set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
"set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=0

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" clipboard
" set clipboard=unnamedplus

" Color scheme (terminal)
set t_Co=256
set background=dark
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" base16
" colorscheme base16-default-dark 

