-- init.lua ou plugins.lua
function _G.execute_command(command, prompt, is_number)
	vim.ui.input({ prompt = prompt }, function(input)
		if input and input ~= "" then
			if is_number and not tonumber(input) then
				vim.api.nvim_err_writeln("Entrada inválida! Deve ser um número.")
				return
			end
			vim.cmd(command .. " " .. input)
		else
			vim.api.nvim_err_writeln("Entrada inválida!")
		end
	end)
end

require("core.keymaps")
require("core.vim-configs")
