;;
;; https://github.com/nvim-telescope/telescope.nvim
;;

(module plugin.telescope
  {autoload {plugin telescope
             actions telescope.actions}
   require-macros [macros]})

(defn- map [mapping cmd]
  (vim.api.nvim_set_keymap 
    :n 
    (.. :<leader> mapping)
    (.. ":Telescope " cmd "<CR>")
    {:silent true}))

;; mappings
(map :ff :find_files)
(map :fg :live_grep)
(map :fb :buffers)
(map :fh :oldfiles)
(map :fc :lsp_code_actions)
(map :fz :spell_suggest)

;; spelling

;; config
(plugin.setup {:defaults 
               {:mappings 
                {:i 
                 {:<ESC> actions.close}}}})
