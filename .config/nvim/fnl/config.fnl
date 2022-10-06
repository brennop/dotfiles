(local {:opt opt :cmd cmd} vim)

(macro setup [plugin config]
  `((. (require ,plugin) :setup) ,config))

;; packages
((require :paq) [
"savq/paq-nvim"
"rktjmp/hotpot.nvim"

;; cosmetic
"rebelot/kanagawa.nvim"

"nvim-treesitter/nvim-treesitter"
])

;; setings
(fn set-config [config]
  (each [key value (pairs config)]
    (tset opt key value)))

(set-config 
  {:termguicolors true
   :shiftwidth 2
   :tabstop 2
   :expandtab true 
   :smartindent true
   :textwidth 80
   :number true

   :signcolumn :no
   :laststatus 3
   :cmdheight 0
   :hidden true
   :swapfile false

   :ignorecase true
   :smartcase true
   :hlsearch true
   :incsearch true

   :scrolloff 8
   :clipboard :unnamedplus
  })

(cmd "colorscheme kanagawa")

;; plugins
(setup :nvim-treesitter.configs {
       :highlight { :enable true }
       :indent { :enable true }
       })
