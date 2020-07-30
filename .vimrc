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
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/vim-emoji'

Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'styled-components/vim-styled-components'
Plugin 'mattn/emmet-vim'

Plugin 'vim-ruby/vim-ruby'

" Plugin 'honza/vim-snippets'
" Plugin 'SirVer/ultisnips'
" Plugin 'mattn/emmet-vim'

" tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'

Plugin 'raimondi/delimitmate'

Plugin 'ycm-core/YouCompleteMe'
Plugin 'junegunn/goyo.vim'

Plugin 'prettier/vim-prettier'
Plugin 'Chiel92/vim-autoformat'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'chriskempson/base16-vim'
Plugin 'dylanaraps/wal.vim'

call vundle#end()            " required
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" mouse
set ttymouse=xterm2
set mouse+=a

" let mapleader = "alt"

" autocomplete preview window
let g:ycm_autoclose_preview_window_after_insertion = 1

" c extra conf
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.global_extra_conf.py' 

" nerdtree
" Map ctrl+i to nerdtree 
map <C-i> :NERDTreeToggle<CR>

" run current file/project on tmux
autocmd FileType lua map <leader>r :w<CR> :VimuxRunCommand("love .")<CR>
autocmd FileType c map <leader>r :w<CR> :VimuxRunCommand("gcc main.c -o /tmp/main && /./tmp/main")<CR>

" folding
set nofoldenable    " disable folding

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
set number
nmap <C-n> :set invrelativenumber<CR>
" inoremap <F3> <C-O>:set invrelativenumber<CR>

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
" set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" esc with j
inoremap jj <ESC>

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=0

" Last line
"set showmode
"set showcmd

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

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

noremap <F3> :Autoformat<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" clipboard
set clipboard=unnamedplus

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
colorscheme wal
