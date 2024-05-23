return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			render = "compact",
			background_colour = "#000000",
			stages = "slide",
			timeout = 2000,
		})

		vim.keymap.set("n", "<leader>fn", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Find Notify" })
	end,
}
