-- This is my init.lua file

vim.cmd("set number")

-- Old code from init.vim
vim.cmd([[
let mapleader = '\'

set shell=powershell.exe
set shellxquote=
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'

call plug#begin()
" The master
	Plug 'junegunn/vim-plug'
" Themes/Aesthethic
	Plug 'Mofiqul/dracula.nvim'
	Plug 'nvim-lualine/lualine.nvim'
" Tex
	Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*'}
	Plug 'lervag/vimtex'
call plug#end()

" Keybind to reload source config
nnoremap <leader>sv <CMD>source $MYVIMRC<CR>

colorscheme dracula

" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

lua require('config')
]])
