return {
  -- automatically detects the tabstop and shiftwidth
  'tpope/vim-sleuth',

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },

  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  'mbbill/undotree',

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- TODO: Firenvim
  --
}
