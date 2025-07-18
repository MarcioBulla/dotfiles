return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local lspconfig = require("lspconfig")
		local esp32 = require("esp32")

		-- clangd for ESP32
		lspconfig.clangd.setup(esp32.lsp_config())

		-- hyprls
		lspconfig.hyprls.setup({
			cmd = { os.getenv("HOME") .. "/go/bin/hyprls" },
		})

		-- ltex-ls-plus
		lspconfig.ltex.setup({
			cmd = { "ltex-ls-plus" },
			filetypes = { "markdown", "text" },
			flags = { debounce_text_changes = 300 },
			settings = {
				ltex = {},
			},
			on_attach = function(client, bufnr)
				require("ltex-utils").on_attach(bufnr)
			end,
		})
	end,
}
