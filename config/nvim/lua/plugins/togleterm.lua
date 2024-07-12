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
			size = 10,
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
			open_mapping = "<c-t>",
			shading_factor = 2,
			direction = "float",
			float_opts = { border = "rounded" },
			close_on_exit = true,
		})

		-- keymap

		local keymap = vim.keymap

		local terminals = {}
		local term_count = 0

		local function toggle_term(direction, size)
			vim.ui.input({ prompt = "Name: " }, function(term_name)
				if term_name and term_name ~= "" then
					if not terminals[term_name] then
						-- Increment the terminal count and assign the new ID to this terminal name
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
					-- Print the command in notifications
					vim.notify("Executing command: " .. command)
					vim.cmd(command)
				else
					local error_message = string.format("<%s> Invalid Name!!", term_name)
					vim.api.nvim_err_writeln(error_message)
				end
			end)
		end

		keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Show/Hide All ToggleTerms" })
		keymap.set("n", "<leader>tN", "<cmd>ToggleTermSetName<cr>", { desc = "Set ToggleTerm name" })
		keymap.set("n", "<leader>ts", "<cmd>TermSelect<cr>", { desc = "Select ToggleTerm" })
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

			local command = string.format(
				"TermExec name=Python direction=%s size=%s close_on_exit=true cmd='python \"%s\"'",
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
			local cmd = string.format('zig %s "%s"', action, current_file)

			local command = string.format(
				"TermExec name=Zig direction=%s size=%s close_on_exit=true cmd='%s'",
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
