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
            (-?> (. opts :mod) (req))
            (use (a.assoc opts 1 name))))))))

(defn- setup [name config]
  (let [(ok? plugin) (pcall require name)] 
    (when ok?
      (plugin.setup (or config {})))))

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
  :nacro90/numb.nvim {:config (setup :numb)}
  :Raimondi/delimitMate {}

  ;; cosmetic
  :karb94/neoscroll.nvim {:config (setup :neoscroll {:easing_function "quadratic"})}

  ;; navigation
  :nvim-telescope/telescope.nvim {:mod :telescope}
  :kyazdani42/nvim-tree.lua {:config (req :tree)}
  :akinsho/nvim-bufferline.lua {:mod :bufferline}

  ;; language tools
  :neovim/nvim-lspconfig {:mod :lsp}
  :hrsh7th/nvim-compe {:mod :completion}

  ;; 🌲 tree-sitter
  :nvim-treesitter/nvim-treesitter {:mod :treesitter 
                                    :branch "0.5-compat"
                                    :run ":TSUpdate"}
  :nvim-treesitter/nvim-treesitter-textobjects {:branch "0.5-compat"}
  :p00f/nvim-ts-rainbow {}

  ;; markdown
  :folke/zen-mode.nvim {:config (setup :zen-mode {:window {:width 80}})}

  ;; tpope
  :tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-fugitive {}
  :tpope/vim-unimpaired {})
