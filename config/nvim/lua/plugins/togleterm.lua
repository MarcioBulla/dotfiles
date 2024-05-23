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
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = { border = "rounded" },
		})

		-- keymap

		local keymap = vim.keymap

		local function toggle_term(direction, size)
			vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
				if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
					local command = string.format(
						"%sToggleTerm direction=%s %s",
						number_term,
						direction,
						size and ("size=" .. size) or ""
					)
					vim.cmd(command)
				else
					local error_message = string.format("<%s> is an Invalid Input!!", number_term)
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

		keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal left window navigation" })
		keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal down window navigation" })
		keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal up window navigation" })
		keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal right window navigation" })
		keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Back to normal mode" })
	end,
}
