-- Disabling provider
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
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

-- Folding
vim.cmd("syntax enable")
vim.g.markdown_folding = 1
vim.opt.fillchars = {
	fold = " ",
	foldclose = "",
	foldopen = "",
	foldsep = " ",
}
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

function _G.CustomFoldText()
	local start_line = vim.v.foldstart
	local end_line = vim.v.foldend
	local content = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1] or ""
	content = content:gsub("\t", string.rep(" ", vim.o.tabstop))

	local suffix = string.format("   %d lines", end_line - start_line + 1)
	local win_width = vim.api.nvim_win_get_width(0)
	local fold_col = tonumber(vim.wo.foldcolumn) or 0
	local available = math.max(win_width - fold_col - vim.fn.strdisplaywidth(suffix) - 4, 20)
	local truncated = vim.fn.strcharpart(content, 0, available)

	return truncated .. suffix
end

vim.opt.foldtext = "v:lua.CustomFoldText()"

-- Auto-sesions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.viewoptions = "folds,cursor,curdir,slash,unix"
vim.opt.viewdir = vim.fn.stdpath("state") .. "/view"

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].buftype == "" then
			pcall(vim.cmd, "mkview")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].buftype == "" then
			pcall(vim.cmd, "silent! loadview")
		end
	end,
})

-- Set tab and indentation settings per file type
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype

		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2

		if vim.bo.buftype == "" then
			if ft == "quarto" or ft == "markdown" or ft == "rmd" then
				vim.opt_local.foldmethod = "expr"
				vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			else
				vim.opt_local.foldmethod = "syntax"
				vim.opt_local.foldexpr = "0"
			end

			vim.opt_local.foldenable = true
			vim.opt_local.foldlevel = 99
		end
	end,
})

-- Custom filetype detection
vim.filetype.add({
	pattern = {
		[".*/waybar/config"] = "jsonc", -- Waybar config (JSON with comments)
		[".*/kitty/.*%.conf"] = "bash", -- Kitty config (shell-like syntax)
	},
})
