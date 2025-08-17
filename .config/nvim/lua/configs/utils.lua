local M = {}

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

M.state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

function M.get_default_win_config()
  return {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    col = math.floor((vim.o.columns - math.floor(vim.o.columns * 0.8)) / 2),
    row = math.floor((vim.o.lines - math.floor(vim.o.lines * 0.8)) / 2),
    style = 'minimal', -- No borders or extra UI elements
    border = 'none',
  }
end

function M.create_floating_window(opts)
  opts = opts or {}

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = opts.win_config or M.get_default_win_config()
  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

return M
