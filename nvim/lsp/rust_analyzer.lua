---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      -- cargo = {
      --   features = "all",
      -- },
      notifications = {
        progress = true,
      },
      checkOnSave = {
        command = "clippy",
      },
      lens = {
        debug = { enable = true },
        enable = true,
        implementations = { enable = true },
        references = {
          adt = { enable = true },
          enumVariant = { enable = true },
          method = { enable = true },
          trait = { enable = true },
          run = { enable = true },
          updateTest = { enable = true },
        },
      },
    },
  },
}
