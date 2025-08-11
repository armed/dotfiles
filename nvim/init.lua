require("config.aucommands")
require("config.hl-groups")
require("config.opts")
require("config.lazy")
require("config.maps")

vim.lsp.enable({
  "clojure_lsp",
  "lua_ls",
  "rust_analyzer",
  "protols",
})

vim.cmd([[ colo kanagawa ]])
