return {
	{
		"brianhuster/live-preview.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.pick",
			"folke/snacks.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		opts = { browser = "brave" },
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		priority = 49,

		dependencies = {
			"saghen/blink.cmp",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
