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
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			telescope.load_extension("ui-select")

			local builtin = require("telescope.builtin")

			local keymap = vim.keymap.set

			-- SEARCH
			keymap("n", "<leader>f<CR>", builtin.resume, { desc = "Resume previous search" })
			keymap("n", "<leader>f'", builtin.marks, { desc = "Find marks" })
			keymap("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Find words in current buffer" })
			keymap("n", "<leader>bf", builtin.buffers, { desc = "Find buffers" })
			keymap("n", "<leader>fc", builtin.grep_string, { desc = "Find word under cursor" })
			keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			keymap("n", "<leader>fF", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end, { desc = "Find all files" })
			keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
			keymap("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
			keymap("n", "<leader>fn", "<cmd>Noice telescope<CR>", { desc = "Notification history" })
			keymap("n", "<leader>fo", builtin.oldfiles, { desc = "Find history" })
			keymap("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
			keymap("n", "<leader>fw", builtin.live_grep, { desc = "Find words" })
			-- LSP
			keymap("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document Symbols" })

			-- SPEEL SUGGEST
			keymap({ "i", "n" }, "<C-.>", builtin.spell_suggest, { desc = "Spell Suggest" })

			-- HELP
			keymap("n", "<leader>hc", builtin.commands, { desc = "Find commands" })
			keymap("n", "<leader>hm", builtin.man_pages, { desc = "Find man" })
		end,
	},
}
