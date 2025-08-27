require("config.aucommands")
require("config.hl-groups")
require("config.opts")
require("config.lazy")
require("config.maps")
require("config.comment")

vim.lsp.enable({
  "clojure_lsp",
  "lua_ls",
  "rust_analyzer",
  "protols",
  "ts_ls"
})

vim.cmd([[ colo kanagawa ]])

