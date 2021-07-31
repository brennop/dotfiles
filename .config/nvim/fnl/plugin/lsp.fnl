;;
;; https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
;;

(module plugin.lsp
  {autoload {plugin lspconfig
             utils utils}
   require-macros [macros]})

(def- opts {:noremap true :silent true})

(defn- lsp-buf-map [bufnr map cmd]
  (vim.api.nvim_buf_set_keymap 
    bufnr 
    :n 
    map 
    (.. "<cmd>lua vim.lsp." cmd "()<CR>")
    opts))

(def- mappings {:gD         :buf.declaration
                :gd         :buf.definition
                :gi         :buf.implementation
                :gr         :buf.references
                :K          :buf.hover
                :<C-k>      :buf.signature_help
                :<leader>rn :buf.rename
                :<leader>D  :buf.type_definition
                :<leader>e  :diagnostic.show_line_diagnostics
                "[d"        :diagnostic.goto_prev
                "]d"        :diagnostic.goto_next
                :<leader>q  :diagnostic.set_loclist})

;; ░▒▓▓▓▓▓▓▒░
;;  tsserver
;; ░▒▓▓▓▓▓▓▒░

(plugin.tsserver.setup {:on_attach (fn [client bufnr]
                                        (do 
                                          (each [map cmd (pairs mappings)]
                                            (lsp-buf-map bufnr map cmd))))})

