return {
	"anurag3301/nvim-platformio.lua",
	cmd = {
		"Pioinit",
		"PioLSP",
		"Piorun",
		"Piomon",
		"Piolsserial",
		"Piolib",
		"Piocmdh",
		"Piocmdf",
		"Piodebug",
		"PioTermList",
	},
	dependencies = {
		"akinsho/nvim-toggleterm.lua",
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>Pi", "<CMD>Pioinit<CR>", desc = "Init Project" },
		{ "<leader>Pg", "<CMD>Piocmdf run -t compiledb<CR>", desc = "Gen Compiledb" },
		{ "<leader>Pu", "<CMD>Piorun upload<CR>", desc = "Upload" },
		{ "<leader>Pb", "<CMD>Piorun build<CR>", desc = "Build" },
		{ "<leader>Pr", "<CMD>Piorun<CR>", desc = "Build and Upload" },
		{ "<leader>Pc", "<CMD>Piorun clean<CR>", desc = "Clean" },
		{ "<leader>Pm", "<CMD>Piomon<CR>", desc = "Monitor" },
		{ "<leader>Pd", "<CMD>Piodebug<CR>", desc = "Debug" },
		{
			"<leader>PM",
			function()
				vim.ui.input({ prompt = "Baudrate: " }, function(input)
					if input and input ~= "" then
						vim.cmd("Piomon " .. input)
					end
				end)
			end,
			desc = "Custom Baudrate Monitor",
		},
		{
			"<leader>Pl",
			function()
				vim.ui.input({ prompt = "Library Name: " }, function(input)
					if input and input ~= "" then
						vim.cmd("Piolib " .. input)
					end
				end)
			end,
			desc = "Install Library",
		},
		{
			"<leader>PC",
			function()
				vim.ui.input({ prompt = "PlatformIO Command: " }, function(input)
					if input and input ~= "" then
						vim.cmd("Piocmdf " .. input)
					end
				end)
			end,
			desc = "PlatformIO commands",
		},
	},
}
