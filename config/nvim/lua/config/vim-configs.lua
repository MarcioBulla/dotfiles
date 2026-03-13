-- Disabling provider
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Enable highlighting of the current line and column
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Tab and indentation settings
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- Number of spaces a <Tab> in file counts for
vim.opt.softtabstop = 2 -- Number of spaces a <Tab> feels like when editing
vim.opt.shiftwidth = 2 -- Size of an indent

-- Line numbering
vim.opt.number = true -- Show absolute line number
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 3 -- Width of the number column

-- Enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Auto-sesions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Set tab and indentation settings per file type
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- Custom filetype detection
vim.filetype.add({
	pattern = {
		[".*/waybar/config"] = "jsonc", -- Waybar config (JSON with comments)
		[".*/kitty/.*%.conf"] = "bash", -- Kitty config (shell-like syntax)
	},
})
