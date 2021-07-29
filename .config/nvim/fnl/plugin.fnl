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
            ; (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name))))))))

(use
  ;; required
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}

  ;; dependencies
  :kyazdani42/nvim-web-devicons {}

  ;; colorscheme
  :andreypopp/vim-colors-plain {:config (vim.cmd "colorscheme plain")}

  ;; utils
  :Olical/conjure {}

  ;; cosmetic
  :akinsho/nvim-bufferline.lua {:as :bufferline
                                :config (req :bufferline)
                                :requires [:moll/vim-bbye]}

  :hoob3rt/lualine.nvim {:as :statusline
                         :config (req :statusline)}

  ;; navigation
  :nvim-telescope/telescope.nvim {:config (req :telescope)
                                  :requires [:nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]}

  ;; tpope
  :tpope/vim-commentary {}
  :tpope/vim-surround {}
  :tpope/vim-repeat {}
  :tpope/vim-fugitive {})
