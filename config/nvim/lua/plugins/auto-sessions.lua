return {
	"rmagatti/auto-session",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		local session = require("auto-session")

		session.setup({
			log_level = "error",
			auto_session_enable_last_session = false,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },

			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
				buftypes_to_ignore = {},
			},
		})

		vim.keymap.set(
			"n",
			"<leader>S",
			require("auto-session.session-lens").search_session,
			{ noremap = true, desc = " Session Lens" }
		)
	end,
}
