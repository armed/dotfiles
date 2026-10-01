dofile("tests/bootstrap.lua")
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/conform.nvim")
package.loaded["which-key"] = { add = function() end }
require("config.plugins.conform").config()
local conform = require("conform")
local seen = {}
local old = conform.get_formatter_info
conform.get_formatter_info = function(name)
  return { available = true }
end
local buf = vim.api.nvim_create_buf(true, false)
vim.bo[buf].filetype = "javascriptreact"
local names = conform.list_formatters_for_buffer(buf)
assert(
  vim.deep_equal(names, { "biome", "pruner_injected" }),
  vim.inspect(names)
)
conform.get_formatter_info = function(name)
  return { available = name == "prettier" }
end
assert(
  vim.deep_equal(
    conform.list_formatters_for_buffer(buf),
    { "prettier", "pruner_injected" }
  )
)
vim.bo[buf].filetype = "markdown"
assert(
  vim.deep_equal(
    conform.list_formatters_for_buffer(buf),
    { "prettier", "injected" }
  )
)
conform.get_formatter_info = old
local biome = conform.get_formatter_config("biome", buf)
assert(type(biome.command) == "function", "use node_modules resolution")
print("PASS: JSX formatter fallback, injected stage and safe Biome command")
