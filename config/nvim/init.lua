require("config.keymaps")
require("config.vim-configs")
require("config.lazy")
require('theme.matugen').setup()

vim.lsp.enable({ "zls", "ltex", "texlab", "clangd", "pyright", "lua_ls", "bashls" })
