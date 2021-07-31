;;
;; https://github.com/nvim-telescope/telescope.nvim
;;

(module plugin.telescope
  {autoload {plugin telescope
             actions telescope.actions
             utils utils}
   require-macros [macros]})

(defn- map [mapping cmd]
  (utils.map :n (.. :<leader> mapping) (.. ":Telescope " cmd "<CR>")))

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
