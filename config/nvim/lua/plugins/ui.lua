return {

	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("e", "󱪝 New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("<leader> f f", "󰈞 Find File"),
				dashboard.button("<leader> f o", " Recents"),
				dashboard.button("<leader> f w", "󰺮 Find Word"),
				dashboard.button("<leader> f '", " Bookmarks"),
				dashboard.button("<leader> S l", " Last Session"),
				dashboard.button("q", "󰗼 Exit", ":qa <CR>"),
			}

			alpha.setup(dashboard.opts)
		end,
	},
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			opts = {
				icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		config = function()
			require("toggleterm").setup({
				highlights = {
					Normal = { link = "Normal" },
					NormalNC = { link = "NormalNC" },
					NormalFloat = { link = "NormalFloat" },
					FloatBorder = { link = "FloatBorder" },
					StatusLine = { link = "StatusLine" },
					StatusLineNC = { link = "StatusLineNC" },
					WinBar = { link = "WinBar" },
					WinBarNC = { link = "WinBarNC" },
				},
				size = 10,
				on_create = function()
					vim.opt.foldcolumn = "0"
					vim.opt.signcolumn = "no"
				end,
				open_mapping = [[<F7>]],
				shading_factor = 2,
				direction = "float",
				float_opts = { border = "rounded" },
			})
		end,
	},
}
