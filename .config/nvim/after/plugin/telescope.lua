local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch among [G]it files' })
vim.keymap.set('n', '<leader>sl', builtin.live_grep, { desc = '[S]earcg with [L]ive grep' })
vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecent files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[S]earchg [B]uffers' })
