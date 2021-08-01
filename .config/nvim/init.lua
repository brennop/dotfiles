local execute = vim.api.nvim_command
local fn = vim.fn

local start_path = fn.stdpath('data') .. '/site/pack/packer/start/'

-- install basic plugins if not already
function bootstrap(plugin)
  local plugin_name = vim.split(plugin, '/')[2]
  local install_path = start_path .. plugin_name

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/' .. plugin, install_path })
    execute ('packadd ' .. plugin_name)
  end
end

-- plugin manager
bootstrap("wbthomason/packer.nvim")

-- fennel config loader
bootstrap("Olical/aniseed")

-- load fnl/init.fnl
vim.g["aniseed#env"] = true

-- cadê todo mundo? ლ(ಠ_ಠლ) - você
-- na pasta fnl/ o((*^▽^*))o
