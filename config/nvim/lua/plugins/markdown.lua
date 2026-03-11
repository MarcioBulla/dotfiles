return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim", lazy = false }, -- makes vim.ui.select available early
		"ibhagwan/fzf-lua",
		"echasnovski/mini.pick",
		"folke/snacks.nvim",
	},
	opts = {
		browser = "brave",
		picker = "telescope",
	},
}
