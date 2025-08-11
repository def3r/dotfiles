vim.g.firenvim_config = {
  localSettings = {
    ['https://discord.com/.*'] = { takeover = 'never', priority = 1 },
  },
}

if vim.g.started_by_firenvim then
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      local url = vim.api.nvim_buf_get_name(0)
      if url:match 'takeuforward.org' or url:match 'leetcode.com' then
        vim.bo.filetype = 'cpp'
      end
    end,
  })
end
