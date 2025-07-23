return {
  "catppuccin/nvim",
  name = "mocchiato",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true
    })
    vim.cmd.colorscheme("mocchiato")
  end,
}
