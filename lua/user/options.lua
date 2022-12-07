
vim.opt.number     = true -- show line numbers
vim.opt.showmode   = false  -- disable in favor of lualine statusline

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


