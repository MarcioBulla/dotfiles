return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			additional_vim_regex_highlighting = true,

			ensure_installed = {
				"python",
				"json",
				"yaml",
				"lua",
				"gitignore",
				"markdown",
				"markdown_inline",
				"bash",
				"c",
				"vim",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
