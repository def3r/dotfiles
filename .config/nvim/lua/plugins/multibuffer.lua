return {
  'zaucy/multibuffer.nvim',
  opts = {
    expander_max_lines = 1,
    expander_signs = { above = '↑', below = '↓', both = '↕' },
    expander_sign_hl = 'Folded',
  },
  config = function(_, opts)
    local mb = require 'multibuffer'
    mb.setup(opts)

    local function source_pos(mbuf)
      local c = vim.api.nvim_win_get_cursor(0)
      local src_buf, src_line = mb.multibuf_get_buf_at_line(mbuf, c[1] - 1)
      return src_buf, src_line, c[2]
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'multibuffer',
      callback = function(args)
        local b = args.buf
        local set = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = b, silent = true, desc = desc })
        end

        -- Jump to real source line
        set('n', '<CR>', function()
          local src_buf, src_line, col = source_pos(b)
          if src_buf and src_line then
            vim.api.nvim_set_current_buf(src_buf)
            vim.api.nvim_win_set_cursor(0, { src_line + 1, col })
          end
        end, 'Multibuffer: jump to source')

        -- Slice expand/shrink
        set('n', '<C-k>', function()
          mb.multibuf_slice_expand(b, 1, 0)
        end, 'Expand up')
        set('n', '<C-j>', function()
          mb.multibuf_slice_expand(b, 0, 1)
        end, 'Expand down')
        set('n', '<C-S-k>', function()
          mb.multibuf_slice_expand(b, 0, -1)
        end, 'Shrink bottom')
        set('n', '<C-S-j>', function()
          mb.multibuf_slice_expand(b, -1, 0)
        end, 'Shrink top')

        -- LSP forwarding from multibuffer -> source buffer
        set('n', 'K', function()
          local src_buf, src_line, col = source_pos(b)
          if not src_buf or not src_line then
            return
          end
          vim.api.nvim_set_current_buf(src_buf)
          vim.api.nvim_win_set_cursor(0, { src_line + 1, col })
          vim.lsp.buf.hover()
        end, 'LSP Hover on source')

        set('n', 'gD', function()
          local src_buf, src_line, col = source_pos(b)
          if not src_buf or not src_line then
            return
          end
          vim.api.nvim_set_current_buf(src_buf)
          vim.api.nvim_win_set_cursor(0, { src_line + 1, col })
          vim.lsp.buf.declaration()
        end, 'LSP Declaration on source')

        set('n', 'gd', function()
          local src_buf, src_line, col = source_pos(b)
          if not src_buf or not src_line then
            return
          end
          vim.api.nvim_set_current_buf(src_buf)
          vim.api.nvim_win_set_cursor(0, { src_line + 1, col })
          vim.lsp.buf.definition()
        end, 'LSP Definition on source')
      end,
    })

    -- Recommended visual defaults for multibuffer windows
    vim.api.nvim_create_autocmd('BufWinEnter', {
      callback = function(args)
        if vim.bo[args.buf].filetype ~= 'multibuffer' then
          return
        end
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_option_value('number', false, { win = win, scope = 'local' })
        vim.api.nvim_set_option_value('relativenumber', false, { win = win, scope = 'local' })
        vim.api.nvim_set_option_value('signcolumn', 'yes:3', { win = win, scope = 'local' })
      end,
    })

    -- Quick demo command: current file around cursor + alternate buffer top
    vim.api.nvim_create_user_command('MultibufTry', function()
      local cur = vim.api.nvim_get_current_buf()
      local cur_line = vim.api.nvim_win_get_cursor(0)[1] - 1
      local alt = vim.fn.bufnr '#'
      local m = mb.create_multibuf { header = { ' multibuffer demo ' } }

      mb.multibuf_add_buf(m, {
        buf = cur,
        regions = { { start_row = math.max(0, cur_line - 5), end_row = cur_line + 5 } },
      })

      if alt > 0 and vim.api.nvim_buf_is_valid(alt) then
        mb.multibuf_add_buf(m, {
          buf = alt,
          regions = { { start_row = 0, end_row = 20 } },
        })
      end

      mb.win_set_multibuf(0, m)
    end, {})

    -- Optional helper mappings
    vim.keymap.set('n', '<leader>mr', function()
      require('multibuffer.plugins.ripgrep').multibuf_ripgrep {}
    end, { desc = 'Multibuffer ripgrep' })

    vim.keymap.set('n', '<leader>ms', function()
      require('multibuffer.plugins.symbols').multibuf_document_symbols(0)
    end, { desc = 'Multibuffer document symbols' })

    vim.keymap.set('n', '<leader>mS', function()
      require('multibuffer.plugins.symbols').multibuf_workspace_symbols ''
    end, { desc = 'Multibuffer workspace symbols' })
  end,
}
