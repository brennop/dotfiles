local fn, cmd, opt, g, api = vim.fn, vim.cmd, vim.opt, vim.g, vim.api
local map = api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
  -- dependencies
  { "savq/paq-nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },

  -- 💄 cosmetic
  { "rebelot/kanagawa.nvim" },
  { "karb94/neoscroll.nvim" },
  { "Pocco81/true-zen.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },

  -- 🗺  navigatin
  { "numToStr/Navigator.nvim" },
  { "kyazdani42/nvim-tree.lua" },
  { "nvim-telescope/telescope.nvim" },

  -- 🔠 language tools
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter" }, -- run TSUpdate

  -- completion
  { "neoclide/coc.nvim", branch = "release" },
  { "fannheyward/telescope-coc.nvim" },
  -- { "github/copilot.vim" },

  -- 🧰 utils
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "echasnovski/mini.nvim" },

  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
}

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⚙  Settings
-- ░▒▓▓▓▓▓▓▓▓▓▒░

cmd "syntax enable"
cmd "syntax on"

opt.termguicolors = true      -- true colors

opt.shiftwidth = 2            -- Size of an indent
opt.tabstop = 2               -- Number of spaces tabs count for
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically
opt.textwidth = 80
opt.number = true

opt.signcolumn = "no"         -- no sign column
opt.laststatus = 3            -- statusline (2 = show, 0 = hidden)
opt.cmdheight = 0             -- no cmdline
opt.showmode = false          -- Insert, Replace or Visual
opt.showcmd = false           -- last key typed
opt.rulerformat = "%=%l,%v"   -- right align, then row, virtual column

opt.hidden = true             -- Enable modified buffers in background
opt.wrap = false              -- turn off wrapping
opt.swapfile = false          -- playing on hard mode

opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals
opt.hlsearch = true
opt.incsearch = true          -- live search

opt.joinspaces = false        -- No double spaces with join after a dot
opt.shiftround = true         -- Round indent
opt.scrolloff = 8             -- Lines of context

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { c = true } -- remove info de completion

cmd [[colorscheme kanagawa]]

-- neovide

opt.guifont = "FiraCode Nerd Font:10"
vim.g.neovide_transparency = 0.98
vim.g.neovide_cursor_animation_length = 0.01

-- end config

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  🔌 Plugins
-- ░▒▓▓▓▓▓▓▓▓▓▒░

require "Navigator".setup {}

require "nvim-tree".setup {
  actions = { open_file = { quit_on_open = true } },
}

require "telescope".setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<esc>"] = require "telescope.actions".close
      },
    },
  },
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("coc")

require "nvim-treesitter.configs".setup {
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = ".",
      node_decremental = ","
    }
  },
}

require "mini.bufremove".setup {}
require "mini.pairs".setup {}
require "mini.tabline".setup {}

require "indent_blankline".setup {}
require "neoscroll".setup { easing_function = "cubic" }

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⌨️  mappings
-- ░▒▓▓▓▓▓▓▓▓▓▒░

g.mapleader = " "
g.maplocalleader = "\\"

map('n', "<Space>", "", {})

map('n', "H", "^", opts)
map('n', "L", "$", opts)

map('n', "Q", "@i", opts)
map('v', "Q", ":norm @i<cr>", opts)

map('n', "<leader>m", ":make<cr>", opts)

map('n', "<leader>,", ":e ~/.config/nvim/init.lua<cr>", opts)
map('n', "<leader>l", ":noh<cr>", opts)

map('n', "<C-n>", ":NvimTreeToggle<cr>", opts)
map('n', "<C-p>", ":Telescope find_files<cr>", opts)
map('n', "<C-f>", ":Telescope live_grep<cr>", opts)
map('n', "<leader>p", ":Telescope command_history<cr>", opts)

-- tabline
map('n', "<A-,>", ":bprev<CR>", opts)
map('n', "<A-.>", ":bnext<CR>", opts)
map('n', "<A-q>", ":lua MiniBufremove.delete()<CR>", opts)

-- Navigator (tmux)
map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

vim.cmd "source ~/.config/nvim/coc.vim"

