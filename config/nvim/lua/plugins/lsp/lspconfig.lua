return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      cmd = {
       os.getenv("HOME") ..  "/.espressif/tools/esp-clang/16.0.1-fe4f10a809/esp-clang/bin/clangd"
      },
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
