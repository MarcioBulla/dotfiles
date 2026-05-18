return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim", lazy = false },
		"ibhagwan/fzf-lua",
		"echasnovski/mini.pick",
	},
	opts = {
		browser = "brave",
		picker = "telescope",
		dynamic_root = false,
		sync_scroll = true,
	},
}
