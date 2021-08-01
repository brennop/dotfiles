;;
;; https://github.com/nvim-treesitter/nvim-treesitter
;; https://github.com/nvim-treesitter/nvim-treesitter-textobjects
;;

(module plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}
   require-macros [macros]})


;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  🌈 rainbow
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(local parsers (require "nvim-treesitter.parsers"))

(def- languages [:fennel :clojure :commonlisp :query])

(def- rainbow {:enable true
             :disable (vim.tbl_filter 
                        (fn [parser] (not (vim.tbl_contains languages parser)))
                        (parsers.available_parsers))
             :colors ["#f2777a"
                      "#f99157"
                      "#ffcc66"
                      "#99cc99"
                      "#66cccc"
                      "#6699cc"
                      "#cc99cc"]})



;; ░▒▓▓▓▓▓▓▓▓▓▒░
;;  textobjects
;; ░▒▓▓▓▓▓▓▓▓▓▒░

(def- textobjects 
  {:select {:enable true
            :lookahead false
            :keymaps {:af "@function.outer"
                      :if "@function.inner"
                      :ac "@class.outer"
                      :ic "@class.inner"
                      :ia "@parameter.inner"
                      :aa "@parameter.outer"}}
   :swap {:enable true
          :swap_next {:<leader>a "@parameter.inner"}
          :swap_previous {:<leader>A "@parameter.inner"}}})

;; ░▒▓▓▓▓▓▓▓▓▒░
;;  📂 folding
;; ░▒▓▓▓▓▓▓▓▓▒░

(set! :foldmethod "expr")
(set! :foldexpr "nvim_treesitter#foldexpr()")


;; ░▒▓▓▓▓▓▓▓▓▒░
;;  incremental
;; ░▒▓▓▓▓▓▓▓▓▒░

(def- incremental 
  {:enable true
   :keymaps {:init_selection    "<C-i>"
             :node_incremental  "."
             :scope_incremental "s"
             :node_decremental  ","}})

;; ░▒▓▓▓▓▓▓▓▒░
;;  🔧 setup
;; ░▒▓▓▓▓▓▓▓▒░

(treesitter.setup
  {:highlight {:enable true}
   :indent {:enable true}
   :incremental_selection incremental
   :rainbow rainbow
   :textobjects textobjects})
