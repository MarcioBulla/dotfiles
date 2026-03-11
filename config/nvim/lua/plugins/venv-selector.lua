return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  event = "VeryLazy",
  keys = {
    { "<leader>ps", "<cmd>VenvSelect<cr>" },
    { "<leader>pc", "<cmd>VenvSelectCached<cr>" },
  },
  opts = {
    name = { ".venv" },
  },
}
