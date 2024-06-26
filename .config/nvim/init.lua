local cmd, opt, g, api, keymap = vim.cmd, vim.opt, vim.g, vim.api, vim.keymap

local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
  "savq/paq-nvim",
  "mcchrish/zenbones.nvim",
  'echasnovski/mini.nvim',
  "junegunn/fzf.vim", 
  "junegunn/fzf",
  "neovim/nvim-lspconfig",
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-tree.lua",
  'nvim-tree/nvim-web-devicons',
  "tpope/vim-repeat",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
}

opt.shiftwidth = 2            -- Size of an indent
opt.tabstop = 2               -- Number of spaces tabs count for
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically
opt.signcolumn = "no"         -- no sign column
opt.laststatus = 3            -- statusline (2 = show, 0 = hidden)
opt.cmdheight = 0
opt.swapfile = false          -- playing on hard mode
opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals
opt.scrolloff = 10             -- Lines of context
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { c = true }
opt.number = true
opt.termguicolors = true
g.zenbones_compat = 1
cmd.colorscheme "zenbones"

require "nvim-tree".setup {}

require "nvim-treesitter.configs".setup {
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
}

keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

local function on_attach(client, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)

  vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
end

for _, lsp in ipairs { "tsserver", "solargraph", "emmet_language_server" } 
  do require "lspconfig" [lsp].setup { on_attach = on_attach, } end

require "lspconfig".clangd.setup {
 on_attach = on_attach,
 cmd = { "clangd", "--offset-encoding=utf-16" },
}

g.mapleader = " "

keymap.set("n", "<leader>,", ":e ~/.config/nvim/init.lua<cr>")
keymap.set("n", "<leader>r", ":make<cr>")
keymap.set("n", "<C-p>", ":GFiles --cached --others --exclude-standard<cr>")
keymap.set("n", "<C-f>", ":Rg<cr>")
keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<cr>")
