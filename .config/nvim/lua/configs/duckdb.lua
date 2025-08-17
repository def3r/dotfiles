local utils = require 'configs.utils'

local function exec_duckdb_current_file()
  local file = vim.fn.expand '%:p' -- full path to current file
  if file == '' then
    print 'No file open'
    return
  end

  local fName = vim.fn.expand '%:t:r' -- filename without extension
  local db_path = fName .. '.db'

  -- remove old DB
  os.remove(db_path)

  -- run SQL file into DuckDB
  local cmd = string.format('duckdb %s <%s > /dev/null', db_path, file)
  local result = os.execute(cmd)
  if result ~= 0 then
    print 'Error: DuckDB execution failed'
    return
  end

  -- open floating terminal running DuckDB
  local term_cmd = string.format('duckdb %s', db_path)
  local buf = vim.api.nvim_create_buf(false, true)
  local win_config = utils.get_default_win_config()
  win_config.border = 'single'

  local win = vim.api.nvim_open_win(buf, true, win_config)
  utils.state.floating = { buf = buf, win = win }

  local job_id = vim.fn.termopen(term_cmd, { detach = true })
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<leader>ddb', exec_duckdb_current_file, { desc = '[D]uck[D][B]' })

return {
  exec_duckdb_current_file = exec_duckdb_current_file,
}
