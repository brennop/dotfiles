;;
;; https://github.com/akinsho/nvim-bufferline.lua
;;

(module plugin.bufferline
  {autoload {plugin bufferline}
   require-macros [macros]})

;; mappings
(map! :n :gt ":BufferLineCycleNext<CR>" {:silent true})
(map! :n :gT ":BufferLineCyclePrev<CR>" {:silent true})
(map! :n :<leader>q ":Bdelete<CR>" {:silent true}) ;; vim-bbye

;; config
(plugin.setup {:options 
               {:offsets [{ :filetype "NvimTree" }]
                :show_close_icon false
                :show_buffer_close_icons false
                :separator_style ["" ""]}})
