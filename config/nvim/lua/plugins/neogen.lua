return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({})

		vim.keymap.set("n", "<leader>Na", "<cmd>Neogen type<CR>")
		vim.keymap.set("n", "<leader>Nt", "<cmd>Neogen func<CR>")
		vim.keymap.set("n", "<leader>Nf", "<cmd>Neogen class<CR>")
		vim.keymap.set("n", "<leader>Nc", "<cmd>Neogen file<CR>")
	end,
}
