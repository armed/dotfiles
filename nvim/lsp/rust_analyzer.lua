---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      files = {
        excludeDirs = { "target", ".*" },
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
        enable = true,
        typeHints = true,
        parameterHints = true,
        chainingHints = true,
      },
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
    },
  },
}
