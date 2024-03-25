let g:vimtex_view_general_viewer = 'F:\Programs\sioyek-release-windows\sioyek.exe'
let g:vimtex_view_general_options = '@pdf --forward-search-file @tex --forward-search-line @line --inverse-search "C:\Shortcuts\inverse.bat \"%1\" %2"'

" let g:vimtex_view_method = 'sioyek'

set conceallevel=2

let g:tex_flavor="latex"
let g:tex_conceal="admg"
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:vimtex_syntax_custom_cmds = [
\ {'name': 'sum', 'mathmode': 1, 'concealchar': 'Σ'},
\ {'name': 'ind', 'mathmode': 1, 'concealchar': '𝟙'},
\ {'name': 'urlref', 'cmdre': 'urlref\{.{-}\}', 'conceal': 1, 'concealchar': '☍', 'argstyle': 'bold'},
\]

let g:vimtex_syntax_custom_cmds_with_concealed_delims = [
	  \ {'name': 'ket', 'mathmode': 1, 'cchar_open': '|', 'cchar_close': '>'},
	  \ {'name': 'binom', 'nargs': 2, 'mathmode': 1, 'cchar_open': '(', 'cchar_mid': '|',  'cchar_close': ')'},
\]

" backslash as the local leader key for `tex` filetype.
let maplocalleader = "\\"