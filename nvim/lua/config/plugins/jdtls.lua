return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    require("config.lsp.custom.jdtls").setup()
  end,
}
