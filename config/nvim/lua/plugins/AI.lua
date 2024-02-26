return {
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			search_engine = "duck_duck_go",
			openai_api_key = "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",
			openai_model_id = "gpt-3.5-turbo",
		},
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}
