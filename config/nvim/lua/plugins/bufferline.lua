return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        style_preset = {
          bufferline.no_italic,
          bufferline.no_bold,
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = " NeoTree",
          },
        },
        separator_style = {"", ""},-- { "\\", "/" },
        indicator = {
          icon = "",
          style = "underline",
        },
      },
    })
  end,
}
