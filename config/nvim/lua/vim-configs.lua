vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.numberwidth = 3
-- vim.opt.showcmd = true
-- vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.g.mapleader = " "

vim.filetype.add({
  pattern = {
    [".*/hyprland%.conf"] = "hyprlang",
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/*.conf"] = "bash",
  },
})

if vim.g.neovide then
  vim.g.neovide_transparency = 0.7
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.cmd("highlight Normal guibg=#2a1e1d")
  vim.cmd("highlight Normal guifg=#dfdab7")
  vim.g.neovide_fullscreen = true
end
