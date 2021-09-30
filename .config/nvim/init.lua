local fn, cmd, opt, g, api = vim.fn, vim.cmd, vim.opt, vim.g, vim.api

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require "paq" {
  -- dependencies
  { "savq/paq-nvim" };
  { "kyazdani42/nvim-web-devicons" };

  -- 💄 cosmetic
  { "mcchrish/zenbones.nvim" };
  { "karb94/neoscroll.nvim" };

  -- 🗺 navigation
  { "kyazdani42/nvim-tree.lua" };
  { "akinsho/nvim-bufferline.lua" };
  { "junegunn/fzf", run = vim.fn["fzf#install"] };
  { "junegunn/fzf.vim" };

  -- 🔠 language tools
  { "neovim/nvim-lspconfig" };
  { "nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = function() vim.cmd "TSUpdate" end };
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = "0.5-compat" };
  { "hrsh7th/cmp-nvim-lsp" };
  { "hrsh7th/nvim-cmp" };

  -- 🧰 utils
  { "cohama/lexima.vim" };
  { "tpope/vim-commentary" };
  { "tpope/vim-surround" };
  { "tpope/vim-repeat" };
  { "tpope/vim-fugitive" };
}

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⚙ Settings
-- ░▒▓▓▓▓▓▓▓▓▓▒░

cmd "colorscheme zenflesh"
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

-- end config

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  ⌨️ mappings
-- ░▒▓▓▓▓▓▓▓▓▓▒░

local map = api.nvim_set_keymap
local opts = { noremap = true, silent = true }

g.mapleader = " "
g.maplocalleader = "\\"

map('n', "<Space>", "", {})

map('n', "<leader>,", ":e ~/.config/nvim/init.lua<cr>", opts)
map('n', "<leader>p", ":lua vim.lsp.buf.formatting()<cr>", opts) 
map('n', "<leader>l", ":noh<cr>", opts)

-- emacs in command
map('c', "<C-A>", "<Home>", opts)
map('c', "<C-F>", "<Right>", opts)
map('c', "<C-B>", "<Left>", opts)

-- fzf
map('n', "<C-p>", ":Files<CR>", opts)
map('n', "<C-f>", ":Rg<CR>", opts)

-- tree
map('n', "<C-n>", ":NvimTreeToggle<CR>", opts)
map('n', "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- bufferline
map('n', "<A-.>", ":BufferLineCycleNext<CR>", opts)
map('n', "<A-,>", ":BufferLineCyclePrev<CR>", opts)
map('n', "<leader>c", ":bdelete<CR>", opts)

-- ░▒▓▓▓▓▓▓▓▓▓▒░
--  🔌 Plugins
-- ░▒▓▓▓▓▓▓▓▓▓▒░

require "neoscroll".setup { easing_function = "quadratic" }

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

g.nvim_tree_gitignore = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 1
require "nvim-tree".setup {}

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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { ["]m"] = "@function.outer" },
      goto_next_end = { ["]M"] = "@function.outer" },
      goto_previous_start = { ["[m"] = "@function.outer" },
      goto_previous_end = { ["[M"] = "@function.outer" },
    }
  }
}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
      local indent = string.match(line_text, '^%s*')
      local replace = vim.split(args.body, '\n', true)
      local surround = string.match(line_text, '%S.*') or ''
      local surround_end = surround:sub(col)

      replace[1] = surround:sub(0, col - 1)..replace[1]
      replace[#replace] = replace[#replace]..(#surround_end > 1 and ' ' or '')..surround_end
      if indent ~= '' then
        for i, line in ipairs(replace) do
          replace[i] = indent..line
        end
      end

      vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
  }
})

local nvim_lsp = require('lspconfig')

local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

for _, lsp in ipairs({"tsserver", "solargraph", "metals", "pyright"}) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

