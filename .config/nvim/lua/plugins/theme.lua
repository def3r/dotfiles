local M

-- OG
-- M = { 'hachy/eva01.vim' }

-- M = { 'rose-pine/neovim', name = 'rose-pine' }
-- M = { 'EdenEast/nightfox.nvim' }
-- M = { 'rebelot/kanagawa.nvim' }
-- M = {
--   'thesimonho/kanagawa-paper.nvim',
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }

-- M = {
--   'vague-theme/vague.nvim',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other plugins
--   config = function()
--     -- NOTE: you do not need to call setup if you don't want to.
--     require('vague').setup {
--       -- optional configuration here
--     }
--     vim.cmd 'colorscheme vague'
--   end,
-- }

-- M = {
--   'mellow-theme/mellow.nvim',
--   config = function()
--     vim.g.mellow_bold_functions = true
--   end,
-- }

M = { 'dgox16/oldworld.nvim' }

M.lazy = false
M.priority = 1000

M.config = function()
  require('oldworld').setup {
    terminal_colors = true, -- enable terminal colors
    variant = 'default', -- default, oled, cooler
    styles = { -- You can pass the style using the format: style = true
      comments = { italic = true }, -- style for comments
      keywords = { underline = true }, -- style for keywords
      identifiers = {}, -- style for identifiers
      functions = { bold = true }, -- style for functions
      variables = { italic = true }, -- style for variables
      booleans = {}, -- style for booleans
      types = { underline = true },
    },
    integrations = {
      alpha = true,
      cmp = true,
      flash = true,
      gitsigns = true,
      hop = false,
      indent_blankline = true,
      lazy = true,
      lsp = true,
      markdown = true,
      mason = true,
      navic = true,
      neo_tree = false,
      neogit = false,
      neorg = false,
      noice = true,
      notify = true,
      rainbow_delimiters = true,
      telescope = false,
      treesitter = true,
    },
    highlight_overrides = {
      MiniStatuslineFilename = { fg = '#ACA1CF', bold = true },
    },
  }
  vim.cmd.colorscheme 'oldworld'
end

return M
