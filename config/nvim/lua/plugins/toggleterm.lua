return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			highlights = {
				Normal = { link = "Normal" },
				NormalNC = { link = "NormalNC" },
				NormalFloat = { link = "NormalFloat" },
				FloatBorder = { link = "FloatBorder" },
				StatusLine = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLineNC" },
				WinBar = { link = "WinBar" },
				WinBarNC = { link = "WinBarNC" },
			},
			size = function(term)
				if term.direction == "horizontal" then
					return 10
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			on_create = function()
				vim.opt_local.foldcolumn = "0"
				vim.opt_local.signcolumn = "no"
			end,
			-- open_mapping = "<c-t>",
			shading_factor = 2,
			direction = "float",
			float_opts = { border = "rounded" },
			close_on_exit = true,
		})

		-- keymap

		local keymap = vim.keymap

		local terminals = {}
		local term_count = 0

		-- Function to generate automatic terminal name
		local function generate_terminal_name(direction)
			local prefix = {
				horizontal = "H",
				vertical = "V",
				float = "F",
				tab = "T",
			}
			return string.format("%s-term-%d", prefix[direction] or "term", term_count + 1)
		end

		-- Improved toggle_term function
		local function toggle_term(direction, size)
			vim.ui.input({
				prompt = "Name (Enter for auto): ",
				default = "",
			}, function(term_name)
				if term_name == nil then
					-- User cancelled
					return
				end

				if term_name == "" then
					-- Auto-generate name
					term_count = term_count + 1
					term_name = generate_terminal_name(direction)
					terminals[term_name] = term_count

					local command = string.format(
						"%dToggleTerm direction=%s size=%s name=%s",
						term_count,
						direction,
						size and size or "",
						term_name
					)

					vim.notify("Terminal created: " .. term_name)
					vim.cmd(command)
				else
					-- User provided name
					if not terminals[term_name] then
						term_count = term_count + 1
						terminals[term_name] = term_count
					end

					local term_id = terminals[term_name]
					local command = string.format(
						"%dToggleTerm direction=%s size=%s name=%s",
						term_id,
						direction,
						size and size or "",
						term_name
					)

					vim.notify("Executing command: " .. command)
					vim.cmd(command)
				end
			end)
		end

		-- Function to list active terminals
		local function list_terminals()
			local active_terms = {}
			for name, id in pairs(terminals) do
				table.insert(active_terms, string.format("%s (ID: %d)", name, id))
			end

			if #active_terms == 0 then
				vim.notify("No named terminals active")
			else
				vim.notify("Active terminals:\n" .. table.concat(active_terms, "\n"))
			end
		end

		keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Show/Hide All ToggleTerms" })
		keymap.set("n", "<leader>tN", "<cmd>ToggleTermSetName<cr>", { desc = "Set ToggleTerm name" })
		keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "Select ToggleTerm" })
		keymap.set("n", "<leader>tl", list_terminals, { desc = "List active terminals" })
		keymap.set("n", "<leader>tv", function()
			toggle_term("vertical", 80)
		end, { desc = "ToggleTerm vertical split" })
		keymap.set("n", "<leader>th", function()
			toggle_term("horizontal", 10)
		end, { desc = "ToggleTerm horizontal split" })
		keymap.set("n", "<leader>tf", function()
			toggle_term("float")
		end, { desc = "ToggleTerm float split" })
		keymap.set("n", "<leader>tt", function()
			toggle_term("tab")
		end, { desc = "ToggleTerm tab split" })

		keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Back to normal mode" })

		-- Python
		local function python(direction, size)
			vim.cmd("w")

			local current_file = vim.fn.expand("%:p")

			if vim.fn.filereadable(current_file) == 0 then
				vim.notify("File not found!", vim.log.levels.ERROR)
				return
			end

			local term_name = "Python-" .. vim.fn.expand("%:t")

			local command = string.format(
				"TermExec name=%s direction=%s size=%s close_on_exit=true cmd='python \"%s\"'",
				term_name,
				direction,
				size and size or "",
				current_file
			)

			vim.cmd(command)
		end

		keymap.set("n", "<leader>pf", function()
			python("float")
		end, { desc = "Run Python Float" })
		keymap.set("n", "<leader>ph", function()
			python("horizontal")
		end, { desc = "Run Python Horizontal" })
		keymap.set("n", "<leader>pv", function()
			python("vertical", 60)
		end, { desc = "Run Python Vertical" })

		-- Zig
		local function zig(action, direction, size)
			vim.cmd("w")

			local current_file = vim.fn.expand("%:p")

			if vim.fn.filereadable(current_file) == 0 then
				vim.notify("File not found!", vim.log.levels.ERROR)
				return
			end

			local cmd
			if action == "build" or current_file == nil or current_file == "" then
				cmd = ("zig %s"):format(action)
			else
				cmd = ('zig %s "%s"'):format(action, current_file)
			end
			local term_name = string.format("Zig-%s", action)

			local command = string.format(
				"TermExec name=%s direction=%s size=%s close_on_exit=true cmd='%s'",
				term_name,
				direction,
				size and size or "",
				cmd
			)

			vim.cmd(command)
		end

		keymap.set("n", "<leader>zr", function()
			zig("run", "float")
		end, { desc = "Run Zig Float" })
		keymap.set("n", "<leader>zb", function()
			zig("build", "float")
		end, { desc = "Build Zig Float" })
		keymap.set("n", "<leader>zt", function()
			zig("test", "float")
		end, { desc = "Test Zig Float" })
		keymap.set("n", "<leader>zh", function()
			zig("build", "horizontal")
		end, { desc = "Build Zig Horizontal" })
		keymap.set("n", "<leader>zv", function()
			zig("build", "vertical", 60)
		end, { desc = "Build Zig Vertical" })
	end,
}
