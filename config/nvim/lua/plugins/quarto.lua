return {
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		cmd = {
			"QuartoActivate",
			"QuartoClosePreview",
			"QuartoHelp",
			"QuartoPreview",
			"QuartoSend",
			"QuartoSendAbove",
			"QuartoSendAll",
			"QuartoSendBelow",
			"QuartoSendLine",
		},
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>qp", "<cmd>QuartoPreview<cr>", desc = "Preview" },
			{ "<leader>qP", "<cmd>QuartoClosePreview<cr>", desc = "Close preview" },
			{ "<leader>qh", "<cmd>QuartoHelp<cr>", desc = "Help" },
			{
				"<leader>qc",
				function()
					require("quarto.runner").run_cell()
				end,
				desc = "Run cell",
			},
			{
				"<leader>qa",
				function()
					require("quarto.runner").run_above()
				end,
				desc = "Run cell and above",
			},
			{
				"<leader>qb",
				function()
					require("quarto.runner").run_below()
				end,
				desc = "Run cell and below",
			},
			{
				"<leader>qA",
				function()
					require("quarto.runner").run_all()
				end,
				desc = "Run all cells",
			},
			{
				"<leader>ql",
				function()
					require("quarto.runner").run_line()
				end,
				desc = "Run line",
			},
			{
				"<leader>qr",
				function()
					require("quarto.runner").run_range()
				end,
				desc = "Run selection",
				mode = "v",
			},
			{
				"<leader>qR",
				function()
					require("quarto.runner").run_all(true)
				end,
				desc = "Run all languages",
			},
		},
		opts = {
			closePreviewOnExit = true,
			lspFeatures = {
				enabled = true,
				chunks = "curly",
				languages = { "r", "python", "julia", "bash", "html" },
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = true,
				default_method = "slime",
				never_run = { "yaml" },
			},
		},
		config = function(_, opts)
			require("quarto").setup(opts)
			require("which-key").add({
				{ "<leader>q", group = "Quarto", icon = "󰏪" },
			})
		end,
	},
	{
		"jpalardy/vim-slime",
		ft = { "quarto", "python", "r" },
		keys = {
			{
				"<leader>qs",
				function()
					vim.fn["slime#config"]()
				end,
				desc = "Select terminal",
			},
		},
		init = function()
			vim.g.slime_target = "neovim"
			vim.g.slime_no_mappings = true
			vim.g.slime_python_ipython = 1
		end,
		config = function()
			vim.g.slime_input_pid = false
			vim.g.slime_suggest_default = true
			vim.g.slime_menu_config = false
			vim.g.slime_neovim_ignore_unlisted = true
		end,
	},
}
