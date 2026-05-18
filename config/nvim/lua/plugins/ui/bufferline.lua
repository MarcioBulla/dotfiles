return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				style_preset = {
					bufferline.no_italic,
					bufferline.no_bold,
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = " NeoTree",
					},
				},
				separator_style = { "\\", "/" },
				indicator = {
					icon = "",
					style = "underline",
				},
			},
		})

		-- keymap
		vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>", { desc = "Close Current Buffer" })
		vim.keymap.set("n", "<leader>bC", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all Other Buffers" })
		vim.keymap.set("n", "<leader>b]", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
		vim.keymap.set("n", "<leader>b[", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
		vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick Buffer" })
		vim.keymap.set("n", "<leader>bP", "<cmd>BufferLinePickClose<CR>", { desc = "Close Pick Buffer" })
		vim.keymap.set("n", "<leader>b<", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Prev Buffer" })
		vim.keymap.set("n", "<leader>b>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Next Buffer" })
		vim.keymap.set("n", "<leader>bSe", "<cmd>BufferLineSortByExtension", { desc = "Sort by Extension" })
		vim.keymap.set("n", "<leader>bSd", "<cmd>BufferLineSortByDirectory", { desc = "Sort by Directory" })
		vim.keymap.set("n", "<leader>bSt", "<cmd>BufferLineSortByTabs", { desc = "Sort by Tabs" })
		vim.keymap.set(
			"n",
			"<leader>bSr",
			"<cmd>BufferLineSortByRelativeDirectory",
			{ desc = "Sort by Relative Directory" }
		)
	end,
}
