return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescriptreact", "typescript" },
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    expose_as_code_action = "all",
    on_attach = function(client, _)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end
    end,
  },
}
