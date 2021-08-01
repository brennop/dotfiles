(module init
  {autoload {a aniseed.core}
   require-macros [macros]})

(def- opts { :noremap true :silent true })

(defn map [mode lhs rhs]
  (vim.api.nvim_set_keymap mode lhs rhs opts))

(defn noremap! [lhs rhs] 
  (vim.api.nvim_set_keymap
    :n
    (.. "<leader>" lhs)
    (.. ":" rhs "<CR>")
    opts))

;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  ⌨️ mappings
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(let! :mapleader " ")
(let! :maplocalleader :\\\)

(map :n :<Space> "")

(noremap! "," "e ~/.config/nvim/fnl/init.fnl")  ; edit config file 
(noremap! :p "lua vim.lsp.buf.formatting()")    ; try to format

(noremap! :l :noh) ; Clear search

;; navigating cmdline without arrow keys (cmdline-editing)
(map :c :<C-a> :<Home>)
(map :c :<C-f> :<Right>)
(map :c :<C-b> :<Left>)
