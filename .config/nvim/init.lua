local cmd, opt, g, api, keymap = vim.cmd, vim.opt, vim.g, vim.api, vim.keymap

local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
if not is_installed then
  vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
  return true
end

require "paq" {
  { "savq/paq-nvim" },
  { "nvim-lua/plenary.nvim" },
  { "mcchrish/zenbones.nvim" },
  { "junegunn/fzf.vim" }, 
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-telescope/telescope.nvim" },
  { "echasnovski/mini.nvim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-rails" },
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
opt.inccommand = "split"      -- Show a live preview of :substitute in split
opt.scrolloff = 10             -- Lines of context
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noinsert,popup,fuzzy"
opt.pumheight = 5
opt.shortmess:append { c = true }
opt.number = true
opt.termguicolors = true
g.zenbones_compat = 1
cmd.colorscheme "zenbones"

if os.getenv "SCHEME" == "'prefer-light'" then opt.background = 'light' end

require "nvim-tree".setup {}
require "mini.tabline".setup {}

require "nvim-treesitter.configs".setup {
  highlight = { enable = true },
  indent = { enable = false },
  incremental_selection = { enable = true },
}

keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

local function on_attach(client, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)

  vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
end

for _, lsp in ipairs { "tsserver", "solargraph", "emmet_language_server", "gopls" } 
  do require "lspconfig" [lsp].setup { on_attach = on_attach, } end

require "lspconfig".clangd.setup {
 on_attach = on_attach,
 cmd = { "clangd", "--offset-encoding=utf-16" },
}

g.mapleader = " "

keymap.set("n", "<leader>,", ":e ~/.config/nvim/init.lua<cr>")
keymap.set("n", "<leader>r", ":Rails<cr>")
keymap.set("n", "<leader>gr", ":.Rails<cr>")
keymap.set("n", "<C-p>", ":GFiles --cached --others --exclude-standard<cr>")
keymap.set("n", "<C-f>", ":Rg<cr>")
keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<cr>")

keymap.set("n", "<A-q>", function() require "mini.bufremove".delete() end, {})
keymap.set("n", "<A-.>", ":bnext<cr>", {})
keymap.set("n", "<A-,>", ":bprev<cr>", {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.oldfiles, {})
