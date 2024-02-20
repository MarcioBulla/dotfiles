local wk = require("which-key")
local wtf = require("wtf")

-- LSP SIGNATURE

vim.keymap.set({ "i" }, "<C-,>", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

-- SPELL SUGGEST
vim.keymap.set("i", "<C-.>", "<cmd>:Telescope spell_suggest<CR>", { desc = "Spell Suggest" })
vim.keymap.set("n", "<C-.>", "<cmd>:Telescope spell_suggest<CR>", { desc = "Spell Suggest" })

wk.register({
	["<leader>"] = {
		h = {
			name = "󱜸 Help Code",

			-- WTF
			c = {
				function()
					wtf.ai()
				end,
				"Debug diagnostic with AI",
			},
			s = {
				function()
					wtf.search()
				end,
				"Search diagnostic witch DuckDuckGo",
			},

			--LSPSAGA
			d = {
				"<cmd>Lspsaga hover_doc<cr>",
				"Show Docstring",
			},
		},

		-- NEO-TREE
		e = { ":Neotree toggle reveal left<CR>", "Toggle NeoTree" },
		o = {
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			"Focus Neotree",
		},

		-- COMMENTS
		["/"] = {
			{
				mode = "n",
				function()
					require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
				end,
				"Toggle comment line",
			},
			{
				mode = "v",
				"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				"Toggle comment for selection",
			},
		},

		-- TELESCOPE
		f = {
			name = " Telescope",
			i = {
				"<cmd>Nerdy<cr>",
				"Find Icon Nerd Font",
			},
			["<CR>"] = {
				function()
					require("telescope.builtin").resume()
				end,
				"Resume previous search",
			},
			["'"] = {
				function()
					require("telescope.builtin").marks()
				end,
				"Find marks",
			},
			["/"] = {
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				"Find words in current buffer",
			},
			b = {
				function()
					require("telescope.builtin").buffers()
				end,
				"Find buffers",
			},
			c = {
				function()
					require("telescope.builtin").grep_string()
				end,
				"Find word under cursor",
			},
			C = {
				function()
					require("telescope.builtin").commands()
				end,
				"Find commands",
			},
			f = {
				function()
					require("telescope.builtin").find_files()
				end,
				"Find files",
			},
			F = {
				function()
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
				end,
				"Find all files",
			},
			h = {
				function()
					require("telescope.builtin").help_tags()
				end,
				"Find help",
			},
			k = {
				function()
					require("telescope.builtin").keymaps()
				end,
				"Find keymaps",
			},
			m = {
				function()
					require("telescope.builtin").man_pages()
				end,
				"Find man",
			},
			o = {
				function()
					require("telescope.builtin").oldfiles()
				end,
				"Find history",
			},
			r = {
				function()
					require("telescope.builtin").registers()
				end,
				"Find registers",
			},
			w = {
				function()
					require("telescope.builtin").live_grep()
				end,
				"Find words",
			},
			W = {
				function()
					require("telescope.builtin").live_grep({
						additional_args = function(args)
							return vim.list_extend(args, { "--hidden", "--no-ignore" })
						end,
					})
				end,
				"Find words in all files",
			},
			n = {
				function()
					require("telescope").extensions.notify.notify()
				end,
				"Find Notify",
			},
		},

		-- BUFFERLINE
		b = {
			name = " BufferLine",
			c = { ":bdelete<CR>", "Close Current Buffer" },
			C = { ":BufferLineCloseOthers<CR>", "Close all Other Buffers" },
			["]"] = { ":BufferLineCycleNext<CR>", "Next Buffer" },
			["["] = { ":BufferLineCyclePrev<CR>", "Prev Buffer" },
			p = { ":BufferLinePick<CR>", "Pick Buffer" },
			P = { ":BufferLinePickClose<CR>", "Close Pick Buffer" },
			["<"] = { ":BufferLineMovePrev<CR>", "Move Prev Buffer" },
			[">"] = { ":BufferLineMoveNext<CR>", "Move Next Buffer" },
		},

		-- LSP
		l = {
			name = " LSP",
			f = { vim.lsp.buf.format, "Formatting" },
			c = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
			r = { "<cmd>Lspsaga rename<cr>", "Rename Variable" },
			s = {
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				"Search symbols",
			},
      d = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Show Diagnostic line"},
      D = {"<cmd>Lspsaga show_workspace_diagnostics<cr>", "Show All Diagnostics"},
      o = {"<cmd>Lspsaga outline<cr>", "Show Outline"},
      ["]"] = {"<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump Next Error"},
      ["["] = {"<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump Prev Error"},
      g = {"<cmd>Lspsaga goto_definition<cr>", "Go To Definition"},
      G = {"<cmd>Lspsaga goto_type_definition<cr>", "Goto TYPE Definition"},
      p = {"<cmd>Lspsaga peek_definition<cr>", "Preview Definition"},
      P = {"<cmd>Lspsaga peek_type_definition<cr>", "Preview Definition"},
		},

		-- NEOGEN
		N = {
			name = "󰅽 Auto Docstring",
			a = { "<cmd>Neogen<cr>", "Automatic" },
			t = { "<cmd>Neogen type<cr>", "Type" },
			f = { "<cmd>Neogen func<cr>", "Function" },
			c = { "<cmd>Neogen class<cr>", "Class" },
			F = { "<cmd>Neogen file<cr>", "File" },
		},
	},

	-- TOGGLETERM
	t = {
		name = " ToggleTerms",
		a = { "<cmd>ToggleTermToggleAll<cr>", "Show/Hide All ToggleTerms" },
		N = { "<cmd>ToggleTermSetName<cr>", "Set ToggleTerm name" },
		s = { "<cmd>TermSelect<cr>", "Select ToggleTerm" },
		v = {
			function()
				vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
					if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
						local command =
							string.format("%sToggleTerm direction=vertical size=80 direction=vertical", number_term)
						vim.cmd(command)
					else
						local error_message = string.format("<%s> is a Invalid Input!!", number_term)
						vim.api.nvim_err_writeln(error_message)
					end
				end)
			end,
			"ToggleTerm vertical split",
		},

		h = {
			function()
				vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
					if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
						local command = string.format("%sToggleTerm direction=horizontal size=10", number_term)
						vim.cmd(command)
					else
						local error_message = string.format("<%s> is a Invalid Input!!", number_term)
						vim.api.nvim_err_writeln(error_message)
					end
				end)
			end,
			"ToggleTerm horizontal split",
		},
		f = {
			function()
				vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
					if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
						local command = string.format("%sToggleTerm direction=float", number_term)
						vim.cmd(command)
					else
						local error_message = string.format("<%s> is a Invalid Input!!", number_term)
						vim.api.nvim_err_writeln(error_message)
					end
				end)
			end,
			"ToggleTerm float split",
		},
	},
	-- Improved Terminal Navigation
	["<C-h>"] = { mode = "t", "<cmd>wincmd h<cr>", "Terminal left window navigation" },
	["<C-j>"] = { mode = "t", "<cmd>wincmd j<cr>", "Terminal down window navigation" },
	["<C-k>"] = { mode = "t", "<cmd>wincmd k<cr>", "Terminal up window navigation" },
	["<C-l>"] = { mode = "t", "<cmd>wincmd l<cr>", "Terminal right window navigation" },
	["<esc>"] = { mode = "t", "<C-\\><C-n>", "Back to normal mode" },

	-- INDENT
	["<S-Tab>"] = { mode = "v", "<gv", "Unindent line" },
	["<Tab>"] = { mode = "v", ">gv", "Indent line" },

	-- SMART SPLITS
	["<C-h>"] = {
		function()
			require("smart-splits").move_cursor_left()
		end,
		"Move to left split",
	},
	["<C-j>"] = {
		function()
			require("smart-splits").move_cursor_down()
		end,
		"Move to below split",
	},
	["<C-k>"] = {
		function()
			require("smart-splits").move_cursor_up()
		end,
		"Move to above split",
	},
	["<C-l>"] = {
		function()
			require("smart-splits").move_cursor_right()
		end,
		"Move to right split",
	},
	["<C-Up>"] = {
		function()
			require("smart-splits").resize_up()
		end,
		"Resize split up",
	},
	["<C-Down>"] = {
		function()
			require("smart-splits").resize_down()
		end,
		"Resize split down",
	},
	["<C-Left>"] = {
		function()
			require("smart-splits").resize_left()
		end,
		"Resize split left",
	},
	["<C-Right>"] = {
		function()
			require("smart-splits").resize_right()
		end,
		"Resize split right",
	},
})
