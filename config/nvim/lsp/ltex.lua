return {
  cmd = { "ltex-ls" },
  filetypes = { "tex", "plaintex", "bib", "markdown", "pandoc", "quarto", "rmd", "text" },
  root_markers = { ".git" },
  settings = {
    ltex = {
      language = vim.g.ltex_language or "pt-BR",
    },
  },
}
