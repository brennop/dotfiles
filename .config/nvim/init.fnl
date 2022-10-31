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
(set! :number false)
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
(set! :completeopt "menuone,noselect")

(set! :background :light)
(cmd "colorscheme zenbones")

(let [paq (require :paq)]
  (paq [:savq/paq-nvim
        :udayvir-singh/tangerine.nvim
        :kyazdani42/nvim-web-devicons
        :rktjmp/lush.nvim
        :cideM/yui
        :stefanvanburen/rams
        :mcchrish/zenbones.nvim
        :lukas-reineke/indent-blankline.nvim
        :junegunn/fzf
        :junegunn/fzf.vim
        :numToStr/Navigator.nvim
        :nvim-tree/nvim-tree.lua
        :neovim/nvim-lspconfig
        :nvim-treesitter/nvim-treesitter
        :p00f/nvim-ts-rainbow
        :echasnovski/mini.nvim
        :github/copilot.vim
        :tpope/vim-fugitive
        :tpope/vim-repeat
        :tpope/vim-commentary
        :tpope/vim-surround]))

(setup :nvim-treesitter.configs
       {:highlight {:enable true}
        :indent {:enable true}
        :rainbow {:enable true
                  :colors ["#d43e36"
                           "#f89623"
                           "#eec100"
                           "#839b00"
                           "#4ba8af"
                           "#5286bc"
                           "#9c71b7"]}
        :incremental_selection {:enable true
                                :keymaps {:node_incremental "."
                                          :node_decremental ","}}})

(setup :Navigator {})
(setup :indent_blankline {:char "."})
(setup :nvim-tree {:actions {:open_file {:quit_on_open true}}})

(setup :mini.pairs {})

(nmap :<space>e vim.diagnostic.open_float)
(nmap "[d" vim.diagnostic.goto_prev)
(nmap "]d" vim.diagnostic.goto_next)

(fn on_attach [client bufnr]
  (let [bufopts {:noremap true :silent true :buffer bufnr}
        map #(keymap.set :n $1 (. vim :lsp :buf $2) bufopts)]
    (do
      (map :K :hover)
      (map :gd :definition)
      (map :gr :references)
      (map :<space>D :type_definition)
      (map :<space>rn :rename)
      (map :<space>ca :code_action)
      (keymap.set :n :<space>f #(vim.lsp.buf.format {:async true}) bufopts))))

(let [lsp (require :lspconfig)]
  (each [_ server (ipairs [:clangd :tsserver :dartls])]
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
