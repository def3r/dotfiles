local transOn = false

function Trans()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none' })
  vim.opt.cursorline = false
  transOn = true
end

function ToggleTrans()
  if transOn then
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#000000' })
    vim.opt.cursorline = true
    transOn = false
  else
    Trans()
  end
end
