return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 10
		local wk = require("which-key")

		wk.register({
			["<leader>t"] = { name = " ToggleTerms" },
			["<leader>f"] = { name = " Telescope" },
			["<leader>b"] = { name = " BufferLine" },
			["<leader>bS"] = { name = "󰒺 Sort by" },
			["<leader>N"] = { name = "Neogen", desc = "󰅽 Auto Docstring" },
			["<leader>h"] = { name = "Help", desc = "󱜸 Help Code" },
			["<leader>p"] = { name = "Python", desc = " Python" },
			["<leader>P"] = { name = "PlatformIO", desc = " PlatformIO" },
			["<leader>z"] = { name = "Zig", desc = " Zig" },
		})
		wk.register({
			["<leader>l"] = { name = " LSP" },
		}, { mode = { "n", "v" } })
	end,
	opts = {
		opts = {
			icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
		},
	},
}
