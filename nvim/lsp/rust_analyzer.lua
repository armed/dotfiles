---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      files = {
        exclude = { "target" },
      },
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      cargo = {
        targetDir = true,
        sysroot = "discover",
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        typeHints = { enable = true },
        parameterHints = { enable = true },
        chainingHints = { enable = true },
      },
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
    },
  },
}
