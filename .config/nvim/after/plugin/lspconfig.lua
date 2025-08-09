local lspconfig = require('lspconfig')
local lsp = require('configs.lsp')

for _, server in ipairs(lsp.servers) do
  -- local opts = lsp.settings[server] or {}
  -- lspconfig[server].setup(opts)
end
