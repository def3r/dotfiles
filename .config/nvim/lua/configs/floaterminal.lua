local utils = require 'configs.utils'

local job_id = 0
local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(utils.state.floating.win) then
    vim.api.nvim_win_hide(utils.state.floating.win)
    return
  end

  utils.state.floating = utils.create_floating_window { buf = utils.state.floating.buf }
  if vim.bo[utils.state.floating.buf].buftype ~= 'terminal' then
    job_id = vim.fn.termopen(vim.o.shell, { detach = true })
    vim.cmd 'startinsert'
  end
end

local terminal_git = function(arg)
  vim.fn.chansend(job_id, arg)
end

-- vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

-- Keymap to open the floating terminal
vim.keymap.set('n', '<leader>mt', toggle_terminal, { desc = 'Open Floating Terminal' })
vim.keymap.set({ 'n', 't' }, '<M-g>', function()
  terminal_git 'git status -s\n'
end, { desc = 'Open Floating Terminal with Git Status' })

-- Set floating window background to be the same as Normal
-- local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#070707' })
