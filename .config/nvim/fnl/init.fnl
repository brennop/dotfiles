(module init
  {autoload {a aniseed.core
             utils utils}
   require-macros [macros]})

(let! :mapleader " ")
(let! :maplocalleader "\\")

(include :plugin)

;
; options
;

(cmd! "syntax enable")
(cmd! "syntax on")

(set! :termguicolors true)      ; true colors

(set! :shiftwidth 2)            ; Size of an indent
(set! :tabstop 2)               ; Number of spaces tabs count for
(set! :expandtab true)          ; Use spaces instead of tabs
(set! :smartindent true)        ; Insert indents automatically
(set! :textwidth 80)
(set! :number true)

(set! :signcolumn "no")         ; no sign column
(set! :laststatus 2)            ; hide something
(set! :showmode false)          ; hide Insert, Replace or Visual (lualine)

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

;
; mappings
;

(utils.map :n "<Space>" "")

(utils.noremap! "," "e ~/.config/nvim/fnl/init.fnl")    ; edit config file 

(utils.map :n :<localleader>n ::nohlsearch<cr>) ; Clear search
