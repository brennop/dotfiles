;; -========================-
;;    vim, sabor erva-doce
;; -========================-

(module init
  {autoload {a aniseed.core
             utils utils}
   require-macros [macros]})

(include :plugin)

;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  ⚙ Settings
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(cmd! "syntax enable")
(cmd! "syntax on")

(set! :termguicolors true)      ; true colors

(set! :shiftwidth 2)            ; Size of an indent
(set! :tabstop 2)               ; Number of spaces tabs count for
(set! :expandtab true)          ; Use spaces instead of tabs
(set! :smartindent true)        ; Insert indents automatically
(set! :textwidth 80)
(set! :number false)

(set! :signcolumn "no")         ; no sign column
(set! :laststatus 0)            ; statusline (2 = show, 0 = hidden)
(set! :showmode false)          ; Insert, Replace or Visual
(set! :showcmd false)           ; last key typed
(set! :rulerformat "%=%l,%v")   ; right align, then row, virtual column

(set! :hidden true)             ; Enable modified buffers in background
(set! :wrap false)              ; turn off wrapping
(set! :swapfile false)          ; playing on hard mode

(set! :ignorecase true)         ; Ignore case
(set! :smartcase true)          ; Don't ignore case with capitals
(set! :hlsearch true)
(set! :incsearch true)          ; live search
(set! :inccommand "split")      ; live substitution

(set! :joinspaces false)        ; No double spaces with join after a dot
(set! :shiftround true)         ; Round indent
(set! :scrolloff 8)             ; Lines of context
(set! :sidescrolloff 8)         ; Columns of context

(set! :clipboard "unnamedplus")
(set! :mouse "a")

(vim.opt.shortmess:append {:c true}) ; compe pare de mostrar coisa la em baixo
(set! :foldlevelstart 99)

;; vimwiki
(let! vimwiki_list [{:path "~/notes/unb" :syntax "markdown" :ext ".md"}])
(let! vimwiki_create_link 0)

;; professor pasquale
(set! :spelllang "pt_br")
(cmd! "autocmd BufRead,BufNewFile *.md setlocal spell")
(cmd! "autocmd FileType gitcommit setlocal spell")

;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  ⌨️ mappings
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(let! :mapleader " ")
(let! :maplocalleader :\\\\)

(utils.map :n :<Space> "")

(utils.noremap! "," "e ~/.config/nvim/fnl/init.fnl")  ; edit config file 
(utils.noremap! :p "lua vim.lsp.buf.formatting()")    ; try to format

(utils.noremap! :l :noh) ; Clear search

;; navigating cmdline without arrow keys (cmdline-editing)
(utils.map :c :<C-a> :<Home>)
(utils.map :c :<C-f> :<Right>)
(utils.map :c :<C-b> :<Left>)
