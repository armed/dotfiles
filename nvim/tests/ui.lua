dofile("tests/bootstrap.lua")
require("config.basics.aucommands")
require("config.basics.hl-groups").setup()
vim.cmd.colorscheme("habamax")
for _, name in ipairs({
  "Green",
  "user.repl.statusline",
  "ClojureSystemRestart",
}) do
  assert(next(vim.api.nvim_get_hl(0, { name = name })))
end
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "first", "second", "", "" })
vim.api.nvim_win_set_cursor(0, { 1, 2 })
vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buf })
assert(
  vim.deep_equal(
    vim.api.nvim_buf_get_lines(buf, 0, -1, false),
    { "first", "second" }
  )
)
assert(vim.deep_equal(vim.api.nvim_win_get_cursor(0), { 1, 2 }))
vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "first", "", "" })
vim.bo.binary = true
vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buf })
assert(vim.api.nvim_buf_line_count(buf) == 3)
vim.bo.binary = false
local old = vim.go.colorcolumn
vim.cmd("source ftplugin/rust.lua")
assert(vim.go.colorcolumn == old and vim.wo.colorcolumn == "100")
vim.cmd.tabnew()
vim.cmd.tabprevious()
local tab = vim.api.nvim_get_current_tabpage()
vim.api.nvim_exec_autocmds("VimResized", {})
assert(tab == vim.api.nvim_get_current_tabpage())
print(
  "PASS: highlight reload, cursor-preserving cleanup, Rust option and active tab"
)
