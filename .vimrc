call plug#begin('~/.vim/plugged')

" Autocomplete / lint
Plug 'ycm-core/YouCompleteMe'
Plug 'dense-analysis/ale'

" Javascript / Typescript / React
Plug 'HerringtonDarkholme/yats.vim'

" Files
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf.vim'

" tpope
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" markdown
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" misc
Plug 'chriskempson/base16-vim'
Plug 'psliwka/vim-smoothie'

call plug#end()

filetype plugin indent on
syntax on

" Remap jj to esc
inoremap jj <ESC>

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
map <leader><space> :let @/=''<cr> " clear search

" ctrlp / fzf
nmap <silent> <C-p> :Files<CR>

" Fast saving
nmap <leader>w :w!<cr>
:command! W w

" change cursor in insert mode (vim)

let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[1 q"

" live substitution
" set inccommand=split

" turn backup off (gonna regret this)
set nobackup
set nowb
set noswapfile

set updatetime=300

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

" NERDTree
nmap <silent> <C-n> :NERDTreeToggle<CR>
nmap <silent> <C-m> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeIgnore = ['^node_modules$']

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\}
let g:ale_fix_on_save = 1

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-seti
