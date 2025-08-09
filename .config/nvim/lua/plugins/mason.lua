local lsp = require("configs.lsp")

return {
  {
    "mason-org/mason.nvim",
    opts = {},
    config = true
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp.servers,
    },
    -- automatic_enable = false,
  }
}
