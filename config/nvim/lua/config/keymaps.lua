vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

-- Indentation
keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent line" })
keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent line" })
keymap.set("n", "<C-o>", "o<Esc>", { noremap = true, silent = true, desc = "Create empty line below" })

-- Open workspace diagnostics in the quickfix list
local function open_workspace_diagnostics()
  vim.diagnostic.setqflist({ open = true })
end

-- Show document symbols
local function open_document_symbols()
  vim.lsp.buf.document_symbol()
end

-- Show workspace symbols
local function open_workspace_symbols()
  vim.lsp.buf.workspace_symbol("")
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(args)
    local bufnr = args.buf

    local function opts(desc)
      return { buffer = bufnr, noremap = true, silent = true, desc = desc }
    end

    -- Navigation and information
    keymap.set("n", "gd", vim.lsp.buf.definition, opts("LSP: Go to definition"))
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts("LSP: Go to declaration"))
    keymap.set("n", "gI", vim.lsp.buf.implementation, opts("LSP: Go to implementation"))
    keymap.set("n", "gy", vim.lsp.buf.type_definition, opts("LSP: Go to type definition"))
    keymap.set("n", "gr", vim.lsp.buf.references, opts("LSP: References"))
    keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP: Hover"))
    keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("LSP: Signature help"))

    -- LSP
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Diagnostics: Previous"))
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Diagnostics: Next"))
    keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts("Diagnostics: Send to location list"))
    keymap.set("n", "<leader>ls", open_document_symbols, opts("LSP: Document symbols"))
    keymap.set("n", "<leader>hd", vim.lsp.buf.hover, opts("LSP: Hover"))
    keymap.set("n", "<leader>li", vim.lsp.buf.hover, opts("LSP: Hover"))
    keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, opts("LSP: Code action"))
    keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts("LSP: Rename"))
    keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts("Diagnostics: Line diagnostics"))
    keymap.set("n", "<leader>lD", open_workspace_diagnostics, opts("Diagnostics: Workspace diagnostics"))
    keymap.set("n", "<leader>lS", open_document_symbols, opts("LSP: Document symbols"))
    keymap.set("n", "<leader>l]", vim.diagnostic.goto_next, opts("Diagnostics: Next"))
    keymap.set("n", "<leader>l[", vim.diagnostic.goto_prev, opts("Diagnostics: Previous"))
    keymap.set("n", "<leader>lg", vim.lsp.buf.definition, opts("LSP: Go to definition"))
    keymap.set("n", "<leader>lG", vim.lsp.buf.type_definition, opts("LSP: Go to type definition"))
  end,
})
