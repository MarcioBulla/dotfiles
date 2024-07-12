return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({})

		vim.keymap.set(
			"n",
			"<leader>/",
			"<cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<CR>",
			{ desc = " Toggle comment line" }
		)
		vim.keymap.set(
			"v",
			"<leader>/",
			"<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			{ desc = " Toggle comment for selection" }
		)
	end,

	lazy = false,
}
