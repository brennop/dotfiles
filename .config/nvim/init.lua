local cmd, opt, g, api, keymap = vim.cmd, vim.opt, vim.g, vim.api, vim.keymap

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", 
    "--branch=stable", lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require "lazy".setup {
  { "rebelot/kanagawa.nvim", config = function() cmd.colorscheme "kanagawa" end},
  { "kyazdani42/nvim-web-devicons", },
  { "junegunn/fzf.vim", dependencies = { "junegunn/fzf", },
    keys = {
      { "<C-p>", ":GFiles --cached --others --exclude-standard<cr>", },
      { "<C-f>", ":Rg<cr>", },
    },
  },
  { "nvim-tree/nvim-tree.lua",
    config = true,
    keys = {
      { "<C-n>", ":NvimTreeToggle<cr>" },
    },
  },
  { "neovim/nvim-lspconfig", },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      ident = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = ".",
          node_decremental = ","
        }
      },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  { "github/copilot.vim", },
  { "tpope/vim-fugitive", },
  { "tpope/vim-repeat", },
  { "tpope/vim-commentary", },
  { "tpope/vim-surround", },
}

opt.shiftwidth = 2            -- Size of an indent
opt.tabstop = 2               -- Number of spaces tabs count for
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically
opt.textwidth = 80
opt.number = true
opt.signcolumn = "no"         -- no sign column
opt.laststatus = 3            -- statusline (2 = show, 0 = hidden)
opt.cmdheight = 0
opt.wrap = false              -- turn off wrapping
opt.swapfile = false          -- playing on hard mode
opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals
opt.scrolloff = 8             -- Lines of context
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { c = true }

local opts = { noremap=true, silent=true }
keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
local function on_attach(client, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  local function map(lhs, api) keymap.set("n", lhs, vim.lsp.buf[api], opts) end
  vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  map("K", "hover")
  map("gd", "definition")
  map("gr", "references")
  map("<space>rn", "rename")
  map("<space>ca", "code_action")
  map("<space>D", "type_definition")
  map("<C-k>", "signature_help")
  keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)
end

local lspconfig = require "lspconfig"
for _, lsp in ipairs {
   "tsserver", "tailwindcss", "hls", "dartls", "pyright",
} do lspconfig[lsp].setup { on_attach = on_attach, } end

-- fix for clang offset-encoding
lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = { "clangd", "--offset-encoding=utf-16" },
}

keymap.set("n", "<leader>,", ":e ~/.config/nvim/init.lua<cr>")
keymap.set("n", "<leader>r", ":make<cr>")
