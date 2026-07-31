return {
	"selimacerbas/markdown-preview.nvim",
	dependencies = { "selimacerbas/live-server.nvim" },
	config = function()
		local preview = require("markdown_preview")
		local preview_dir

		local function cleanup()
			local dir = preview_dir or vim.fn.getcwd()

			for _, name in ipairs({ ".content.html", ".content.md" }) do
				pcall(vim.uv.fs_unlink, vim.fs.joinpath(dir, name))
			end
			preview_dir = nil
		end

		local function prepare()
			preview_dir = vim.fn.getcwd()
			local source = vim.api.nvim_get_runtime_file("assets/index.html", false)[1]
			local index = vim.fs.joinpath(preview_dir, ".content.html")
			local html = table.concat(vim.fn.readfile(source), "\n"):gsub(
				"content%.md",
				".content.md"
			)
			vim.fn.writefile(vim.split(html, "\n", { plain = true }), index)
		end

		preview.setup({
			instance_mode = "multi",
			port = 0,
			open_browser = true,
			debounce_ms = 300,
			workspace_dir = ".",
			index_name = ".content.html",
			content_name = ".content.md",
			overwrite_index_on_start = false,
			hooks = {
				on_stop = cleanup,
			},
		})

		pcall(vim.api.nvim_del_user_command, "MarkdownPreview")
		vim.api.nvim_create_user_command("MarkdownPreview", function()
			prepare()
			preview.start()
		end, {})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = cleanup,
		})
	end,
}
