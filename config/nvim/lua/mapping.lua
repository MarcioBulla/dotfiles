local wk = require("which-key")

-- UTIL
vim.keymap.set("i", "<C-.>", "<cmd>:Telescope spell_suggest<CR>", { desc = "Spell Suggest" })
vim.keymap.set("n", "<C-.>", "<cmd>:Telescope spell_suggest<CR>", { desc = "Spell Suggest" })

-- TOGGLETERMS
wk.register({
  ["<leader>t"] = { name = " ToggleTerms" },
})

vim.keymap.set("n", "<leader>ta", ":ToggleTermToggleAll<cr>", { desc = "Show/Hide All ToggleTerms" })
vim.keymap.set("n", "<leader>tN", ":ToggleTermSetName<cr>", { desc = "Set ToggleTerm name" })
vim.keymap.set("n", "<leader>ts", ":TermSelect<cr>", { desc = "Select ToggleTerm" })
vim.keymap.set("n", "<leader>tv", function()
  vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
    if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
      local command = string.format("%sToggleTerm direction=vertical size=80 direction=vertical", number_term)
      vim.cmd(command)
    else
      local error_message = string.format("<%s> is a Invalid Input!!", number_term)
      vim.api.nvim_err_writeln(error_message)
    end
  end)
end, { desc = "ToggleTerm vertical split" })
vim.keymap.set("n", "<leader>th", function()
  vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
    if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
      local command = string.format("%sToggleTerm direction=horizontal size=10", number_term)
      vim.cmd(command)
    else
      local error_message = string.format("<%s> is a Invalid Input!!", number_term)
      vim.api.nvim_err_writeln(error_message)
    end
  end)
end, { desc = "ToggleTerm horizontal split" })
vim.keymap.set("n", "<leader>tf", function()
  vim.ui.input({ prompt = "Number of Terminal [1-9]: " }, function(number_term)
    if tonumber(number_term) and tonumber(number_term) >= 1 and tonumber(number_term) <= 9 then
      local command = string.format("%sToggleTerm direction=float", number_term)
      vim.cmd(command)
    else
      local error_message = string.format("<%s> is a Invalid Input!!", number_term)
      vim.api.nvim_err_writeln(error_message)
    end
  end)
end, { desc = "ToggleTerm float split" })

-- Improved Terminal Navigation
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal left window navigation" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal down window navigation" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal up window navigation" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal right window navigation" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Back to normal mode" })

-- TELESCOPE
wk.register({
  ["<leader>f"] = { name = " Telescope" },
})

vim.keymap.set("n", "<leader>f<CR>", function()
  require("telescope.builtin").resume()
end, { desc = "Resume previous search" })
vim.keymap.set("n", "<leader>f'", function()
  require("telescope.builtin").marks()
end, { desc = "Find marks" })
vim.keymap.set("n", "<leader>f/", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Find words in current buffer" })
vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").grep_string()
end, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fC", function()
  require("telescope.builtin").commands()
end, { desc = "Find commands" })
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fF", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files" })
vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Find help" })
vim.keymap.set("n", "<leader>fk", function()
  require("telescope.builtin").keymaps()
end, { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fm", function()
  require("telescope.builtin").man_pages()
end, { desc = "Find man" })
vim.keymap.set("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Find history" })
vim.keymap.set("n", "<leader>fr", function()
  require("telescope.builtin").registers()
end, { desc = "Find registers" })
vim.keymap.set("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end, { desc = "Find words" })
vim.keymap.set("n", "<leader>fW", function()
  require("telescope.builtin").live_grep({
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  })
end, { desc = "Find words in all files" })
vim.keymap.set("n", "<leader>fn", function ()
require('telescope').extensions.notify.notify()
end, { desc = "Find Notify" })

-- NEO-TREE
vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal left<CR>", { desc = "Toggle NeoTree" })
vim.keymap.set("n", "<leader>o", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd.wincmd("p")
  else
    vim.cmd.Neotree("focus")
  end
end, { desc = "Focus Neotree" })

-- COMMENTS
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Toggle comment line" })
vim.keymap.set(
  "v",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment for selection" }
)

-- INDENT
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent line" })

-- SMART SPLITS
vim.keymap.set("n", "<C-h>", function()
  require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", function()
  require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", function()
  require("smart-splits").move_cursor_up()
end, { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", function()
  require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", function()
  require("smart-splits").resize_up()
end, { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", function()
  require("smart-splits").resize_down()
end, { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", function()
  require("smart-splits").resize_left()
end, { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", function()
  require("smart-splits").resize_right()
end, { desc = "Resize split right" })

-- BUFFERLINE
wk.register({
  ["<leader>b"] = { name = " BufferLine" },
})
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>", { desc = "Close Current Buffer" })
vim.keymap.set("n", "<leader>bC", ":BufferLineCloseOthers<CR>", { desc = "Close all Other Buffers" })
vim.keymap.set("n", "<leader>b]", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>b[", ":BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick Buffer" })
vim.keymap.set("n", "<leader>bP", ":BufferLinePickClose<CR>", { desc = "Close Pick Buffer" })
vim.keymap.set("n", "<leader>b<", ":BufferLineMovePrev<CR>", { desc = "Move Prev Buffer" })
vim.keymap.set("n", "<leader>b>", ":BufferLineMoveNext<CR>", { desc = "Move Next Buffer" })

-- LSP
wk.register({
  ["<leader>l"] = { name = " LSP" },
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Formatting" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Variable" })
vim.keymap.set("n", "<leader>ls", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "Search symbols" })

-- NEOGEN
wk.register({
  ["<leader>N"] = { name = "Neogen", desc = "Auto Docstring" },
})
vim.keymap.set("n", "<leader>Na", "<cmd>Neogen<cr>", { desc = "Automatic" })
vim.keymap.set("n", "<leader>Nt", "<cmd>Neogen type<cr>", { desc = "Type" })
vim.keymap.set("n", "<leader>Nf", "<cmd>Neogen func<cr>", { desc = "Function" })
vim.keymap.set("n", "<leader>Nc", "<cmd>Neogen class<cr>", { desc = "Class" })
vim.keymap.set("n", "<leader>NF", "<cmd>Neogen file<cr>", { desc = "File" })
