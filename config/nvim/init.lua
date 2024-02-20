local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
require("vim-configs")
require("mapping")

if vim.g.neovide then
	vim.g.neovide_transparency = 0.5
	vim.g.neovide_background_color = "#563c27"
	vim.g.neovide_fullscreen = true
end
