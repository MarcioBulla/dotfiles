return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵",
				},
			},
		})
		local neotree = require("neo-tree")

		neotree.setup({
			close_if_last_window = true,
			source_selector = {
				winbar = true,
			},
			default_component_configs = {

				git_status = {
					symbols = {
						added = "󱪝 ",
						modified = "󰷈 ",
						deleted = "󱪟 ",
						renamed = "󱔗 ",
						untracked = "★ ",
						ignored = "󰘓 ",
						unstaged = "✗ ",
						staged = "✓ ",
						conflict = " ",
					},
				},
				modified = {
					symbol = "●",
					highlight = "NeoTreeModified",
				},
			},
			window = {
				width = 40,
				position = "right",
			},
		})

		-- set keymaps
		local keymap = vim.keymap
		local neo_tree = require("neo-tree.command")

		keymap.set("n", "<leader>e", function()
			neo_tree.execute({
				revel = true,
				toggle = true,
			})
		end, { desc = "Toggle NeoTree" })

		keymap.set("n", "<leader>o", function()
			if vim.bo.filetype == "neo-tree" then
				vim.cmd.wincmd("p")
			else
				vim.cmd.Neotree("focus")
			end
		end, { desc = "Focus Neotree" })
	end,
}
