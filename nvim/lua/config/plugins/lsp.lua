return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "saghen/blink.cmp",
    "antosha417/nvim-lsp-file-operations",
  },
  config = function()
    vim.lsp.log.set_level(vim.log.levels.ERROR)
    vim.lsp.config("*", {
      capabilities = vim.tbl_deep_extend(
        "force",
        require("blink.cmp").get_lsp_capabilities(),
        require("lsp-file-operations").default_capabilities()
      ),
    })
  end,
}
