return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "*" },
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        if not vim.treesitter.language.add(lang) then
          local available = require("nvim-treesitter").get_available()

          if vim.tbl_contains(available, lang) then
            require("nvim-treesitter").install(lang)
          end
        end

        if vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
