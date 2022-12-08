local ls = require("luasnip")

ls.config.set_config({ -- Setting LuaSnip config
  enable_autosnippets = true, -- Enable autotriggered snippets
  store_selection_keys = "<Tab>", -- Use Tab (or some other key if you prefer) to trigger visual selection
  update_events = 'TextChanged,TextChangedI', -- Update repeated insert nodes on text change instead of insert mode exit
  store_selection_keys = "<Tab>", -- Use <Tab> (or some other key if you prefer) to trigger visual selection
})

-- Keybindings
vim.keymap.set("i", "<Tab>", function() 
	if ls.expand_or_jumpable() then
		return '<Plug>luasnip-expand-or-jump'
	else
		return '<Tab>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip Expand or Jump through snippets"})


vim.keymap.set("s", "<Tab>", function() 
	if ls.jumpable(1) then
		return '<Plug>luasnip-jump-next'
	else
		return '<Tab>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip Jump through snippets"})


vim.keymap.set("i", "<S-Tab>", function() 
	if ls.jumpable(-1) then
		return '<Plug>luasnip-jump-prev'
	else
		return '<S-Tab>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip Jump back through snippets"})


vim.keymap.set("s", "<S-Tab>", function() 
	if ls.jumpable(-1) then
		return '<Plug>luasnip-jump-prev'
	else
		return '<S-Tab>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip Jump back through snippets"})


vim.keymap.set("i", "<C-f>", function() 
	if ls.choice_active() then
		return '<Plug>luasnip-next-choice'
	else
		return '<C-f>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip iterate through choices"})

vim.keymap.set("s", "<C-f>", function() 
	if ls.choice_active() then
		return '<Plug>luasnip-next-choice'
	else
		return '<C-f>'
	end
end,
{remap = true, silent = true, expr = true, desc = "LuaSnip iterate through choices"})

vim.api.nvim_create_user_command("LuaSnipEdit", function() 
		require("luasnip.loaders").edit_snippet_files({
			edit = function(file) vim.cmd("tabe " .. file) end
		})
	end,
{desc="Edit LuaSnip snippet files"})

vim.api.nvim_create_user_command("LuaSnipReload", function()
		require("luasnip.loaders.from_lua").lazy_load({paths = vim.fs.normalize("$LOCALAPPDATA/nvim/LuaSnip/")})
	end,
{desc="Reload LuaSnip snippet files"})

--- Currently only working on Windows
require("luasnip.loaders.from_lua").load({paths = vim.fs.normalize('$LOCALAPPDATA/nvim/LuaSnip/') })

