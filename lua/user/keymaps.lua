-- Set <Leader> key to backslash
vim.g.mapleader = '\\'

-- Keybind to reload source config
vim.keymap.set("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>")

-- Write and quit if possible/applicable, force quit otherwise
vim.keymap.set('n', '<Leader>q',
  function()
    local success, result = pcall(vim.cmd, 'wq')
    if not success then
      vim.cmd('q!')
    end
  end,
  {desc = 'Write and quit if possible/applicable, force quit otherwise.'})
