return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
      source_selector = {
        winbar = true,
      },
      default_component_configs = {

        git_status = {
          symbols = {
            added = "󱪝 ",
            modified = "󰷈 ",
            deleted = "󱪟 ",
            renamed = "󱔗 ",
            untracked = "★ ",
            ignored = "󰘓 ",
            unstaged = "✗ ",
            staged = "✓ ",
            conflict = " ",
          },
        },
        modified = {
          symbol = "●",
          highlight = "NeoTreeModified",
        },
      },
      window = {
        width = 40,
      },
    })
  end,
}
