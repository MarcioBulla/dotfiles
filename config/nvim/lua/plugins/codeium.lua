return {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = true,
      virtual_text = {
        enabled = false, -- evita competir com o menu do blink
      },
    },
  }
