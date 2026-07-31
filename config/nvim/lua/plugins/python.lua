return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python",
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		lazy = false,
		event = "VeryLazy",
		keys = {
			{ "<leader>pvs", "<cmd>VenvSelect<cr>", desc = "Select venv" },
			{ "<leader>pvc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
		},
		opts = {
			name = { ".venv" },
		},
	},
	{
		"benomahony/uv.nvim",
		ft = { "python" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>pp", "<cmd>lua require('uv').pick_uv_commands()<cr>", desc = "UV Commands", mode = { "n", "v" } },
			{ "<leader>pr", "<cmd>UVRunFile<cr>", desc = "UV Run Current File" },
			{ "<leader>ps", ":<C-u>UVRunSelection<cr>", desc = "UV Run Selection", mode = "v" },
			{ "<leader>pf", "<cmd>UVRunFunction<cr>", desc = "UV Run Function" },
			{ "<leader>pe", "<cmd>lua require('uv').pick_uv_venv()<cr>", desc = "UV Environment" },
			{ "<leader>pi", "<cmd>UVInit<cr>", desc = "UV Init" },
			{
				"<leader>pa",
				function()
					vim.ui.input({ prompt = "Enter package name: " }, function(input)
						if input and input ~= "" then
							require("uv").run_command("uv add " .. input)
						end
					end)
				end,
				desc = "UV Add Package",
			},
			{ "<leader>pd", "<cmd>lua require('uv').remove_package()<cr>", desc = "UV Remove Package" },
			{ "<leader>pc", "<cmd>lua require('uv').run_command('uv sync')<cr>", desc = "UV Sync Packages" },
			{
				"<leader>pC",
				"<cmd>lua require('uv').run_command('uv sync --all-extras --all-packages --all-groups')<cr>",
				desc = "UV Sync All",
			},
		},
		opts = {
			picker_integration = true,
			keymaps = {
				prefix = "<leader>p",
			},
		},
	},
}
