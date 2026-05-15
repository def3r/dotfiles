local navic = require 'nvim-navic'
local navic_winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
local navic_status = false

navic.setup {
  icons = {
    File = '󰈙 ',
    Module = ' ',
    Namespace = '󰌗 ',
    Package = ' ',
    Class = '󰌗 ',
    Method = '󰆧 ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = '󰕘',
    Interface = '󰕘',
    Function = '󰊕 ',
    Variable = '󰆧 ',
    Constant = '󰏿 ',
    String = '󰀬 ',
    Number = '󰎠 ',
    Boolean = '◩ ',
    Array = '󰅪 ',
    Object = '󰅩 ',
    Key = '󰌋 ',
    Null = '󰟢 ',
    EnumMember = ' ',
    Struct = '󰌗 ',
    Event = ' ',
    Operator = '󰆕 ',
    TypeParameter = '󰊄 ',
    enabled = true,
  },
  lsp = {
    auto_attach = false,
    preference = nil,
  },
  highlight = false,
  separator = ' > ',
  depth_limit = 0,
  depth_limit_indicator = '..',
  safe_output = true,
  lazy_update_context = false,
  click = false,
  format_text = function(text)
    return text
  end,
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, args.buf)
      if navic_status then
        vim.wo.winbar = navic_winbar
      end
    end
  end,
})

vim.keymap.set('n', '<F2>', function()
  navic_status = not navic_status
  vim.wo.winbar = navic_status and navic_winbar or ''
end, { desc = 'Toggle winbar scope context' })
