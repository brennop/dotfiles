local cmd, opt, g, api, keymap = vim.cmd, vim.opt, vim.g, vim.api, vim.keymap

g.mapleader = " "
keymap.set("n", "<leader>,", ":e ~/.config/nvim/init.lua<cr>")

local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
if not is_installed then
  vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
  return true
end

require "paq" {
  { "savq/paq-nvim" },
  { "nvim-lua/plenary.nvim" },
  { "rktjmp/lush.nvim" },
  { "zenbones-theme/zenbones.nvim" },
  { "rebelot/kanagawa.nvim"},
  { "junegunn/fzf.vim" }, 
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", branch = 'main', build = ':TSUpdate' },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-telescope/telescope.nvim" },
  { "HiPhish/rainbow-delimiters.nvim" },
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
opt.number = false
opt.termguicolors = true
opt.background = 'light'
cmd.colorscheme "zenbones"

-- Tomorrow Night colors
local colors = {
  red    = "#b36f84", -- oklch(50.5% 0.213 27.518)
  orange = "#b17652", -- oklch(47% 0.157 37.304)
  yellow = "#908844", -- oklch(47.6% 0.114 61.907)
  green  = "#58966d", -- oklch(44.8% 0.119 151.328)
  cyan   = "#3496a0", -- oklch(52% 0.105 223.128)
  blue   = "#6388bc", -- oklch(48.8% 0.243 264.376)
  purple = "#9677b0", -- oklch(49.6% 0.265 301.924)
}

-- Define rainbow delimiter highlight groups
vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = colors.red })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.orange })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = colors.green })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = colors.cyan })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = colors.blue })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.purple })

vim.g.rainbow_delimiters = {
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterOrange",
    "RainbowDelimiterYellow",
    "RainbowDelimiterGreen",
    "RainbowDelimiterCyan",
    "RainbowDelimiterBlue",
    "RainbowDelimiterViolet",
  },
}

require "nvim-tree".setup {}
require "nvim-treesitter".setup {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'fennel', 'lua', 'html', 'javascript', 'typescriptreact', 'bash', 'ruby' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tsv",
  callback = function()
    vim.opt_local.tabstop = 16
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
})

keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

local function on_attach(client, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)

  vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})'

  vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
end

for _, lsp in ipairs {  "solargraph", "emmet_language_server", "ts_ls", "vue_ls", "gopls" } do 
  vim.lsp.enable(lsp, { on_attach = on_attach, })
end

keymap.set("n", "<C-p>", ":GFiles --cached --others --exclude-standard<cr>")
keymap.set("n", "<C-f>", ":Rg<cr>")
keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<cr>")

keymap.set("n", "<A-q>", function() require "mini.bufremove".delete() end, {})
keymap.set("n", "<A-.>", ":bnext<cr>", {})
keymap.set("n", "<A-,>", ":bprev<cr>", {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.oldfiles, {})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
