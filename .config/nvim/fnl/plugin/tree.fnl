;;
;; https://github.com/kyazdani42/nvim-tree.lua
;;

(module plugin.tree
  {autoload {plugin nvim-tree.lua}
   require-macros [macros]})

;; mappings
(map! :n :<C-n> ":NvimTreeToggle<CR>" {:silent true})
(map! :n :<leader>n ":NvimTreeFindFile<CR>" {:silent true})

;; config
(let! :nvim_tree_gitignore 1)
(let! :nvim_tree_tab_open 1)
(let! :nvim_tree_quit_on_open 1)
(let! :nvim_tree_indent_markers 1)
