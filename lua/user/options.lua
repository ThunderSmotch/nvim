vim.opt.cursorline = true   -- highlight current line
vim.opt.number     = true   -- show line numbers
vim.opt.ruler      = true	-- shows cursor position in current line
vim.opt.showmode   = false  -- disable in favor of lualine statusline
vim.opt.incsearch  = false  -- don't jump to search results as search string is being typed
vim.opt.autowrite  = true   -- write current buffer when moving buffers
vim.opt.wrap       = true   -- wrap long lines
vim.opt.linebreak  = true   -- break lines at words
vim.opt.spell      = true   -- enable spellcheck
vim.opt.ignorecase = true   -- ignore case in search patterns
vim.opt.smartcase  = true   -- on search if caps is used then ignores ignorecase
vim.opt.smartindent= true   -- enable smart indentation on new lines
vim.opt.undofile   = true   -- enable persistent undos

vim.opt.completeopt = {"menu", "noinsert", "menuone"}

vim.opt.scrolloff  = 8 -- always keep 8 lines around cursor both ways
vim.opt.tabstop    = 4 -- tab size
vim.opt.shiftwidth = 4 -- needed for tab size

-- Spelling languages
vim.opt.spelllang = "en,pt_pt"

-- Set powershell as default shell on Windows
if vim.loop.os_uname()["sysname"] == "Windows_NT" then
	vim.opt.shell = "powershell.exe"
	vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;" 
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellxquote = ""
	vim.opt.shellquote = ""
	print("Windows found, switching to Powershell!")
end
