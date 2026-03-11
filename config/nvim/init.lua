require('config.keymaps')
require('config.vim-configs')
require('config.lazy')

vim.lsp.enable({ "zls", "ltex", "stylua", "clangd", "pyright" })
