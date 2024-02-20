return {
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = false,
    },

    lazy = false,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
