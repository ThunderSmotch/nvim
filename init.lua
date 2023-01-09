-- This is my init.lua file

local modules = {
"user.options",
"user.keymaps",
"user.plugins"
}

for k, v in pairs(modules) do
	package.loaded[v]=nil
	require(v)
end

vim.cmd("colorscheme dracula")

vim.cmd("highlight Conceal guifg=#50fa7b")
