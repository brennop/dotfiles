;;
;; https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
;;

(module plugin.lsp
  {autoload {plugin lspconfig
             utils utils}
   require-macros [macros]})

(defn- lsp-buf-map [bufnr map cmd]
  (vim.api.nvim_buf_set_keymap 
    bufnr 
    :n 
    map 
    (.. "<cmd>lua vim.lsp." cmd "()<CR>")
    {:noremap true :silent true}))

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

(defn- on-attach [_ bufnr] 
  "set default mappings on attach to buffer"
  (do 
    (each [map cmd (pairs mappings)] 
      (lsp-buf-map bufnr map cmd))))

;; ░▒▓▓▓▓▓▓▓▒░
;;  defaults
;; ░▒▓▓▓▓▓▓▓▒░

(each [_ server (ipairs [:tsserver :hls])] 
  (let [s (. plugin server)] 
    (s.setup {:on_attach on-attach})))

;; ░▒▓▓▓▓▓▓▓▓▓▓▓▓▒░
;;  🌅 solargraph
;; ░▒▓▓▓▓▓▓▓▓▓▓▓▓▒░

(plugin.solargraph.setup {:on_attach on-attach
                          :flags {:debounce_text_changes 100}})

;; ░▒▓▓▓▓▓▓▒░
;;   🚨 efm
;; ░▒▓▓▓▓▓▓▒░

(def- eslint {:lintCommand "eslint_d -f unix --stdin --stdin-filename ${INPUT}"
              :lintIgnoreExitCode true
              :lintStdin true
              :lintFormats ["%f:%l:%c: %m"]
              :formatCommand "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}"
              :formatStdin true})

(def- prettier {:formatCommand "prettier --stdin-filepath ${INPUT}"
                :formatStdin true})

(plugin.efm.setup 
  {:on_attach (fn [client] (do
                             (set client.resolved_capabilities.document_formatting true)
                             (set client.resolved_capabilities.goto_definition false)))
   :settings 
   {:languages 
    {:css [prettier]
     :html [prettier]
     :javascript [prettier eslint]
     :javascriptreact [prettier eslint]
     :json [prettier]
     :markdown [prettier]
     :scss [prettier]
     :typescript [prettier eslint]
     :typescriptreact [prettier eslint]
     :yaml [prettier]}}})

