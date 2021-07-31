;;
;; https://github.com/hrsh7th/nvim-compe
;;

(module plugin.completion
  {autoload {plugin compe
             utils utils}
   require-macros [macros]})

(set! :completeopt "menuone,noselect")

(plugin.setup 
  {:autocomplete true
   :min_length 2
   :source {
    :path true
    :buffer true
    :calc true
    :spell true
    :nvim_lsp true
    :nvim_lua true
    :omni true
    :emoji true}})
