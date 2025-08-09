if not vim.g.started_by_firenvim then
  return
end

-- basic UI tweaks for the browser overlay
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.number = false
vim.o.relativenumber = false

-- Minimum size you want (rows x cols)
local MIN_LINES = 5 -- tiny; you may prefer 10-20 for usability
local MIN_COLS = 30 -- 30 is small for code; 60-100 is more practical

vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  callback = function()
    -- Detect the attaching client to ensure it's Firenvim
    local chan = vim.v.event.chan
    local chan_info = vim.api.nvim_get_chan_info(chan)
    if not (chan_info and chan_info.client and chan_info.client.name == 'Firenvim') then
      return
    end

    -- Only raise lines/columns if they're smaller than our minimum
    local cur_lines = tonumber(vim.o.lines) or 0
    local cur_cols = tonumber(vim.o.columns) or 0

    if cur_lines < MIN_LINES then
      vim.o.lines = MIN_LINES
    end
    if cur_cols < MIN_COLS then
      vim.o.columns = MIN_COLS
    end

    -- one small deferred retry — browser may resize after attach
    vim.defer_fn(function()
      if (tonumber(vim.o.lines) or 0) < MIN_LINES then
        vim.o.lines = MIN_LINES
      end
      if (tonumber(vim.o.columns) or 0) < MIN_COLS then
        vim.o.columns = MIN_COLS
      end
    end, 80)
  end,
})
