local home = vim.env.HOME

return {
  cmd = {
    "clangd",
    "--background-index",
    "--compile-commands-dir=build",
    "--query-driver=" .. home .. "/.espressif/tools/**/bin/*-gcc",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = {
    "sdkconfig",
    "CMakeLists.txt",
    ".clangd",
    ".git",
  },
}
