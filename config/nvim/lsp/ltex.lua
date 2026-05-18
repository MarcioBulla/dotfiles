return {
  cmd = { "ltex-ls" },
  filetypes = { "tex", "plaintex", "bib", "markdown", "text" },
  root_markers = { ".git" },
  settings = {
    ltex = {
      language = vim.g.ltex_language,
    },
  },
}
