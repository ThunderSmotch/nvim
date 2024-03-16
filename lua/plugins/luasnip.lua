local ls = require("luasnip")

ls.config.set_config({ -- Setting LuaSnip config
  enable_autosnippets = true, -- Enable autotriggered snippets
  store_selection_keys = "<Tab>", -- Use Tab (or some other key if you prefer) to trigger visual selection
  update_events = 'TextChanged,TextChangedI', -- Update repeated insert nodes on text change instead of insert mode exit
  delete_check_events = "InsertLeave", -- Update snippet history when leaving InsertMode
  history = false, -- Do not save snippet history
  store_selection_keys = "<Tab>", -- Use <Tab> (or some other key if you prefer) to trigger visual selection
})

-- Some shorthands
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- Make it so we can undo auto_expanded snippets 
-- https://github.com/L3MON4D3/LuaSnip/issues/830
local auto_expand = require("luasnip").expand_auto
require("luasnip").expand_auto = function(...)
    vim.o.undolevels = vim.o.undolevels
    auto_expand(...)
end

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

--- Util Functions for luasnip
lua_snip_utils = {}

lua_snip_utils.get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, {i(1, parent.snippet.env.SELECT_RAW), i(2)})
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Some LaTeX-specific conditional expansion functions (requires VimTeX)
lua_snip_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
lua_snip_utils.in_text = function()
  return not lua_snip_utils.in_mathzone()
end
lua_snip_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
lua_snip_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
lua_snip_utils.in_equation = function()  -- equation environment detection
    return lua_snip_utils.in_env('equation')
end
lua_snip_utils.in_itemize = function()  -- itemize environment detection
    return lua_snip_utils.in_env('itemize')
end
lua_snip_utils.in_tikz = function()  -- TikZ picture environment detection
    return lua_snip_utils.in_env('tikzpicture')
end

--- Below two functions are necessary functions to insert space if the next press is a char
local if_char_insert_space = function()
	--print("RUN FUNC")
	if string.find(vim.v.char, "[%a%d]") then
		vim.v.char = " "..vim.v.char
		return true
	elseif string.find(vim.v.char, "[%s%.%,%!%?%-]") then
		return true
	end
end

lua_snip_utils.create_autocmd_for_char_insert_space = function() 
	vim.api.nvim_create_autocmd("InsertCharPre", {
		callback = if_char_insert_space
	})
end

---

vim.api.nvim_create_user_command("LuaSnipReload", function()
		require("luasnip.loaders.from_lua").lazy_load({paths = vim.fs.normalize("$LOCALAPPDATA/nvim/LuaSnip/")})
	end,
{desc="Reload LuaSnip snippet files"})

--- Currently only working on Windows
--require("luasnip.loaders.from_lua").load({paths = vim.fs.normalize('$LOCALAPPDATA/nvim/LuaSnip/') })
require("luasnip.loaders.from_lua").load({paths = vim.fs.normalize('$LOCALAPPDATA/nvim/LuaSnip/') })

--- Exit Snippet on exiting Insert Mode or the insides of the snippet.
local unlinkgrp = vim.api.nvim_create_augroup(
  'UnlinkSnippetOnModeChange',
  { clear = true }
)

vim.api.nvim_create_autocmd('ModeChanged', {
  group = unlinkgrp,
  pattern = {'s:n', 'i:*'},
  desc = 'Forget the current snippet when leaving the insert mode',
  callback = function(evt)
    if
      ls.session
      and ls.session.current_nodes[evt.buf]
      and not ls.session.jump_active
    then
      ls.unlink_current()
    end
  end,
})

