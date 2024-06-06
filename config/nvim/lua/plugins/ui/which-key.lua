return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 10
		local wk = require("which-key")

		wk.register({
			["<leader>t"] = { name = " ToggleTerms" },
		})
		wk.register({
			["<leader>f"] = { name = " Telescope" },
		})
		wk.register({
			["<leader>b"] = { name = " BufferLine" },
		})
		wk.register({
			["<leader>l"] = { name = " LSP" },
		})
		wk.register({
			["<leader>N"] = { name = "Neogen", desc = "󰅽 Auto Docstring" },
		})
		wk.register({
			["<leader>h"] = { name = "Help", desc = "󱜸 Help Code" },
		})
		wk.register({
			["<leader>V"] = { name = "Virtualenv", desc = " Vituralenv" },
		})
	end,
	opts = {
		opts = {
			icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
		},
	},
}
