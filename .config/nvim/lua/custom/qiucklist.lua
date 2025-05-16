local function getGitRoot()
  local filepath = vim.fn.expand '%:p:h'
  local git_root = vim.fn.systemlist('git -C ' .. filepath .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a Git repository'
    return nil
  end
  return git_root
end

local telescope = require 'telescope.builtin'

vim.keymap.set('n', '<leader>oo', function()
  telescope.live_grep {
    prompt_title = 'find string in open buffers...',
    grep_open_files = true,
  }
end, { desc = '' })

vim.keymap.set('n', '<leader>sib', function()
  telescope.current_buffer_fuzzy_find {
    prompt_title = 'Search in this Buffer',
  }
end, { desc = '[S]earch [I]n this [B]uffer' })

vim.keymap.set('n', '<leader>gc', function()
  local git_root = getGitRoot()
  if git_root == nil then
    return nil
  end
  telescope.git_commits {
    cwd = git_root,
  }
end, { desc = '[G]it [C]ommits' })

vim.keymap.set('n', '<leader>gbc', function()
  local git_root = getGitRoot()
  if git_root == nil then
    return nil
  end
  telescope.git_bcommits {
    cwd = git_root,
  }
end, { desc = '[G]it [B]uffer [C]ommits' })

vim.keymap.set('n', '<leader>gs', function()
  local git_root = getGitRoot()
  if git_root == nil then
    return nil
  end
  require('telescope.builtin').git_status {
    prompt_title = '<tab> to toggle stage',
    cwd = git_root,
  }
end, { desc = '[G]it [S]tatus' })

vim.keymap.set('n', '<leader>man', function()
  require('telescope.builtin').man_pages {
    sections = { 'ALL' },
  }
end, { desc = '[G]it [S]tatus' })
