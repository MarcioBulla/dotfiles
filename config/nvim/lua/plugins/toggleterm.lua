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
		local Terminal = require("toggleterm.terminal").Terminal

		local terminals = {}
		local term_count = 0
		local idf_initialized = false
		local idf_term = Terminal:new({
			direction = "float",
			display_name = "ESP-IDF",
			close_on_exit = false,
			hidden = false,
		})

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

		local function shellescape(cmd)
			return vim.fn.shellescape(cmd)
		end

		local function get_project_root()
			return vim.loop.cwd()
		end

		local function send_to_idf_terminal(command)
			local root = get_project_root()
			local commands = {
				"cd " .. shellescape(root),
			}

			if not idf_initialized then
				table.insert(commands, "get_idf")
				idf_initialized = true
			end

			if command and command ~= "" then
				table.insert(commands, command)
			end

			idf_term:open()
			idf_term:send(table.concat(commands, "\n"), false)
		end

		local function idf(command)
			send_to_idf_terminal(command)
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

		keymap.set("n", "<leader>Ei", function()
			idf("")
		end, { desc = "ESP-IDF init terminal" })
		keymap.set("n", "<leader>Eb", function()
			idf("idf.py build")
		end, { desc = "ESP-IDF build" })
		keymap.set("n", "<leader>Ef", function()
			idf("idf.py flash")
		end, { desc = "ESP-IDF flash" })
		keymap.set("n", "<leader>Em", function()
			idf("idf.py monitor")
		end, { desc = "ESP-IDF monitor" })
		keymap.set("n", "<leader>Er", function()
			idf("idf.py reconfigure")
		end, { desc = "ESP-IDF reconfigure" })
		keymap.set("n", "<leader>Ec", function()
			idf("idf.py fullclean")
		end, { desc = "ESP-IDF fullclean" })
		keymap.set("n", "<leader>Es", function()
			vim.ui.input({ prompt = "ESP target: " }, function(target)
				if not target or target == "" then
					return
				end

				idf("idf.py set-target " .. target)
			end)
		end, { desc = "ESP-IDF set target" })
		keymap.set("n", "<leader>EE", function()
			vim.ui.input({ prompt = "ESP-IDF command: ", default = "idf.py " }, function(command)
				if not command or command == "" then
					return
				end

				idf(command)
			end)
		end, { desc = "ESP-IDF custom command" })

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
	end,
}
