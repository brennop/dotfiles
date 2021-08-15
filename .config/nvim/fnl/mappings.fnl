(module mappings
  {autoload {a aniseed.core}
   require-macros [macros]})

;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  ⌨️ mappings
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(let! :mapleader " ")
(let! :maplocalleader "\\")

(map! :n :<Space> "" {})

(map! :n "<leader>," ":e ~/.config/nvim/fnl/init.fnl<cr>") ; edit config file 
(map! :n :<leader>p ":lua vim.lsp.buf.formatting()<cr>")  ; try to format
(map! :n :<leader>l ":noh<cr>") ; Clear search

;; navigating cmdline without arrow keys (cmdline-editing)

(map! :c :<C-A> :<Home>)
(map! :c :<C-F> :<Right>)
(map! :c :<C-B> :<Left>)
