return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      cmd = {
        os.getenv("HOME") .. "/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
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
