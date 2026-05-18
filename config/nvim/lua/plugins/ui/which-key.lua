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
			{ "<leader>E", group = "ESP-IDF", icon = "󰐻" },
			{ "<leader>f", group = "Telescope", icon = "" },
			{ "<leader>b", group = "BufferLine", icon = "" },
			{ "<leader>bS", group = "Sort by", icon = "󰒺" },
			{ "<leader>c", group = "Codex", icon = "󰚩" },
			{ "<leader>N", group = "Auto Docstring", icon = "󰅽" },
			{ "<leader>h", group = "Help Code", icon = "󱜸" },
			{ "<leader>p", group = "Python", icon = "" },
			{ "<leader>P", group = "PlatformIO", icon = "" },
			{ "<leader>e", group = "Toggle NeoTree", icon = "" },
			{ "<leader>o", group = "Focus NeoTree", icon = "" },
			{ "<leader>l", group = "LSP", icon = "", mode = { "n", "v" } },
			{ "<leader>s", group = "Auto Session", icon = "" },
			{ "<leader>S", group = "Language", icon = "󰗊" },
			{ "<leader>O", group = "Obsidian", icon = "" },
		})
	end,
	opts = { icons = { mappings = true } },
}
