let g:vimtex_view_general_viewer = 'F:\Programs\sioyek-release-windows\sioyek.exe'
let g:vimtex_view_general_options = '@pdf --forward-search-file @tex --forward-search-line @line --inverse-search "C:\Shortcuts\inverse.bat \"%1\" %2"'

" let g:vimtex_view_method = 'sioyek'

set conceallevel=2

let g:tex_flavor="latex"
let g:tex_conceal="admg"
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:vimtex_syntax_custom_cmds = [
\ {'name': 'sum', 'mathmode': 1, 'concealchar': 'Σ'},
\]

" backslash as the leader leader key for `tex` filetype.
let maplocalleader = "\\"