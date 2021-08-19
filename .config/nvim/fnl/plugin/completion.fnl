;;
;; https://github.com/hrsh7th/nvim-compe
;;

(module plugin.completion
  {autoload {plugin compe}
   require-macros [macros]})

(set! :completeopt "menuone,noselect")

(map! :i :<C-n> "compe#complete()" {:silent true :expr true})
(map! :i :<C-y> "compe#confirm()" {:silent true :expr true}) 

(plugin.setup 
  {:autocomplete true
   :source {
    :path true
    :nvim_lsp true
    :nvim_lua true
    :emoji true}})
