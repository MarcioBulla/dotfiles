return {
	"folke/which-key.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 10
		local wk = require("which-key")

		wk.setup({})

		wk.add({
			{ "<leader>t", group = "ToggleTerms", icon = "" },
			{ "<leader>f", group = "Telescope", icon = "" },
			{ "<leader>b", group = "BufferLine", icon = "" },
			{ "<leader>bS", group = "Sort by", icon = "󰒺" },
			{ "<leader>N", group = "Auto Docstring", icon = "󰅽" },
			{ "<leader>h", group = "Help Code", icon = "󱜸" },
			{ "<leader>p", group = "Python", icon = "" },
			{ "<leader>P", group = "PlatformIO", icon = "" },
			{ "<leader>z", group = "Zig", icon = "" },
			{ "<leader>e", group = "Toggle NeoTree", icon = "" },
			{ "<leader>o", group = "Focus NeoTree", icon = "" },
			{ "<leader>l", group = "LSP", icon = "", mode = { "n", "v" } },
			{ "<leader>S", group = "Auto Session", icon = "" },
			{ "<leader>O", group = "Obsidian", icon = "" },
			{ "<leader>R", group = "ESP IDF", icon = "" },
		})
	end,
	opts = { icons = { mappings = true } },
}
