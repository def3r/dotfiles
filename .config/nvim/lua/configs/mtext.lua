local serverPath = '/home/asbestos/dotfiles/mtext'
local serverRunning = false
local server

function MTextIntendedPath()
  local path = vim.fn.expand '%:p'
  local expectedPath = '/home/asbestos/part9/Asbestos/cp/'
  return path:sub(1, #expectedPath) == expectedPath
end

function MTextRunServer()
  vim.system({ 'go', 'build', '.' }, { cwd = serverPath })
  server = vim.system({ './mtext' }, { cwd = serverPath })
  serverRunning = true
end

function MTextKillServer()
  vim.uv.kill(server.pid, 'sigint')
  serverRunning = false
end

function MTextServerStatus()
  print(serverRunning)
  if serverRunning then
    print(server.pid)
  end
end

vim.api.nvim_create_augroup('MTextAutocmd', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'MTextAutocmd',
  callback = function()
    if MTextIntendedPath() == false then
      return
    end

    if serverRunning == false then
      MTextRunServer()
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'MTextAutocmd',
  callback = function(args)
    if MTextIntendedPath() == false then
      return
    end

    if serverRunning == false then
      MTextRunServer()
    end

    print(args.file)
    vim.system({ 'nc', '-c', 'localhost', '6767' }, { stdin = args.file })
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = 'MTextAutocmd',
  callback = function()
    if server and server.pid then
      local ok, err = pcall(vim.uv.kill, server.pid, 'sigint')
      if not ok then
        vim.schedule(function()
          vim.notify(('Failed to kill server: %s'):format(err), vim.log.levels.DEBUG)
        end)
      end
    end
  end,
})

vim.api.nvim_create_user_command('MTextIntendedPath', function()
  print(MTextIntendedPath())
end, { desc = 'Check if current path is MText valid' })

vim.api.nvim_create_user_command('MTextRunServer', function()
  MTextRunServer()
  print(server.pid)
end, { desc = 'Star MText Server' })

vim.api.nvim_create_user_command('MTextKillServer', MTextRunServer, { desc = 'Kill MText Server' })

vim.api.nvim_create_user_command('MTextServerStatus', MTextRunServer, { desc = 'Check MText Server Status' })
