return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  opts = {
    auto_install = true,
  },
  config = function()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")

    mason.setup()
    mason_lsp.setup()

    mason_lsp.setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities =  require('cmp_nvim_lsp').default_capabilities(),
        })
      end,
      ["rust_analyzer"] = function()
        require("rust-tools").setup {}
      end
    }
    vim.cmd.colorscheme("catppuccin")
  end
}
