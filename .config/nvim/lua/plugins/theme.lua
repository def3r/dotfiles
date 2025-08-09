local M = { 'hachy/eva01.vim' }

M.lazy = false
M.priority = 1000

M.config = function()
  vim.cmd.colorscheme 'eva01'
  -- or vim.cmd.colorscheme 'eva01-LCL'
end

return M
