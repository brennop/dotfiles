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

  -- 🗺 navigation
  { "numToStr/Navigator.nvim" },
  { "kyazdani42/nvim-tree.lua" },
  { "nvim-telescope/telescope.nvim" },

  -- 🔠 language tools
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter" }, -- run TSUpdate

  { "echasnovski/mini.nvim" },

  -- 🧰 utils
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
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

-- end config

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  🔌 Plugins
-- ░▒▓▓▓▓▓▓▓▓▓▒░

require "neoscroll".setup { easing_function = "quadratic" }
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

require "mini.comment".setup {}
require "mini.completion".setup {}
require "mini.pairs".setup {}
require "mini.surround".setup {}
require "mini.jump".setup {}

-- lsp

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>.', '<cmd>Telescope lsp_code_actions<CR>', opts)
end

for _, lsp in ipairs { 
  "tsserver",
  "pyright",
  "clangd",
  "dartls",
  "tailwindcss",
  "eslint",
} do
  (require "lspconfig")[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = vim.lsp.protocol.make_client_capabilities()
  }
end

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

map('n', "<leader>r", ":make<cr>", opts)

map('n', "<leader>,", ":e ~/.config/nvim/init.lua<cr>", opts)
map('n', "<leader>l", ":noh<cr>", opts)

map('n', "<C-n>", ":NvimTreeToggle<cr>", opts)
map('n', "<C-p>", ":Telescope find_files<cr>", opts)
map('n', "<C-f>", ":Telescope live_grep<cr>", { silent = true })

-- Navigator (tmux)
map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
