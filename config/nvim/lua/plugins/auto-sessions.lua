return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>Sr", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<leader>Ss", "<cmd>AutoSession save<CR>", desc = "Save session" },
		{ "<leader>Sa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
		{ "<leader>S", desc = "Auto Session" },
	},
	opts = {
		auto_restore = false,
		auto_restore_last_session = false,
		pre_save_cmds = { "Neotree close" },
		session_lens = {
			load_on_setup = true,
			mappings = {
				alternate_session = { "i", "<C-S>" },
				copy_session = { "i", "<C-Y>" },
				delete_session = { "i", "<C-D>" },
			},
			picker_opts = {
				border = true,
			},
			previewer = false,
		},
	},
}
