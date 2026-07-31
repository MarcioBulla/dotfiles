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

			local function ltex_code_action(retries)
				retries = retries or 10

				local client = vim.lsp.get_clients({ bufnr = 0, name = "ltex" })[1]
					or vim.lsp.get_clients({ bufnr = 0, name = "ltex_plus" })[1]

				if not client then
					if retries > 0 then
						vim.defer_fn(function()
							ltex_code_action(retries - 1)
						end, 100)
						return
					end

					vim.notify("LTeX is not attached to this buffer", vim.log.levels.WARN)
					return
				end

				local line = vim.api.nvim_win_get_cursor(0)[1] - 1
				local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
				params.context = {
					diagnostics = vim.diagnostic.get(0, { lnum = line }),
				}

				client:request("textDocument/codeAction", params, function(err, result)
					if err then
						vim.notify(err.message or tostring(err), vim.log.levels.ERROR)
						return
					end

					if not result or vim.tbl_isempty(result) then
						vim.notify("No LanguageTool suggestions", vim.log.levels.INFO)
						return
					end

					vim.ui.select(result, {
						prompt = "LanguageTool suggestions",
						format_item = function(action)
							return action.title
						end,
					}, function(action)
						if not action then
							return
						end

						if action.edit then
							vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
						end

						if action.command then
							vim.lsp.buf.execute_command(action.command)
						end
					end)
				end, 0)
			end

			-- LSP SUGGEST
			keymap({ "i", "n" }, "<C-.>", ltex_code_action, { desc = "LanguageTool suggestions" })

			-- HELP
			keymap("n", "<leader>hc", builtin.commands, { desc = "Find commands" })
			keymap("n", "<leader>hm", builtin.man_pages, { desc = "Find man" })
		end,
	},
}
