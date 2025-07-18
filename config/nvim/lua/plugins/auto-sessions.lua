return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>Sr", "<cmd>SessionSearch<CR>", desc = "Session search" },
		{ "<leader>Ss", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>Sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
		{ "<leader>S", desc = "Auto Session" },
	},
	opts = {
		auto_restore_enabled = false,
		auto_session_enable_last_session = false,
		pre_save_cmds = {
			"Neotree close",
		},
		session_lens = {
			load_on_setup = true,
			previewer = false,
			mappings = {
				delete_session = { "i", "<C-D>" },
				alternate_session = { "i", "<C-S>" },
				copy_session = { "i", "<C-Y>" },
			},
			theme_conf = {
				border = true,
			},
		},
	},
}
