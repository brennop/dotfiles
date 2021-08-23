;;
;; https://github.com/akinsho/nvim-bufferline.lua
;;

(module plugin.bufferline
  {autoload {plugin bufferline}
   require-macros [macros]})

;; mappings
(map! :n "<A-.>" ":BufferLineCycleNext<CR>" {:silent true})
(map! :n "<A-,>" ":BufferLineCyclePrev<CR>" {:silent true})
(map! :n "<A-q>" ":Bdelete<CR>" {:silent true}) ;; vim-bbye

;; config
(plugin.setup {:options 
               {:offsets [{ :filetype "NvimTree" }]
                :show_buffer_icons false
                :show_close_icon false
                :show_buffer_close_icons false
                :indicator_icon " "
                :separator_style ["" ""]}
               :highlights
               {:buffer_selected
                {:gui "bold" :guibg "#e0e0e0"}
                :indicator_selected
                {:guibg "#e0e0e0"}
                :modified_selected
                {:guibg "#e0e0e0"}
                :fill
                {:guibg "NONE"}
                :background
                {:guibg "NONE"}
                :modified
                {:guibg "NONE"}
                :modified_visible
                {:guibg "NONE"}}})
