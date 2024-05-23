vim.g.mapleader = " "

-- keymaps
local keymap = vim.keymap

-- Indent
keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent line" })
keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent line" })
