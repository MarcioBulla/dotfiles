return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.fixjson,
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.yamlfix,
        null_ls.builtins.diagnostics.yamllint,
      },
    })
  end,
}
