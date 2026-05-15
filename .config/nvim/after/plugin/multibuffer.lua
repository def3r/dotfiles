vim.api.nvim_create_autocmd('FileType', {
  pattern = 'multibuffer',
  callback = function(args)
    -- Navigation: <CR> to jump to source line
    vim.keymap.set('n', '<cr>', function()
      local mbuf = require 'multibuffer'
      local cursor = vim.api.nvim_win_get_cursor(0)
      local buf, line = multibuffer.multibuf_get_buf_at_line(args.buf, cursor[1])
      if buf then
        vim.api.nvim_set_current_buf(buf)
        vim.api.nvim_win_set_cursor(0, { line, cursor[2] })
      end
    end, { buffer = args.buf, desc = 'Jump to source' })
  end,
})

-- using BufWinEnter so that if the multibuf window changes to a different buffer it will reset
-- NOTE: this assumes you're setting your window options in another autocmd
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(args)
    if vim.bo[args.buf].filetype ~= 'multibuffer' then
      return
    end
    local winid = vim.api.nvim_get_current_win()
    vim.api.nvim_set_option_value('number', false, { scope = 'local', win = winid })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local', win = winid })
    -- Ensure enough room for multibuf line numbers (e.g. 4 digits)
    vim.api.nvim_set_option_value('signcolumn', 'yes:3', { scope = 'local', win = winid })
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew', 'BufWinEnter', 'TermOpen' }, {
  callback = function()
    if vim.bo.filetype == 'multibuffer' then
      return
    end

    -- restore your window options
  end,
})
