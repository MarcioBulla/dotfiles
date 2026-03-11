return {
  cmd = {
    "clangd",
    "--background-index",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = {
    ".clangd",
    ".git",
    "compile_commands.json",
    "compile_flags.txt",
    "CMakeLists.txt",
  },
}
