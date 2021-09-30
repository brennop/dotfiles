;;
;; https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
;;

(module plugin.lsp
  {autoload {plugin lspconfig}
   require-macros [macros]})

(defn- buf-set-keymap [buffer map cmd]
  (vim.api.nvim_buf_set_keymap 
    buffer :n map (.. "<cmd>lua vim.lsp." cmd "()<CR>") {:noremap true :silent true}))

(defn- buf-set-option [buffer name value]
  (vim.api.nvim_buf_set_option buffer name value))

(def- mappings {:gD         :buf.declaration
                :gd         :buf.definition
                :gi         :buf.implementation
                :gr         :buf.references
                :K          :buf.hover
                :<C-k>      :buf.signature_help
                :<leader>rn :buf.rename
                :<leader>D  :buf.type_definition
                :<leader>p  :buf.formatting
                :<leader>e  :diagnostic.show_line_diagnostics
                "[d"        :diagnostic.goto_prev
                "]d"        :diagnostic.goto_next})

(defn- on-attach [_ bufnr] 
  "set default mappings on attach to buffer"
  (do 
    (buf-set-option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
    (each [map cmd (pairs mappings)] 
      (buf-set-keymap bufnr map cmd))))

;; ░▒▓▓▓▓▓▓▓▒░
;;  defaults
;; ░▒▓▓▓▓▓▓▓▒░

(each [_ server (ipairs [:clangd :hls :metals :pyright])] 
  (let [s (. plugin server)] 
    (s.setup {:on_attach on-attach})))

;; ░▒▓▓▓▓▓▓▓▓▒░
;;   tsserver
;; ░▒▓▓▓▓▓▓▓▓▒░

(plugin.tsserver.setup 
  {:on_attach (fn [client buffer] 
                (do
                  (set client.resolved_capabilities.document_formatting false)
                  (on-attach client buffer)))})

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
  {:on_attach (fn [client] 
                (do
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
     :yaml [prettier]}}
   :filetypes [:css :html :javascript :javascript :javascriptreact :json
               :markdown :scss :typescript :typescriptreact :yaml]})

