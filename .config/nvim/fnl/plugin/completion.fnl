;;
;; https://old.reddit.com/r/neovim/comments/mn8ipa/lsp_add_missing_imports_on_complete_using_the/
;;

(module plugin.completion
  {autoload {cmp cmp}
   require-macros [macros]})

(set! :completeopt "menu,menuone,noselect")

(cmp.setup 
  {:autocomplete true
   :mapping {:<C-d>     (cmp.mapping.scroll_docs -4)
             :<C-f>     (cmp.mapping.scroll_docs 4)
             :<C-Space> (cmp.mapping.complete)
             :<C-e>     (cmp.mapping.close)
             :<C-y>     (cmp.mapping.confirm { :select true })}
   :sources [{:name :nvim_lsp}]})
