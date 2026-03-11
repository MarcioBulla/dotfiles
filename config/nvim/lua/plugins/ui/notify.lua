return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    vim.opt.termguicolors = true

    local notify = require("notify")

    notify.setup({
      timeout = 3000,
      render = "default",
      stages = "fade",
      top_down = true,
    })

    vim.notify = notify
  end,
}
