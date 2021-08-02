;;
;; https://github.com/hrsh7th/nvim-compe
;;

(module plugin.completion
  {autoload {plugin compe}
   require-macros [macros]})

(set! :completeopt "menuone,noselect")

(map! :i :<C-Space> "compe#complete()" {:silent true :noremap false :expr true}) 
(map! :i :<CR> "compe#confirm(\'<CR>\')" {:silent true :noremap false :expr true})

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
    :vsnip true
    :omni true
    :emoji true}})
