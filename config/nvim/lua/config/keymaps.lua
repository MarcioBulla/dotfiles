vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- keymaps
local keymap = vim.keymap

-- Indent
keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent line" })
keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent line" })
keymap.set("n", "<C-o>", "o<Esc>", { noremap = true, silent = true, desc = "Create empty line below" })
