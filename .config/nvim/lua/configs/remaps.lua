local newTerminal = function(horizontal)
  vim.cmd.vnew()
  vim.cmd.term()
  if horizontal then
    vim.cmd.wincmd 'J'
  end
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.fn.chansend(vim.bo.channel, 'fish\r\nclear\n')
  vim.cmd 'startinsert'
end

vim.g.mapleader = ' '
vim.g.maplocalleadr = ' '

vim.keymap.set('n', '<leader>x', vim.cmd.q, { desc = 'e[X]it' })

-- enable if netrw available
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = "[E]xplorer" })
-- vim.keymap.set('n', '<leader>ve', vim.cmd.Ve, { desc = "[V]ertical split [E]xplorer" })
-- vim.keymap.set('n', '<leader>he', vim.cmd.Sex, { desc = "[H]orixontal split [E]xplorer" })

vim.keymap.set('n', '<leader>e', vim.cmd.Oil, { desc = '[E]xplorer' })
vim.keymap.set('n', '<leader>ve', function()
  vim.cmd.vs()
  vim.cmd.Oil { '.' }
end, { desc = '[V]ertical split [E]xplorer' })
vim.keymap.set('n', '<leader>he', function()
  vim.cmd.sp()
  vim.cmd.Oil { '.' }
end, { desc = '[H]orixontal split [E]xplorer' })

vim.keymap.set('n', '<leader>hb', function()
  vim.cmd.sp()
  vim.cmd.enew()
end, { desc = 'new [H]orizontal [B]uffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>vb', function()
  vim.cmd.vs()
  vim.cmd.enew()
end, { desc = 'new [V]ertical [B]uffer', noremap = true, silent = true })

vim.keymap.set('n', '<leader>vt', newTerminal, { desc = 'new [V]ertical [T]erminal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ht', function()
  newTerminal(true)
end, { desc = 'new [V]ertical [T]erminal', noremap = true, silent = true })
vim.keymap.set('n', '<ESC>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'diagnostic [Q]uick fix list' })

vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { desc = 'exit terminal mode' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { desc = 'Move current line up', noremap = true, silent = true })
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { desc = 'Move current line down', noremap = true, silent = true })
vim.keymap.set('x', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up', noremap = true, silent = true })
vim.keymap.set('x', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down', noremap = true, silent = true })

-- Create a key mapping to call the switch_buffers function
vim.keymap.set('n', '\\', '<C-^>', { desc = 'Switch between buffers' })
vim.keymap.set('n', '<M-->', '4<C-w>-', { desc = 'Decrease tab height' })
vim.keymap.set('n', '<M-=>', '4<C-w>+', { desc = 'Increase tab height' })
vim.keymap.set('n', '<M-,>', '<C-w>4>', { desc = 'Decrease tab length' })
vim.keymap.set('n', '<M-.>', '<C-w>4<', { desc = 'Increase tab length' })

-- Yes, Disable the Arrow Keys like a psychopath
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Navigate among the split windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>u', function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end, { desc = '[U]ndotree toggle' })

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

vim.keymap.set('n', '<leader>man', function()
  require('telescope.builtin').man_pages {
    sections = { 'ALL' },
  }
end, { desc = '[MAN] pages' })
