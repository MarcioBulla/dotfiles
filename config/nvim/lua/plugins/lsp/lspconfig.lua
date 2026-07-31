return {
	"neovim/nvim-lspconfig",
	config = function()
		local languagetool_uri = "http://127.0.0.1:8081"
		local ltex_filetypes = { "tex", "plaintex", "bib", "markdown", "pandoc", "quarto", "rmd", "text" }
		local ltex_settings = {
			ltex = {
				language = vim.g.ltex_language or "pt-BR",
				languageToolHttpServerUri = languagetool_uri,
			},
		}

		for _, server in ipairs({ "ltex", "ltex_plus" }) do
			vim.lsp.config(server, {
				filetypes = ltex_filetypes,
				settings = ltex_settings,
			})
		end

		local function set_text_language(spell, ltex)
			vim.opt_local.spell = true
			vim.opt_local.spelllang = spell

			for _, name in ipairs({ "ltex", "ltex_plus" }) do
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0, name = name })) do
					client.config.settings = client.config.settings or {}
					client.config.settings.ltex = client.config.settings.ltex or {}
					client.config.settings.ltex.language = ltex
					client.config.settings.ltex.languageToolHttpServerUri = languagetool_uri
					client:notify("workspace/didChangeConfiguration", {
						settings = client.config.settings,
					})
				end
			end

			vim.notify("Spell: " .. spell .. " | LTeX: " .. ltex)
		end

		vim.keymap.set("n", "<leader>Se", function()
			set_text_language("es", "es-AR")
		end, { desc = "Text language: Spanish (AR)" })

		vim.keymap.set("n", "<leader>Sp", function()
			set_text_language("pt_br", "pt-BR")
		end, { desc = "Text language: Portuguese (BR)" })

		vim.keymap.set("n", "<leader>Su", function()
			set_text_language("en_us", "en-US")
		end, { desc = "Text language: English (US)" })
	end,
}
