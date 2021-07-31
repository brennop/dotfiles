;;
;; https://github.com/nvim-treesitter/nvim-treesitter
;; https://github.com/nvim-treesitter/nvim-treesitter-textobjects
;;

(module plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}
   require-macros [macros]})

(local parsers (require "nvim-treesitter.parsers"))

(def- languages [:fennel :clojure :commonlisp :query])

;; config
(treesitter.setup
  {:highlight {:enable true}
   :indent {:enable true}
   :rainbow {:enable true
             :disable (vim.tbl_filter 
                        (fn [parser] (not (vim.tbl_contains languages parser)))
                        (parsers.available_parsers))
             :colors [:#cc6666 :#de935f :#f0c674 :#b5bd68 :#8abeb7 :#81a2be :#b294bb]}})


;; folding
(set! :foldmethod "expr")
(set! :foldexpr "nvim_treesitter#foldexpr()")
