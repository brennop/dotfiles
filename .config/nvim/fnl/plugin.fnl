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

(use
  ;; required
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}

  ;; dependencies
  :kyazdani42/nvim-web-devicons {}
  :moll/vim-bbye {}
  :nvim-lua/popup.nvim {}
  :nvim-lua/plenary.nvim {}

  ;; colorscheme
  :andreypopp/vim-colors-plain {:config (vim.cmd "colorscheme plain")}

  ;; utils
  :Olical/conjure {}

  ;; cosmetic
  :akinsho/nvim-bufferline.lua {:config (req :bufferline)}

  ;; navigation
  :nvim-telescope/telescope.nvim {:config (req :telescope)}
  :kyazdani42/nvim-tree.lua {:config (req :tree)}

  ;; language tools
  :neovim/nvim-lspconfig {:config (req :lsp)}
  :nvim-treesitter/nvim-treesitter {:run ::TSUpdate}
  :hrsh7th/nvim-compe {}

  ;; tpope
  :tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-fugitive {})
