return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	opts = {
		automatic_installation = true,
	},
	config = function()
		local mason = require("mason")
		local mason_lsp = require("mason-lspconfig")
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason.setup()
		mason_lsp.setup()

		for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
			if server_name == "rust_analyzer" then
				require("rust-tools").setup({})
			else
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end
		end

		vim.cmd.colorscheme("catppuccin")
	end,
}
