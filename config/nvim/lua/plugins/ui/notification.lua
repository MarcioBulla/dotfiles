return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		config = function()
			vim.opt.termguicolors = true

			local notify = require("notify")

			notify.setup({
				background_colour = "#000000",
				timeout = 3000,
				render = "default",
				stages = "fade_in_slide_out",
				top_down = false,
			})

			vim.notify = notify
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<leader>fn",
				"<cmd>Noice telescope<CR>",
				desc = "Noice telescope",
			},
		},
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},

			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},

			notify = {
				enabled = true,
				view = "notify",
			},

			popupmenu = {
				enabled = true,
			},

			lsp = {
				progress = {
					enabled = false,
				},
				hover = {
					enabled = true,
				},
				signature = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
	},
}
