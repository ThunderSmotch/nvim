vim.cmd([[
" nnoremap <leader>sv <CMD>source $MYVIMRC<CR>


" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

]])


require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
  
  --- Update repeated insert nodes on text change instead of insert mode exit
  update_events = 'TextChanged,TextChangedI',
  
  -- Use <Tab> (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

--- Place this in your init.vim
require("luasnip.loaders.from_lua").load({paths = vim.fs.normalize('$LOCALAPPDATA/nvim/LuaSnip/') })

