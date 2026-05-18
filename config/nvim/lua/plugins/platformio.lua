return {
	"anurag3301/nvim-platformio.lua",
	dependencies = {
		"akinsho/nvim-toggleterm.lua",
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- keymaps

		vim.keymap.set("n", "<leader>Pi", "<CMD>Pioinit<CR>", { desc = "Init Project" })
		vim.keymap.set("n", "<leader>Pg", "<CMD>Piocmd run -t compiledb<CR>", { desc = "Gen Compiledb" })
		vim.keymap.set("n", "<leader>Pu", "<CMD>Piorun upload<CR>", { desc = "Uploard" })
		vim.keymap.set("n", "<leader>Pb", "<CMD>Piorun build<CR>", { desc = "Build" })
		vim.keymap.set("n", "<leader>Pr", "<CMD>Piorun<CR>", { desc = "Build and Upload" })
		vim.keymap.set("n", "<leader>Pc", "<CMD>Piorun clean<CR>", { desc = "Clean" })
		vim.keymap.set("n", "<leader>Pm", "<CMD>Piomon<CR>", { desc = "Monitor" })
		vim.keymap.set("n", "<leader>Pd", "<CMD>Piodebug<CR>", { desc = "Debug" })
		vim.keymap.set("n", "<leader>PM", function()
			_G.execute_command("Piomon", "Baudrate: ", true)
		end, { desc = "Custom Baudrate Monitor" })
		vim.keymap.set("n", "<leader>Pl", function()
			_G.execute_command("Piolib", "Library Name: ", false)
		end, { desc = "Install Library" })
		vim.keymap.set("n", "<leader>PC", function()
			_G.execute_command("Piocmd", "PlatformIO Command: ", false)
		end, { desc = "PlatformIO commands" })
	end,
}
