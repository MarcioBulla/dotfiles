return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
			outline = {
				keys = {
					toggle_or_jump = "h",
					jump = "l",
				},
			},
		})

		-- keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>hd", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show Docstring" })
		keymap.set("n", "<leader>lc", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
		keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "Raname Variable" })
		keymap.set("n", "<leader>ld", "<cmd> Lspsaga show_line_diagnostics<CR>", { desc = "Show diagnostic line" })
		keymap.set("n", "<leader>lD", "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Show All Diagnostics" })
		keymap.set("n", "<leader>lo", "<cmd>Lspsaga outline<cr>", { desc = "Show Outline" })
		keymap.set("n", "<leader>l]", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Jump Next Error" })
		keymap.set("n", "<leader>l[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Jump Prev Error" })
		keymap.set("n", "<leader>lg", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go To Definition" })
		keymap.set("n", "<leader>lG", "<cmd>Lspsaga goto_type_definition<cr>", { desc = "Goto TYPE Definition" })
		keymap.set("n", "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Preview Definition" })
		keymap.set("n", "<leader>lP", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Preview Definition" })
	end,
}
