return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = {
		"Exafunction/codeium.nvim",
		"jmbuhr/cmp-pandoc-references",
	},
	opts = {
		keymap = {
			preset = "none",
			["<C-Space>"] = false,
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-e>"] = { "show", "show_documentation", "hide" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = false },
		},
		sources = {
			default = { "lsp", "path", "buffer", "snippets", "pandoc_references", "codeium" },
			transform_items = function(_, items)
				local seen = {}
				local deduped = {}

				for _, item in ipairs(items) do
					local key = table.concat({
						item.label or "",
						tostring(item.kind or ""),
						item.insertText or "",
					}, "\0")

					if not seen[key] then
						seen[key] = true
						deduped[#deduped + 1] = item
					end
				end

				return deduped
			end,

			providers = {
				lsp = {
					score_offset = 40,
				},
				path = {
					score_offset = 30,
				},
				buffer = {
					score_offset = 20,
				},
				snippets = {
					score_offset = 10,
				},
				pandoc_references = {
					name = "pandoc_references",
					module = "cmp-pandoc-references.blink",
					score_offset = -5,
				},
				codeium = {
					name = "Codeium",
					module = "codeium.blink",
					async = true,
					score_offset = 0,
				},
			},
		},
	},
}
