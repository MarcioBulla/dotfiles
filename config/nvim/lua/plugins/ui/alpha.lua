return {
	"goolord/alpha-nvim",
	events = "LazyVimStarted",
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
			dashboard.button("<leader> S", " Last Session"),
			dashboard.button("q", "󰗼 Exit", ":qa <CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
