return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.env.NVIM_LISTEN_ADDRESS = "/tmp/nvim-server"
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "build",
      out_dir = "",
    }
  end,
}
