return {
	{
		"fedepujol/move.nvim",
		config = function()
			require("move").setup({})
			local opts = { noremap = true, silent = true }

			vim.keymap.set({ "n", "i" }, "<A-Down>", "<cmd>MoveLine(1)<CR>", opts)
			vim.keymap.set({ "n", "i" }, "<A-Up>", "<cmd>MoveLine(-1)<CR>", opts)
			vim.keymap.set({ "n", "i" }, "<A-Left>", "<cmd>MoveWord(-1)<CR>", opts)
			vim.keymap.set({ "n", "i" }, "<A-Right>", "<cmd>MoveWord(1)<CR>", opts)

			vim.keymap.set("v", "<A-Down>", ":MoveBlock(1)<CR>", opts)
			vim.keymap.set("v", "<A-Up>", ":MoveBlock(-1)<CR>", opts)
		end,
	},
}
