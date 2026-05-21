return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura_simple"
    vim.env.NVIM_LISTEN_ADDRESS = nil
    if vim.v.servername == "" then
      vim.fn.serverstart()
    end
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "build",
      out_dir = "",
    }
  end,
}
