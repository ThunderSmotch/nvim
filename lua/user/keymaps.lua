-- Set <Leader> key to backslash
vim.g.mapleader = '\\'

vim.keymap.set("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>", {desc = "Reload Vim config from scratch"})

-- Write and quit if possible/applicable, force quit otherwise
vim.keymap.set("n", "<Leader>q",
	function()
		local success, result = pcall(vim.cmd, "wq")
    	if not success then
      		vim.cmd("q!")
    	end
  	end,
	{desc = "Write and quit if possible/applicable, force quit otherwise"})

vim.keymap.set("n", "<Leader>w", "<Cmd>write<CR>", {desc="Write file"})
vim.keymap.set("n", "<C-z>", "u", {desc="Undo previous change"})


-- Moving Lines
vim.keymap.set("n", "<S-Up>", "<Cmd>m-2<CR>", {desc="Move current line up"})
vim.keymap.set("n", "<S-Down>", "<Cmd>m+<CR>", {desc="Move current line down"})

vim.keymap.set("i", "<S-Up>", "<Cmd>m-2<CR>", {desc="Move current line up"})
vim.keymap.set("i", "<S-Down>", "<Cmd>m+<CR>", {desc="Move current line down"})

-- Input mode
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", {desc="Quick-fix previous spelling error."})

-- 1 oine
-- 2
-- 3
-- 4
-- 5
