local M = {}

M.servers = {
  'lua_ls',
  'clangd',
}

M.settings = {
  lua_ls = {},
  clangd = {},
  c3_lsp = { filetypes = { 'c3' } },
}

return M
