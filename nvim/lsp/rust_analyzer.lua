---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      files = {
        excludeDirs = { "target", ".git" },
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
