dofile("tests/bootstrap.lua")
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")
local requested
package.loaded["nvim-treesitter"] = {
  install = function(parsers)
    requested = parsers
    return { await = function() end }
  end,
}
require("config.plugins.treesitter").config()
assert(
  vim.tbl_contains(requested, "rust") and vim.tbl_contains(requested, "tsx")
)
local buf = vim.api.nvim_get_current_buf()
vim.bo[buf].filetype = "lua"
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "local x = 1" })
vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
assert(vim.treesitter.highlighter.active[buf])
local other = vim.api.nvim_create_buf(true, false)
assert(#vim.api.nvim_buf_get_keymap(other, "n") == 0)
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { string.rep("x", 201 * 1024) })
vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
assert(
  not vim.treesitter.highlighter.active[buf],
  "large unsaved buffer must stop highlighting"
)
assert(vim.fn.maparg("<CR>", "n") == "", "large buffer must restore Enter")
print(
  "PASS: working-language parser list, buffer-local selection and large unsaved buffer"
)
