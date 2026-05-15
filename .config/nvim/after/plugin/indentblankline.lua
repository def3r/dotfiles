local opts = {
  indent = { highlight = { 'LineNr' } },
  scope = { enabled = true, highlight = { 'QuickFixLine' } },
}

require('ibl').setup(opts)
-- vim.cmd.IBLDisable() -- Lets give it a try

vim.keymap.set('n', 'me', vim.cmd.IBLEnable, { desc = 'Indent Blank Line Enable' })
vim.keymap.set('n', 'md', vim.cmd.IBLDisable, { desc = 'Indent Blank Line Disable' })

vim.keymap.set('n', 'mr', function()
  if vim.g.rainbow_delimiters ~= nil then
    vim.g.rainbow_delimiters = nil
    require('ibl').setup(opts)
    return
  end

  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
  }

  local hooks = require 'ibl.hooks'
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }
  require('ibl').setup { indent = { highlight = highlight } }
end, { desc = 'Indent Blank Line toggle Rainbow highlight' })
