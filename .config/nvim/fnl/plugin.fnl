(module plugin
  {autoload {a aniseed.core
             packer packer}})

(defn- req [name]
  (let [(ok? val-or-err) (pcall require (.. "plugin." name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(defn- use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            ; (-?> (. opts :mod) (req))
            (use (a.assoc opts 1 name))))))))

(defn- setup [name config]
  (let [(ok? plugin) (pcall require name)] 
    (when ok?
      (plugin.setup config))))

(use
  ;; required
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}

  ;; dependencies
  :kyazdani42/nvim-web-devicons {}
  :nvim-lua/plenary.nvim {}
  :nvim-lua/popup.nvim {}
  :moll/vim-bbye {}

  ;; colorscheme
  :andreypopp/vim-colors-plain {:config (vim.cmd "colorscheme plain")}
  :folke/lsp-colors.nvim {}

  ;; utils
  :Olical/conjure {}
  :nacro90/numb.nvim {:config (setup :numb {})}

  ;; cosmetic
  :akinsho/nvim-bufferline.lua {:config (req :bufferline)}
  :karb94/neoscroll.nvim {:config (setup :neoscroll {:easing_function "quadratic"})}
  :sunjon/shade.nvim {:config (setup :shade {})}

  ;; navigation
  :nvim-telescope/telescope.nvim {:config (req :telescope)}
  :kyazdani42/nvim-tree.lua {:config (req :tree)}

  ;; language tools
  :neovim/nvim-lspconfig {:config (req :lsp)}
  :hrsh7th/nvim-compe {:config (req :completion)}

  ;; 🌲 tree-sitter
  :nvim-treesitter/nvim-treesitter {:config (req :treesitter) 
                                    :branch "0.5-compat"
                                    :run ":TSUpdate"}
  :nvim-treesitter/nvim-treesitter-textobjects {:branch "0.5-compat"}
  :p00f/nvim-ts-rainbow {}

  ;; snippets
  :rafamadriz/friendly-snippets {}
  :hrsh7th/vim-vsnip {}
  :hrsh7th/vim-vsnip-integ {}

  ;; markdown
  :vimwiki/vimwiki {}
  :folke/zen-mode.nvim {}
  :npxbr/glow.nvim {}

  ;; tpope
  :tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-fugitive {})
