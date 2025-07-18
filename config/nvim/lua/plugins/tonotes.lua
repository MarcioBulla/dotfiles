return {
	{
		"brymer-meneses/grammar-guard.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = vim.fn.expand("~") .. "/MyNotes/vaults",
				},
				{
					name = "quartz",
					path = vim.fn.expand("~") .. "/MyNotes/content",
				},
			},
			completion = {
				nvim_cmp = true,
			},

			mappings = {
				["<leader>Og"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true, desc = "Obsidian: Goto File" },
				},
				["<leader>Oc"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true, desc = "Obsidian: Toggle Checkbox" },
				},
				["<leader>O<CR>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true, desc = "Obsidian: Smart Action" },
				},

				["<leader>Oo"] = {
					action = function()
						vim.cmd("ObsidianOpen")
					end,
					opts = { desc = "Obsidian: Open" },
				},
				["<leader>On"] = {
					action = function()
						vim.cmd("ObsidianNew")
					end,
					opts = { desc = "Obsidian: New Note" },
				},
				["<leader>Oq"] = {
					action = function()
						vim.cmd("ObsidianQuickSwitch")
					end,
					opts = { desc = "Obsidian: Quick Switch" },
				},
				["<leader>Ol"] = {
					action = function()
						vim.cmd("ObsidianFollowLink")
					end,
					opts = { desc = "Obsidian: Follow Link" },
				},
				["<leader>Ov"] = {
					action = function()
						vim.cmd("ObsidianFollowLink vsplit")
					end,
					opts = { desc = "Obsidian: Follow Link (vsplit)" },
				},
				["<leader>Oh"] = {
					action = function()
						vim.cmd("ObsidianFollowLink hsplit")
					end,
					opts = { desc = "Obsidian: Follow Link (hsplit)" },
				},
				["<leader>Ob"] = {
					action = function()
						vim.cmd("ObsidianBacklinks")
					end,
					opts = { desc = "Obsidian: Backlinks" },
				},
				["<leader>Ot"] = {
					action = function()
						vim.cmd("ObsidianTags")
					end,
					opts = { desc = "Obsidian: Tags" },
				},
				["<leader>Od"] = {
					action = function()
						vim.cmd("ObsidianToday")
					end,
					opts = { desc = "Obsidian: Today" },
				},
				["<leader>Oy"] = {
					action = function()
						vim.cmd("ObsidianYesterday")
					end,
					opts = { desc = "Obsidian: Yesterday" },
				},
				["<leader>Om"] = {
					action = function()
						vim.cmd("ObsidianTomorrow")
					end,
					opts = { desc = "Obsidian: Tomorrow" },
				},
				["<leader>OA"] = {
					action = function()
						vim.cmd("ObsidianDailies")
					end,
					opts = { desc = "Obsidian: Dailies" },
				},
				["<leader>OT"] = {
					action = function()
						vim.cmd("ObsidianTemplate")
					end,
					opts = { desc = "Obsidian: Insert Template" },
				},
				["<leader>OS"] = {
					action = function()
						vim.cmd("ObsidianSearch")
					end,
					opts = { desc = "Obsidian: Search" },
				},
				["<leader>OL"] = {
					action = function()
						vim.cmd("ObsidianLink")
					end,
					opts = { desc = "Obsidian: Link" },
				},
				["<leader>Oe"] = {
					action = function()
						vim.cmd("ObsidianLinkNew")
					end,
					opts = { desc = "Obsidian: Link New" },
				},
				["<leader>Ox"] = {
					action = function()
						vim.cmd("ObsidianLinks")
					end,
					opts = { desc = "Obsidian: Show Links" },
				},
				["<leader>OE"] = {
					action = function()
						vim.cmd("ObsidianExtractNote")
					end,
					opts = { desc = "Obsidian: Extract Note" },
				},
				["<leader>Ow"] = {
					action = function()
						vim.cmd("ObsidianWorkspace")
					end,
					opts = { desc = "Obsidian: Switch Workspace" },
				},
				["<leader>Oi"] = {
					action = function()
						vim.cmd("ObsidianPasteImg")
					end,
					opts = { desc = "Obsidian: Paste Image" },
				},
				["<leader>OR"] = {
					action = function()
						vim.cmd("ObsidianRename")
					end,
					opts = { desc = "Obsidian: Rename Note" },
				},
				["<leader>ON"] = {
					action = function()
						vim.cmd("ObsidianNewFromTemplate")
					end,
					opts = { desc = "Obsidian: New from Template" },
				},
				["<leader>OC"] = {
					action = function()
						vim.cmd("ObsidianTOC")
					end,
					opts = { desc = "Obsidian: Table of Contents" },
				},
			},
		},
	},
}
