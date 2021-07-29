-- Aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local opt = vim.opt

local execute = vim.api.nvim_command
local map = vim.api.nvim_set_keymap

local options = { noremap = true, silent = true }

map('n', '<Space>', '', {})
g.mapleader = ' '

-- edit configs
map('n', '<leader>,', ':e ~/.config/nvim/init.lua<CR>', options)

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

require('packer').startup(function(use)
  -- Packer can manage itself
  use { "wbthomason/packer.nvim", opt = true }

  -- navigation 🧭
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  -- use 'romgrk/barbar.nvim'

  -- utils 🧰
  use 'nacro90/numb.nvim'
  use 'windwp/nvim-autopairs'
  use 'RRethy/nvim-treesitter-textsubjects'
  -- use 'sunjon/shade.nvim'
  use 'windwp/nvim-ts-autotag'
  use 'hoob3rt/lualine.nvim'

  -- language tools 🔠
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'

  -- colors 🎨
  use 'norcalli/nvim-colorizer.lua'
  use 'arcticicestudio/nord-vim'

  -- misc
  use 'Pocco81/TrueZen.nvim'
  use 'karb94/neoscroll.nvim'

  -- wiki/md
  use 'vimwiki/vimwiki'
  use 'folke/zen-mode.nvim'
  use 'npxbr/glow.nvim'

  -- tpope 🙏 
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'

end)
-- end plugins

cmd "syntax enable"
cmd "syntax on"

-- setup plugins
opt.termguicolors = true

g.nvim_tree_gitignore = 1
g.nvim_tree_tab_open = 1
g.nvim_tree_quit_on_open = 1

require 'numb'.setup {}
require 'nvim-autopairs'.setup {}
require 'colorizer'.setup {}
-- require 'shade'.setup {}

require 'zen-mode'.setup {
  window = {
    width = 80
  },
}

local bg = "#2e3440"
local bg2 = "#3b4252"
local bg3 = "#282c34"
local fg = "#CACed6"
local accent = "#81a1c1"

require("bufferline").setup{
  options = {
    offsets = {{ filetype = "NvimTree" }},
    show_close_icon = false,
    show_buffer_close_icons = false,
    separator_style = { '', '' },
  },
}

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {'NvimTree'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

local actions = require('telescope.actions')
require 'telescope'.setup {
  defaults = {
    mappings = {
      i = {
          ["<esc>"] = actions.close,
        }
      }
    }
}

require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
  autotag = { enable = true },
  textsubjects = {
    enable = true,
    keymaps = {
        ['.'] = 'textsubjects-smart',
        [';'] = 'textsubjects-big',
    }
  },
}

require 'neoscroll'.setup {
  easing_function = 'quadratic',
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

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

local servers = { "tsserver", "clangd", "solargraph", "rust_analyzer", "vuels", "svelte", "pyright", "hls" }

for _, server in ipairs(servers) do
  nvim_lsp[server].setup { on_attach = on_attach }
end

-- lua lsp
local sumneko_root_path = '/home/brn/clone/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "./main.lua"},
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    }
  }
}

-- efm
local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { '%f:%l:%c: %m' },
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true,
}

nvim_lsp.efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
  end,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      css = { prettier },
      html = { prettier },
      javascript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      json = { prettier },
      markdown = { prettier },
      scss = { prettier },
      typescript = { prettier, eslint },
      typescriptreact = { prettier, eslint },
      yaml = { prettier },
    }
  },
}


opt.completeopt = "menuone,noselect"

require 'compe'.setup {
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
    spell = true;
    nvim_lsp = true;
    nvim_lua = true;
    omni = true;
  };
}

-- vimwiki
g.vimwiki_list = {{
  path = '~/notes/unb',
  syntax = 'markdown',
  ext = '.md'
}}
g.vimwiki_create_link = 0

require 'true-zen'.setup {
	modes = {
		ataraxis = {
			ideal_writing_area_width = {0},
    }
  }
}

-- end setup plugins

-- options

opt.shiftwidth = 2            -- Size of an indent
opt.tabstop = 2               -- Number of spaces tabs count for
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true        -- Insert indents automatically
opt.signcolumn = 'no'

opt.hidden = true             -- Enable modified buffers in background
opt.wrap = false             -- turn off wrapping
opt.swapfile = false         -- playing on hard mode

opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals
opt.laststatus = 2
opt.hlsearch = true
opt.incsearch = true          -- live search
opt.inccommand = 'split'      -- live substitution

opt.joinspaces = false        -- No double spaces with join after a dot
opt.scrolloff = 8             -- Lines of context
opt.shiftround = true         -- Round indent
opt.sidescrolloff = 8         -- Columns of context

opt.showmode = false          -- hide Insert, Replace or Visual (lualine)
opt.textwidth = 80

-- LSP Sign Column
vim.fn.sign_define("LspDiagnosticsSignError", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "" })

opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
-- end options

-- colors
g.nord_italic = 1
g.nord_italic_comments = 1
g.nord_underline = 1
cmd "colorscheme nord"
--

-- mappings
map('n', '<C-n>', ':NvimTreeToggle<CR>', options)

map('n', '<leader>n', ':nohlsearch<CR>', options)

-- try to format
map('n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)

-- telescope
map('n', '<C-p>', ':Telescope find_files<CR>', options)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', options)
map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', options)
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>', options)
map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>', options)

-- barbar
map('n', '<C-s>', ':BufferPick<CR>',          options) -- magic buffer selection
map('n', '<A-,>', ':BufferLineCyclePrev<CR>',      options) -- previous
map('n', '<A-.>', ':BufferLineCycleNext<CR>',          options) -- next
map('n', '<A-c>', ':BufferClose<CR>',         options) -- close buffer

-- tree

local compe_options = { noremap = true, silent = true, expr = true }
map('i', '<C-Space>', 'compe#complete()', compe_options)
map('i', '<CR>', "compe#confirm('<CR>')", compe_options)

-- end mappings

-- spell
opt.spelllang = 'pt_br'
cmd [[autocmd BufRead,BufNewFile *.md setlocal spell]]
cmd [[autocmd FileType gitcommit setlocal spell]]
--

