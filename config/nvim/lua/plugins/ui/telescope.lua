return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = false,
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")

			local telescope = require("telescope.builtin")

			local keymap = vim.keymap.set

			-- SEARCH
			keymap("n", "<leader>f<CR>", telescope.resume, { desc = "Resume previous search" })
			keymap("n", "<leader>f'", telescope.marks, { desc = "Find marks" })
			keymap("n", "<leader>f/", telescope.current_buffer_fuzzy_find, { desc = "Find words in current buffer" })
			keymap("n", "<leader>bf", telescope.buffers, { desc = "Find buffers" })
			keymap("n", "<leader>fc", telescope.grep_string, { desc = "Find word under cursor" })
			keymap("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
			keymap("n", "<leader>fF", function()
				telescope.find_files({ hidden = true, no_ignore = true })
			end, { desc = "Find all files" })
			keymap("n", "<leader>fh", telescope.help_tags, { desc = "Find help" })
			keymap("n", "<leader>fk", telescope.keymaps, { desc = "Find keymaps" })
			keymap("n", "<leader>fn", "<cmd>Noice telescope<CR>", { desc = "Noice telescope" })
			keymap("n", "<leader>fo", telescope.oldfiles, { desc = "Find history" })
			keymap("n", "<leader>fr", telescope.registers, { desc = "Find registers" })
			keymap("n", "<leader>fw", telescope.live_grep, { desc = "Find words" })
			-- LSP
			keymap("n", "<leader>ls", telescope.lsp_document_symbols, { desc = "Document Symbols" })

			-- SPEEL SUGGEST
			keymap({ "i", "n" }, "<C-.>", telescope.spell_suggest, { desc = "Spell Suggest" })

			-- HELP
			keymap("n", "<leader>hc", telescope.commands, { desc = "Find commands" })
			keymap("n", "<leader>hm", telescope.man_pages, { desc = "Find man" })
		end,
	},
}
