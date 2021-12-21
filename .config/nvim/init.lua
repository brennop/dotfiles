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

  { "echasnovski/mini.nvim" },

  -- 💄 cosmetic
  { "catppuccin/nvim" },
  { "karb94/neoscroll.nvim" },

  -- 🗺 navigation
  { "junegunn/fzf", run = vim.fn["fzf#install"] },
  { "junegunn/fzf.vim" },
  { "numToStr/Navigator.nvim" },
  { "kyazdani42/nvim-tree.lua" },

  -- 🔠 language tools
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", run = function() vim.cmd 'TSUpdate' end },

  -- 🧰 utils
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
}

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⚙ Settings
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
opt.laststatus = 0            -- statusline (2 = show, 0 = hidden)
opt.showmode = false          -- Insert, Replace or Visual
opt.showcmd = false           -- last key typed
opt.rulerformat = "%=%l,%v"   -- right align, then row, virtual column

opt.hidden = true             -- Enable modified buffers in background
opt.wrap = false              -- turn off wrapping
opt.swapfile = false          -- playing on hard mode

opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals
opt.hlsearch = true
-- opt.incsearch = true          -- live search
-- opt.inccommand = "split"      -- live substitution

opt.joinspaces = false        -- No double spaces with join after a dot
opt.shiftround = true         -- Round indent
opt.scrolloff = 8             -- Lines of context

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { c = true } -- remove info de completion

opt.background = "dark"
cmd "colorscheme catppuccin"

-- end config

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  🔌 Plugins
-- ░▒▓▓▓▓▓▓▓▓▓▒░

require "neoscroll".setup { easing_function = "quadratic" }
require "Navigator".setup {}

g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 1
require'nvim-tree'.setup {}

local parsers = require("nvim-treesitter.parsers")

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

-- mini

require "mini.bufremove".setup {}
require "mini.completion".setup {}
require "mini.pairs".setup {}
require "mini.tabline".setup {}
require "mini.comment".setup()

require "mini.statusline".setup {
  content = {
    active = function() 
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 80 })
      local git           = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 140 })
      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { location } },
      })
    end
  }
}

-- lsp

local nvim_lsp = require "lspconfig"

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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

for _, lsp in ipairs { 
  "tsserver",
  "solargraph",
  "metals",
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "clangd"
} do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  }
end

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⌨️ mappings
-- ░▒▓▓▓▓▓▓▓▓▓▒░

g.mapleader = " "
g.maplocalleader = "\\"

map('n', "<Space>", "", {})

-- beginning and end
map('n', "H", "^", opts)
map('n', "L", "$", opts)

-- macros
map('n', "Q", "@i", opts)
map('v', "Q", ":norm @i<cr>", opts)

-- make/compile
map('n', "<leader>r", ":make<cr>", opts)

map('n', "<leader>,", ":e ~/.config/nvim/init.lua<cr>", opts)
map('n', "<leader>l", ":noh<cr>", opts)

map('n', "<C-n>", ":NvimTreeToggle<cr>", opts)
map('n', "<leader>n", ":NvimTreeFindFile<cr>", opts)

-- fzf
map('n', "<C-p>", ":Files<CR>", opts)
map('n', "<C-f>", ":Rg<CR>", { silent = true })
map('n', "<C-b>", ":Buffers<CR>", { silent = true })

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
