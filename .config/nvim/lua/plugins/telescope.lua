return {
  {
    'nvim-telescope/telescope.nvim',
    -- branch = 'master',
    -- or tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- This is your opts table
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            'node_modules/.*',
            '%.env',
            'yarn.lock',
            'package-lock.json',
            'raylib/',
            '.git/',
          },
          theme = 'dropdown',
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },

        pickers = {
          find_files = {
            hidden = true,
            theme = 'dropdown',
          },
        },

        live_grep = {
          find_files = {
            hidden = true,
            -- gitignore = false,
          },
          theme = 'dropdown',
        },
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension 'ui-select'
    end,
  },
}
