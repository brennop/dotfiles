(local {: opt : cmd : keymap : g} vim)
(local opts {:silent true :noremap true})
(local enable true)

(macro setup [plugin config]
  `((. (require ,plugin) :setup) ,config))

(macro set! [key value]
  `(tset opt ,key ,value))

(macro nmap [lhs rhs]
  `(keymap.set :n ,lhs ,rhs opts))

(let [paq (require :paq)]
  (paq [:savq/paq-nvim
        :udayvir-singh/tangerine.nvim
        :nvim-lua/plenary.nvim
        :kyazdani42/nvim-web-devicons
        :rktjmp/lush.nvim
        :mcchrish/zenbones.nvim
        :rebelot/kanagawa.nvim
        :nyoom-engineering/oxocarbon.nvim
        :lukas-reineke/indent-blankline.nvim
        :junegunn/fzf
        :junegunn/fzf.vim
        :numToStr/Navigator.nvim
        :nvim-tree/nvim-tree.lua
        :MunifTanjim/nui.nvim
        :neovim/nvim-lspconfig
        :nvim-treesitter/nvim-treesitter
        :nvim-treesitter/nvim-treesitter-textobjects
        :echasnovski/mini.nvim
        :github/copilot.vim
        :Olical/conjure
        :tpope/vim-fugitive
        :tpope/vim-repeat
        :tpope/vim-commentary
        :tpope/vim-surround]))

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

(set! :background :dark)
(cmd.colorscheme :kanagawa)

(setup :nvim-treesitter.configs
       {:highlight {: enable}
        :indent {: enable}
        :textobjects {:select {: enable}}
        :incremental_selection {: enable
                                :keymaps {:node_incremental "."
                                          :node_decremental ","}}})

(setup :nvim-tree {})
(setup :Navigator {})
(setup :indent_blankline {:char "."})
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
  (each [_ server (ipairs [:clangd :tsserver :dartls :hls :tailwindcss])]
    ((. lsp server :setup) {: on_attach})))

(tset g :mapleader " ")
(tset g :maplocalleader ",")
(keymap.set :n :<Space> "" {})

(nmap "<leader>," ":e ~/.config/nvim/init.fnl<cr>")
(nmap :<leader>l ":noh<cr>")
(nmap :H "^")
(nmap :L "$")
(nmap :<C-n> ":NvimTreeToggle<cr>")
(nmap :<C-p> ":GFiles --cached --others --exclude-standard<cr>")
(nmap :<C-f> ":Rg<cr>")

(keymap.set :n :j :gj)
(keymap.set :n :k :gk)
(keymap.set :n :Q "@i" opts)
(keymap.set :v :Q ":norm @i<cr>" opts)

(let [navigator (require :Navigator)]
  (each [key dir (pairs {:h :left :k :up :l :right :j :down})]
    (keymap.set :n (.. :<A- key ">") (. navigator dir) opts)))
