-- Setup Plugins using vim-plug

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Generic
	Plug 'junegunn/vim-plug'
	Plug 'folke/which-key.nvim'
	Plug 'ggandor/leap.nvim'
	Plug 'windwp/nvim-autopairs'
-- Themes/Aesthethic
	Plug 'Mofiqul/dracula.nvim'
	Plug 'nvim-lualine/lualine.nvim'
-- Tex
	Plug ('L3MON4D3/LuaSnip', {tag = 'v<CurrentMajor>.*'})
	Plug 'lervag/vimtex'
vim.call('plug#end')

local modules = {
	"plugins.lualine",
	"plugins.luasnip",
	"plugins.which-key",
	"plugins.leap",
	"plugins.autopairs",
}

for k, v in pairs(modules) do
	package.loaded[v]=nil
	require(v)
end


