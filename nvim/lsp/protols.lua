local utils = require("config.lsp.utils")

local farthest_parent = { "/protols.toml" }
local root_finder = utils.make_lsp_root_finder(farthest_parent)

---@type vim.lsp.Config
return {
  filetypes = { "proto" },
  -- cmd = { "protols" },
  root_markers = { "protols.toml" },
  root_dir = root_finder,
}
