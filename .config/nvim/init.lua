local hotpot_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
  vim.fn.system({'git', 'clone',
                 'https://github.com/rktjmp/hotpot.nvim', hotpot_path})
  vim.cmd("helptags " .. hotpot_path .. "/doc")
end

-- Enable fnl/ support
require "hotpot"

-- load fnl/config.fnl
require "config"
