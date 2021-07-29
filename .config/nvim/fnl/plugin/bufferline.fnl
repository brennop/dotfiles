;;
;; https://github.com/akinsho/nvim-bufferline.lua
;;

(module plugin.bufferline
  {autoload {plugin bufferline
             utils utils}
   require-macros [macros]})

;; mappings
(utils.map :n :gt ::BufferLineCycleNext<CR>)
(utils.map :n :gT ::BufferLineCyclePrev<CR>)
(utils.noremap! :q :Bdelete) ;; vim-bbye

;; config
(plugin.setup {:options 
               {:offsets [{ :filetype "NvimTree" }]
                :show_close_icon false
                :show_buffer_close_icons false
                :separator_style ["" ""]}})
