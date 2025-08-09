vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  -- whats zamata with this group?
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  command = 'setlocal relativenumber',
})

vim.schedule(function()
  vim.opt.clipboard:append 'unnamedplus'
end)
