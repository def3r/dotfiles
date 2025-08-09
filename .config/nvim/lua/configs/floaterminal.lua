local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
local job_id = 0

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    -- border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
    return
  end

  state.floating = create_floating_window { buf = state.floating.buf }
  if vim.bo[state.floating.buf].buftype ~= 'terminal' then
    job_id = vim.fn.termopen(vim.o.shell, { detach = true })
    vim.cmd 'startinsert'
    vim.schedule(function()
      vim.fn.chansend(job_id, 'fish\nclear\n')
    end)
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
