local utils = require("config.lsp.utils")

---@type vim.lsp.Config
return {
  filetypes = "proto",
  cmd = { utils.home_dir .. "/.cargp/bin/protols" },
  root_markers = { "protols.toml" },
}
