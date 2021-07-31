;;
;; https://github.com/kyazdani42/nvim-tree.lua
;;

(module plugin.tree
  {autoload {plugin nvim-tree.lua
             utils utils}
   require-macros [macros]})

;; mappings
(utils.map :n :<C-n> ::NvimTreeToggle<CR>)
(utils.map :n :<leader>n ::NvimTreeFindFile<CR>)

;; config
(let! :nvim_tree_gitignore 1)
(let! :nvim_tree_tab_open 1)
(let! :nvim_tree_quit_on_open 1)
