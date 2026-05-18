require("config.keymaps")
require("config.vim-configs")
require("config.lazy")

vim.lsp.enable({ "zls", "ltex_local", "clangd", "pyright", "lua_ls", "hyprls", "bashls" })
