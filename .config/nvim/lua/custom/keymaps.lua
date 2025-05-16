local function newTerminal(horizontal)
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

vim.keymap.set('n', '<leader>hb', ':sp<CR>:enew<CR>', { desc = 'new [H]orizontal [B]uffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>vb', ':vs<CR>:enew<CR>', { desc = 'new [V]ertical [B]uffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>vt', newTerminal, { desc = 'new [V]ertical [T]erminal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ht', function()
  newTerminal(true)
end, { desc = 'new [V]ertical [T]erminal', noremap = true, silent = true })
-- ':sp<CR>:term<CR>ifish<CR>'

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'new [V]ertical terminal', noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

vim.keymap.set('n', '<leader>x', ':q<CR>', { desc = 'e[X]it and close buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = '[E]xplorer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ve', ':Vexplore!<CR>', { desc = '[V]ertical split [E]plorer', noremap = true, silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { desc = 'Move current line up', noremap = true, silent = true })
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { desc = 'Move current line down', noremap = true, silent = true })
vim.keymap.set('x', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up', noremap = true, silent = true })
vim.keymap.set('x', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down', noremap = true, silent = true })

-- Create a key mapping to call the switch_buffers function
vim.keymap.set('n', '\\', '<C-^>', { desc = 'Switch between buffers' })
vim.keymap.set('n', '-', '<C-w>-', { desc = 'Decrease tab height' })
vim.keymap.set('n', '+', '<C-w>+', { desc = 'Increase tab height' })

-- debug mappings
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', { desc = '[D]ebugger toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>dr', ':DapContinue<CR>', { desc = '[D]bugger [R]un or continue' })

-- undo tree:
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'toggle [U]ndo tree' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- vim.keymap.set('n', 'x', '_x') -- not storing deleted chars in the yank register
vim.keymap.set('n', '<leader>mw', ':w<CR>', { desc = ':[w]' })
vim.keymap.set('n', '<leader>mq', ':q<CR>', { desc = ':[q]' })
vim.keymap.set('n', '<leader>mQ', ':qa<CR>', { desc = ':qa' })

vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'LSP Rename' })
