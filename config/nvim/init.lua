require("config.keymaps")
require("config.vim-configs")
require("config.lazy")
require('theme.matugen').setup()

vim.lsp.config("panache", {
	handlers = {
		["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			if result and result.diagnostics then
				result.diagnostics = vim.tbl_filter(function(diagnostic)
					return diagnostic.code ~= "missing-bibliography-key"
				end, result.diagnostics)
			end

			return vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
		end,
	},
})

vim.lsp.enable({ "zls", "ltex", "texlab", "clangd", "pyright", "lua_ls", "bashls", "panache" })
