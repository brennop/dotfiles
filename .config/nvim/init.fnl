(local {: opt : cmd : keymap : g} vim)
(local opts {:silent true :noremap true})

(macro setup [plugin config]
  `((. (require ,plugin) :setup) ,config))

(macro set! [key value]
  `(tset opt ,key ,value))

(macro nmap [lhs rhs]
  `(keymap.set :n ,lhs ,rhs opts))

(set! :termguicolors true)
(set! :shiftwidth 2)
(set! :tabstop 2)
(set! :expandtab true)
(set! :smartindent true)
(set! :textwidth 80)
(set! :number true)
(set! :signcolumn :no)
(set! :laststatus 3)
(set! :cmdheight 0)
(set! :hidden true)
(set! :swapfile false)
(set! :ignorecase true)
(set! :smartcase true)
(set! :hlsearch true)
(set! :incsearch true)
(set! :scrolloff 8)
(set! :clipboard :unnamedplus)

(cmd "colorscheme kanagawa")

(let [paq (require :paq)]
  (paq [:savq/paq-nvim
        :udayvir-singh/tangerine.nvim
        :kyazdani42/nvim-web-devicons
        :rebelot/kanagawa.nvim
        :lukas-reineke/indent-blankline.nvim
        :junegunn/fzf
        :junegunn/fzf.vim
        :kyazdani42/nvim-tree.lua
        :numToStr/Navigator.nvim
        :neovim/nvim-lspconfig
        :nvim-treesitter/nvim-treesitter
        :tpope/vim-fugitive
        :tpope/vim-repeat
        :tpope/vim-commentary
        :tpope/vim-surround]))

(setup :nvim-treesitter.configs
       {:highlight {:enable true}
        :indent {:enable true}
        :incremental_selection {:enable true
                                :keymaps {:node_incremental "."
                                          :node_decremental ","}}})

(setup :Navigator {})
(setup :indent_blankline {})

(nmap :<space>e vim.diagnostic.open_float)
(nmap "[d" vim.diagnostic.goto_prev)
(nmap "]d" vim.diagnostic.goto_next)

(fn on_attach [client bufnr]
  (let [bufopts {:noremap true :silent true :buffer bufnr}
        map #(keymap.set :n $1 (. vim :lsp :buf $2) bufopts)]
    (do
      (map :K :hover)
      (map :gD :declaration)
      (map :gd :definition)
      (map :gi :implementation)
      (map :gr :references)
      (map :<space>D :type_definition)
      (map :<spane>rn :rename)
      (map :<space>ca :code_action)
      (keymap.set :n :<space>f #(vim.lsp.buf.format {:async true}) bufopts))))

(let [lsp (require :lspconfig)]
  (each [_ server (ipairs [:clangd :tsserver])]
    ((. lsp server :setup) {: on_attach})))

(tset g :mapleader " ")
(keymap.set :n :<Space> "" {})

(nmap "<leader>," ":e ~/.config/nvim/init.fnl<cr>")
(nmap :<leader>l ":noh<cr>")
(nmap :H "^")
(nmap :L "$")
(nmap :<C-n> ":NvimTreeToggle<cr>")
(nmap :<C-p> ":Files<cr>")
(nmap :<C-f> ":Rg<cr>")

(keymap.set :n :j :gj)
(keymap.set :v :k :gk)
(keymap.set :n :Q "@i" opts)
(keymap.set :v :Q ":norm @i<cr>" opts)

(let [navigator (require :Navigator)]
  (each [key dir (pairs {:h :left :k :up :l :right :j :down})]
    (keymap.set :n (.. :<A- key ">") (. navigator dir) opts)))
