local M = { 'folke/which-key.nvim' }

M.event = 'VimEnter'
M.config = function()
  require("which-key").setup()
  require("which-key").add {
    { '<leader>h', group = 'Git [H]unk', mode = {'n', 'v'}},
  }
  end

return M
