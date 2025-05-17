local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "onsails/lspkind.nvim",
  },
}

function M.config()
  vim.lsp.log.set_level(vim.log.levels.ERROR)
  require("lspconfig.ui.windows").default_options.border = "rounded"
  require("config.lsp.autocmds").setup()
  require("config.lsp.diagnostics").setup()
  require("config.lsp.custom.jdtls").setup()
end

return M
