return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      cmd = {
        "clangd",
        "--compile-commands-dir=build"
      },
      init_options = {},
      on_attach = on_attach,
      capabilities = capabilities,
    })
		lspconfig.hyprls.setup({
			cmd = {
				os.getenv("HOME") .. "/go/bin/hyprls",
			},
			capabilities = capabilities,
		})
	end,
}
