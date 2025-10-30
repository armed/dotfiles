require("config.basics")
require("config.lsp")

vim.lsp.enable({
  "clojure_lsp",
  "lua_ls",
  "rust_analyzer",
  "ts_ls"
})

vim.cmd([[ colo kanagawa ]])
