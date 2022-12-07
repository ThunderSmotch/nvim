-- Setup Plugins using vim-plug

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Generic
	Plug 'junegunn/vim-plug'
	Plug 'folke/which-key.nvim'
-- Themes/Aesthethic
	Plug 'Mofiqul/dracula.nvim'
	Plug 'nvim-lualine/lualine.nvim'
-- Tex
	Plug ('L3MON4D3/LuaSnip', {tag = 'v<CurrentMajor>.*'})
	Plug 'lervag/vimtex'
vim.call('plug#end')

require("plugins.lualine")
require("plugins.luasnip")
require("plugins.which-key")