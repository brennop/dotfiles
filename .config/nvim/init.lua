-- Aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local o = vim.o
local wo = vim.wo
local bo = vim.bo

local execute = vim.api.nvim_command
local map = vim.api.nvim_set_keymap

-- Bootstrap packer if cloning dotfiles
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end
-- end bootstrap

-- Plugins
cmd [[packadd packer.nvim]]
cmd 'autocmd BufWritePost plugins.lua PackerCompile'

require('packer').startup(function()
  -- Packer can manage itself
  use {"wbthomason/packer.nvim", opt = true}

  -- navigation 🧭
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use 'romgrk/barbar.nvim'

  -- git
  use 'TimUntersberger/neogit'

  -- utils 🧰
  use 'windwp/nvim-autopairs'
  use 'nacro90/numb.nvim'

  -- language tools 🔠
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'kosayoda/nvim-lightbulb' 

  -- colors 🎨
  use 'norcalli/nvim-colorizer.lua'
  use { 'Th3Whit3Wolf/onebuddy', requires =  'tjdevries/colorbuddy.vim' }
  use 'folke/tokyonight.nvim'

  -- misc
  use 'andweeb/presence.nvim'
  use 'karb94/neoscroll.nvim'
  use 'hoob3rt/lualine.nvim'

  -- vimscript 🙄
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
end)
-- end plugins

cmd "syntax enable"
cmd "syntax on"

-- setup plugins
o.termguicolors = true

g.nvim_tree_gitignore = 1

require 'colorizer'.setup {}
require 'neoscroll'.setup {}
require 'numb'.setup {}
require 'neogit'.setup {}
require 'colorbuddy'.colorscheme('onebuddy')
require 'which-key'.setup {}

require 'lualine'.setup {
  options = {
    theme = 'onedark',
    section_separators = '', 
    component_separators = ''
  }
}

require 'nvim-autopairs'.setup {
  check_ts = true
} 

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>qf', '<cmd>lua require\'telescope.builtin\'.lsp_code_actions()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>p", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>p", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=ColorYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=ColorYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=ColorYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end


local servers = { "tsserver", "clangd", "solargraph", "rust_analyzer", "vuels", "svelte", "pyright" }
for _, server in ipairs(servers) do
  nvim_lsp[server].setup { on_attach = on_attach }
end

o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- end setup plugins

-- options

bo.shiftwidth = 2           -- Size of an indent
o.shiftwidth = 2            -- Size of an indent
bo.tabstop = 2              -- Number of spaces tabs count for
o.tabstop = 2               -- Number of spaces tabs count for
bo.expandtab = true         -- Use spaces instead of tabs
o.expandtab = true          -- Use spaces instead of tabs
bo.smartindent = true       -- Insert indents automatically
o.smartindent = true        -- Insert indents automatically
wo.signcolumn = 'yes'

o.hidden = true             -- Enable modified buffers in background
wo.number = true            -- show line numbers
wo.wrap = false             -- turn off wrapping 
o.showmode = false          -- let status plugin handle mode
bo.swapfile = false         -- playing on hard mode
o.swapfile = false          -- playing on hard mode

o.ignorecase = true         -- Ignore case
o.smartcase = true          -- Don't ignore case with capitals
o.laststatus = 2
o.hlsearch = true
o.incsearch = true          -- live search
o.inccommand = 'split'      -- live substitution

o.joinspaces = false        -- No double spaces with join after a dot
o.scrolloff = 4             -- Lines of context
o.shiftround = true         -- Round indent
o.sidescrolloff = 8         -- Columns of context

o.splitbelow = true         -- Put new windows below current
o.splitright = true         -- Put new windows right of current

-- LSP Sign Column
vim.fn.sign_define("LspDiagnosticsSignError", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "" })

-- highlights
-- cmd "hi SignColumn guibg=NONE"

o.clipboard = 'unnamedplus'
o.mouse = 'a'
-- end options

-- mappings
map('n', '<Space>', '', {})
g.mapleader = ' '

local options = { noremap = true, silent = true }
map('n', '<C-n>', ':NvimTreeToggle<CR>', options)

-- telescope
map('n', '<C-p>', ':Telescope find_files<CR>', options)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', options)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', options)

-- barbar
map('n', '<C-s>', ':BufferPick<CR>',          options) -- magic buffer selection
map('n', '<A-,>', ':BufferPrevious<CR>',      options) -- previous
map('n', '<A-.>', ':BufferNext<CR>',          options) -- next
map('n', '<A-<>', ':BufferMovePrevious<CR>',  options) -- reoder
map('n', '<A->>', ':BufferMoveNext<CR>',      options) -- reoder
map('n', '<A-1>', ':BufferGoto 1<CR>',        options)
map('n', '<A-2>', ':BufferGoto 2<CR>',        options)
map('n', '<A-3>', ':BufferGoto 3<CR>',        options)
map('n', '<A-4>', ':BufferGoto 4<CR>',        options)
map('n', '<A-5>', ':BufferGoto 5<CR>',        options)
map('n', '<A-6>', ':BufferGoto 6<CR>',        options)
map('n', '<A-7>', ':BufferGoto 7<CR>',        options)
map('n', '<A-8>', ':BufferGoto 8<CR>',        options)
map('n', '<A-9>', ':BufferLast<CR>',          options)
map('n', '<A-c>', ':BufferClose<CR>',         options) -- close buffer


local compe_options = { noremap = true, silent = true, expr = true }
map('i', '<C-Space>', 'compe#complete()', compe_options)
map('i', '<CR>', "compe#confirm('<CR>')", compe_options)

-- end mappings

