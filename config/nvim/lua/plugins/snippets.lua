return {
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			ls.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
