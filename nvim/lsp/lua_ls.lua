---@type vim.lsp.Config
return {
  filetypes = { "lua" },
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      format = {
        enable = false,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
}
