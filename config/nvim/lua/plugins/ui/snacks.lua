return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    picker = { enabled = true, ui_select = true },
    input  = { enabled = true },
    image  = { enabled = true },
    terminal = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true },

    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
