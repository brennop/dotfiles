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
  { "stefanvanburen/rams.vim" },
  { "karb94/neoscroll.nvim" },

  -- 🗺 navigation
  { "junegunn/fzf", run = vim.fn["fzf#install"] },
  { "junegunn/fzf.vim" },
  { "akinsho/nvim-bufferline.lua" },
  { "moll/vim-bbye" },
  { "numToStr/Navigator.nvim" },
  { "kyazdani42/nvim-tree.lua" },

  -- 🔠 language tools
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = function() vim.cmd("TSUpdate") end },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "p00f/nvim-ts-rainbow" },

  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/vim-vsnip' },

  -- 🧰 utils
  { "windwp/nvim-autopairs" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-commentary" },
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
opt.number = false

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
opt.incsearch = true          -- live search
opt.inccommand = "split"      -- live substitution

opt.joinspaces = false        -- No double spaces with join after a dot
opt.shiftround = true         -- Round indent
opt.scrolloff = 8             -- Lines of context

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { c = true } -- remove info de completion

opt.foldlevelstart = 99

opt.spelllang = "pt_br,en_us"
cmd "autocmd BufRead,BufNewFile *.md setlocal spell"
cmd "autocmd FileType gitcommit setlocal spell"

opt.background = "dark"
cmd "colorscheme rams"

-- end config

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  🔌 Plugins
-- ░▒▓▓▓▓▓▓▓▓▓▒░

require "neoscroll".setup { easing_function = "quadratic" }
require "Navigator".setup {}

g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 1
require'nvim-tree'.setup {}

require "bufferline".setup {
  options = {
    offsets = {{ filetype = "NvimTree" }},
    show_buffer_icons = false,
    show_close_icon = false,
    show_buffer_close_icons = false,
    indicator_icon = " ",
    separator_style = { "", "" }
  }
}

-- fzf
g.fzf_layout = {
  window = {
    width = 1,
    height = 0.6,
    relative = true,
    yoffset = 1.0,
    border = 'sharp'
  } 
}

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
  rainbow = {
    enable = true,
    disable = vim.tbl_filter(function(p) 
      return p ~= "clojure" and p ~= "commonlisp" and p ~= "fennel" and p ~= "query"
    end, parsers.available_parsers()),
    colors = {
      "#f2777a",
      "#f99157",
      "#ffcc66",
      "#99cc99",
      "#66cccc",
      "#6699cc",
      "#cc99cc",
    }
  },
}

require "nvim-autopairs".setup {
  check_ts = true,
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
}

local null_ls = require "null-ls"

null_ls.config({
  sources = { 
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint_d,
  }
})

--
-- completion
--

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  })
})

-- lsp

local nvim_lsp = require "lspconfig"

local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- let prettier format
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs { "tsserver", "solargraph", "metals", "pyright", "null-ls", "rust_analyzer", "tailwindcss" } do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = capabilities,
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

-- bufferline
map('n', "<A-.>", ":BufferLineCycleNext<CR>", opts)
map('n', "<A-,>", ":BufferLineCyclePrev<CR>", opts)
map('n', "<A-q>", ":Bdelete<CR>", opts)
map('n', "<tab>", "<C-^>", opts)

-- Navigator (tmux)
map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)
