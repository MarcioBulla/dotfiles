return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      cmd = {
        os.getenv("HOME") .. "/.espressif/tools/esp-clang/15.0.0-23786128ae/esp-clang/bin/clangd",
        "--offset-encoding=utf-16",
      },
      capabilities = capabilities,
    })
  end,
}
